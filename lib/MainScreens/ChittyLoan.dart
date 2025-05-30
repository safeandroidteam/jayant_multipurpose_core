import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:passbook_core_jayant/Passbook/ChittyTransaction.dart';
import 'package:passbook_core_jayant/Passbook/LoanTransaction.dart';
import 'package:passbook_core_jayant/Passbook/Model/PassbookListModel.dart';
import 'package:passbook_core_jayant/Passbook/bloc/pass_book_bloc.dart';
import 'package:passbook_core_jayant/Util/custom_print.dart';
import 'package:passbook_core_jayant/Util/util.dart';
import 'package:shared_preferences/shared_preferences.dart';

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
  var id;
  var cmpCode;
  var section;
  static const double spaceBetween = 3.0;
  late SharedPreferences preferences;
  loadDPShCard() async {
    preferences = await SharedPreferences.getInstance();

    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      final passBookBloc = PassBookBloc.get(context);

      id = preferences.getString(StaticValues.custID) ?? "";
      cmpCode = preferences.getString(StaticValues.cmpCodeKey) ?? "";
      alertPrint("widget type =${widget.type}");
      switch (widget.type) {
        case "DP":
          section = "Deposit";
          break;
        case "SH":
          section = "Share";
          break;
        case "LN":
          section = "Loan";
          break;
        default:
          section = "Chitty";
      }

      warningPrint("section =$section");
      passBookBloc.add(ChittyLoanEvent(id, cmpCode, section ?? ""));
    });
  }

  @override
  void initState() {
    isShare = widget.type == "LN" ? null : widget.type.toLowerCase() == "sh";
    warningPrint("isShare=$isShare");
    loadDPShCard();
    super.initState();
  }

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
                          text: "Balance ${StaticValues.rupeeSymbol}",
                          size: 12.0,
                        ),
                      ),
                    ),
                    TableCell(child: TextView(text: ":")),
                    TableCell(
                      child: TextView(
                        text: passbookTable.balance!.toStringAsFixed(2),
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
                        child: TextView(text: "Account Number", size: 12.0),
                      ),
                    ),
                    TableCell(child: TextView(text: ":")),
                    TableCell(
                      child: TextView(
                        text: passbookTable.accNo ?? "",
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
                          text:
                              isShare == null
                                  ? "Loan"
                                  : isShare == true
                                  ? "Share Type"
                                  : "Chitty Type",
                          size: 12.0,
                        ),
                      ),
                    ),
                    TableCell(child: TextView(text: ":")),
                    TableCell(
                      child: TextView(
                        text: passbookTable.schName ?? "",
                        size: 12.0,
                      ),
                    ),
                  ],
                ),
                TableRow(
                  children: <Widget>[
                    TableCell(
                      child: Padding(
                        padding: EdgeInsets.symmetric(vertical: spaceBetween),
                        child: TextView(text: "Account Branch", size: 12.0),
                      ),
                    ),
                    TableCell(child: TextView(text: ":")),
                    TableCell(
                      child: TextView(
                        text: passbookTable.depBranch ?? "",
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
                                      accID: passbookTable.accId,
                                    )
                                    : ChittyTransaction(
                                      accNo: passbookTable.accNo,
                                    ),
                      ),
                    ),
                child: Card(
                  elevation: 3.0,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(100.0),
                  ),
                  color: Theme.of(context).primaryColor,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextView(
                      text: "view details",
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
      body: BlocBuilder<PassBookBloc, PassBookState>(
        buildWhen:
            (previous, current) =>
                current is ChittyLoanLoading ||
                current is ChittyLoanResponse ||
                current is ChittyLoanErrorException,

        builder: (context, state) {
          if (state is PassBookBlocInitial) {
            return Stack(
              children: [Center(child: CircularProgressIndicator())],
            );
          }
          if (state is ChittyLoanLoading) {
            return Stack(
              children: [Center(child: CircularProgressIndicator())],
            );
          } else if (state is ChittyLoanResponse) {
            if (state.passbookItemList.isEmpty) {
              return Stack(
                children: [
                  Center(
                    child: TextView(
                      text:
                          "You don't have a ${widget.type == "" ? 'loan' : 'chitty'} in this bank",
                    ),
                  ),
                ],
              );
            } else {
              var address = state.passbookItemList[0].address ?? "";
              var clenaedAddress =
                  address.replaceAll(RegExp(r'\s+'), ' ').trim();
              successPrint("clean address =$address");
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
                                text: state.passbookItemList[0].custName ?? "",
                                size: 16.0,
                              ),
                              Text(clenaedAddress),
                            ],
                          ),
                          subtitle: Text(
                            state.passbookItemList[0].brName ?? "",
                            style: TextStyle(fontSize: 12.0),
                          ),
                        ),
                        ListView.builder(
                          shrinkWrap: true,
                          physics: NeverScrollableScrollPhysics(),
                          itemCount: state.passbookItemList.length,
                          itemBuilder: (context, index) {
                            return accountDetailWidget(
                              state.passbookItemList[index],
                            );
                          },
                        ),
                      ],
                    ),
                  ),
                ),
              );
            }
          } else if (state is ChittyLoanErrorException) {
            return Stack(
              children: [
                Center(child: TextView(text: "Error :${state.error}")),
              ],
            );
          } else {
            return Stack(
              children: [
                Center(
                  child: TextView(
                    text:
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
