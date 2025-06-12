class BranchResponseModel {
  final String proceedStatus;
  final String proceedMessage;
  final List<BranchData> data;

  BranchResponseModel({
    required this.proceedStatus,
    required this.proceedMessage,
    required this.data,
  });

  factory BranchResponseModel.fromJson(Map<String, dynamic> json) {
    return BranchResponseModel(
      proceedStatus: json['ProceedStatus'] ?? '',
      proceedMessage: json['ProceedMessage'] ?? '',
      data:
          (json['Data'] as List<dynamic>?)
              ?.map((e) => BranchData.fromJson(e))
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

class BranchData {
  final int brCode;
  final String brName;

  BranchData({required this.brCode, required this.brName});

  factory BranchData.fromJson(Map<String, dynamic> json) {
    return BranchData(
      brCode: json['Br_Code'] ?? 0,
      brName: json['Br_Name'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {'Br_Code': brCode, 'Br_Name': brName};
  }
}
