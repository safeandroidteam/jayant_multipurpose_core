import 'package:flutter/material.dart';
import 'package:passbook_core_jayant/Passbook/ChittyTransaction.dart';
import 'package:passbook_core_jayant/Passbook/LoanTransaction.dart';
import 'package:passbook_core_jayant/Passbook/Model/PassbookListModel.dart';
import 'package:passbook_core_jayant/Util/custom_print.dart';
import 'package:passbook_core_jayant/Util/util.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../REST/RestAPI.dart';

class ChittyLoan extends StatefulWidget {
  ///if [type] is null it will show loan details. if it is "MMBS" it show chitty details.
  final String type;

  ///if [isAccount] is true it will not show view details button.
  final bool isAccount;

  const ChittyLoan({super.key, required this.type, this.isAccount = true});

  @override
  _ChittyLoanState createState() => _ChittyLoanState();
}

class _ChittyLoanState extends State<ChittyLoan> {
  bool? isShare; // Initialize with default value

  Future<List<PassbookItem>> getChittyShare() async {
    SharedPreferences pref = await SharedPreferences.getInstance();

    Map<String, dynamic> res = await RestAPI().get(
      "${APis.otherAccListInfo}${pref.getString(StaticValues.custID)}&Acc_Type=${widget.type ?? "LN"}",
    );
    successPrint("${widget.type} Data in Chitty Loan page=$res");
    PassbookListModel transactionModel = PassbookListModel.fromJson(res);
    return transactionModel.table!;
  }

  static const double spaceBetween = 3.0;

  Widget accountDetailWidget(PassbookItem passbookTable) {
    return Card(
      elevation: 3.0,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: <Widget>[
            Table(
              defaultVerticalAlignment: TableCellVerticalAlignment.middle,
              columnWidths: {
                0: FractionColumnWidth(.40),
                1: FractionColumnWidth(.10),
                2: FractionColumnWidth(.50),
              },
              children: <TableRow>[
                TableRow(
                  children: <Widget>[
                    TableCell(
                      ///To give a space between each row
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                          vertical: spaceBetween,
                        ),
                        child: TextView(
                          "Balance ${StaticValues.rupeeSymbol}",
                          size: 12.0,
                        ),
                      ),
                    ),
                    TableCell(child: TextView( ":")),
                    TableCell(
                      child: TextView(
                        passbookTable.balance!.toStringAsFixed(2),
                        size: 16.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
                TableRow(
                  children: <Widget>[
                    TableCell(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                          vertical: spaceBetween,
                        ),
                        child: TextView( "Account Number", size: 12.0),
                      ),
                    ),
                    TableCell(child: TextView( ":")),
                    TableCell(
                      child: TextView(
                        "${passbookTable.accNo}",
                        size: 12.0,
                      ),
                    ),
                  ],
                ),
                TableRow(
                  children: <Widget>[
                    TableCell(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                          vertical: spaceBetween,
                        ),
                        child: TextView(
                         
                              isShare == null
                                  ? "Loan"
                                  : isShare == true
                                  ? "Share Type"
                                  : "Chitty Type",
                          size: 12.0,
                        ),
                      ),
                    ),
                    TableCell(child: TextView( ":")),
                    TableCell(
                      child: TextView(
                        "${passbookTable.schName}",
                        size: 12.0,
                      ),
                    ),
                  ],
                ),
                TableRow(
                  children: <Widget>[
                    TableCell(
                      child: Padding(
                        padding:  EdgeInsets.symmetric(
                          vertical: spaceBetween,
                        ),
                        child: TextView( "Account Branch", size: 12.0),
                      ),
                    ),
                    TableCell(child: TextView( ":")),
                    TableCell(
                      child: TextView(
                        "${passbookTable.depBranch}",
                        size: 12.0,
                      ),
                    ),
                  ],
                ),
              ],
            ),
            Visibility(
              visible: !widget.isAccount,
              child: InkWell(
                borderRadius: BorderRadius.circular(100.0),
                splashColor: Theme.of(context).primaryColor,
                onTap:
                    () => Navigator.of(context).push(
                      MaterialPageRoute(
                        builder:
                            (context) =>
                                isShare == null
                                    ? LoanTransaction(
                                      accNo: passbookTable.accNo!,
                                    )
                                    : ChittyTransaction(
                                      accNo: passbookTable.accNo!,
                                    ),
                      ),
                    ),
                child: Card(
                  elevation: 3.0,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(100.0),
                  ),
                  color: Theme.of(context).dividerColor,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextView(
                      "view details",
                      size: 12.0,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  void initState() {
    isShare = widget.type == "LN" ? null : widget.type.toLowerCase() == "sh";
    warningPrint("isShare=$isShare");
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: Text(
          isShare == null
              ? "Loan"
              : isShare == true
              ? "Share"
              : "Chitty",
          style: TextStyle(color: Colors.white),
        ),
      ),
      body: FutureBuilder<List<PassbookItem>?>(
        future: getChittyShare(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Stack(
              children: [Center(child: CircularProgressIndicator())],
            );
          }
          if (!snapshot.hasData) {
            return Stack(
              children: [
                Center(
                  child: TextView(
                   
                        "You don't have a ${widget.type == "" ? 'loan' : 'chitty'} in this bank",
                  ),
                ),
              ],
            );
          } else {
            if (snapshot.data!.isNotEmpty)
              return SingleChildScrollView(
                child: SafeArea(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      children: <Widget>[
                        ListTile(
                          title: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              TextView(
                                snapshot.data![0].custName!,
                                size: 16.0,
                              ),
                              Text(
                                snapshot.data![0].address!.split(",").join(","),
                              ),
                            ],
                          ),
                          subtitle: Text(
                            snapshot.data![0].brName!,
                            style: TextStyle(fontSize: 12.0),
                          ),
                        ),
                        ListView.builder(
                          shrinkWrap: true,
                          physics: NeverScrollableScrollPhysics(),
                          itemCount: snapshot.data!.length,
                          itemBuilder: (context, index) {
                            return accountDetailWidget(snapshot.data![index]);
                          },
                        ),
                      ],
                    ),
                  ),
                ),
              );
            else
              return Stack(
                children: [
                  Center(
                    child: TextView(
                     
                          "You don't have a ${widget.type == "LN" ? 'loan' : 'chitty'} in this bank",
                    ),
                  ),
                ],
              );
          }
        },
      ),
    );
  }
}
