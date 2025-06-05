class OwnBankToAccNoModal {
  final String proceedStatus;
  final String proceedMessage;
  final List<OwnBankAccountData> data;

  OwnBankToAccNoModal({
    required this.proceedStatus,
    required this.proceedMessage,
    required this.data,
  });

  factory OwnBankToAccNoModal.fromJson(Map<String, dynamic> json) {
    return OwnBankToAccNoModal(
      proceedStatus: json['ProceedStatus'] ?? '',
      proceedMessage: json['ProceedMessage'] ?? '',
      data:
          (json['Data'] as List<dynamic>?)
              ?.map((e) => OwnBankAccountData.fromJson(e))
              .toList() ??
          [],
    );
  }
}

class OwnBankAccountData {
  final String accNo;
  final String custName;

  OwnBankAccountData({required this.accNo, required this.custName});

  factory OwnBankAccountData.fromJson(Map<String, dynamic> json) {
    return OwnBankAccountData(
      accNo: json['Acc_No'] ?? '',
      custName: json['Cust_Name'] ?? '',
    );
  }
}
