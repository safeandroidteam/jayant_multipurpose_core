import 'package:date_format/date_format.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:passbook_core_jayant/Account/Model/AccountsDepositModel.dart';
import 'package:passbook_core_jayant/Account/Model/AccountsLoanModel.dart';
import 'package:passbook_core_jayant/Passbook/Model/PassbookListModel.dart';
import 'package:passbook_core_jayant/Util/util.dart';

import '../Account/Model/AccountsShareModel.dart';

double _height = 200.0;

BoxDecoration _boxDecoration({
  required BuildContext context,
  bool shadowDisabled = false,
}) => BoxDecoration(
  borderRadius: BorderRadius.circular(15.0),
  gradient: LinearGradient(
    begin: Alignment.topRight,
    end: Alignment.bottomLeft,
    stops: [0.5, 0.9],
    colors: [Theme.of(context).primaryColor, Theme.of(context).focusColor],
  ),
  boxShadow:
      shadowDisabled
          ? null
          : [
            BoxShadow(
              color: Colors.black45,
              offset: Offset(1.5, 1.5), //(x,y)
              blurRadius: 5.0,
              spreadRadius: 2.0,
            ),
          ],
);

class DepositCardModel extends StatelessWidget {
  final AccountsDepositTable? accountsDeposit;
  final Function? onPressed;

