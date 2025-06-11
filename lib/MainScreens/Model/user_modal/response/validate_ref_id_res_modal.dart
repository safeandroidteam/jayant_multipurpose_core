class ValidateRefIDResponseModal {
  final String proceedStatus;
  final String proceedMessage;
  final List<ValidateRefIDData> data;

  ValidateRefIDResponseModal({
    required this.proceedStatus,
    required this.proceedMessage,
    required this.data,
  });

  factory ValidateRefIDResponseModal.fromJson(Map<String, dynamic> json) {
    return ValidateRefIDResponseModal(
      proceedStatus: json['ProceedStatus'] ?? '',
      proceedMessage: json['ProceedMessage'] ?? '',
      data:
          (json['Data'] as List<dynamic>?)
              ?.map((e) => ValidateRefIDData.fromJson(e))
              .toList() ??
          [],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'ProceedStatus': proceedStatus,
      'ProceedMessage': proceedMessage,
      'Data': data.map((e) => e.toJson()).toList(),
    };
  }
}

class ValidateRefIDData {
  final String custName;

  ValidateRefIDData({required this.custName});

  factory ValidateRefIDData.fromJson(Map<String, dynamic> json) {
    return ValidateRefIDData(custName: json['Cust_Name'] ?? '');
  }

  Map<String, dynamic> toJson() {
    return {'Cust_Name': custName};
  }
}
