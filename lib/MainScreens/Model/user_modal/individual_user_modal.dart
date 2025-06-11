import 'package:passbook_core_jayant/MainScreens/Model/user_modal/prsent_address_modal.dart';

class IndividualUserCreationUIModal {
  final String cmpCode;
  final String brCode;

  final String custTypeCode;
  final String accountType;
  final String refID;
  final String custTitleCode;
  final String custFirstName;
  final String? custMiddleName;
  final String custLastName;
  final String custFatherName;
  final String custMotherName;
  final String custSpouseName;
  final String custDobInc;
  final String custGender;
  final String custPrimaryMobileNo;
  final String custEmail;
  final String custAdhaarNo;
  final String custPanCardNo;
  final String qualification;
  final String ckycNo;
  final AddressModal permanentAddressModal;
  final AddressModal presentAddressModal;
  final String communiCationAddress;
  final String custImage;
  final String custSignature;

  final String aadhaarCardFront;
  final String aadhaarCardBack;
  final String panCardFront;

  IndividualUserCreationUIModal(
    this.cmpCode,
    this.brCode,
    this.custTypeCode,
    this.accountType,
    this.refID,
    this.custTitleCode,
    this.custFirstName,
    this.custMiddleName,
    this.custLastName,
    this.custFatherName,
    this.custMotherName,
    this.custSpouseName,
    this.custDobInc,
    this.custGender,
    this.custPrimaryMobileNo,
    this.custEmail,
    this.custAdhaarNo,
    this.custPanCardNo,
    this.qualification,
    this.ckycNo,
    this.permanentAddressModal,
    this.presentAddressModal,
    this.communiCationAddress,
    this.custImage,
    this.custSignature,
    this.aadhaarCardFront,
    this.aadhaarCardBack,
    this.panCardFront,
  );
}
