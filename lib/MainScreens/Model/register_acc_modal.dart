

class RegisterAccData {
  final String accId;
  final String accNo;

  RegisterAccData({required this.accId, required this.accNo});

  factory RegisterAccData.fromJson(Map<String, dynamic> json) {
    return RegisterAccData(
      accId: json['Acc_ID'] ?? '',
      accNo: json['Acc_No'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {'Acc_ID': accId, 'Acc_No': accNo};
  }
}
