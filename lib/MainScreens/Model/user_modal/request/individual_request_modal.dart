class IndividualUserRequestModel {
  final String cmpCode;
  final String brCode;
  final String custTypeCode;
  final String custTitleCode;
  final String custFirstName;
  final String custMiddleName;
  final String custLastName;
  final String custFatherName;
  final String custMotherName;
  final String custSpouseName;
  final String custDobInc;
  final String custGender;
  final String custPrimaryMobile;
  final String custPrimaryEmail;
  final String custAdhaarNo;
  final String custPanCard;
  final String presentAddXml;
  final String permanentAddXml;
  final String communicationAddXml;
  final String accountType;
  final String refID;

  final String photoImage;
  final String signatureImage;
  final String aadhaarFrontImage;
  final String aadhaarBackImage;
  final String panImage;

  IndividualUserRequestModel({
    required this.cmpCode,
    required this.brCode,
    required this.custTypeCode,
    required this.custTitleCode,
    required this.custFirstName,
    required this.custMiddleName,
    required this.custLastName,
    required this.custFatherName,
    required this.custMotherName,
    required this.custSpouseName,
    required this.custDobInc,
    required this.custGender,
    required this.custPrimaryMobile,
    required this.custPrimaryEmail,
    required this.custAdhaarNo,
    required this.custPanCard,
    required this.presentAddXml,
    required this.permanentAddXml,
    required this.communicationAddXml,
    required this.accountType,
    required this.refID,
    required this.photoImage,

    required this.signatureImage,
    required this.aadhaarFrontImage,
    required this.aadhaarBackImage,
    required this.panImage,
  });

  Map<String, dynamic> toJson() {
    return {
      "Parameter_Xml": {
        "Cmp_Code": cmpCode,
        "Br_Code": brCode,
        "Cust_Type_Code": custTypeCode,
        "Cust_Title_Code": custTitleCode,
        "Cust_FirstName": custFirstName,
        "Cust_MiddleName": custMiddleName,
        "Cust_LastName": custLastName,
        "Cust_FatherName": custFatherName,
        "Cust_MotherName": custMotherName,
        "Cust_SpouseName": custSpouseName,
        "Cust_Dob_Inc": custDobInc,
        "Cust_Gender": custGender,
        "Cust_PrimaryMobile": custPrimaryMobile,
        "Cust_PrimaryEmail": custPrimaryEmail,
        "Cust_AdhaarNo": custAdhaarNo,
        "Cust_PanCard": custPanCard,
        "Present_Add_Xml": presentAddXml,
        "Permanent_Add_Xml": permanentAddXml,
        "Communication_Add_Xml": communicationAddXml,
        "Account_Type": accountType,
        "Ref_ID": refID,
      },
      "PhotoImage": photoImage,
      "SignatureImage": signatureImage,
      "Aadhaar_FrontImage": aadhaarFrontImage,
      "Aadhaar_BackImage": aadhaarBackImage,
      "PAN_Image": panImage,
    };
  }
}
