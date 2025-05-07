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
  final dynamic custId;
  final String custName;
  final String adds;
  final String brName;
  final String accNo;
  final String schCode;
  final String schName;
  final String brCode;
  final String depBranch;
  final dynamic balance;
  final String module;
  String? address;

  PassbookItem({
    required this.custId,
    required this.custName,
    required this.adds,
    required this.brName,
    required this.accNo,
    required this.schCode,
    required this.schName,
    required this.brCode,
    required this.depBranch,
    required this.balance,
    required this.module,
    this.address,
  });

  factory PassbookItem.fromJson(Map<String, dynamic> json) {
    return PassbookItem(
      custId: json['Cust_Id'],
      custName: json['Cust_Name'],
      adds: json['Adds'],
      brName: json['Br_Name'],
      accNo: json['Acc_No'],
      address: json["Adds"],
      schCode: json['Sch_Code'],
      schName: json['Sch_Name'],
      brCode: json['Br_Code'],
      depBranch: json['Dep_Branch'],
      balance: json['Balance'],
      module: json['Module'],
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
