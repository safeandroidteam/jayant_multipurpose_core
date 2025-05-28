import 'dart:convert';

AccountsDepositModel transactionModelFromJson(String str) =>
    AccountsDepositModel.fromJson(json.decode(str));

String transactionModelToJson(AccountsDepositModel data) =>
    json.encode(data.toJson());

class AccountsDepositModel {
  String proceedStatus;
  String proceedMessage;
  List<AccountsDepositTable> data;

  AccountsDepositModel({
    required this.proceedStatus,
    required this.proceedMessage,
    required this.data,
  });

  factory AccountsDepositModel.fromJson(Map<String, dynamic> json) =>
      AccountsDepositModel(
        proceedStatus: json["ProceedStatus"] ?? '',
        proceedMessage: json["ProceedMessage"] ?? '',
        data:
            json["Data"] == null
                ? []
                : List<AccountsDepositTable>.from(
                  json["Data"]!.map((x) => AccountsDepositTable.fromJson(x)),
                ),
      );

  Map<String, dynamic> toJson() => {
    "ProceedStatus": proceedStatus,
    "ProceedMessage": proceedMessage,
    "Data": data.map((x) => x.toJson()).toList(),
  };
}

class AccountsDepositTable {
  int? custId;
  String? accNo;
  String? custName;
  String? address;
  int? brCode;
  String? brName;
  int? schCode;
  String? schName;
  String? accType;
  String? depBranch;
  double? balance;
  String? dueDate;
  String? nominee;

  AccountsDepositTable({
    required this.custId,
    required this.accNo,
    required this.custName,
    required this.address,
    required this.brCode,
    required this.brName,
    required this.schCode,
    required this.schName,
    // required this.module,
    required this.accType,
    required this.depBranch,
    required this.balance,
    required this.dueDate,
    required this.nominee,
  });

  factory AccountsDepositTable.fromJson(Map<String, dynamic> json) =>
      AccountsDepositTable(
        custId: json["Cust_ID"],
        accNo: json["ACC_No"],
        custName: json["Cust_Name"],
        address: json["Address"],
        brCode: json["Br_Code"],
        brName: json["Br_Name"],
        schCode: json["Sch_Code"],
        schName: json["Sch_Name"],
        accType: json["AccType"],
        depBranch: json["Dep_Branch"],
        balance: json["Balance"],
        dueDate: json["DueDate"],
        nominee: json["Nominee"] is String ? json["Nominee"] : null,
      );

  Map<String, dynamic> toJson() => {
    "Cust_ID": custId,
    "ACC_No": accNo,
    "Cust_Name": custName,
    "Address": address,
    "Br_Code": brCode,
    "Br_Name": brName,
    "Sch_Code": schCode,
    "Sch_Name": schName,
    "AccType": accType,
    "Dep_Branch": depBranch,
    "Balance": balance,
    "DueDate": dueDate,
    "Nominee": nominee,
  };
}
