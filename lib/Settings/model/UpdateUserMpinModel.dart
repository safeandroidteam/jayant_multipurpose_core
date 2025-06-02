import 'dart:convert';

UpdateUserMpinModel updateUserMpinModelFromJson(String str) =>
    UpdateUserMpinModel.fromJson(json.decode(str));

String updateUserMpinModelToJson(UpdateUserMpinModel data) =>
    json.encode(data.toJson());

class UpdateUserMpinModel {
  UpdateUserMpinModel({
    required this.proceedStatus,
    required this.proceedMessage,
    required this.data,
  });

  final String? proceedStatus;
  final String? proceedMessage;
  final List<UpdateUserMpinData> data;

  factory UpdateUserMpinModel.fromJson(Map<String, dynamic> json) {
    return UpdateUserMpinModel(
      proceedStatus: json["ProceedStatus"],
      proceedMessage: json["ProceedMessage"],
      data:
          json["Data"] == null
              ? []
              : List<UpdateUserMpinData>.from(
                json["Data"]!.map((x) => UpdateUserMpinData.fromJson(x)),
              ),
    );
  }

  Map<String, dynamic> toJson() => {
    "ProceedStatus": proceedStatus,
    "ProceedMessage": proceedMessage,
    "Data": data.map((x) => x?.toJson()).toList(),
  };
}

class UpdateUserMpinData {
  UpdateUserMpinData({
    required this.proceedStatus,
    required this.proceedMessage,
  });

  final String? proceedStatus;
  final String? proceedMessage;

  factory UpdateUserMpinData.fromJson(Map<String, dynamic> json) {
    return UpdateUserMpinData(
      proceedStatus: json["Proceed_Status"],
      proceedMessage: json["Proceed_Message"],
    );
  }

  Map<String, dynamic> toJson() => {
    "Proceed_Status": proceedStatus,
    "Proceed_Message": proceedMessage,
  };
}
