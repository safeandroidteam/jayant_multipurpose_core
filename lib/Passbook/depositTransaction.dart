import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:intl/intl.dart';
import 'package:passbook_core_jayant/Passbook/bloc/pass_book_bloc.dart';
import 'package:passbook_core_jayant/Util/GlobalWidgets.dart';
import 'package:passbook_core_jayant/Util/StaticValue.dart';
import 'package:passbook_core_jayant/Util/custom_print.dart';

import 'package:shared_preferences/shared_preferences.dart';

import 'Model/PassbookListModel.dart';

class DepositShareTransaction extends StatefulWidget {
  final PassbookItem depositTransaction;

  const DepositShareTransaction({super.key, required this.depositTransaction});

  @override
  _DepositShareTransactionState createState() =>
      _DepositShareTransactionState();
}

class _DepositShareTransactionState extends State<DepositShareTransaction>
    with AutomaticKeepAliveClientMixin {
  bool isShare = false;
  late SharedPreferences preferences;
  bool hasFetchedTransactions = false;
  @override
  void initState() {
    customPrint(
      "deposit transaction passed data =${widget.depositTransaction.toJson()}",
    );

    isShare = widget.depositTransaction.module?.toLowerCase() == "share";
    if (!hasFetchedTransactions) {
      // getTransactions(isInitial: true);
      hasFetchedTransactions = true;
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return BlocBuilder<PassBookBloc, PassBookState>(
      buildWhen:
          (previous, current) =>
              current is DepositShareTransactionLoading ||
              current is DepositShareTransactionResponse ||
              CurveTween is DepositShareTransactionErrorException,
      builder: (context, state) {
        if (state is PassBookBlocInitial) {
          return Center(child: CircularProgressIndicator());
        } else if (state is DepositShareTransactionLoading) {
          return Center(child: CircularProgressIndicator());
        } else if (state is DepositShareTransactionResponse) {
          if (state.transactionList.isEmpty) {
            return Center(child: Text("No Data Found"));
          } else {
            return Column(
              children: <Widget>[
                SizedBox(
                  width: MediaQuery.of(context).size.width * .8,
                  height: 20.0,
                  child: Table(
                    defaultVerticalAlignment: TableCellVerticalAlignment.middle,
                    columnWidths: {
                      0: FractionColumnWidth(.40),
                      1: FractionColumnWidth(.30),
                      2: FractionColumnWidth(.30),
                    },
                    children: <TableRow>[
                      TableRow(
                        children: [
                          TableCell(
                            child: TextView(
                              text: "Date",
                              fontWeight: FontWeight.bold,
                              textAlign: TextAlign.start,
                              size: 12,
                            ),
                          ),
                          isShare
                              ? TableCell(
                                child: TextView(
                                  text: "Type",
                                  fontWeight: FontWeight.bold,
                                  textAlign: TextAlign.center,
                                  size: 12,
                                ),
                              )
                              : TableCell(
                                child: CustomText(
                                  children: [
                                    TextSpan(
                                      text: "Credit",
                                      style: TextStyle(
                                        color: Colors.green,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    TextSpan(text: "/"),
                                    TextSpan(
                                      text: "Debit",
                                      style: TextStyle(
                                        color: Colors.red,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                          TableCell(
                            child:
                                isShare
                                    ? CustomText(
                                      children: [
                                        TextSpan(
                                          text: "Credit",
                                          style: TextStyle(
                                            color: Colors.green,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                        TextSpan(text: "/"),
                                        TextSpan(
                                          text: "Debit",
                                          style: TextStyle(
                                            color: Colors.red,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      ],
                                    )
                                    : TextView(
                                      text: "Balance",
                                      fontWeight: FontWeight.bold,
                                      textAlign: TextAlign.end,
                                      size: 12,
                                    ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height * .59,
                  width: MediaQuery.of(context).size.width * .85,
                  child: ListView.builder(
                    shrinkWrap: true,
                    physics: BouncingScrollPhysics(),
                    itemCount: state.transactionList.length,
                    itemBuilder: (context, index) {
                      return Card(
                        elevation: 3.0,
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Table(
                            defaultVerticalAlignment:
                                TableCellVerticalAlignment.middle,
                            columnWidths: {
                              0: FractionColumnWidth(.40),
                              1: FractionColumnWidth(.30),
                              2: FractionColumnWidth(.30),
                            },
                            children: <TableRow>[
                              TableRow(
                                children: [
                                  TableCell(
                                    child: Padding(
                                      padding: const EdgeInsets.symmetric(
                                        vertical: 8.0,
                                      ),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        children: <Widget>[
                                          TextView(
                                            text:
                                                state
                                                    .transactionList[index]
                                                    .trDate,

                                            fontWeight: FontWeight.bold,
                                            size: 12,
                                            textAlign: TextAlign.start,
                                          ),
                                          TextView(
                                            text:
                                                state
                                                    .transactionList[index]
                                                    .remarks,
                                            textAlign: TextAlign.start,
                                            size: 10,
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                  TableCell(
                                    child: TextView(
                                      text: state.transactionList[index].amount!
                                          .toStringAsFixed(2),
                                      textAlign: TextAlign.end,
                                      fontWeight: FontWeight.bold,
                                      color:
                                          state.transactionList[index].tranType
                                                      .toString() ==
                                                  "1"
                                              ? Colors.green
                                              : Colors.red,
                                    ),
                                  ),
                                  TableCell(
                                    child: TextView(
                                      text: state.transactionList[index].amount!
                                          .toStringAsFixed(2),
                                      textAlign: TextAlign.end,
                                      size: 12,
                                      fontWeight: FontWeight.bold,
                                      color:
                                          isShare
                                              ? state
                                                          .transactionList[index]
                                                          .tranType
                                                          .toString() ==
                                                      'c'
                                                  ? Colors.green
                                                  : Colors.red
                                              : Colors.black,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ],
            );
          }
        } else if (state is DepositShareTransactionErrorException) {
          return Center(
            child: Text(
              "Error: ${state.error}",
              style: const TextStyle(color: Colors.red),
            ),
          );
        } else {
          return Center(
            child: Text(
              "Something Went Wrong",
              style: const TextStyle(color: Colors.red),
            ),
          );
        }
      },
    );
  }

  @override
  bool get wantKeepAlive => true;
}
