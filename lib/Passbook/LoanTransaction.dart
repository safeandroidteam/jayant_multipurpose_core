import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:passbook_core_jayant/Passbook/Model/LoanTransModel.dart';
import 'package:passbook_core_jayant/Passbook/bloc/pass_book_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../Util/GlobalWidgets.dart';
import '../Util/StaticValue.dart';

class LoanTransaction extends StatefulWidget {
  // final String? accNo;
  final int? accID;

  const LoanTransaction({super.key, this.accID});

  @override
  _LoanTransactionState createState() => _LoanTransactionState();
}

class _LoanTransactionState extends State<LoanTransaction> {
  late SharedPreferences preferences;
  var cmpCode;

  @override
  void dispose() {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.landscapeRight,
      DeviceOrientation.landscapeLeft,
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    super.dispose();
  }

  @override
  void initState() {
    loadLoanTransactions();
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.landscapeLeft,
      DeviceOrientation.landscapeRight,
    ]);
    super.initState();
  }

  loadLoanTransactions() async {
    preferences = await SharedPreferences.getInstance();

    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      final passBookBloc = PassBookBloc.get(context);
      cmpCode = preferences.getString(StaticValues.cmpCodeKey) ?? "";
      passBookBloc.add(LoanTransEvent(cmpCode, widget.accID ?? 0));
      // passBookBloc.add(LoanTransEvent(cmpCode, 186196));
    });
  }

  List<Widget> header() {
    return [
      TableCell(
        child: ListTile(
          dense: true,
          contentPadding: EdgeInsets.symmetric(horizontal: 5.0),
          title: TextView(
            text: "Date",
            textAlign: TextAlign.center,
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      TableCell(
        child: TextView(
          text: "Amount",
          textAlign: TextAlign.end,
          color: Colors.white,
          fontWeight: FontWeight.bold,
        ),
      ),
      TableCell(
        child: TextView(
          text: "Interest",
          textAlign: TextAlign.end,
          color: Colors.white,
          fontWeight: FontWeight.bold,
        ),
      ),
      TableCell(
        child: TextView(
          text: "Charges",
          textAlign: TextAlign.end,
          color: Colors.white,
          fontWeight: FontWeight.bold,
        ),
      ),
      TableCell(
        child: TextView(
          text: "Total Cr/Dr",
          textAlign: TextAlign.end,
          fontWeight: FontWeight.bold,
          color: Colors.white,
        ),
      ),
      TableCell(
        child: TextView(
          text: "Total Amount",
          textAlign: TextAlign.end,
          fontWeight: FontWeight.bold,
          color: Colors.white,
        ),
      ),
      TableCell(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 5.0),
          child: TextView(
            text: "Balance",
            textAlign: TextAlign.end,
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      TableCell(
        child: TextView(
          text: "Remarks",
          textAlign: TextAlign.end,
          fontWeight: FontWeight.bold,
          color: Colors.white,
        ),
      ),
    ];
  }

  // List<TableRow> rows(List<LoanTransTable> loanTransTable) {
  List<TableRow> rows(List<LoanTransData> loanTransData) {
    List<TableRow> tableRows = [];
    // loanTransTable.asMap().forEach((index, item) {
    loanTransData.asMap().forEach((index, item) {
      DateTime date = DateTime.parse(item.trDate!);
      String formattedtrDate = DateFormat("dd MMM yyyy").format(date);
      tableRows.add(
        TableRow(
          decoration: BoxDecoration(
            color: index % 2 == 0 ? Colors.black12 : Colors.white,
          ),
          children: [
            TableCell(
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  vertical: 8.0,
                  horizontal: 5.0,
                ),
                child: TextView(
                  text:
                      // item.trdate!.replaceAll("/", "-"),
                      // item.trDate!.replaceAll("/", "-"),
                      formattedtrDate,
                  textAlign: TextAlign.start,
                  size: 14.0,
                ),
              ),
            ),
            TableCell(
              child: TextView(
                text:
                    // item.amount!.toStringAsFixed(2),
                    item.debitAmt != 0.00
                        ? item.debitAmt!.toStringAsFixed(2)
                        : (item.debitAmt == 0.00 && item.creditAmt == 0.00)
                        ? "0.00"
                        : item.creditAmt!.toStringAsFixed(2),
                textAlign: TextAlign.end,
                color:
                    item.debitAmt != 0.00
                        ? Colors.red
                        : (item.debitAmt == 0.00 && item.creditAmt == 0.00)
                        ? Colors.black
                        : Colors.green,
                size: 14.0,
              ),
            ),
            TableCell(
              child: TextView(
                // text: item.interest!.toStringAsFixed(2),
                text:
                    item.interestDr != 0.00
                        ? item.interestDr!.toStringAsFixed(2)
                        : (item.interestDr == 0.00 && item.interestCr == 0.00)
                        ? "0.00"
                        : item.interestCr!.toStringAsFixed(2),
                textAlign: TextAlign.end,
                color:
                    item.interestDr != 0.00
                        ? Colors.red
                        : (item.interestDr == 0.00 && item.interestCr == 0.00)
                        ? Colors.black
                        : Colors.green,
                size: 14.0,
              ),
            ),
            TableCell(
              child: TextView(
                // text: item.charges!.toStringAsFixed(2),
                text:
                    item.chrgDr != 0.00
                        ? item.chrgDr!.toStringAsFixed(2)
                        : (item.chrgDr == 0.00 && item.chrgCr == 0.00)
                        ? "0.00"
                        : item.chrgCr!.toStringAsFixed(2),
                textAlign: TextAlign.end,
                color:
                    item.chrgDr != 0.00
                        ? Colors.red
                        : (item.chrgDr == 0.00 && item.chrgCr == 0.00)
                        ? Colors.black
                        : Colors.green,
                size: 14.0,
              ),
            ),
            TableCell(
              child: TextView(
                // text: item.total!.toStringAsFixed(2),
                text:
                    item.totalDr != 0.00
                        ? item.totalDr!.toStringAsFixed(2)
                        : (item.totalDr == 0.00 && item.totalCr == 0.00)
                        ? "0.00"
                        : item.totalCr!.toStringAsFixed(2),
                textAlign: TextAlign.end,
                color:
                    item.totalDr != 0.00
                        ? Colors.red
                        : (item.totalDr == 0.00 && item.totalCr == 0.00)
                        ? Colors.black
                        : Colors.green,
                size: 14.0,
              ),
            ),
            TableCell(
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  vertical: 8.0,
                  horizontal: 5.0,
                ),
                child: TextView(
                  // text: item.balance!.toStringAsFixed(2),
                  text: item.totalAmt!.toStringAsFixed(2),
                  textAlign: TextAlign.end,
                  size: 14.0,
                ),
              ),
            ),
            TableCell(
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  vertical: 8.0,
                  horizontal: 5.0,
                ),
                child: TextView(
                  text: item.balAmt!.toStringAsFixed(2),
                  textAlign: TextAlign.end,
                  color:
                      // item.drcr!.toLowerCase() == "dr"
                      item.balType!.toLowerCase() == "dr"
                          ? Colors.red
                          : Colors.green,
                  size: 14.0,
                ),
              ),
            ),
            TableCell(
              child: TextView(
                text: item.remarks!,
                textAlign: TextAlign.end,
                size: 14.0,
              ),
            ),
          ],
        ),
      );
    });
    return tableRows;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        top: false,
        maintainBottomViewPadding: true,
        child: BlocBuilder<PassBookBloc, PassBookState>(
          buildWhen:
              (previous, current) =>
                  current is LoanTransactionLoading ||
                  current is LoanTransactionResponse ||
                  current is LoanTransactionErrorException,
          builder: (context, state) {
            if (state is PassBookBlocInitial) {
              return Center(child: CircularProgressIndicator());
            } else if (state is LoanTransactionLoading) {
              return Center(child: CircularProgressIndicator());
            } else if (state is LoanTransactionResponse) {
              if (state.loanTransList.isNotEmpty) {
                return CustomScrollView(
                  slivers: <Widget>[
                    SliverAppBar(
                      centerTitle: true,
                      title: Text(
                        "Loan Transaction",
                        style: TextStyle(color: Colors.white),
                      ),
                      leading: IconButton(
                        icon: Icon(
                          Icons.arrow_back,
                          color: Colors.white,
                          size: 30.0,
                        ),
                        onPressed: () => Navigator.of(context).pop(),
                      ),
                      floating: true,
                      pinned: true,
                      forceElevated: true,
                      bottom: PreferredSize(
                        preferredSize: Size.fromHeight(kToolbarHeight),
                        child: Table(
                          defaultVerticalAlignment:
                              TableCellVerticalAlignment.middle,
                          children: <TableRow>[TableRow(children: header())],
                        ),
                      ),
                    ),
                    SliverList(
                      delegate: SliverChildListDelegate([
                        Table(
                          defaultVerticalAlignment:
                              TableCellVerticalAlignment.middle,
                          children: rows(state.loanTransList),
                        ),
                      ]),
                    ),
                  ],
                );
              } else {
                // return Center(child: Text("No Data Found"));
                return Column(
                  children: [
                    Expanded(
                      child: CustomScrollView(
                        slivers: <Widget>[
                          SliverAppBar(
                            centerTitle: true,
                            title: Text(
                              "Loan Transaction",
                              style: TextStyle(color: Colors.white),
                            ),
                            leading: IconButton(
                              icon: Icon(
                                Icons.arrow_back,
                                color: Colors.white,
                                size: 30.0,
                              ),
                              onPressed: () => Navigator.of(context).pop(),
                            ),
                            floating: true,
                            pinned: true,
                            forceElevated: true,
                            bottom: PreferredSize(
                              preferredSize: Size.fromHeight(kToolbarHeight),
                              child: Table(
                                defaultVerticalAlignment:
                                    TableCellVerticalAlignment.middle,
                                children: <TableRow>[
                                  TableRow(children: header()),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Expanded(child: Text("No Data Found")),
                  ],
                );
              }
            } else if (state is LoanTransactionErrorException) {
              return Center(child: Text("Error : ${state.error}"));
            } else {
              return Center(child: Text("Something went Wrong"));
            }
          },
        ),
      ),
    );
  }
}
