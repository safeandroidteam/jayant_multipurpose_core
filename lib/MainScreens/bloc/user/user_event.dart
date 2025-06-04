part of 'user_bloc.dart';

abstract class UserEvent extends Equatable {
  const UserEvent();

  @override
  List<Object> get props => [];
}

class FillPickUpTypesEvent extends UserEvent {
  final int cmpCode;
  final int pickUpType;

  const FillPickUpTypesEvent({required this.cmpCode, required this.pickUpType});

  @override
  List<Object> get props => [cmpCode, pickUpType];
}

class SelectPickUpTypeEvent extends UserEvent {
  final PickUpTypeResponseModal selectedItem;

  const SelectPickUpTypeEvent(this.selectedItem);

  @override
  List<Object> get props => [selectedItem];
}

class IndividualUserOnBoardingEvent extends UserEvent {
  final String firmName;
  final String firmRegNo;
  final String firmAddress;
  final String productDetails;
  final String turnOver;
  final String proprietorName;
  final String proprietorMobileNumber;
  final String proprietorDOB;
  final String proprietorMotherName;
  final String proprietorFatherName;
  final String proprietorEmailId;
  final String institutionGender;
  final String nationality;
  final String institutionQualification;
  final String profession;
  final String institutionPanCard;
  final String institutionAadharNo;
  final String institutionPermanentAddress;
  final String institutionCurrentCommAddress;
  final String aadharOtpVerification;

  const IndividualUserOnBoardingEvent({
    required this.firmName,
    required this.firmRegNo,
    required this.firmAddress,
    required this.productDetails,
    required this.turnOver,
    required this.proprietorName,
    required this.proprietorMobileNumber,
    required this.proprietorDOB,
    required this.proprietorMotherName,
    required this.proprietorFatherName,
    required this.proprietorEmailId,
    required this.institutionGender,
    required this.nationality,
    required this.institutionQualification,
    required this.profession,
    required this.institutionPanCard,
    required this.institutionAadharNo,
    required this.institutionPermanentAddress,
    required this.institutionCurrentCommAddress,
    required this.aadharOtpVerification,
  });

  @override
  List<Object> get props => [
    firmName,
    firmRegNo,
    firmAddress,
    productDetails,
    turnOver,
    proprietorName,
    proprietorMobileNumber,
    proprietorDOB,
    proprietorMotherName,
    proprietorFatherName,
    proprietorEmailId,
    institutionGender,
    nationality,
    institutionQualification,
    profession,
    institutionPanCard,
    institutionAadharNo,
    institutionPermanentAddress,
    institutionCurrentCommAddress,
    aadharOtpVerification,
  ];
}
