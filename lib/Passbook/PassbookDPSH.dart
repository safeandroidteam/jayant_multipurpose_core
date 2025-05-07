import 'dart:async';

import 'package:dots_indicator/dots_indicator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:passbook_core_jayant/Passbook/bloc/pass_book_bloc.dart';
import 'package:passbook_core_jayant/Passbook/depositTransaction.dart';
import 'package:passbook_core_jayant/Util/custom_print.dart';
import 'package:passbook_core_jayant/Util/util.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../REST/RestAPI.dart';
import 'Model/PassbookListModel.dart';

class PassbookDPSH extends StatefulWidget {
  final String? type;

  const PassbookDPSH({super.key, this.type});

  @override
  _PassbookDPSHState createState() => _PassbookDPSHState();
}

class _PassbookDPSHState extends State<PassbookDPSH> {
  final PageController _pageController = PageController(
    initialPage: 0,
    keepPage: true,
    viewportFraction: .90,
  );
  late SharedPreferences preferences;
  var id;
  @override
  void initState() {
    loadDPShCard();
    super.initState();
  }

  loadDPShCard() async {
    preferences = await SharedPreferences.getInstance();

    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      final passBookBloc = PassBookBloc.get(context);
      id = preferences.getString(StaticValues.custID) ?? "";
      passBookBloc.add(PassBookDPSHCardEvent(id, widget.type ?? ""));
    });
  }

  @override
  Widget build(BuildContext context) {
    final passBookBloc = PassBookBloc.get(context);

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          widget.type!.toLowerCase() == "dp" ? "Deposit" : "Share",
          style: TextStyle(color: Colors.white),
        ),
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.white, size: 30.0),
          onPressed: () => Navigator.of(context).pop(),
        ),
      ),
      body: SafeArea(
        child: MultiBlocListener(
          listeners: [
            BlocListener<PassBookBloc, PassBookState>(
              listenWhen: (prev, curr) => curr is CurrentPageState,
              listener: (context, state) {
                if (state is CurrentPageState) {
                  _pageController.jumpToPage(state.currentPage);
                }
              },
            ),
          ],
          child: BlocBuilder<PassBookBloc, PassBookState>(
            buildWhen:
                (previous, current) =>
                    current is DPSHCardLoading ||
                    current is DPSHCardResponse ||
                    current is DPSHCardErrorException,
            builder: (context, state) {
              if (state is DPSHCardLoading) {
                return Center(child: CircularProgressIndicator());
              } else if (state is DPSHCardResponse) {
                if (state.passbookItemList.isNotEmpty) {
                  passBookBloc.add(
                    DepositShareTransactionEvent(
                      id,
                      state.passbookItemList.first.module.toLowerCase() ==
                          "share",
                      state.passbookItemList.first.accNo,
                      state.passbookItemList.first.schCode,
                      state.passbookItemList.first.brCode,
                    ),
                  );
                  return Column(
                    children: <Widget>[
                      BlocBuilder<PassBookBloc, PassBookState>(
                        buildWhen: (prev, curr) => curr is CurrentPageState,
                        builder: (context, currState) {
                          int currentPage =
                              (currState is CurrentPageState)
                                  ? currState.currentPage
                                  : 0;
                          return DotsIndicator(
                            dotsCount: state.passbookItemList.length,
                            position: currentPage.toDouble(),
                            decorator: DotsDecorator(
                              color: Theme.of(
                                context,
                              ).primaryColor.withAlpha(80),
                              activeColor: Theme.of(context).primaryColor,
                              size: const Size(18.0, 5.0),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(5.0),
                              ),
                              activeSize: const Size(18.0, 5.0),
                              activeShape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(5.0),
                              ),
                            ),
                          );
                        },
                      ),
                      Expanded(
                        child: PageView.builder(
                          itemCount: state.passbookItemList.length,
                          controller: _pageController,
                          itemBuilder: (context, index) {
                            return Column(
                              children: <Widget>[
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Container(
                                    decoration: BoxDecoration(
                                      gradient: LinearGradient(
                                        colors: [
                                          Theme.of(context).focusColor,
                                          Theme.of(context).primaryColor,
                                        ],
                                      ),
                                      boxShadow: [
                                        BoxShadow(
                                          color: Colors.black45,
                                          offset: Offset(1.5, 1.5), //(x,y)
                                          blurRadius: 5.0,
                                          spreadRadius: 2.0,
                                        ),
                                      ],
                                      borderRadius: BorderRadius.circular(20.0),
                                    ),
                                    child: ListTile(
                                      title: Column(
                                        children: <Widget>[
                                          ListTile(
                                            dense: true,
                                            isThreeLine: true,
                                            contentPadding: EdgeInsets.all(0.0),
                                            title: TextView(
                                              state
                                                  .passbookItemList[index]
                                                  .accNo,
                                              color: Colors.white,
                                              size: 16.0,
                                              fontWeight: FontWeight.bold,
                                              textAlign: TextAlign.start,
                                            ),
                                            subtitle: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: <Widget>[
                                                TextView(
                                                  state
                                                      .passbookItemList[index]
                                                      .schName,
                                                  color: Colors.white,
                                                  textAlign: TextAlign.start,
                                                  size: 12.0,
                                                ),
                                                TextView(
                                                  state
                                                      .passbookItemList[index]
                                                      .depBranch,
                                                  color: Colors.white,
                                                  textAlign: TextAlign.start,
                                                  size: 12.0,
                                                ),
                                              ],
                                            ),
                                          ),
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              TextView(
                                                "sch Code ${state.passbookItemList[index].schCode}",
                                                color: Colors.white,
                                                size: 15,
                                              ),
                                              TextView(
                                                "Br Code ${state.passbookItemList[index].brCode}",
                                                color: Colors.white,
                                                size: 15,
                                              ),
                                            ],
                                          ),

                                          TextView(
                                            state
                                                .passbookItemList[index]
                                                .balance
                                                .toStringAsFixed(2),
                                            color: Colors.white,
                                            size: 28,
                                          ),
                                          TextView(
                                            "Available Balance",
                                            color: Colors.white,
                                            size: 13,
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                                SizedBox(height: 10),
                                DepositShareTransaction(
                                  depositTransaction:
                                      state.passbookItemList[index],
                                ),
                              ],
                            );
                          },
                          onPageChanged: (index) {
                            customPrint("page index==$index");
                            passBookBloc.add(CurrentPageChanged(index));

                            passBookBloc.add(
                              DepositShareTransactionEvent(
                                preferences.getString(StaticValues.custID) ??
                                    "",
                                widget.type!.toLowerCase() == 'share',
                                state.passbookItemList[index].accNo,
                                state.passbookItemList[index].schCode,
                                state.passbookItemList[index].brCode,
                              ),
                            );
                          },
                        ),
                      ),
                    ],
                  );
                } else {
                  return Center(
                    child: Text(
                      "No Data Found",
                      style: TextStyle(color: Colors.black),
                    ),
                  );
                }
              } else if (state is DPSHCardErrorException) {
                return Center(
                  child: Column(
                    children: [
                      Text(
                        "Error: ${state.error}",
                        style: const TextStyle(color: Colors.red),
                      ),
                      ElevatedButton(
                        onPressed: () => loadDPShCard(),
                        child: Text("Retry"),
                      ),
                    ],
                  ),
                );
              } else {
                return Stack(
                  children: [
                    Center(
                      child: TextView(
                        "You don't have a ${widget.type == "DP" ? 'deposit' : 'share'} in this bank",
                      ),
                    ),
                  ],
                );
              }
            },
          ),
        ),
      ),
    );
  }
}
