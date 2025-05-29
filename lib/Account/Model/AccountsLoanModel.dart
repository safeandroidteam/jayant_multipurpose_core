import 'dart:convert';

AccountsLoanModel transactionModelFromJson(String str) =>
    AccountsLoanModel.fromJson(json.decode(str));

String transactionModelToJson(AccountsLoanModel data) =>
    json.encode(data.toJson());

class AccountsLoanModel {
  final String? proceedStatus;
  final String? proceedMessage;
  List<AccountsLoanTable> data;

  AccountsLoanModel({
    required this.proceedStatus,
    required this.proceedMessage,
    required this.data,
  });

  factory AccountsLoanModel.fromJson(Map<String, dynamic> json) =>
      AccountsLoanModel(
        proceedStatus: json["ProceedStatus"],
        proceedMessage: json["ProceedMessage"],
        data:
            json["Data"] == null
                ? []
                : List<AccountsLoanTable>.from(
                  json["Data"].map((x) => AccountsLoanTable.fromJson(x)),
                ),
      );

  Map<String, dynamic> toJson() => {
    "ProceedStatus": proceedStatus,
    "ProceedMessage": proceedMessage,
    "Data": List<dynamic>.from(data.map((x) => x.toJson())),
  };
}

class AccountsLoanTable {
  final int? accId;
  final int? custId;
  final String? custName;
  final String? fullAddress;
  final String? custBranch;
  final String? loanNo;
  final String? loanType;
  final int? schCode;
  final String? module;
  final double? balance;
  final double? interest;
  final double? odAmount;
  final double? odInterest;
  final String? surety;
  final int? loanBrCode;
  final double? intRate;
  final String? openDate;
  final String? dueDate;
  final String? loanBrName;

  AccountsLoanTable({
    this.accId,
    this.custId,
    this.custName,
    this.fullAddress,
    this.custBranch,
    this.loanNo,
    this.loanType,
    this.schCode,
    this.module,
    this.balance,
    this.interest,
    this.odAmount,
    this.odInterest,
    this.surety,
    this.loanBrCode,
    this.intRate,
    this.openDate,
    this.dueDate,
    this.loanBrName
  });

  factory AccountsLoanTable.fromJson(Map<String, dynamic> json) =>
      AccountsLoanTable(
        accId: json["Acc_ID"],
        custId: json["Cust_ID"],
        custName: json["Cust_Name"],
        fullAddress: json["Full_Address"],
        custBranch: json["Cust_Branch"],
        loanNo: json["LoanNo"],
        loanType: json["Loan_Type"],
        schCode: json["Sch_Code"],
        module: json["Module"],
        balance: json["Balance"],
        interest: json["Interest"],
        odAmount: json["ODAmount"],
        odInterest: json["OD_Interest"],
        surety: json["Surety"],
        loanBrCode: json["Loan_BrCode"],
        intRate: json["IntRate"],
        openDate: json["OpenDate"],
        dueDate: json["DueDate"],
        loanBrName:json["Loan_BrName"],
      );

  Map<String, dynamic> toJson() => {
    "Acc_ID": accId,
    "Cust_ID": custId,
    "Cust_Name": custName,
    "Full_Address": fullAddress,
    "Cust_Branch": custBranch,
    "LoanNo": loanNo,
    "Loan_Type": loanType,
    "Sch_Code": schCode,
    "Module": module,
    "Balance": balance,
    "Interest": interest,
    "ODAmount": odAmount,
    "OD_Interest": odInterest,
    "Surety": surety,
    "Loan_BrCode": loanBrCode,
    "IntRate": intRate,
    "OpenDate": openDate,
    "DueDate": dueDate,
    "Loan_BrName":loanBrName
  };
}
