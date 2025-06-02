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

  UserAccTable({required this.accNo, required this.balance});

  factory UserAccTable.fromJson(Map<String, dynamic> json) {
    return UserAccTable(
      accNo: json['Acc_No'] ?? '',
      balance: json['Balance'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {'Acc_No': accNo, 'Balance': balance};
  }
}
