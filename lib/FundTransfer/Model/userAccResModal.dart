class UserAccResModel {
  final String proceedStatus;
  final String proceedMessage;
  final List<UserAccTable> data;

  UserAccResModel({
    required this.proceedStatus,
    required this.proceedMessage,
    required this.data,
  });

  factory UserAccResModel.fromJson(Map<String, dynamic> json) {
    return UserAccResModel(
      proceedStatus: json['ProceedStatus'] ?? '',
      proceedMessage: json['ProceedMessage'] ?? '',
      data:
          (json['Data'] as List<dynamic>?)
              ?.map((item) => UserAccTable.fromJson(item))
              .toList() ??
          [],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'ProceedStatus': proceedStatus,
      'ProceedMessage': proceedMessage,
      'Data': data.map((item) => item.toJson()).toList(),
    };
  }
}

class UserAccTable {
  final String accNo;
  final String balance;
  final String schName;

  UserAccTable({
    required this.accNo,
    required this.balance,
    required this.schName,
  });

  factory UserAccTable.fromJson(Map<String, dynamic> json) {
    return UserAccTable(
      accNo: json['Acc_No'] ?? '',
      balance: json['Balance'] ?? '',
      schName: json['Sch_Name'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {'Acc_No': accNo, 'Balance': balance, 'Sch_Name': schName};
  }
}
