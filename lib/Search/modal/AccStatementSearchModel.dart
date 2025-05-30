class AccStatementSearchModel {
  AccStatementSearchModel({
    required this.proceedStatus,
    required this.proceedMessage,
    required this.data,
  });

  final String? proceedStatus;
  final String? proceedMessage;
  final List<AccStatementSearchData>? data;

  factory AccStatementSearchModel.fromJson(Map<String, dynamic> json) {
    return AccStatementSearchModel(
      proceedStatus: json["ProceedStatus"],
      proceedMessage: json["ProceedMessage"],
      data:
          json["Data"] == null
              ? []
              : List<AccStatementSearchData>.from(
                json["Data"]!.map((x) => AccStatementSearchData.fromJson(x)),
              ),
    );
  }

  Map<String, dynamic> toJson() => {
    "ProceedStatus": proceedStatus,
    "ProceedMessage": proceedMessage,
    "Data": data!.map((x) => x.toJson()).toList(),
  };
}

class AccStatementSearchData {
  AccStatementSearchData({
    required this.tranId,
    required this.trDate,
    required this.valueDate,
    required this.caption,
    required this.amount,
    required this.tranType,
    required this.balAmt,
    required this.balType,
    required this.remarks,
    required this.accNo,
  });

  dynamic tranId;
  String trDate;
  String valueDate;
  String caption;
  dynamic amount;
  dynamic tranType;
  dynamic balAmt;
  String balType;
  String remarks;
  String accNo;

  factory AccStatementSearchData.fromJson(Map<String, dynamic> json) {
    return AccStatementSearchData(
      tranId: json["Tran_ID"],
      trDate: json["Tr_Date"],
      valueDate: json["Value_Date"],
      caption: json["Caption"],
      amount: json["Amount"],
      tranType: json["Tran_Type"],
      balAmt: json["Bal_Amt"],
      balType: json["Bal_Type"],
      remarks: json["Remarks"],
      accNo: json["Acc_No"],
    );
  }

  Map<String, dynamic> toJson() => {
    "Tran_ID": tranId,
    "Tr_Date": trDate,
    "Value_Date": valueDate,
    "Caption": caption,
    "Amount": amount,
    "Tran_Type": tranType,
    "Bal_Amt": balAmt,
    "Bal_Type": balType,
    "Remarks": remarks,
    "Acc_No": accNo,
  };
}
