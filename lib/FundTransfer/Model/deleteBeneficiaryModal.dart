class DeleteBeneficiaryModal {
  final String proceedStatus;
  final String proceedMessage;
  final List<DeleteBeneficiaryData> data;

  DeleteBeneficiaryModal({
    required this.proceedStatus,
    required this.proceedMessage,
    required this.data,
  });

  factory DeleteBeneficiaryModal.fromJson(Map<String, dynamic> json) {
    return DeleteBeneficiaryModal(
      proceedStatus: json['ProceedStatus'] ?? '',
      proceedMessage: json['ProceedMessage'] ?? '',
      data: (json['Data'] as List<dynamic>?)
          ?.map((item) => DeleteBeneficiaryData.fromJson(item))
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

class DeleteBeneficiaryData {
  final String proceedStatus;
  final String proceedMessage;

  DeleteBeneficiaryData({
    required this.proceedStatus,
    required this.proceedMessage,
  });

  factory DeleteBeneficiaryData.fromJson(Map<String, dynamic> json) {
    return DeleteBeneficiaryData(
      proceedStatus: json['Proceed_Status'] ?? '',
      proceedMessage: json['Procees_Message'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'Proceed_Status': proceedStatus,
      'Procees_Message': proceedMessage,
    };
  }
}
