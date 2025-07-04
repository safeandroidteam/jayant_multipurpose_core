import 'dart:io';

import 'package:flutter/cupertino.dart';

import '../../../Model/institution/proprietor_modal.dart';

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
  String selectedAccType = "";
  String selectedIndividualTitle = "";
  String selectedBranch = "";
  String selectedIndividualGender = "";
  final TextEditingController customerPrimaryMobileNumberCntlr =
      TextEditingController();
  final TextEditingController newUserRefIDCntlr = TextEditingController();
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
  String communicationAddress = "";
  final TextEditingController permanentAddress = TextEditingController();
  final TextEditingController permanentAddress1 = TextEditingController();
  final TextEditingController permanentAddress2 = TextEditingController();
  final TextEditingController permanent_City_town_village =
      TextEditingController();
  final TextEditingController permanent_post_office_pincode =
      TextEditingController();
  final TextEditingController permanent_country = TextEditingController();
  //final TextEditingController permanent_states = TextEditingController();
  final TextEditingController permanent_district = TextEditingController();

  final TextEditingController presentAddress = TextEditingController();

  void newUserDispose() {
    selectedCustomerType = "";
    selectedAccType = "";
    selectedIndividualTitle = "";
    selectedBranch = "";
  }

  void newUserClear() {
    selectedCustomerType = "";
    selectedAccType = "";

    selectedBranch = "";
    newUserRefIDCntlr.clear();
  }

  void individualClear() {
    communicationAddress = "";
    individualCustomerImageFileBase64 = null;
    individualCustomerSignatureFileBase64 = null;
    individualAadhaarFrontProofFileBase64 = null;
    individualAadhaarBackProofFileBase64 = null;
    individualPanCardProofFileBase64 = null;
    individualBankDetailsFileBase64 = null;
    individualSelfieFileBase64 = null;
    individualVideoRecordingFileBase64 = null;
    individualCustomerImageFile = null;
    individualCustomerSignatureFile = null;
    individualAadhaarFrontProofFile = null;
    individualAadhaarBackProofFile = null;
    individualPanCardProofFile = null;
    individualBankDetailsFile = null;
    individualSelfieFile = null;
    individualVideoRecordingFile = null;
    firstNameCntlr.clear();
    selectedIndividualTitle = "";
    selectedIndividualGender = "";
    customerPrimaryMobileNumberCntlr.clear();
    secondaryMobileNumberCntlr.clear();
    customerPrimaryEmailCntlr.clear();
    customerAadharNumberCntlr.clear();
    customerPanNumberCntlr.clear();
    customerQualificationCntlr.clear();
    customerCkycNumberCntlr.clear();
    presentAddressHouseNoNameCntlr.clear();
    presentAddress1Cntrl.clear();
    presentAddress2Cntrl.clear();
    present_City_town_village_cntlr.clear();
    present_post_office_pincode_cntlr.clear();
    present_country_cntlr.clear();
    present_states_cntlr.clear();
    present_district_cntlr.clear();
    permanentAddressHouseNoNameCntlr.clear();
    permanentAddress1Cntrl.clear();
    permanentAddress2Cntrl.clear();
    permanent_City_town_village_cntlr.clear();
    permanent_post_office_pincode_cntlr.clear();
    permanent_country_cntlr.clear();
    permanent_states_cntlr.clear();
    permanent_district_cntlr.clear();
    slectedCustomerDob.clear();
    middleNameCntlr.clear();
    lastNameCntlr.clear();
    fatherNameCntlr.clear();
    motherNameCntlr.clear();
    spouseNameCntlr.clear();
    guardian.clear();
    permanentAddress.clear();
    permanentAddress1.clear();
    permanentAddress2.clear();
    permanent_City_town_village.clear();
    permanent_post_office_pincode.clear();
    permanent_country.clear();
    permanent_district.clear();
    presentAddress.clear();
  }

  void individualDispose() {
    // Dispose controllers
    firstNameCntlr.dispose();
    customerPrimaryMobileNumberCntlr.dispose();
    newUserRefIDCntlr.dispose();
    secondaryMobileNumberCntlr.dispose();
    customerPrimaryEmailCntlr.dispose();
    customerAadharNumberCntlr.dispose();
    customerPanNumberCntlr.dispose();
    customerQualificationCntlr.dispose();
    customerCkycNumberCntlr.dispose();
    presentAddressHouseNoNameCntlr.dispose();
    presentAddress1Cntrl.dispose();
    presentAddress2Cntrl.dispose();
    present_City_town_village_cntlr.dispose();
    present_post_office_pincode_cntlr.dispose();
    present_country_cntlr.dispose();
    present_states_cntlr.dispose();
    present_district_cntlr.dispose();
    permanentAddressHouseNoNameCntlr.dispose();
    permanentAddress1Cntrl.dispose();
    permanentAddress2Cntrl.dispose();
    permanent_City_town_village_cntlr.dispose();
    permanent_post_office_pincode_cntlr.dispose();
    permanent_country_cntlr.dispose();
    permanent_states_cntlr.dispose();
    permanent_district_cntlr.dispose();
    slectedCustomerDob.dispose();
    middleNameCntlr.dispose();
    lastNameCntlr.dispose();
    fatherNameCntlr.dispose();
    motherNameCntlr.dispose();
    spouseNameCntlr.dispose();
    guardian.dispose();
    permanentAddress.dispose();
    permanentAddress1.dispose();
    permanentAddress2.dispose();
    permanent_City_town_village.dispose();
    permanent_post_office_pincode.dispose();
    permanent_country.dispose();
    permanent_district.dispose();
    presentAddress.dispose();

    // Reset all string variables

    selectedIndividualGender = "";
    communicationAddress = "";
  }

  // void dispose() {
  //   ///Individual
  //   firstNameCntlr.dispose();
  //   middleNameCntlr.dispose();
  //   lastNameCntlr.dispose();
  //   fatherNameCntlr.dispose();
  //   motherNameCntlr.dispose();
  //   spouseNameCntlr.dispose();
  //   guardian.dispose();
  //   customerPrimaryMobileNumberCntlr.dispose();
  //   secondaryMobileNumberCntlr.dispose();
  //   customerPrimaryEmailCntlr.dispose();
  //   customerAadharNumberCntlr.dispose();
  //   customerPanNumberCntlr.dispose();
  //   customerQualificationCntlr.dispose();
  //   customerCkycNumberCntlr.dispose();
  //   permanentAddress.dispose();
  //   permanentAddress1.dispose();
  //   permanentAddress2.dispose();
  //   permanent_City_town_village.dispose();
  //   permanent_post_office_pincode.dispose();
  //   permanent_country.dispose();
  //   permanent_states_cntlr.dispose();
  //   permanent_district.dispose();
  //
  //   presentAddress.dispose();
  //   presentAddressHouseNoNameCntlr.dispose();
  //   presentAddress1Cntrl.dispose();
  //   presentAddress2Cntrl.dispose();
  //   present_City_town_village_cntlr.dispose();
  //   present_post_office_pincode_cntlr.dispose();
  //   present_country_cntlr.dispose();
  //   present_states_cntlr.dispose();
  //   present_district_cntlr.dispose();
  //
  //   ///Institution
  //   firmName.dispose();
  //   firmReg_No.dispose();
  //   turnOver.dispose();
  //   for (var map in proprietorControllers) {
  //     for (var controller in map.values) {
  //       controller.dispose();
  //     }
  //   }
  // }


  //institution

  final TextEditingController firmName = TextEditingController();
  final TextEditingController firmReg_No = TextEditingController();
  final TextEditingController institutionPrimaryEmail = TextEditingController();
  final TextEditingController institutionMobileNo = TextEditingController();
  final TextEditingController institutionFirmGstin = TextEditingController();
  final TextEditingController institutionFirmStartDate =
      TextEditingController();
  final TextEditingController institutionFirmPlace = TextEditingController();
  final TextEditingController turnOver = TextEditingController();
  final TextEditingController institutionFirmPanCard = TextEditingController();

  File? institutionPanCardImage;
  File? institutionAadhaarFrontImage;
  File? institutionAadhaarBackImage;

  String? institutionPanCardImageBase64;
  String? institutionAadhaarFrontImageBase64;
  String? institutionAadhaarBackImageBase64;

  /// Proprietor Details
  final TextEditingController proprietorName = TextEditingController();
  final TextEditingController proprietorEducation = TextEditingController();
  final TextEditingController proprietorDob = TextEditingController();
  final TextEditingController proprietorExperience = TextEditingController();

  /// Ownership Details
  List<ProprietorModal> proprietors = [ProprietorModal()];
  List<Map<String, TextEditingController>> proprietorControllers = [
    {
      'name': TextEditingController(),
      'address': TextEditingController(),
      'panCardNo': TextEditingController(),
    },
  ];

  /// Institution address
  /// permanent address
  final TextEditingController institutionPermanentAddress1 =
      TextEditingController();
  final TextEditingController institutionPermanentAddress2 =
      TextEditingController();
  final TextEditingController institutionPermanentAddress3 =
      TextEditingController();
  final TextEditingController institutionPermanentCity =
      TextEditingController();
  final TextEditingController institutionPermanentTaluk =
      TextEditingController();
  final TextEditingController institutionPermanentDistrict =
      TextEditingController();
  final TextEditingController institutionPermanentState =
      TextEditingController();
  final TextEditingController institutionPermanentCountry =
      TextEditingController();
  final TextEditingController institutionPermanentPinCode =
      TextEditingController();

  ///Current
  final TextEditingController institutionCurrentAddress1 =
      TextEditingController();
  final TextEditingController institutionCurrentAddress2 =
      TextEditingController();
  final TextEditingController institutionCurrentAddress3 =
      TextEditingController();
  final TextEditingController institutionCurrentCity = TextEditingController();
  final TextEditingController institutionCurrentTaluk = TextEditingController();
  final TextEditingController institutionCurrentDistrict =
      TextEditingController();
  final TextEditingController institutionCurrentState = TextEditingController();
  final TextEditingController institutionCurrentCountry =
      TextEditingController();
  final TextEditingController institutionCurrentPinCode =
      TextEditingController();
  String institutionCommunicationAddress = "";

  //institution new vishnu
  void institutionClear(){
    firmName.clear();
    firmReg_No.clear();
    institutionPrimaryEmail.clear();
    institutionMobileNo.clear();
    institutionFirmGstin.clear();
    institutionFirmStartDate.clear();
    institutionFirmPlace.clear();
    turnOver.clear();
    institutionFirmPanCard.clear();
    institutionPanCardImage= null;
    institutionPanCardImageBase64= null;
    proprietorControllers.clear();
    institutionPermanentAddress1.clear();
    institutionPermanentAddress2.clear();
    institutionPermanentAddress3.clear();
    institutionPermanentCity.clear();
    institutionPermanentTaluk.clear();
    institutionPermanentDistrict.clear();
    institutionPermanentState.clear();
    institutionPermanentCountry.clear();
    institutionPermanentPinCode.clear();
    institutionCurrentAddress1.clear();
    institutionCurrentAddress2.clear();
    institutionCurrentAddress3.clear();
    institutionCurrentCity.clear();
    institutionCurrentTaluk.clear();
    institutionCurrentDistrict.clear();
    institutionCurrentState.clear();
    institutionCurrentCountry.clear();
    institutionCurrentPinCode.clear();
    institutionCommunicationAddress = "";
    institutionAadhaarFrontImage = null;
    institutionAadhaarFrontImageBase64 = null;
    institutionAadhaarBackImage = null;
    institutionAadhaarBackImageBase64 = null;
    proprietorName.clear();
    proprietorEducation.clear();
    proprietorDob.clear();
    proprietorExperience.clear();
  }

  void institutionDispose() {
    firmName.dispose();
    firmReg_No.dispose();
    institutionPrimaryEmail.dispose();
    institutionMobileNo.dispose();
    institutionFirmGstin.dispose();
    institutionFirmStartDate.dispose();
    institutionFirmPlace.dispose();
    turnOver.dispose();
    institutionFirmPanCard.dispose();
    //proprietorControllers.dispose();
    institutionPermanentAddress1.dispose();
    institutionPermanentAddress2.dispose();
    institutionPermanentAddress3.dispose();
    institutionPermanentCity.dispose();
    institutionPermanentTaluk.dispose();
    institutionPermanentDistrict.dispose();
    institutionPermanentState.dispose();
    institutionPermanentCountry.dispose();
    institutionPermanentPinCode.dispose();
    institutionCurrentAddress1.dispose();
    institutionCurrentAddress2.dispose();
    institutionCurrentAddress3.dispose();
    institutionCurrentCity.dispose();
    institutionCurrentTaluk.dispose();
    institutionCurrentDistrict.dispose();
    institutionCurrentState.dispose();
    institutionCurrentCountry.dispose();
    institutionCurrentPinCode.dispose();
    institutionCommunicationAddress = "";
    proprietorName.dispose();
    proprietorEducation.dispose();
    proprietorDob.dispose();
    proprietorExperience.dispose();
  }
}
