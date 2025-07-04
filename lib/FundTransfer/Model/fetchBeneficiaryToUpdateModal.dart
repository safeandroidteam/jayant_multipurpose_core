class FetchBeneficiaryToUpdateModal {
  final String proceedStatus;
  final String proceedMessage;
  final List<BeneficiaryDataToUpdate> data;

  FetchBeneficiaryToUpdateModal({
    required this.proceedStatus,
    required this.proceedMessage,
    required this.data,
  });

  factory FetchBeneficiaryToUpdateModal.fromJson(Map<String, dynamic> json) {
    return FetchBeneficiaryToUpdateModal(
      proceedStatus: json['ProceedStatus'] ?? '',
      proceedMessage: json['ProceedMessage'] ?? '',
      data: (json['Data'] as List<dynamic>?)
          ?.map((e) => BeneficiaryDataToUpdate.fromJson(e))
          .toList() ??
          [],
    );
  }
}

class BeneficiaryDataToUpdate {
  final int beneficiaryId;
  final int custId;
  final String nickName;
  final String accountNo;
  final String accountHolderName;
  final String mobileNo;
  final String ifscCode;
  final String bankName;
  final String bankAddress;

  BeneficiaryDataToUpdate({
    required this.beneficiaryId,
    required this.custId,
    required this.nickName,
    required this.accountNo,
    required this.accountHolderName,
    required this.mobileNo,
    required this.ifscCode,
    required this.bankName,
    required this.bankAddress,
  });

  factory BeneficiaryDataToUpdate.fromJson(Map<String, dynamic> json) {
    return BeneficiaryDataToUpdate(
      beneficiaryId: json['Beneficiary_ID'] ?? 0,
      custId: json['Cust_ID'] ?? 0,
      nickName: json['Beneficiary_NickName'] ?? '',
      accountNo: json['BeneficiaryAcc_No'] ?? '',
      accountHolderName: json['Beneficiary_AccountHolderName'] ?? '',
      mobileNo: json['Mobile_No'] ?? '',
      ifscCode: json['IFSC_Code'] ?? '',
      bankName: json['Bank_Name'] ?? '',
      bankAddress: json['Bank_Address'] ?? '',
    );
  }
}
