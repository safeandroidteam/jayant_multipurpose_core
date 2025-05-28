import 'dart:convert';

AccountsShareModel transactionModelFromJson(String str) =>
    AccountsShareModel.fromJson(json.decode(str));

String transactionModelToJson(AccountsShareModel data) =>
    json.encode(data.toJson());

class AccountsShareModel {
  String proceedStatus;
  String proceedMessage;
  List<AccountsShareTable> data;

  AccountsShareModel({
    required this.proceedStatus,
    required this.proceedMessage,
    required this.data,
  });

  factory AccountsShareModel.fromJson(Map<String, dynamic> json) =>
      AccountsShareModel(
        proceedStatus: json["ProceedStatus"] ?? '',
        proceedMessage: json["ProceedMessage"] ?? '',
        data:
            json["Data"] == null
                ? []
                : List<AccountsShareTable>.from(
                  json["Data"]!.map((x) => AccountsShareTable.fromJson(x)),
                ),
      );

  Map<String, dynamic> toJson() => {
    "ProceedStatus": proceedStatus,
    "ProceedMessage": proceedMessage,
    "Data": data.map((x) => x.toJson()).toList(),
  };
}

class AccountsShareTable {
  int? custId;
  String? custName;
  String? custBranch;
  String? accNo;
  int? schCode;
  String? schName;
  int? brCode;
  String? shareBranch;
  double? balance;
  String? module;
  String? fullAddress;

  AccountsShareTable({
    required this.custId,
    required this.custName,
    required this.custBranch,
    required this.accNo,
    required this.schCode,
    required this.schName,
    required this.brCode,
    required this.shareBranch,
    required this.balance,
    required this.module,
    required this.fullAddress,
  });

  factory AccountsShareTable.fromJson(Map<String, dynamic> json) =>
      AccountsShareTable(
        custId: json["Cust_ID"],
        custName: json["Cust_Name"],
        custBranch: json["Cust_Branch"],
        accNo: json["ACC_No"],
        schCode: json["Sch_Code"],
        schName: json["Sch_Name"],
        brCode: json["BrCode"],
        shareBranch: json["ShareBranch"],
        balance: json["Balance"],
        module: json["Module"],
        fullAddress: json["Full_Address"],
      );

  Map<String, dynamic> toJson() => {
    "Cust_ID": custId,
    "Cust_Name": custName,
    "Cust_Branch": custBranch,
    "ACC_No": accNo,
    "Sch_Code": schCode,
    "Sch_Name": schName,
    "BrCode": brCode,
    "ShareBranch": shareBranch,
    "Balance": balance,
    "Module": module,
    "Full_Address": fullAddress,
  };
}
