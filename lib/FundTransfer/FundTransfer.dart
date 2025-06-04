import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:passbook_core_jayant/FundTransfer/Beneficiary.dart';
import 'package:passbook_core_jayant/FundTransfer/Model/PeopleModel.dart';
import 'package:passbook_core_jayant/FundTransfer/OtherBankTransfer.dart';
import 'package:passbook_core_jayant/FundTransfer/OwnBankTransfer.dart';
import 'package:passbook_core_jayant/FundTransfer/bloc/bloc.dart';
import 'package:passbook_core_jayant/REST/RestAPI.dart';
import 'package:passbook_core_jayant/Util/custom_print.dart';
import 'package:passbook_core_jayant/Util/util.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../REST/app_exceptions.dart';

class FundTransfer extends StatefulWidget {
  const FundTransfer({super.key});

  @override
  _FundTransferState createState() => _FundTransferState();

  //  @override
  //  _FundTransfer2State createState() => _FundTransfer2State();
}

class _FundTransferState extends State<FundTransfer>
    with SingleTickerProviderStateMixin {
  String acc = "", name = "";
  String cmpCode = "", custTypeCode="";
  GlobalKey<ScaffoldState>? scaffoldKey;
  final _peopleKey = GlobalKey();

  final ScrollController _customScrollController = ScrollController();
  late SharedPreferences preferences;
  People people = People();
  String _amount = "", userBal = "";
  String userName = "", userAcc = "", userId = "";
  double _minTransferAmt = 0.0, _maxTransferAmt = 0.0;

  /*  void loadData() async {
    preferences = await SharedPreferences.getInstance();
    setState(() {
	    acc = preferences?.getString(StaticValues.accNumber) ?? "";
	    name = preferences?.getString(StaticValues.accName) ?? "";
    });


 
  }*/

  void loadData() async {
    preferences = await SharedPreferences.getInstance();
    setState(() {
      acc = preferences.getString(StaticValues.accountNo) ?? "";
      name = preferences.getString(StaticValues.accName) ?? "";
      userName = preferences.getString(StaticValues.accName) ?? "";
      userId = preferences.getString(StaticValues.custID) ?? "";
      cmpCode = preferences.getString(StaticValues.cmpCodeKey) ?? "";
      custTypeCode = preferences.getString(StaticValues.custTypeCode) ?? "";
    });
    warningPrint(
      "acc no ==$acc,\n name =$name \n userid=$userId \n cmpCOde=$cmpCode \n custTypeCode=$custTypeCode",
    );

    //fetchuserlimit
    final transferBloc = TransferBloc.get(context);
    transferBloc.add(FetchUserLimitevent(cmpCode, custTypeCode));

    fetchBeneficiary();
  }

  fetchBeneficiary() async {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      final transferBloc = TransferBloc.get(context);
      var id = preferences.getString(StaticValues.custID) ?? "";
      transferBloc.add(FetchBenificiaryevent(cmpCode, userId));
    });
  }

  Future<Map> deleteBeneficiary(String recieverId) async {
    return await RestAPI().get(APis.deleteBeneficiary(recieverId));
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
  }

  @override
  void initState() {
    scaffoldKey = GlobalKey();
    loadData();
    successPrint("initstate executing fund transfer");

    super.initState();
  }

  Widget options() {
    return Align(
      alignment: Alignment.topCenter,
      child: ListView(
        shrinkWrap: true,
        itemExtent: 80.0,
        scrollDirection: Axis.horizontal,
        children: [
          GlobalWidgets().btnWithText(
            icon: Image.asset(
              "assets/otherBankTransfer.png",
              height: 30.0,
              width: 30.0,
              color: Theme.of(context).primaryColor,
            ),
            name: "Other Bank Transfer",
            onPressed: () {
              Scrollable.ensureVisible(
                _peopleKey.currentContext!,
                duration: Duration(milliseconds: 350),
                curve: Curves.easeIn,
              );
            },
          ),
          GlobalWidgets().btnWithText(
            icon: Icon(
              Icons.add,
              size: 30.0,
              color: Theme.of(context).primaryColor,
            ),
            name: "Add Beneficiary",
            onPressed: () async {
              var result = await Navigator.of(
                context,
              ).push(MaterialPageRoute(builder: (context) => Beneficiary()));
              print("RESULT ::: $result");
            },
          ),
          GlobalWidgets().btnWithText(
            icon: Image.asset(
              "assets/ownBankTransfer.png",
              height: 30.0,
              width: 30.0,
              color: Theme.of(context).primaryColor,
            ),
            name: "Own Bank Transfer",
            onPressed: () {
              Navigator.of(context).push(
                MaterialPageRoute(builder: (context) => OwnBankTransfer()),
              );
            },
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        Navigator.of(context).pushReplacementNamed("/HomePage");
        return false; // Prevent default pop behavior
      },
      child: Scaffold(
        key: scaffoldKey,
        body: Stack(
          children: [
            CustomScrollView(
              controller: _customScrollController,
              physics: BouncingScrollPhysics(),
              slivers: [
                SliverAppBar(
                  expandedHeight: MediaQuery.of(context).size.width * 1.30,
                  pinned: true,
                  centerTitle: true,
                  title: Text(
                    "Fund Transfer",
                    style: TextStyle(color: Colors.white),
                  ),
                  leading: IconButton(
                    icon: Icon(
                      Icons.arrow_back,
                      size: 30.0,
                      color: Colors.white,
                    ),
                    onPressed:
                        () => Navigator.of(
                          context,
                        ).pushReplacementNamed("/HomePage"),
                  ),
                  stretch: true,
                  flexibleSpace: FlexibleSpaceBar(
                    centerTitle: true,
                    collapseMode: CollapseMode.parallax,
                    stretchModes: [
                      StretchMode.fadeTitle,
                      StretchMode.blurBackground,
                    ],
                    background: Stack(
                      children: [
                        Align(
                          alignment: Alignment.center,
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              QrImageView(
                                data: acc,
                                version: QrVersions.auto,
                                size: 200.0,
                                backgroundColor: Colors.white,
                                foregroundColor: Colors.black,
                              ),
                              SizedBox(height: 10.0),
                              TextView(
                                text: name,
                                color: Colors.white,
                                size: 18,
                              ),
                              TextView(
                                text: acc,
                                size: 16.0,
                                color: Colors.white,
                              ),
                            ],
                          ),
                        ),
                        Align(
                          alignment: Alignment.bottomRight,
                          child: IconButton(
                            visualDensity: VisualDensity.compact,
                            padding: EdgeInsets.all(20.0),
                            icon: Image.asset(
                              "assets/qr-code.png",
                              color: Colors.white,
                            ),
                            onPressed: () {
                              GlobalWidgets().shoppingPay(
                                scaffoldKey!.currentContext!,
                                setState,
                                scaffoldKey!,
                                userBal,
                              );
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                SliverList(
                  key: _peopleKey,
                  delegate: SliverChildListDelegate([
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Align(
                            alignment: Alignment.topCenter,
                            child: Container(
                              margin: EdgeInsets.symmetric(vertical: 5.0),
                              decoration: BoxDecoration(
                                color: Colors.grey,
                                borderRadius: BorderRadius.circular(20.0),
                              ),
                              width: 25.0,
                              height: 5.0,
                            ),
                          ),
                          SizedBox(height: 10.0),
                          LimitedBox(maxHeight: 120.0, child: options()),
                          Padding(
                            padding: const EdgeInsets.only(
                              top: 21.0,
                              left: 12.0,
                            ),
                            child: TextView(
                              text: "People",
                              size: 20.0,
                              textAlign: TextAlign.start,
                            ),
                          ),
                          BlocBuilder<TransferBloc, TransferState>(
                            buildWhen:
                                (previous, current) =>
                                    current is FetchBenificiaryLoading ||
                                    current is FetchBenificiaryResponse ||
                                    current is FetchBenificiaryError,
                            builder: (context, state) {
                              customPrint("state =$state");
                              if (state is FetchBenificiaryLoading) {
                                return Center(
                                  child: CircularProgressIndicator(),
                                );
                              } else if (state is FetchBenificiaryResponse) {
                                if (state.beneficiaryList.isNotEmpty) {
                                  return GridView.builder(
                                    gridDelegate:
                                        SliverGridDelegateWithFixedCrossAxisCount(
                                          crossAxisCount: 3,
                                          mainAxisSpacing: 10.0,
                                        ),
                                    physics: NeverScrollableScrollPhysics(),
                                    primary: true,
                                    shrinkWrap: true,
                                    itemCount: state.beneficiaryList.length,
                                    itemBuilder: (context, index) {
                                      return InkWell(
                                        onLongPress: () {
                                          showDialog(
                                            context: context,
                                            builder: (context) {
                                              return AlertDialog(
                                                title: const Text("Are you sure?"),
                                                content: TextView(
                                                  text:
                                                  "Do you want to delete or edit ${state.beneficiaryList[index].recieverName} beneficiary",
                                                ),
                                                shape: RoundedRectangleBorder(
                                                  borderRadius: BorderRadius.circular(10.0),
                                                ),
                                                actions: <Widget>[
                                                  Row(
                                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                    children: [
                                                      // Cancel button on the left
                                                      ElevatedButton(
                                                        onPressed: () => Navigator.of(context).pop(),
                                                        style: ElevatedButton.styleFrom(
                                                          shape: RoundedRectangleBorder(
                                                            borderRadius: BorderRadius.circular(10.0),
                                                          ),
                                                          backgroundColor: Theme.of(context).cardColor,
                                                          padding: const EdgeInsets.all(5.0),
                                                        ),
                                                        child: const TextView(
                                                          text: "Cancel",
                                                          size: 12.0,
                                                          color: Colors.white,
                                                        ),
                                                      ),

                                                      const Spacer(), // Push Edit & Delete to the right

                                                      // Edit button
                                                      ElevatedButton(
                                                        onPressed: () async {
                                                          // Add your edit logic here
                                                        },
                                                        style: ElevatedButton.styleFrom(
                                                          shape: RoundedRectangleBorder(
                                                            borderRadius: BorderRadius.circular(10.0),
                                                          ),
                                                          backgroundColor: Colors.green,
                                                          padding: const EdgeInsets.all(5.0),
                                                        ),
                                                        child: const TextView(
                                                          text: "Edit",
                                                          size: 12.0,
                                                          color: Colors.white,
                                                        ),
                                                      ),

                                                      const SizedBox(width: 8), // spacing between Edit and Delete

                                                      // Delete button
                                                      ElevatedButton(
                                                        onPressed: () async {
                                                          await deleteBeneficiary(
                                                            state.beneficiaryList[index].recieverId.toString(),
                                                          );
                                                          fetchBeneficiary();
                                                          Navigator.pop(context);
                                                        },
                                                        style: ElevatedButton.styleFrom(
                                                          shape: RoundedRectangleBorder(
                                                            borderRadius: BorderRadius.circular(10.0),
                                                          ),
                                                          backgroundColor: Colors.red,
                                                          padding: const EdgeInsets.all(5.0),
                                                        ),
                                                        child: const TextView(
                                                          text: "Delete",
                                                          size: 12.0,
                                                          color: Colors.white,
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ],
                                              );
                                            },
                                          );
                                        },
                                        onTap: () {
                                          Navigator.push(
                                            context,
                                            SizeRoute(
                                              page: OtherBankTransfer(
                                                peopleTable:
                                                    state
                                                        .beneficiaryList[index],
                                              ),
                                            ),
                                          );
                                        },
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceEvenly,
                                          children: [
                                            Card(
                                              elevation: 6.0,
                                              shape: CircleBorder(),
                                              child: Padding(
                                                padding: const EdgeInsets.all(
                                                  15.0,
                                                ),
                                                child: Image.asset(
                                                  "assets/otherBankTransfer.png",
                                                  height: 30.0,
                                                  width: 30.0,
                                                  color:
                                                      Theme.of(
                                                        context,
                                                      ).primaryColor,
                                                ),
                                              ),
                                            ),
                                            SizedBox(height: 5.0),
                                            TextView(
                                              text: toBeginningOfSentenceCase(
                                                state
                                                    .beneficiaryList[index]
                                                    .recieverName,
                                              ),
                                            ),
                                            TextView(
                                              text: toBeginningOfSentenceCase(
                                                state
                                                    .beneficiaryList[index]
                                                    .recieverAccno,
                                              ),
                                              size: 10.0,
                                            ),
                                          ],
                                        ),
                                      );
                                    },
                                  );
                                } else
                                  // if(state.beneficiaryList
                                  //   .length<1)
                                  {
                                  return Center(
                                    child: Text(
                                      "No Data Found",
                                      style: TextStyle(color: Colors.black),
                                    ),
                                  );
                                }
                              } else if (state is FetchBenificiaryError) {
                                return Column(
                                  children: [
                                    SizedBox(height: 30,),
                                    Center(
                                      child: Text(
                                        "Error: ${state.error}",
                                        style: const TextStyle(
                                          color: Colors.red,
                                        ),
                                      ),
                                    ),
                                  ],
                                );
                              } else {
                                return Center(
                                  child: Text(
                                    "Something went Wrong",
                                    style: TextStyle(color: Colors.black),
                                  ),
                                );
                              }
                            },
                          ),
                        ],
                      ),
                    ),
                  ]),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class SizeRoute extends PageRouteBuilder {
  final Widget? page;

  SizeRoute({this.page})
    : super(
        pageBuilder:
            (
              BuildContext context,
              Animation<double> animation,
              Animation<double> secondaryAnimation,
            ) => page!,
        transitionsBuilder:
            (
              BuildContext context,
              Animation<double> animation,
              Animation<double> secondaryAnimation,
              Widget child,
            ) => Align(
              child: SizeTransition(sizeFactor: animation, child: child),
            ),
      );
}
