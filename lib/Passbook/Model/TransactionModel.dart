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
  final String accNo;
  final String schCode;
  final String brCode;
  final DateTime trDate;
  final String tranType;
  final String display;
  final dynamic amount;
  final String narration;
  final dynamic balance;
  final double seqNo;
  final String show;
  final dynamic dailyBalance;
  final dynamic tranBalance;

  TransactionItem({
    required this.id,
    required this.accNo,
    required this.schCode,
    required this.brCode,
    required this.trDate,
    required this.tranType,
    required this.display,
    required this.amount,
    required this.narration,
    required this.balance,
    required this.seqNo,
    required this.show,
    required this.dailyBalance,
    required this.tranBalance,
  });

  factory TransactionItem.fromJson(Map<String, dynamic> json) {
    return TransactionItem(
      id: json['ID'],
      accNo: json['Acc_No'],
      schCode: json['Sch_Code'],
      brCode: json['Br_Code'],
      trDate: DateTime.parse(json['Tr_Date']),
      tranType: json['Tran_Type'],
      display: json['Display'],
      amount: json['Amount'] ,
      narration: json['Narration'],
      balance: json['balance'] ,
      seqNo: json['Seq_No'] ,
      show: json['Show'],
      dailyBalance: json['DailyBalance'] ,
      tranBalance: json['TranBalance'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'ID': id,
      'Acc_No': accNo,
      'Sch_Code': schCode,
      'Br_Code': brCode,
      'Tr_Date': trDate.toIso8601String(),
      'Tran_Type': tranType,
      'Display': display,
      'Amount': amount,
      'Narration': narration,
      'balance': balance,
      'Seq_No': seqNo,
      'Show': show,
      'DailyBalance': dailyBalance,
      'TranBalance': tranBalance,
    };
  }
}
