import 'package:passbook_core_jayant/MainScreens/Model/user_modal/prsent_address_modal.dart';

class IndividualUserModal {
  final String branch;
  final String custType;
  final String title;
  final String custFirstName;
  final String? custMiddleName;
  final String custLastName;
  final String fatcherName;
  final String motherName;
  final String spouseName;
  final String dob;
  final String gender;
  final String primaryMobileNo;
  final String aadharNo;
  final String panNo;
  final String qualification;
  final String ckycNo;
  final AddressModal permanentAddressModal;
  final AddressModal presentAddressModal;
  final String communiCationAddress;
  final String custImage;
  final String custSignature;
  final String custSelfie;
  final String aadhaarCardFront;
  final String aadhaarCardBack;
  final String panCardFront;

  IndividualUserModal(
    this.branch,
    this.custType,
    this.title,
    this.custFirstName,
    this.custMiddleName,
    this.custLastName,
    this.fatcherName,
    this.motherName,
    this.spouseName,
    this.dob,
    this.gender,
    this.primaryMobileNo,
    this.aadharNo,
    this.panNo,
    this.qualification,
    this.ckycNo,
    this.permanentAddressModal,
    this.presentAddressModal,
    this.communiCationAddress,
    this.custImage,
    this.custSignature,
    this.custSelfie,
    this.aadhaarCardFront,
    this.aadhaarCardBack,
    this.panCardFront,
  );
}
