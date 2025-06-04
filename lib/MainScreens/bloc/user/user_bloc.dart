import 'dart:io';

import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:passbook_core_jayant/REST/RestAPI.dart';
import 'package:passbook_core_jayant/Util/custom_print.dart';

import '../../Model/fill_pickUp_response_modal.dart';

part 'user_event.dart';
part 'user_state.dart';

class UserBloc extends Bloc<UserEvent, UserState> {
  ///Individual image data type
  File? individualCustomerImageFile;
  File? individualCustomerSignatureFile;
  File? individualIdProofFile;
  File? individualBankDetailsFile;
  File? individualSelfieFile;
  File? individualVideoRecordingFile;

  /// Store base64 strings
  String? individualCustomerImageFileBase64;
  String? individualCustomerSignatureFileBase64;
  String? individualIdProofFileBase64;
  String? individualBankDetailsFileBase64;
  String? individualSelfieFileBase64;
  String? individualVideoRecordingFileBase64;

  var individualTitle;
  final TextEditingController firstName = TextEditingController();
  final TextEditingController middleName = TextEditingController();
  final TextEditingController lastName = TextEditingController();
  final TextEditingController fatherName = TextEditingController();
  final TextEditingController motherName = TextEditingController();
  final TextEditingController spouseName = TextEditingController();
  final TextEditingController guardian = TextEditingController();
  final TextEditingController primaryMobileNumber = TextEditingController();
  final TextEditingController secondaryMobileNumber = TextEditingController();
  final TextEditingController primaryEmail = TextEditingController();
  final TextEditingController aadharNumber = TextEditingController();
  final TextEditingController panNumber = TextEditingController();
  final TextEditingController qualification = TextEditingController();
  final TextEditingController ckycNumber = TextEditingController();
  final TextEditingController permanentAddress = TextEditingController();
  final TextEditingController permanentAddress1 = TextEditingController();
  final TextEditingController permanentAddress2 = TextEditingController();
  final TextEditingController permanent_City_town_village =
      TextEditingController();
  final TextEditingController permanent_post_office_pincode =
      TextEditingController();
  final TextEditingController permanent_country = TextEditingController();
  final TextEditingController permanent_states = TextEditingController();
  final TextEditingController permanent_district = TextEditingController();
  final TextEditingController communicationAddress = TextEditingController();
  final TextEditingController presentAddress = TextEditingController();
  final TextEditingController HouseNo_Name = TextEditingController();
  final TextEditingController presentAddress1 = TextEditingController();
  final TextEditingController presentAddress2 = TextEditingController();
  final TextEditingController present_City_town_village =
      TextEditingController();
  final TextEditingController present_post_office_pincode =
      TextEditingController();
  final TextEditingController present_country = TextEditingController();
  final TextEditingController present_states = TextEditingController();
  final TextEditingController present_district = TextEditingController();
  bool terms_condition = false;
  String? individualGender;
  String? individualCommunticationAddress;

  void dispose() {
    ///Individual
    firstName.dispose();
    middleName.dispose();
    lastName.dispose();
    fatherName.dispose();
    motherName.dispose();
    spouseName.dispose();
    guardian.dispose();
    primaryMobileNumber.dispose();
    secondaryMobileNumber.dispose();
    primaryEmail.dispose();
    aadharNumber.dispose();
    panNumber.dispose();
    qualification.dispose();
    ckycNumber.dispose();
    permanentAddress.dispose();
    permanentAddress1.dispose();
    permanentAddress2.dispose();
    permanent_City_town_village.dispose();
    permanent_post_office_pincode.dispose();
    permanent_country.dispose();
    permanent_states.dispose();
    permanent_district.dispose();
    communicationAddress.dispose();
    presentAddress.dispose();
    HouseNo_Name.dispose();
    presentAddress1.dispose();
    presentAddress2.dispose();
    present_City_town_village.dispose();
    present_post_office_pincode.dispose();
    present_country.dispose();
    present_states.dispose();
    present_district.dispose();

    ///Institution

    firmName.dispose();
    firmReg_No.dispose();
    firmAddress.dispose();
    productDetails.dispose();
    turnOver.dispose();

    proprietorName.dispose();
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

  ///institution
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
  final TextEditingController proprietorName = TextEditingController();
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

  UserBloc() : super(UserInitial()) {
    on<FillPickUpTypesEvent>(_onFetchCustomerTypes);
    on<SelectPickUpTypeEvent>(_onSelectCustomerType);
  }

  Future<void> _onFetchCustomerTypes(
    FillPickUpTypesEvent event,
    Emitter<UserState> emit,
  ) async {
    if (event.pickUpType == 6) {
      emit(PickUpCustomerTypeLoading());
    } else if (event.pickUpType == 5) {
      emit(PickUpTitleTypeLoading());
    } else if (event.pickUpType == 8) {
      emit(PickUpGenderTypeLoading());
    }

    try {
      final response = await RestAPI().post(
        APis.fillPickUp,
        params: {"Cmp_Code": event.cmpCode, "PickUpType": event.pickUpType},
      );

      successPrint("CmpCode ${event.cmpCode}");
      successPrint("PickUpTYpe ${event.pickUpType}");

      final data = response['Data'] as List<dynamic>;

      final List<PickUpTypeResponseModal> list =
          data.map((e) => PickUpTypeResponseModal.fromJson(e)).toList();

      successPrint("Data ${data.first.toString()}");

      successPrint("List Starting ${list}");

      if (event.pickUpType == 6) {
        emit(PickUpCustomerTypeResponse(pickUpCustomerTypeList: list));
      } else if (event.pickUpType == 5) {
        emit(PickUpTitleTypeResponse(pickUpTitleTypeList: list));
      } else if (event.pickUpType == 8) {
        emit(PickUpGenderTypeResponse(pickUpGenderTypeList: list));
      }
    } catch (e) {
      if (event.pickUpType == 6) {
        emit(PickUpCustomerTypeError("Failed to load customer types.$e"));
      } else if (event.pickUpType == 5) {
        emit(PickUpTitleTypeError("Failed to load customer types.$e"));
      } else if (event.pickUpType == 8) {
        emit(PickUpGenderTypeError("Failed to load customer types.$e"));
      }
      errorPrint("Error: $e");
    }
  }

  void _onSelectCustomerType(
    SelectPickUpTypeEvent event,
    Emitter<UserState> emit,
  ) {
    warningPrint("_onSelectCustomerType Loading");
    emit(UserSelectedCustomerTypeLoading());
    emit(UserSelectedCustomerType(event.selectedItem.pkcCode));
    warningPrint("_onSelectCustomerType Success");
  }

  static UserBloc get(context) => BlocProvider.of(context);
}
