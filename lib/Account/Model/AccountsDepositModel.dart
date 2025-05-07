import 'dart:convert';

AccountsDepositModel transactionModelFromJson(String str) =>
    AccountsDepositModel.fromJson(json.decode(str));

String transactionModelToJson(AccountsDepositModel data) =>
    json.encode(data.toJson());

class AccountsDepositModel {
  List<AccountsDepositTable> table;

  AccountsDepositModel({
    this.table = const [], // Default to empty list if null
  });

  factory AccountsDepositModel.fromJson(Map<String, dynamic> json) =>
      AccountsDepositModel(
        table:
            json["Table"] == null
                ? []
                : List<AccountsDepositTable>.from(
                  json["Table"].map((x) => AccountsDepositTable.fromJson(x)),
                ),
      );

  Map<String, dynamic> toJson() => {
    "Table": List<dynamic>.from(table.map((x) => x.toJson())),
  };
}

class AccountsDepositTable {
  double custId;
  String custName;
  String address;
  String custBranch;
  String accNo;
  String accBranch;
  double balance;
  String nominee;
  String accType;
  String module;
  String dueDate;

  AccountsDepositTable({
    required this.custId,
    required this.custName,
    required this.address,
    required this.custBranch,
    required this.accNo,
    required this.accBranch,
    required this.balance,
    required this.nominee,
    required this.accType,
    required this.module,
    required this.dueDate,
  });

  factory AccountsDepositTable.fromJson(Map<String, dynamic> json) =>
      AccountsDepositTable(
        custId: json["Cust_Id"] == null ? 0.0 : json["Cust_Id"].toDouble(),
        custName: json["Cust_Name"] ?? '',
        address: json["Adds"] ?? '',
        custBranch: json["Cust_Br"] ?? '',
        accNo: json["Acc_No"] ?? '',
        accBranch: json["Acc_Br"] ?? '',
        balance: json["Balance"] == null ? 0.0 : json["Balance"].toDouble(),
        nominee: json["nominee"] ?? '',
        accType: json["Acc_type"] ?? '',
        module: json["module"] ?? '',
        dueDate: json["Due_Date"] ?? '',
      );

  Map<String, dynamic> toJson() => {
    "Cust_Id": custId,
    "Cust_Name": custName,
    "Adds": address,
    "Cust_Br": custBranch,
    "Acc_No": accNo,
    "Acc_Br": accBranch,
    "Balance": balance,
    "nominee": nominee,
    "Acc_type": accType,
    "module": module,
    "Due_Date": dueDate,
  };
}
