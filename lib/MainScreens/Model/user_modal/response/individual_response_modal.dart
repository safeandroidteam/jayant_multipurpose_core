class IndividualUserResponseModel {
  final String proceedStatus;
  final String proceedMessage;
  final List<IndividualUserData> data;

  IndividualUserResponseModel({
    required this.proceedStatus,
    required this.proceedMessage,
    required this.data,
  });

  factory IndividualUserResponseModel.fromJson(Map<String, dynamic> json) {
    return IndividualUserResponseModel(
      proceedStatus: json['ProceedStatus'] ?? '',
      proceedMessage: json['ProceedMessage'] ?? '',
      data:
          (json['Data'] as List<dynamic>?)
              ?.map((item) => IndividualUserData.fromJson(item))
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

class IndividualUserData {
  final String custId;
  final String accNo;
  final String shareNo;

  IndividualUserData({
    required this.custId,
    required this.accNo,
    required this.shareNo,
  });

  factory IndividualUserData.fromJson(Map<String, dynamic> json) {
    return IndividualUserData(
      custId: json['Cust_ID']?.toString() ?? '',
      accNo: json['Acc_No']?.toString() ?? '',
      shareNo: json['Share_No']?.toString() ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {'Cust_ID': custId, 'Acc_No': accNo, 'Share_No': shareNo};
  }
}
