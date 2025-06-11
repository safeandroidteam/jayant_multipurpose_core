import 'package:passbook_core_jayant/MainScreens/Model/institution/address_modal.dart';
import 'package:passbook_core_jayant/MainScreens/Model/institution/proprietor_modal.dart';

class InstitutionUiModal {
  final String cmpCode;
  final String brCode;
  final String custTypeCode;
  final String accountType;
  final String refID;
  final String firmName;
  final String firmRegNo;
  final String firmRegType;
  final String firmStartDate;
  final String firmPlaceINC;
  final String firmPanNo;
  final String firmPrimaryEmail;
  final String firmGstin;
  final InstitutionAddressModal firmPresentAdd;
  final InstitutionAddressModal firmPermanentAdd;
  final String communicationAddress;
  final List<ProprietorModal> proprietors;
  final String aadhaarCardFront;
  final String aadhaarCardBack;
  final String panCardFront;

  InstitutionUiModal(
    this.cmpCode,
    this.brCode,
    this.custTypeCode,
    this.accountType,
    this.refID,
    this.firmName,
    this.firmRegNo,
    this.firmRegType,
    this.firmStartDate,
    this.firmPlaceINC,
    this.firmPanNo,
    this.firmPrimaryEmail,
    this.firmGstin,
    this.firmPresentAdd,
    this.firmPermanentAdd,
    this.communicationAddress,
    this.proprietors,
    this.aadhaarCardFront,
    this.aadhaarCardBack,
    this.panCardFront,
  );

  // Method to convert an InstitutionUiModal object to a JSON map
  Map<String, dynamic> toJson() {
    return {
      'cmpCode': cmpCode,
      'brCode': brCode,
      'custTypeCode': custTypeCode,
      'accountType': accountType,
      'refID': refID,
      'firmName': firmName,
      'firmRegNo': firmRegNo,
      'firmRegType': firmRegType,
      'firmStartDate': firmStartDate,
      'firmPlaceINC': firmPlaceINC,
      'firmPanNo': firmPanNo,
      'firmPrimaryEmail': firmPrimaryEmail,
      'firmGstin': firmGstin,
      // Call toJson() on nested InstitutionAddressModal objects
      'firmPresentAdd': firmPresentAdd,
      'firmPermanentAdd': firmPermanentAdd,
      'communicationAddress': communicationAddress,
      // Map the list of ProprietorModal objects to a list of JSON maps
      'proprietors': proprietors,
      'aadhaarCardFront': aadhaarCardFront,
      'aadhaarCardBack': aadhaarCardBack,
      'panCardFront': panCardFront,
    };
  }
}
