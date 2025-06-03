class FetchBeniBankDetailsModal {
  final String proceedStatus;
  final String proceedMessage;
  final List<FetchBankDetailData> data;

  FetchBeniBankDetailsModal({
    required this.proceedStatus,
    required this.proceedMessage,
    required this.data,
  });

  factory FetchBeniBankDetailsModal.fromJson(Map<String, dynamic> json) {
    return FetchBeniBankDetailsModal(
      proceedStatus: json['ProceedStatus'] ?? '',
      proceedMessage: json['ProceedMessage'] ?? '',
      data: (json['Data'] as List<dynamic>)
          .map((item) => FetchBankDetailData.fromJson(item))
          .toList(),
    );
  }
}

class FetchBankDetailData {
  final String bnkName;
  final String brDistrict;

  FetchBankDetailData({
    required this.bnkName,
    required this.brDistrict,
  });

  factory FetchBankDetailData.fromJson(Map<String, dynamic> json) {
    return FetchBankDetailData(
      bnkName: json['Bnk_Name'] ?? '',
      brDistrict: json['Br_District'] ?? '',
    );
  }
}
