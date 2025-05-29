class PassbookListModel {
  final List<PassbookItem> table;

  PassbookListModel({required this.table});

  factory PassbookListModel.fromJson(Map<String, dynamic> json) {
    return PassbookListModel(
      table: List<PassbookItem>.from(
        json['Table']?.map((item) => PassbookItem.fromJson(item)) ?? [],
      ),
    );
  }

  Map<String, dynamic> toJson() {
    return {'Table': table.map((item) => item.toJson()).toList()};
  }
}

class PassbookItem {
  dynamic custId;
  String? custName;
  String? adds;
  String? brName;
  String? accNo;
  dynamic schCode;
  String? schName;
  dynamic brCode;
  String? depBranch;
  dynamic balance;
  String? module;
  String? address;
  dynamic accId;

  PassbookItem({
    this.custId,
    this.custName,
    this.adds,
    this.brName,
    this.accNo,
    this.schCode,
    this.schName,
    this.brCode,
    this.depBranch,
    this.balance,
    this.module,
    this.address,
    this.accId,
  });

  factory PassbookItem.fromJson(Map<String, dynamic> json) {
    return PassbookItem(
      custId: json['Cust_ID'],
      custName: json['Cust_Name'],
      adds: json['Address'],
      brName: json['Br_Name'],
      accNo: json['Acc_No'],
      address: json["Address"],
      schCode: json['Sch_Code'],
      schName: json['Sch_Name'],
      brCode: json['Br_Code'],
      depBranch: json['Dep_Branch'],
      balance: json['Balance'],
      module: json['Module'],
      accId: json["Acc_ID"],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'Cust_Id': custId,
      'Cust_Name': custName,
      'Adds': adds,
      'Br_Name': brName,
      'Acc_No': accNo,
      'Sch_Code': schCode,

      'Sch_Name': schName,
      'Br_Code': brCode,
      'Dep_Branch': depBranch,
      'Balance': balance,
      'Module': module,
    };
  }
}
