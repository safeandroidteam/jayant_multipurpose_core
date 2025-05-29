class TransactionModal {
  final List<TransactionItem> table;

  TransactionModal({required this.table});

  factory TransactionModal.fromJson(Map<String, dynamic> json) {
    return TransactionModal(
      table: List<TransactionItem>.from(
        json['Table']?.map((item) => TransactionItem.fromJson(item)) ?? [],
      ),
    );
  }

  Map<String, dynamic> toJson() {
    return {'Table': table.map((item) => item.toJson()).toList()};
  }
}

class TransactionItem {
  final dynamic id;
  final String trDate;
  final String caption;
  final dynamic amount;
  final int tranType;
  final dynamic balance;
  final String balType;
  final String remarks;

  TransactionItem({
    required this.id,
    required this.trDate,
    required this.caption,
    required this.amount,
    required this.tranType,
    required this.balance,
    required this.balType,
    required this.remarks,
  });

  factory TransactionItem.fromJson(Map<String, dynamic> json) {
    return TransactionItem(
      id: json['ID'],
      trDate: json['Tr_Date'],
      caption: json['Caption'],
      amount: json['Amount'],
      tranType: json['Tran_Type'],

      balType: json["Bal_Type"],
      remarks: json["Remarks"],

      balance: json['balance'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'ID': id,
      'Tr_Date': trDate,
      'Tran_Type': tranType,
      'Amount': amount,
      'balance': balance,
    };
  }
}
