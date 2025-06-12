import 'package:passbook_core_jayant/MainScreens/Model/institution/proprietor_modal.dart';

import 'address_modal.dart';

class InstituitionUiReqModel {
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
  final InstitutionAddressModal presentAddressXml;
  final InstitutionAddressModal permanentAddressXml;
  final String communicationAddress;
  final List<ProprietorModal> proprietorsXml;
  final String accountType;
  final String refID;
  final String aadhaarFrontImage;
  final String aadhaarBackImage;
  final String panImage;
  final String proprietorName;
  final String proprietorEducation;
  final String proprietorDOB;
  final String proprietorExperience;

  InstituitionUiReqModel({
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
}
