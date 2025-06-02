class FetchUserLimitModal {
  final String proceedStatus;
  final String proceedMessage;
  final List<UserLimitData> data;

  FetchUserLimitModal({
    required this.proceedStatus,
    required this.proceedMessage,
    required this.data,
  });

  factory FetchUserLimitModal.fromJson(Map<String, dynamic> json) {
    return FetchUserLimitModal(
      proceedStatus: json['ProceedStatus'] ?? '',
      proceedMessage: json['ProceedMessage'] ?? '',
      data: (json['Data'] as List<dynamic>?)
          ?.map((item) => UserLimitData.fromJson(item))
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

class UserLimitData {
  final int cmpCode;
  final int custType;
  final String minRcghBal;
  final String minFundTranBal;
  final String maxRcghBal;
  final String maxFundTranBal;
  final String maxInterFundTranBal;

  UserLimitData({
    required this.cmpCode,
    required this.custType,
    required this.minRcghBal,
    required this.minFundTranBal,
    required this.maxRcghBal,
    required this.maxFundTranBal,
    required this.maxInterFundTranBal,
  });

  factory UserLimitData.fromJson(Map<String, dynamic> json) {
    return UserLimitData(
      cmpCode: json['Cmp_Code'] ?? 0,
      custType: json['Cust_Type'] ?? 0,
      minRcghBal: json['Min_rcghbal'] ?? '',
      minFundTranBal: json['Min_fundtranbal'] ?? '',
      maxRcghBal: json['Max_rcghbal'] ?? '',
      maxFundTranBal: json['Max_fundtranbal'] ?? '',
      maxInterFundTranBal: json['Max_interfundtranbal'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'Cmp_Code': cmpCode,
      'Cust_Type': custType,
      'Min_rcghbal': minRcghBal,
      'Min_fundtranbal': minFundTranBal,
      'Max_rcghbal': maxRcghBal,
      'Max_fundtranbal': maxFundTranBal,
      'Max_interfundtranbal': maxInterFundTranBal,
    };
  }
}
