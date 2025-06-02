// To parse this JSON data, do
//
//     final fundTransferTypeResponseModal = fundTransferTypeResponseModalFromJson(jsonString);

import 'dart:convert';

FetchFundTransferTypeResModal fetchFundTransferTypeResModalFromJson(
  String str,
) => FetchFundTransferTypeResModal.fromJson(json.decode(str));

String fetchFundTransferTypeResModalToJson(
  FetchFundTransferTypeResModal data,
) => json.encode(data.toJson());

class FetchFundTransferTypeResModal {
  final String? proceedStatus;
  final String? proceedMessage;
  List<FetchFundTransferTypeData> data;

  FetchFundTransferTypeResModal({
    required this.proceedStatus,
    required this.proceedMessage,
    required this.data,
  });

  factory FetchFundTransferTypeResModal.fromJson(Map<String, dynamic> json) =>
      FetchFundTransferTypeResModal(
        proceedStatus: json["ProceedStatus"],
        proceedMessage: json["ProceedMessage"],
          data:
          json["Data"] == null
              ? []
              : List<FetchFundTransferTypeData>.from(json["Data"]!.map((x) => FetchFundTransferTypeData.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
    "ProceedStatus": proceedStatus,
    "ProceedMessage": proceedMessage,
    // "Data": List<dynamic>.from(data.map((x) => x.toJson())),
    "Data": data.map((x) => x.toJson()).toList(),
  };
}

class FetchFundTransferTypeData {
  final int? slNo;
  final String? typeName;

  FetchFundTransferTypeData({required this.slNo, required this.typeName});

  factory FetchFundTransferTypeData.fromJson(Map<String, dynamic> json) =>
      FetchFundTransferTypeData(slNo: json["SlNo"], typeName: json["TYPE_NAME"]);

  Map<String, dynamic> toJson() => {"SlNo": slNo, "TYPE_NAME": typeName};
}