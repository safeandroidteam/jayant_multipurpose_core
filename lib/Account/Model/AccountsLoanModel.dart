import 'dart:convert';

AccountsLoanModel transactionModelFromJson(String str) =>
    AccountsLoanModel.fromJson(json.decode(str));

String transactionModelToJson(AccountsLoanModel data) =>
    json.encode(data.toJson());

class AccountsLoanModel {
  List<AccountsLoanTable> table;

  AccountsLoanModel({
    this.table = const [], // Default to empty list if null
  });

  factory AccountsLoanModel.fromJson(Map<String, dynamic> json) =>
      AccountsLoanModel(
        table:
            json["Table"] == null
                ? []
                : List<AccountsLoanTable>.from(
                  json["Table"].map((x) => AccountsLoanTable.fromJson(x)),
                ),
      );

  Map<String, dynamic> toJson() => {
    "Table": List<dynamic>.from(table.map((x) => x.toJson())),
  };
}

class AccountsLoanTable {
  double accId;
  String custId;
  String name;
  String address;
  String custBranch;
  String loanNo;
  String loanType;
  String loanBranch;
  double balance;
  double intrest;
  double overdueAmnt;
  double overdueIntrest;
  String suerty;
  String module;
  String schemeCode;
  String loanbranchCode;
  double intrestRate;
  String loanDate;
  String dueDate;

  AccountsLoanTable({
    required this.accId,
    required this.custId,
    required this.name,
    required this.address,
    required this.custBranch,
    required this.loanNo,
    required this.loanType,
    required this.loanBranch,
    required this.balance,
    required this.intrest,
    required this.overdueAmnt,
    required this.overdueIntrest,
    required this.suerty,
    required this.module,
    required this.schemeCode,
    required this.loanbranchCode,
    required this.intrestRate,
    required this.loanDate,
    required this.dueDate,
  });

  factory AccountsLoanTable.fromJson(Map<String, dynamic> json) =>
      AccountsLoanTable(
        accId: json["Acc_ID"] == null ? 0.0 : json["Acc_ID"].toDouble(),
        custId: json["Cust_id"] ?? '',
        name: json["Name"] ?? '',
        address: json["Addrs"] ?? '',
        custBranch: json["cust_br"] ?? '',
        loanNo: json["Loan_no"] ?? '',
        loanType: json["Loan_type"] ?? '',
        loanBranch: json["Loan_br"] ?? '',
        balance: json["Balance"] == null ? 0.0 : json["Balance"].toDouble(),
        intrest: json["Interest"] == null ? 0.0 : json["Interest"].toDouble(),
        overdueAmnt:
            json["OverDue_Amt"] == null ? 0.0 : json["OverDue_Amt"].toDouble(),
        overdueIntrest:
            json["OverDue_Int"] == null ? 0.0 : json["OverDue_Int"].toDouble(),
        suerty: json["Suerty"] ?? '',
        module: json["Module"] ?? '',
        schemeCode: json["Sch_code"] ?? '',
        loanbranchCode: json["Ln_Br_Code"] ?? '',
        intrestRate:
            json["Int_Rate"] == null ? 0.0 : json["Int_Rate"].toDouble(),
        loanDate: json["Loan_date"] ?? '',
        dueDate: json["Due_date"] ?? '',
      );

  Map<String, dynamic> toJson() => {
    "Acc_ID": accId,
    "Cust_id": custId,
    "Name": name,
    "Addrs": address,
    "cust_br": custBranch,
    "Loan_no": loanNo,
    "Loan_type": loanType,
    "Loan_br": loanBranch,
    "Balance": balance,
    "Interest": intrest,
    "OverDue_Amt": overdueAmnt,
    "OverDue_Int": overdueIntrest,
    "Suerty": suerty,
    "Module": module,
    "Sch_code": schemeCode,
    "Ln_Br_Code": loanbranchCode,
    "Int_Rate": intrestRate,
    "Loan_date": loanDate,
    "Due_date": dueDate,
  };
}
