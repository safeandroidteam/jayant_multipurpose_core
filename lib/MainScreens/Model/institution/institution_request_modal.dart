class InstitutionReqModal {
  final String cmpCode;
  final String brCode;
  final String custTypeCode;
  final String firmName;
  final String firmRegType;
  final String firmRegNo;
  final String firmStartDate;
  final String firmPlaceInc;
  final String firmPanNo;
  final String firmPrimaryEmail;
  final String firmGstin;
  final String presentAddressXml;
  final String permanentAddressXml;
  final String communicationAddress;
  final String proprietorsXml;
  final String accountType;
  final String refID;
  final String aadhaarFrontImage;
  final String aadhaarBackImage;
  final String panImage;
  final String proprietorName;
  final String proprietorEducation;
  final String proprietorDOB;
  final String proprietorExperience;

  InstitutionReqModal({
    required this.cmpCode,
    required this.brCode,
    required this.custTypeCode,
    required this.firmName,
    required this.firmRegType,
    required this.firmRegNo,
    required this.firmStartDate,
    required this.firmPlaceInc,
    required this.firmPanNo,
    required this.firmPrimaryEmail,
    required this.firmGstin,
    required this.presentAddressXml,
    required this.permanentAddressXml,
    required this.communicationAddress,
    required this.proprietorsXml,
    required this.accountType,
    required this.refID,
    required this.aadhaarFrontImage,
    required this.aadhaarBackImage,
    required this.panImage,
    required this.proprietorName,
    required this.proprietorEducation,
    required this.proprietorDOB,
    required this.proprietorExperience,
  });

  Map<String, dynamic> toJson() {
    return {
      "Parameter_Xml": {
        "Cmp_Code": cmpCode,
        "Br_Code": brCode,
        "Cust_Type_Code": custTypeCode,
        "Firm_Name": firmName,
        "Firm_RegistrationType": firmRegType,
        "Firm_RegistrationNumber": firmRegNo,
        "Firm_StartDate": firmStartDate,
        "Cust_PlaceInc": firmPlaceInc,
        "Cust_Pan": firmPanNo,
        "Cust_PrimaryEmail": firmPrimaryEmail,
        "Cust_GSTIN": firmGstin,
        "Cust_ProprietorName": proprietorName,
        "Cust_ProprietorEducation": proprietorEducation,
        "Cust_Proprietordob_Inc": proprietorDOB,
        "Cust_ProprietorExp": proprietorExperience,
        "Present_Add_Xml": presentAddressXml,
        "Permanent_Add_Xml": permanentAddressXml,
        "Communication_Add_Xml": communicationAddress,
        "Own_Xml": proprietorsXml,
        "Account_Type": accountType,
        "Ref_ID": refID,
      },
      "Aadhaar_FrontImage": aadhaarFrontImage,
      "Aadhaar_BackImage": aadhaarBackImage,
      "PAN_Image": panImage,
    };
  }
}
