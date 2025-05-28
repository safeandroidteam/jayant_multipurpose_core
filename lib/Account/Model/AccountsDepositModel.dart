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
                  json["Data"].map((x) => AccountsDepositTable.fromJson(x)),
                ),
      );

  Map<String, dynamic> toJson() => {
    "ProceedStatus": proceedStatus,
    "ProceedMessage": proceedMessage,
    "Data": List<dynamic>.from(data.map((x) => x.toJson())),
  };
}

class AccountsDepositTable {
  int custId;
  String custName;
  String address;
  int brCode;
  String brName;
  int schCode;
  String schName;
  String module;
  String depBranch;
  String balance;

  AccountsDepositTable({
    required this.custId,
    required this.custName,
    required this.address,
    required this.brCode,
    required this.brName,
    required this.schCode,
    required this.schName,
    required this.module,
    required this.depBranch,
    required this.balance,
  });

  factory AccountsDepositTable.fromJson(Map<String, dynamic> json) =>
      AccountsDepositTable(
        custId: json["Cust_ID"] ?? 0,
        custName: json["Cust_Name"] ?? '',
        address: json["Address"] ?? '',
        brCode: json["Br_Code"] ?? 0,
        brName: json["Br_Name"] ?? '',
        schCode: json["Sch_Code"] ?? 0,
        schName: json["Sch_Name"] ?? '',
        module: json["Module"] ?? '',
        depBranch: json["Dep_Branch"] ?? '',
        balance: json["Balance"] ?? '0.00',
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
