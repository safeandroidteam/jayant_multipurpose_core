class People {
  List<PeopleTable> table;

  People({this.table = const []}); // Ensure an empty list if no data is passed

  factory People.fromJson(Map<String, dynamic> json) {
    // Ensure that "Table" exists and is a List, otherwise an empty list is used
    return People(
      table: json["Table"] != null
          ? List<PeopleTable>.from(
              json["Table"].map((x) => PeopleTable.fromJson(x)))
          : [], // Empty list if no "Table" is found
    );
  }

  Map<String, dynamic> toJson() => {
        "Table": List<dynamic>.from(table.map((x) => x.toJson())),
      };

  @override
  String toString() {
    return 'People{table: $table}';
  }
}

class PeopleTable {
  String recieverName;
  String recieverMob;
  String recieverIfsc;
  String recieverAccno;
  double recieverId;

  PeopleTable({
    required this.recieverName,
    required this.recieverMob,
    required this.recieverIfsc,
    required this.recieverAccno,
    required this.recieverId,
  });

  factory PeopleTable.fromJson(Map<String, dynamic> json) {
    return PeopleTable(
      recieverName: json["Reciever_Name"] ?? '',
      recieverMob: json["Reciever_Mob"] ?? '',
      recieverIfsc: json["Reciever_Ifsc"] ?? '',
      recieverAccno: json["Reciever_Accno"] ?? '',
      recieverId: json["Reciever_Id"]?.toDouble() ??
          0.0, // Ensure recieverId is a double
    );
  }

  Map<String, dynamic> toJson() => {
        "Reciever_Name": recieverName,
        "Reciever_Mob": recieverMob,
        "Reciever_Ifsc": recieverIfsc,
        "Reciever_Accno": recieverAccno,
        "Reciever_Id": recieverId,
      };

  @override
  String toString() {
    return 'PeopleTable{recieverName: $recieverName, recieverMob: $recieverMob, recieverIfsc: $recieverIfsc, recieverAccno: $recieverAccno, recieverId: $recieverId}';
  }
}
