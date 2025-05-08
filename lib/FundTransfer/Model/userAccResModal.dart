// To parse this JSON data, do
//
//     final userAccResModal = userAccResModalFromJson(jsonString);

import 'dart:convert';

UserAccResModal userAccResModalFromJson(String str) =>
    UserAccResModal.fromJson(json.decode(str));

String userAccResModalToJson(UserAccResModal data) =>
    json.encode(data.toJson());

class UserAccResModal {
  List<UserAccTable> table;

  UserAccResModal({
    required this.table,
  });

  factory UserAccResModal.fromJson(Map<String, dynamic> json) =>
      UserAccResModal(
        table: List<UserAccTable>.from(
            json["Table"].map((x) => UserAccTable.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "Table": List<dynamic>.from(table.map((x) => x.toJson())),
      };
}

class UserAccTable {
  String accNo;
  double balAmt;
  String accType;

  UserAccTable({
    required this.accNo,
    required this.balAmt,
    required this.accType,
  });

  factory UserAccTable.fromJson(Map<String, dynamic> json) => UserAccTable(
        accNo: json["AccNo"],
        balAmt: json["BalAmt"],
        accType: json["Types"],
      );

  Map<String, dynamic> toJson() => {
        "AccNo": accNo,
        "BalAmt": balAmt,
        "Types":accType
      };
}