  const DepositCardModel({super.key, this.accountsDeposit, this.onPressed});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(15.0),
      onTap: onPressed as void Function()?,
      child: Container(
        height: _height,
        padding: EdgeInsets.all(10.0),
        decoration: _boxDecoration(
          context: context,
          shadowDisabled: onPressed == null,
        ),
        child: Stack(
          children: [
            Column(
              children: [
                TextView(
                  text: accountsDeposit!.accType ?? "NA",
                  size: 16.0,
                  color: Colors.white,
                  fontWeight: FontWeight.w700,
                ),
                SizedBox(height: 5.0),
                TextView(
                  text: accountsDeposit!.depBranch ?? "NA",
                  size: 16.0,
                  color: Colors.white,
                  fontWeight: FontWeight.w700,
                ),
              ],
            ),
            Align(
              alignment: Alignment.centerRight,
              child: TextView(
                text:
                    //  accountsDeposit.accNo.replaceAllMapped(RegExp(r".{5}"), (match) => "${match.group(0)} "),
                    accountsDeposit!.accNo ?? "NA",
                size: 22,
                color: Colors.white54,
              ),
            ),
            Align(
              alignment: Alignment.bottomRight,
              child: TextView(
                text:
                    "${StaticValues.rupeeSymbol}${accountsDeposit!.balance ?? "NA"}",
                color: Colors.white,
                size: 20.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            Align(
              alignment: Alignment.bottomLeft,
              child: Row(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Flexible(
                    fit: FlexFit.loose,
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        TextView(
                          text: "Nominee",
                          textAlign: TextAlign.center,
                          color: Colors.white,
                        ),
                        SizedBox(height: 5.0),
                        TextView(
                          text: accountsDeposit!.nominee ?? "NA",
                          textAlign: TextAlign.center,
                          color: Colors.white,
                        ),
                      ],
                    ),
                  ),
                  SizedBox(width: 20.0),
                  Flexible(
                    fit: FlexFit.loose,
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        TextView(
                          text: "Maturity Date",
                          textAlign: TextAlign.center,
                          color: Colors.white,
                        ),
                        SizedBox(height: 5.0),
                        TextView(
                          text: accountsDeposit!.dueDate ?? "NA",
                          textAlign: TextAlign.center,
                          color: Colors.white,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class LoanCardModel extends StatelessWidget {
  final AccountsLoanTable? accountsLoanTable;
  final Function? onPressed;

  const LoanCardModel({super.key, this.accountsLoanTable, this.onPressed});

  List<String> getDate(String rawDate) {
    final DateTime createdAt = DateFormat("dd/MM/yyyy").parse(rawDate);
    String s = formatDate(createdAt, [M, '\n', dd, '\n', yyyy]);
    var sp = s.split("\n");
    print("SP:: $sp");
    return sp;
  }

  @override
  Widget build(BuildContext context) {
    List<String> dateSplit = getDate(accountsLoanTable!.dueDate!);

    return InkWell(
      borderRadius: BorderRadius.circular(15.0),
      onTap: onPressed as void Function()?,
      child: Container(
        height: _height,
        padding: EdgeInsets.all(10.0),
        decoration: _boxDecoration(
          context: context,
          shadowDisabled: onPressed == null,
        ),
        child: Table(
          defaultVerticalAlignment: TableCellVerticalAlignment.top,
          columnWidths: {
            0: FractionColumnWidth(.75),
            1: FractionColumnWidth(.25),
          },
          children: [
            TableRow(
              children: [
                loanDetailWidget(accountsLoanTable!),
                Stack(
                  children: <Widget>[
                    Align(
                      alignment: Alignment.center,
                      child: Container(
                        margin: EdgeInsets.only(top: 5.0),
                        padding: EdgeInsets.symmetric(
                          vertical: 20.0,
                          horizontal: 20.0,
                        ),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10.0),
                          border: Border.all(width: 1.0, color: Colors.white),
                        ),
                        child: CustomText(
                          children: [
                            TextSpan(
                              text:
                                  dateSplit.isNotEmpty
                                      ? "${dateSplit[0]}\n"
                                      : "NA",
                              // text: "${result[0]}\n",
                              style: TextStyle(
                                fontSize: 16.0,
                                color: Colors.white,
                              ),
                            ),
                            TextSpan(
                              text:
                                  dateSplit.isNotEmpty
                                      ? "${dateSplit[1]}\n"
                                      : "NA",
                              // text: "${result[1]}\n",
                              style: TextStyle(
                                fontSize: 24.0,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                            ),
                            TextSpan(
                              text:
                                  dateSplit.isNotEmpty
                                      ? "${dateSplit[2]}\n"
                                      : "NA",
                              // text: "${result[2]}\n",
                              style: TextStyle(
                                fontSize: 14.0,
                                color: Colors.white,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Align(
                      alignment: Alignment.center,
                      child: Container(
                        padding: EdgeInsets.symmetric(horizontal: 3.0),
                        color: Theme.of(context).primaryColor,
                        child: TextView(
                          text: "Due Date",
                          size: keySize,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  static const double spaceBetween = 3.0;
  static const double keySize = 10.0;
  static const double valueSize = 11.0;

  Widget loanDetailWidget(AccountsLoanTable accountsLoanTable) {
    return Table(
      defaultVerticalAlignment: TableCellVerticalAlignment.middle,
      columnWidths: {
        0: FractionColumnWidth(.45),
        1: FractionColumnWidth(.05),
        2: FractionColumnWidth(.50),
      },
      children: <TableRow>[
        TableRow(
          children: <Widget>[
            TableCell(
              ///To give a space between each row
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: spaceBetween),
                child: TextView(
                  text: "Balance ${StaticValues.rupeeSymbol}",
                  size: keySize,
                  color: Colors.white,
                ),
              ),
            ),
            TableCell(child: TextView(text: ":", color: Colors.white)),
            TableCell(
              child: TextView(
                text: accountsLoanTable.balance!.toStringAsFixed(2) ?? "NA",
                size: 16.0,
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
        TableRow(
          children: <Widget>[
            TableCell(
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: spaceBetween),
                child: TextView(
                  text: "Overdue Amount ${StaticValues.rupeeSymbol}",
                  size: keySize,
                  color: Colors.white,
                ),
              ),
            ),
            TableCell(child: TextView(text: ":", color: Colors.white)),
            TableCell(
              child: TextView(
                text: "${accountsLoanTable.odAmount ?? "NA"}",
                size: valueSize,
                color: Colors.white,
              ),
            ),
          ],
        ),
        TableRow(
          children: <Widget>[
            TableCell(
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: spaceBetween),
                child: TextView(
                  text: "Overdue Interest ${StaticValues.rupeeSymbol}",
                  size: keySize,
                  color: Colors.white,
                ),
              ),
            ),
            TableCell(child: TextView(text: ":", color: Colors.white)),
            TableCell(
              child: TextView(
                text: "${accountsLoanTable.odInterest ?? "NA"}",
                size: valueSize,
                color: Colors.white,
              ),
            ),
          ],
        ),
        TableRow(
          children: <Widget>[
            TableCell(
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: spaceBetween),
                child: TextView(
                  text:
                      "Interest @${accountsLoanTable.intRate.toString().isNotEmpty ? "${accountsLoanTable.intRate}%" : " NA"}",
                  size: keySize,
                  color: Colors.white,
                ),
              ),
            ),
            TableCell(child: TextView(text: ":", color: Colors.white)),
            TableCell(
              child: TextView(
                text: "${accountsLoanTable.interest ?? "NA"}",
                size: valueSize,
                color: Colors.white,
              ),
            ),
          ],
        ),
        TableRow(
          children: <Widget>[
            TableCell(
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: spaceBetween),
                child: TextView(
                  text: "Loan ID",
                  size: keySize,
                  color: Colors.white,
                ),
              ),
            ),
            TableCell(child: TextView(text: ":", color: Colors.white)),
            TableCell(
              child: TextView(
                text: accountsLoanTable.loanNo ?? "NA",
                size: valueSize,
                color: Colors.white,
              ),
            ),
          ],
        ),
        TableRow(
          children: <Widget>[
            TableCell(
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: spaceBetween),
                child: TextView(
                  text: "Loan Type",
                  size: keySize,
                  color: Colors.white,
                ),
              ),
            ),
            TableCell(child: TextView(text: ":", color: Colors.white)),
            TableCell(
              child: TextView(
                text: accountsLoanTable.loanType ?? "NA",
                color: Colors.white,
                size: valueSize,
              ),
            ),
          ],
        ),
        TableRow(
          children: <Widget>[
            TableCell(
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: spaceBetween),
                child: TextView(
                  text: "Loan Branch",
                  color: Colors.white,
                  size: keySize,
                ),
              ),
            ),
            TableCell(child: TextView(text: ":", color: Colors.white)),
            TableCell(
              child: TextView(
                text: accountsLoanTable.loanBrName ?? "NA",
                size: valueSize,
                color: Colors.white,
              ),
            ),
          ],
        ),
        TableRow(
          children: <Widget>[
            TableCell(
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: spaceBetween),
                child: TextView(
                  text: "Suerty",
                  size: keySize,
                  color: Colors.white,
                ),
              ),
            ),
            TableCell(child: TextView(text: ":", color: Colors.white)),
            TableCell(
              child: TextView(
                text: accountsLoanTable.surety ?? "NA",
                color: Colors.white,
                size: valueSize,
              ),
            ),
          ],
        ),
      ],
    );
  }
}

class ChittyCardModel extends StatelessWidget {
  final PassbookItem? chittyListTable;

  final Function? onPressed;

  const ChittyCardModel({super.key, this.chittyListTable, this.onPressed});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(15.0),
      onTap: onPressed as void Function()?,
      child: Container(
        height: _height,
        padding: EdgeInsets.all(10.0),
        decoration: _boxDecoration(
          context: context,
          shadowDisabled: onPressed == null,
        ),
        child: Stack(
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                TextView(
                  text:
                      chittyListTable!.schName!.isNotEmpty
                          ? chittyListTable!.schName!
                          : "NA",
                  size: 16.0,
                  color: Colors.white,
                  textAlign: TextAlign.start,
                  fontWeight: FontWeight.w700,
                ),
                SizedBox(height: 5.0),
                TextView(
                  text:
                      chittyListTable!.depBranch!.isNotEmpty
                          ? chittyListTable!.depBranch!
                          : "NA",
                  size: 16.0,
                  color: Colors.white,
                  textAlign: TextAlign.start,
                  fontWeight: FontWeight.w700,
                ),
              ],
            ),
            Align(
              alignment: Alignment.centerRight,
              child: TextView(
                text:
                    chittyListTable!.accNo!.isNotEmpty
                        ? chittyListTable!.accNo!
                        : "NA",
                size: 22,
                color: Colors.white54,
              ),
            ),
            Align(
              alignment: Alignment.bottomRight,
              child: TextView(
                text:
                    "${StaticValues.rupeeSymbol}${chittyListTable!.balance!.toStringAsFixed(2)}",
                color: Colors.white,
                size: 20.0,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class ShareCardModel extends StatelessWidget {
  // final PassbookItem? shareListTable;
  final AccountsShareTable? accountsShare;
  final Function? onPressed;

  const ShareCardModel({super.key, this.accountsShare, this.onPressed});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(15.0),
      onTap: onPressed as void Function()?,
      child: Container(
        height: _height,
        padding: EdgeInsets.all(10.0),
        decoration: _boxDecoration(
          context: context,
          shadowDisabled: onPressed == null,
        ),
        child: Stack(
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                TextView(
                  text: accountsShare!.schName ?? "NA",
                  size: 16.0,
                  color: Colors.white,
                  textAlign: TextAlign.start,
                  fontWeight: FontWeight.w700,
                ),
                SizedBox(height: 5.0),
                TextView(
                  text: accountsShare!.shareBranch ?? "NA",
                  size: 16.0,
                  color: Colors.white,
                  textAlign: TextAlign.start,
                  fontWeight: FontWeight.w700,
                ),
              ],
            ),
            Align(
              alignment: Alignment.centerRight,
              child: TextView(
                text:
                    //  shareListTable.accNo.replaceAllMapped(RegExp(r".{5}"), (match) => "${match.group(0)} "),
                    accountsShare!.accNo ?? "NA",
                size: 22,
                color: Colors.white54,
              ),
            ),
            Align(
              alignment: Alignment.bottomRight,
              child: TextView(
                text:
                    "${StaticValues.rupeeSymbol}${accountsShare!.balance!.toStringAsFixed(2)}",
                color: Colors.white,
                size: 20.0,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
