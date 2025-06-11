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
}
