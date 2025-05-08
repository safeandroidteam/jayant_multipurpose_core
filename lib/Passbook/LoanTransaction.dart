import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:passbook_core_jayant/Passbook/Model/LoanTransModel.dart';
import 'package:passbook_core_jayant/Passbook/bloc/pass_book_bloc.dart';

import '../Util/GlobalWidgets.dart';

class LoanTransaction extends StatefulWidget {
  final String? accNo;

  const LoanTransaction({super.key, this.accNo});

  @override
  _LoanTransactionState createState() => _LoanTransactionState();
}

class _LoanTransactionState extends State<LoanTransaction> {
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
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      final passBookBloc = PassBookBloc.get(context);

      passBookBloc.add(LoanTransEvent(widget.accNo ?? ""));
    });
  }

  List<Widget> header() {
    return [
      TableCell(
        child: ListTile(
          dense: true,
          contentPadding: EdgeInsets.symmetric(horizontal: 5.0),
          title: TextView(text:
            "Date",
            textAlign: TextAlign.start,
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      TableCell(
        child: TextView(text:
          "Amount",
          textAlign: TextAlign.end,
          color: Colors.white,
          fontWeight: FontWeight.bold,
        ),
      ),
      TableCell(
        child: TextView(text:
          "Interest",
          textAlign: TextAlign.end,
          color: Colors.white,
          fontWeight: FontWeight.bold,
        ),
      ),
      TableCell(
        child: TextView(text:
          "Charges",
          textAlign: TextAlign.end,
          color: Colors.white,
          fontWeight: FontWeight.bold,
        ),
      ),
      TableCell(
        child: TextView(text:
          "Total",
          textAlign: TextAlign.end,
          fontWeight: FontWeight.bold,
          color: Colors.white,
        ),
      ),
      TableCell(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 5.0),
          child: TextView(text:
            "Balance",
            textAlign: TextAlign.end,
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    ];
  }

  List<TableRow> rows(List<LoanTransTable> loanTransTable) {
    List<TableRow> tableRows = [];
    loanTransTable.asMap().forEach((index, item) {
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
                child: TextView(text:
                  item.trdate!.replaceAll("/", "-"),
                  textAlign: TextAlign.start,
                  size: 14.0,
                ),
              ),
            ),
            TableCell(
              child: TextView(text:
                item.amount!.toStringAsFixed(2),
                textAlign: TextAlign.end,
                color:
                    item.drcr!.toLowerCase() == "dr"
                        ? Colors.red
                        : Colors.green,
                size: 14.0,
              ),
            ),
            TableCell(
              child: TextView(text:
                item.interest!.toStringAsFixed(2),
                textAlign: TextAlign.end,
                size: 14.0,
              ),
            ),
            TableCell(
              child: TextView(text:
                item.charges!.toStringAsFixed(2),
                textAlign: TextAlign.end,
                size: 14.0,
              ),
            ),
            TableCell(
              child: TextView(text:
                item.total!.toStringAsFixed(2),
                textAlign: TextAlign.end,
                size: 14.0,
              ),
            ),
            TableCell(
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  vertical: 8.0,
                  horizontal: 5.0,
                ),
                child: TextView(text:
                  item.balance!.toStringAsFixed(2),
                  textAlign: TextAlign.end,
                  size: 14.0,
                ),
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
                return Center(child: Text("No Data Found"));
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
