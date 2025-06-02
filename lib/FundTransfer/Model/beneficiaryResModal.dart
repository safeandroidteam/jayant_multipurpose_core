class BeneficiaryResponseModel {
  final String proceedStatus;
  final String proceedMessage;
  final List<BeneficiaryDatum> data;

  BeneficiaryResponseModel({
    required this.proceedStatus,
    required this.proceedMessage,
    required this.data,
  });

  factory BeneficiaryResponseModel.fromJson(Map<String, dynamic> json) {
    return BeneficiaryResponseModel(
      proceedStatus: json['ProceedStatus'] ?? '',
      proceedMessage: json['ProceedMessage'] ?? '',
      data:
          (json['Data'] as List<dynamic>?)
              ?.map((item) => BeneficiaryDatum.fromJson(item))
              .toList() ??
          [],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'ProceedStatus': proceedStatus,
      'ProceedMessage': proceedMessage,
      'Data': data.map((item) => item.toJson()).toList(),
    };
  }
}

class BeneficiaryDatum {
  final String recieverName;
  final String recieverMob;
  final String recieverIfsc;
  final String recieverAccno;
  final String recieverId;

  BeneficiaryDatum({
    required this.recieverName,
    required this.recieverMob,
    required this.recieverIfsc,
    required this.recieverAccno,
    required this.recieverId,
  });

  factory BeneficiaryDatum.fromJson(Map<String, dynamic> json) {
    return BeneficiaryDatum(
      recieverName: json['Reciever_Name'] ?? '',
      recieverMob: json['Reciever_Mob'] ?? '',
      recieverIfsc: json['Reciever_Ifsc'] ?? '',
      recieverAccno: json['Reciever_Accno'] ?? '',
      recieverId: json['Reciever_Id'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'Reciever_Name': recieverName,
      'Reciever_Mob': recieverMob,
      'Reciever_Ifsc': recieverIfsc,
      'Reciever_Accno': recieverAccno,
      'Reciever_Id': recieverId,
    };
  }
}
