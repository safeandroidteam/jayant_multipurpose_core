import 'dart:convert';

AccountsLoanModel transactionModelFromJson(String str) =>
    AccountsLoanModel.fromJson(json.decode(str));

String transactionModelToJson(AccountsLoanModel data) =>
    json.encode(data.toJson());

class AccountsLoanModel {
  List<AccountsLoanTable> data;

  AccountsLoanModel({this.data = const []});

  factory AccountsLoanModel.fromJson(Map<String, dynamic> json) =>
      AccountsLoanModel(
        data:
            json["Data"] == null
                ? []
                : List<AccountsLoanTable>.from(
                  json["Data"].map((x) => AccountsLoanTable.fromJson(x)),
                ),
      );

  Map<String, dynamic> toJson() => {
    "Data": List<dynamic>.from(data.map((x) => x.toJson())),
  };
}

class AccountsLoanTable {
  dynamic custId;
  dynamic custName;
  dynamic address;
  dynamic brCode;
  dynamic brName;
  dynamic schCode;
  dynamic schName;
  dynamic module;
  dynamic depBranch;
  dynamic balance;

  AccountsLoanTable({
    this.custId,
    this.custName,
    this.address,
    this.brCode,
    this.brName,
    this.schCode,
    this.schName,
    this.module,
    this.depBranch,
    this.balance,
  });

  factory AccountsLoanTable.fromJson(Map<String, dynamic> json) =>
      AccountsLoanTable(
        custId: json["Cust_ID"],
        custName: json["Cust_Name"],
        address: json["Address"],
        brCode: json["Br_Code"],
        brName: json["Br_Name"],
        schCode: json["Sch_Code"],
        schName: json["Sch_Name"],
        module: json["Module"],
        depBranch: json["Dep_Branch"],
        balance: json["Balance"],
      );

  Map<String, dynamic> toJson() => {
    "Cust_ID": custId,
    "Cust_Name": custName,
    "Address": address,
    "Br_Code": brCode,
    "Br_Name": brName,
    "Sch_Code": schCode,
    "Sch_Name": schName,
    "Module": module,
    "Dep_Branch": depBranch,
    "Balance": balance,
  };
}
