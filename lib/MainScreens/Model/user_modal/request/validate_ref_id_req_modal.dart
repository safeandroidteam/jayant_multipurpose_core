class ValidateRefIDReqModal {
  final String cmpCode;
  final String custId;

  ValidateRefIDReqModal({required this.cmpCode, required this.custId});

  factory ValidateRefIDReqModal.fromJson(Map<String, dynamic> json) {
    return ValidateRefIDReqModal(
      cmpCode: json['Cmp_Code'].toString(),
      custId: json['Cust_ID'].toString(),
    );
  }

  Map<String, dynamic> toJson() {
    return {'Cmp_Code': cmpCode, 'Cust_ID': custId};
  }
}
