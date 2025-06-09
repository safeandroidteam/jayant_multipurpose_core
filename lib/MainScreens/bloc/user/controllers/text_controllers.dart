import 'dart:io';

import 'package:flutter/cupertino.dart';

class Textcntlrs {
  // ///Individual image data type
  File? individualCustomerImageFile;
  File? individualCustomerSignatureFile;
  File? individualAadhaarFrontProofFile;
  File? individualAadhaarBackProofFile;
  File? individualPanCardProofFile;
  File? individualBankDetailsFile;
  File? individualSelfieFile;
  File? individualVideoRecordingFile;

  /// Store base64 strings
  String? individualCustomerImageFileBase64;
  String? individualCustomerSignatureFileBase64;
  String? individualAadhaarFrontProofFileBase64;
  String? individualAadhaarBackProofFileBase64;
  String? individualPanCardProofFileBase64;
  String? individualBankDetailsFileBase64;
  String? individualSelfieFileBase64;
  String? individualVideoRecordingFileBase64;

  ///new user jishnu
  final TextEditingController firstNameCntlr = TextEditingController();
  String selectedCustomerType = "";
  String selectedIndividualTitle = "";
  String selectedBranch = "";
  String selectedIndividualGender = "";
  final TextEditingController customerPrimaryMobileNumberCntlr =
      TextEditingController();
  final TextEditingController secondaryMobileNumberCntlr =
      TextEditingController();
  final TextEditingController customerPrimaryEmailCntlr =
      TextEditingController();
  final TextEditingController customerAadharNumberCntlr =
      TextEditingController();
  final TextEditingController customerPanNumberCntlr = TextEditingController();
  final TextEditingController customerQualificationCntlr =
      TextEditingController();
  final TextEditingController customerCkycNumberCntlr = TextEditingController();
  final TextEditingController presentAddressHouseNoNameCntlr =
      TextEditingController();
  final TextEditingController presentAddress1Cntrl = TextEditingController();
  final TextEditingController presentAddress2Cntrl = TextEditingController();
  final TextEditingController present_City_town_village_cntlr =
      TextEditingController();
  final TextEditingController present_post_office_pincode_cntlr =
      TextEditingController();
  final TextEditingController present_country_cntlr = TextEditingController();
  final TextEditingController present_states_cntlr = TextEditingController();
  final TextEditingController present_district_cntlr = TextEditingController();

  final TextEditingController permanentAddressHouseNoNameCntlr =
      TextEditingController();
  final TextEditingController permanentAddress1Cntrl = TextEditingController();
  final TextEditingController permanentAddress2Cntrl = TextEditingController();
  final TextEditingController permanent_City_town_village_cntlr =
      TextEditingController();
  final TextEditingController permanent_post_office_pincode_cntlr =
      TextEditingController();
  final TextEditingController permanent_country_cntlr = TextEditingController();
  final TextEditingController permanent_states_cntlr = TextEditingController();
  final TextEditingController permanent_district_cntlr =
      TextEditingController();

  final TextEditingController slectedCustomerDob = TextEditingController();
  final TextEditingController middleNameCntlr = TextEditingController();
  final TextEditingController lastNameCntlr = TextEditingController();
  final TextEditingController fatherNameCntlr = TextEditingController();
  final TextEditingController motherNameCntlr = TextEditingController();
  final TextEditingController spouseNameCntlr = TextEditingController();
  final TextEditingController guardian = TextEditingController();
  bool isthisCommuniCationAddress = false;
  final TextEditingController permanentAddress = TextEditingController();
  final TextEditingController permanentAddress1 = TextEditingController();
  final TextEditingController permanentAddress2 = TextEditingController();
  final TextEditingController permanent_City_town_village =TextEditingController();
  final TextEditingController permanent_post_office_pincode =TextEditingController();
  final TextEditingController permanent_country = TextEditingController();
  //final TextEditingController permanent_states = TextEditingController();
  final TextEditingController permanent_district = TextEditingController();
  final TextEditingController communicationAddress = TextEditingController();
  final TextEditingController presentAddress = TextEditingController();
  String? individualCommunticationAddress;

