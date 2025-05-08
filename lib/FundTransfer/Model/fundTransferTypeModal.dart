// To parse this JSON data, do
//
//     final fundTransferTypeResponseModal = fundTransferTypeResponseModalFromJson(jsonString);

import 'dart:convert';

FundTransferTypeResponseModal fundTransferTypeResponseModalFromJson(
        String str) =>
    FundTransferTypeResponseModal.fromJson(json.decode(str));

String fundTransferTypeResponseModalToJson(
        FundTransferTypeResponseModal data) =>
    json.encode(data.toJson());

class FundTransferTypeResponseModal {
  List<FetchFundTransferTypeDatum> table;

  FundTransferTypeResponseModal({
    required this.table,
  });

  factory FundTransferTypeResponseModal.fromJson(Map<String, dynamic> json) =>
      FundTransferTypeResponseModal(
        table: List<FetchFundTransferTypeDatum>.from(json["Table"].map((x) => FetchFundTransferTypeDatum.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "Table": List<dynamic>.from(table.map((x) => x.toJson())),
      };
}

class FetchFundTransferTypeDatum {
  String typeName;

  FetchFundTransferTypeDatum({
    required this.typeName,
  });

  factory FetchFundTransferTypeDatum.fromJson(Map<String, dynamic> json) => FetchFundTransferTypeDatum(
        typeName: json["TYPE_NAME"],
      );

  Map<String, dynamic> toJson() => {
        "TYPE_NAME": typeName,
      };
}
