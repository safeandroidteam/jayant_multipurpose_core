// class LoanTransModel {
//   List<LoanTransTable>? table;
//
//   LoanTransModel({
//     this.table,
//   });
//
//   factory LoanTransModel.fromJson(Map<String, dynamic> json) => LoanTransModel(
//         table: List<LoanTransTable>.from(json["Table"].map((x) => LoanTransTable.fromJson(x))),
//       );
//
//   Map<String, dynamic> toJson() => {
//         "Table": List<dynamic>.from(table!.map((x) => x.toJson())),
//       };
// }
//
// class LoanTransTable {
//   String? trdate;
//   double? amount;
//   String? drcr;
//   double? interest;
//   double? charges;
//   double? total;
//   double? balance;
//   String? narration;
//
//   LoanTransTable({
//     this.trdate,
//     this.amount,
//     this.drcr,
//     this.interest,
//     this.charges,
//     this.total,
//     this.balance,
//     this.narration,
//   });
//
//   factory LoanTransTable.fromJson(Map<String, dynamic> json) => LoanTransTable(
//         trdate: json["TRDATE"],
//         amount: json["AMOUNT"],
//         drcr: json["DRCR"],
//         interest: json["INTEREST"],
//         charges: json["CHARGES"],
//         total: json["TOTAL"],
//         balance: json["BALANCE"],
//         narration: json["NARRATION"],
//       );
//
//   Map<String, dynamic> toJson() => {
//         "TRDATE": trdate,
//         "AMOUNT": amount,
//         "DRCR": drcr,
//         "INTEREST": interest,
//         "CHARGES": charges,
//         "TOTAL": total,
//         "BALANCE": balance,
//         "NARRATION": narration,
//       };
// }

class ChittyLoanTransModel {
  ChittyLoanTransModel({
    required this.proceedStatus,
    required this.proceedMessage,
    required this.data,
  });

  final String? proceedStatus;
  final String? proceedMessage;
  final List<ChittyLoanTransData>? data;

  factory ChittyLoanTransModel.fromJson(Map<String, dynamic> json) {
    return ChittyLoanTransModel(
      proceedStatus: json["ProceedStatus"],
      proceedMessage: json["ProceedMessage"],
      // data: json["Data"] == null ? [] : List<LoanTransData>.from(json["Data"]!.map((x) => LoanTransData.fromJson(x))),
      data: List<ChittyLoanTransData>.from(
        json["Table"].map((x) => ChittyLoanTransData.fromJson(x)),
      ),
    );
  }

  Map<String, dynamic> toJson() => {
    "ProceedStatus": proceedStatus,
    "ProceedMessage": proceedMessage,
    // "Data": data!.map((x) => x?.toJson()).toList(),
    "Data": List<dynamic>.from(data!.map((x) => x.toJson())),
  };
}

class ChittyLoanTransData {
  ChittyLoanTransData({
    this.trDate,
    this.creditAmt,
    this.debitAmt,
    this.interestCr,
    this.interestDr,
    this.chrgCr,
    this.chrgDr,
    this.totalCr,
    this.totalDr,
    this.totalAmt,
    this.balAmt,
    this.balType,
    this.remarks,
  });

  String? trDate;
  double? creditAmt;
  double? debitAmt;
  double? interestCr;
  double? interestDr;
  double? chrgCr;
  double? chrgDr;
  double? totalCr;
  double? totalDr;
  double? totalAmt;
  double? balAmt;
  String? balType;
  String? remarks;

  factory ChittyLoanTransData.fromJson(Map<String, dynamic> json) {
    return ChittyLoanTransData(
      trDate: json["Tr_Date"],
      creditAmt: json["Credit_Amt"],
      debitAmt: json["Debit_Amt"],
      interestCr: json["Interest_Cr"],
      interestDr: json["Interest_Dr"],
      chrgCr: json["Chrg_Cr"],
      chrgDr: json["Chrg_Dr"],
      totalCr: json["Total_Cr"],
      totalDr: json["Total_Dr"],
      totalAmt: json["Total_Amt"],
      balAmt: json["Bal_Amt"],
      balType: json["Bal_Type"],
      remarks: json["Remarks"],
    );
  }

  Map<String, dynamic> toJson() => {
    "Tr_Date": trDate,
    "Credit_Amt": creditAmt,
    "Debit_Amt": debitAmt,
    "Interest_Cr": interestCr,
    "Interest_Dr": interestDr,
    "Chrg_Cr": chrgCr,
    "Chrg_Dr": chrgDr,
    "Total_Cr": totalCr,
    "Total_Dr": totalDr,
    "Total_Amt": totalAmt,
    "Bal_Amt": balAmt,
    "Bal_Type": balType,
    "Remarks": remarks,
  };
}
