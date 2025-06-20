class SaveBeneficiaryModal {
  final String proceedStatus;
  final String proceedMessage;
  final List<SaveBeneficiaryData> data;

  SaveBeneficiaryModal({
    required this.proceedStatus,
    required this.proceedMessage,
    required this.data,
  });

  factory SaveBeneficiaryModal.fromJson(Map<String, dynamic> json) {
    return SaveBeneficiaryModal(
      proceedStatus: json['ProceedStatus'] ?? '',
      proceedMessage: json['ProceedMessage'] ?? '',
      data: (json['Data'] as List<dynamic>?)
          ?.map((item) => SaveBeneficiaryData.fromJson(item))
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

class SaveBeneficiaryData {
  final int beneficiaryId;
  final String proceedMessage;

  SaveBeneficiaryData({
    required this.beneficiaryId,
    required this.proceedMessage,
  });

  factory SaveBeneficiaryData.fromJson(Map<String, dynamic> json) {
    return SaveBeneficiaryData(
      beneficiaryId: json['Beneficiary_ID'] ?? 0,
      proceedMessage: json['Proceed_Message'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'Beneficiary_ID': beneficiaryId,
      'Proceed_Message': proceedMessage,
    };
  }
}
