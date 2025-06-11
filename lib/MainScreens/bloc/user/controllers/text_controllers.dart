import 'dart:io';

import 'package:flutter/cupertino.dart';

import '../../../Model/user_modal/proprietor_modal.dart';

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
  final TextEditingController permanent_City_town_village =
      TextEditingController();
  final TextEditingController permanent_post_office_pincode =
      TextEditingController();
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
    turnOver.dispose();
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
  }

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

  String? institutionPanCardImageBase64;

  /// Proprietor Details
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
}
