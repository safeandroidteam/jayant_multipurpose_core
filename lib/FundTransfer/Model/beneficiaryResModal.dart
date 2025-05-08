// To parse this JSON data, do
//
//     final benificaryResponseModal = benificaryResponseModalFromJson(jsonString);

import 'dart:convert';

BenificaryResponseModal benificaryResponseModalFromJson(String str) =>
    BenificaryResponseModal.fromJson(json.decode(str));

String benificaryResponseModalToJson(BenificaryResponseModal data) =>
    json.encode(data.toJson());

class BenificaryResponseModal {
  List<BeneficiaryDatum> table;

  BenificaryResponseModal({
    required this.table,
  });

  factory BenificaryResponseModal.fromJson(Map<String, dynamic> json) =>
      BenificaryResponseModal(
        table: List<BeneficiaryDatum>.from(
            json["Table"].map((x) => BeneficiaryDatum.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "Table": List<dynamic>.from(table.map((x) => x.toJson())),
      };
}

class BeneficiaryDatum {
  String recieverName;
  String recieverMob;
  String recieverIfsc;
  String recieverAccno;
  dynamic recieverId;

  BeneficiaryDatum({
    required this.recieverName,
    required this.recieverMob,
    required this.recieverIfsc,
    required this.recieverAccno,
    required this.recieverId,
  });

  factory BeneficiaryDatum.fromJson(Map<String, dynamic> json) =>
      BeneficiaryDatum(
        recieverName: json["Reciever_Name"],
        recieverMob: json["Reciever_Mob"],
        recieverIfsc: json["Reciever_Ifsc"],
        recieverAccno: json["Reciever_Accno"],
        recieverId: json["Reciever_Id"],
      );

  Map<String, dynamic> toJson() => {
        "Reciever_Name": recieverName,
        "Reciever_Mob": recieverMob,
        "Reciever_Ifsc": recieverIfsc,
        "Reciever_Accno": recieverAccno,
        "Reciever_Id": recieverId,
      };
}
