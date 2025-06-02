import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../Util/GlobalWidgets.dart';
import '../Util/StaticValue.dart';
import 'Model/ChittyLoanTransModel.dart';
import 'bloc/pass_book_bloc.dart';

class ChittyTransaction extends StatefulWidget {
  // final String? accNo;
  final int? accID;

  const ChittyTransaction({Key? key, this.accID}) : super(key: key);

  @override
  _ChittyTransactionState createState() => _ChittyTransactionState();
}

class _ChittyTransactionState extends State<ChittyTransaction> {
  // late ChittyTransModel _chittyTransModel;
  late SharedPreferences preferences;
  var cmpCode;

  loadChittyTransactions() async {
    preferences = await SharedPreferences.getInstance();

    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      final passBookBloc = PassBookBloc.get(context);
      cmpCode = preferences.getString(StaticValues.cmpCodeKey) ?? "";
      passBookBloc.add(ChittyLoanTransEvent(cmpCode, widget.accID ?? 0));
      // passBookBloc.add(ChittyLoanTransEvent(cmpCode, 200873));
    });
  }

  @override
  void initState() {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.landscapeLeft,
      DeviceOrientation.landscapeRight,
    ]);

    loadChittyTransactions();
    super.initState();
  }

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

  // List<TableRow> rows(List<ChittyTransTable> chittyTransTable) {
  List<TableRow> rows(List<ChittyLoanTransData> chittyLoanTransData) {
    List<TableRow> tableRows = [];
    chittyLoanTransData.asMap().forEach((index, item) {
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
                  current is ChittyLoanTransLoading ||
                  current is ChittyLoanTransResponse ||
                  current is ChittyLoanTransErrorException,
          builder: (context, state) {
            if (state is PassBookBlocInitial) {
              return Center(child: CircularProgressIndicator());
            } else if (state is ChittyLoanTransLoading) {
              return Center(child: CircularProgressIndicator());
            } else if (state is ChittyLoanTransResponse) {
              if (state.chittyLoanTransList.isNotEmpty) {
                return CustomScrollView(
                  slivers: <Widget>[
                    SliverAppBar(
                      centerTitle: true,
                      title: Text(
                        "Chitty Transaction",
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
                        child: Table(
                          defaultVerticalAlignment:
                              TableCellVerticalAlignment.middle,
                          children: <TableRow>[TableRow(children: header())],
                        ),
                        preferredSize: Size.fromHeight(kToolbarHeight),
                      ),
                    ),
                    SliverList(
                      delegate: SliverChildListDelegate([
                        Table(
                          defaultVerticalAlignment:
                              TableCellVerticalAlignment.middle,
                          children: rows(state.chittyLoanTransList),
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
                              "Chitty Transaction",
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
            } else if (state is ChittyLoanTransErrorException) {
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