  void dispose() {
    ///Individual
    firstNameCntlr.dispose();
    middleNameCntlr.dispose();
    lastNameCntlr.dispose();
    fatherNameCntlr.dispose();
    motherNameCntlr.dispose();
    spouseNameCntlr.dispose();
    guardian.dispose();
    customerPrimaryMobileNumberCntlr.dispose();
    secondaryMobileNumberCntlr.dispose();
    customerPrimaryEmailCntlr.dispose();
    customerAadharNumberCntlr.dispose();
    customerPanNumberCntlr.dispose();
    customerQualificationCntlr.dispose();
    customerCkycNumberCntlr.dispose();
    permanentAddress.dispose();
    permanentAddress1.dispose();
    permanentAddress2.dispose();
    permanent_City_town_village.dispose();
    permanent_post_office_pincode.dispose();
    permanent_country.dispose();
    permanent_states_cntlr.dispose();
    permanent_district.dispose();
    communicationAddress.dispose();
    presentAddress.dispose();
    presentAddressHouseNoNameCntlr.dispose();
    presentAddress1Cntrl.dispose();
    presentAddress2Cntrl.dispose();
    present_City_town_village_cntlr.dispose();
    present_post_office_pincode_cntlr.dispose();
    present_country_cntlr.dispose();
    present_states_cntlr.dispose();
    present_district_cntlr.dispose();

    ///Institution

    firmName.dispose();
    firmReg_No.dispose();
    firmAddress.dispose();
    productDetails.dispose();
    turnOver.dispose();

    // proprietorName.dispose();
    proprietorMobileNumber.dispose();
    proprietorDOB.dispose();
    proprietorMotherName.dispose();
    proprietorFatherName.dispose();
    proprietorEmailId.dispose();

    institutionQualification.dispose();
    profession.dispose();
    institutionPanCard.dispose();
    institutionAadharNo.dispose();

    institutionPermanentAddress.dispose();
    institution_Current_communticationAddress.dispose();

    aadharOtpVerification.dispose();
  }

  //institution
  File? institutionSelfieFile;
  File? institutionSignatureFile;
  File? institutionImageFile;
  File? institutionBlinkEyeVideoFile;
  File? institutionTalkingVideoFile;

  String? institutionSelfieBase64;
  String? institutionSignatureBase64;
  String? institutionImageBase64;
  String? institutionBlinkEyeVideoBase64;
  String? institutionTalkingVideoBase64;

  final TextEditingController firmName = TextEditingController();
  final TextEditingController firmReg_No = TextEditingController();
  final TextEditingController firmAddress = TextEditingController();
  final TextEditingController productDetails = TextEditingController();
  final TextEditingController turnOver = TextEditingController();

  /// Proprietor Details
  List<Map<String, TextEditingController>> proprietorControllers = [
    {
      'name': TextEditingController(),
      'dob': TextEditingController(),
      'fatherName': TextEditingController(),
      'motherName': TextEditingController(),
      'mobile': TextEditingController(),
      'email': TextEditingController(),
    },
  ];

  final TextEditingController proprietorMobileNumber = TextEditingController();
  final TextEditingController proprietorDOB = TextEditingController();
  final TextEditingController proprietorMotherName = TextEditingController();
  final TextEditingController proprietorFatherName = TextEditingController();
  final TextEditingController proprietorEmailId = TextEditingController();

  /// Institution Identity Info
  final TextEditingController institutionQualification =
      TextEditingController();
  final TextEditingController profession = TextEditingController();
  final TextEditingController institutionPanCard = TextEditingController();
  final TextEditingController institutionAadharNo = TextEditingController();

  /// Address Details
  final TextEditingController institutionPermanentAddress =
      TextEditingController();
  final TextEditingController institution_Current_communticationAddress =
      TextEditingController();

  /// Aadhar OTP Verification
  final TextEditingController aadharOtpVerification = TextEditingController();
}
