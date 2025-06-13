import 'dart:developer';
import 'dart:io';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:passbook_core_jayant/MainScreens/Model/fill_pickUp_response_modal.dart';
import 'package:passbook_core_jayant/MainScreens/Model/institution/proprietor_modal.dart';
import 'package:passbook_core_jayant/MainScreens/Model/user_modal/individual_user_modal.dart';
import 'package:passbook_core_jayant/MainScreens/Model/user_modal/prsent_address_modal.dart';
import 'package:passbook_core_jayant/MainScreens/Model/user_modal/request/individual_request_modal.dart';
import 'package:passbook_core_jayant/MainScreens/Model/user_modal/request/validate_ref_id_req_modal.dart';
import 'package:passbook_core_jayant/MainScreens/Model/user_modal/response/branch_modal.dart';
import 'package:passbook_core_jayant/MainScreens/Model/user_modal/response/individual_response_modal.dart';
import 'package:passbook_core_jayant/MainScreens/Model/user_modal/response/validate_ref_id_res_modal.dart';
import 'package:passbook_core_jayant/REST/RestAPI.dart';
import 'package:passbook_core_jayant/REST/app_exceptions.dart';
import 'package:passbook_core_jayant/Util/custom_print.dart';
import 'package:xml/xml.dart' as xml;

import '../../Model/institution/address_modal.dart';
import '../../Model/institution/institution_request_modal.dart';
import '../../Model/institution/intitutionUiReqModel.dart';
import '../../Model/user_modal/response/institution_response_modal.dart';

part 'user_bloc.freezed.dart'; // GENERATED FILE
part 'user_event.dart';
part 'user_state.dart';

class UserBloc extends Bloc<UserEvent, UserState> {
  UserBloc() : super(UserState.initial()) {
    on<FillPickUpTypesEvent>(_FillPickUpTypesEvent);
    on<selectCustomerTypeEvent>(_onSelectCustomerType);
    on<PickCustomerDobEvent>(_pickDobOfCustomer);
    on<GetBranchesEvent>(_getBranches);
    on<IndividualUserCreationEvent>(_individualCreation);
    on<ValidateRefIDEvent>(_validateRefID);
    on<InstitutionUserCreationEvent>(_institutionCreation);

    on<ClearRefEvent>(_clearRef);
    on<ClearDobEvent>(_clearDob);
  }

  void _FillPickUpTypesEvent(
    FillPickUpTypesEvent event,
    Emitter<UserState> emit,
  ) async {
    warningPrint("pick type code when starting= ${event.pickUpType}");
    List<PickUpTypeResponseModal> customerTypeList = [];
    List<PickUpTypeResponseModal> customerTitleList = [];
    List<PickUpTypeResponseModal> customerGenderList = [];
    if (event.pickUpType == 6) {
      emit(state.copyWith(isPickupCustomerTypeLoading: true));
    } else if (event.pickUpType == 5) {
      emit(state.copyWith(isPickupTitleeLoading: true));
    } else if (event.pickUpType == 8) {
      emit(state.copyWith(isPickupGenderLoading: true));
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

      //  successPrint("Data ${data.first.toString()}");

      //successPrint("List Starting $list");

      if (event.pickUpType == 6) {
        customerTypeList.clear();
        customerTypeList.addAll(list);
        emit(
          state.copyWith(
            isPickupCustomerTypeLoading: false,
            pickUpCustomerTypeList: customerTypeList,
            pickUpGenderList: customerGenderList,
            pickUpTitileList: customerTitleList,
          ),
        );
      } else if (event.pickUpType == 5) {
        customerTitleList.clear();
        customerTitleList.addAll(list);
        emit(
          state.copyWith(
            isPickupTitleeLoading: false,
            pickUpCustomerTypeList: customerTypeList,
            pickUpGenderList: customerGenderList,
            pickUpTitileList: customerTitleList,
          ),
        );
      } else if (event.pickUpType == 8) {
        customerGenderList.clear();
        customerGenderList.addAll(list);
        emit(
          state.copyWith(
            isPickupGenderLoading: false,
            pickUpCustomerTypeList: customerTypeList,
            pickUpGenderList: customerGenderList,
            pickUpTitileList: customerTitleList,
          ),
        );
      }
    } catch (e) {
      if (event.pickUpType == 6) {
        emit(state.copyWith(isPickupCustomerTypeLoading: false));
      } else if (event.pickUpType == 5) {
        emit(state.copyWith(isPickupTitleeLoading: false));
      } else if (event.pickUpType == 8) {
        emit(state.copyWith(isPickupGenderLoading: false));
      }
      errorPrint("Error: $e");
    }
  }

  void _onSelectCustomerType(
    selectCustomerTypeEvent event,
    Emitter<UserState> emit,
  ) {
    //warningPrint("_onSelectCustomerType Loading");
    emit(state.copyWith(selectedCustomerTypeCode: event.selectedItem));
    // warningPrint("_onSelectCustomerType ${state.runtimeType}");
  }

  void _pickDobOfCustomer(PickCustomerDobEvent event, Emitter<UserState> emit) {
    emit(state.copyWith(dobCustomer: event.dob));
  }

  void _getBranches(GetBranchesEvent event, Emitter<UserState> emit) async {
    emit(state.copyWith(isPickUpBranchLoading: true));
    // warningPrint("branch Loading ");
    try {
      final response = await RestAPI().get(APis.getBranches);
      //  warningPrint("branch response =$response");
      final List<BranchData> branchList =
          (response["Data"] as List)
              .map((e) => BranchData.fromJson(e))
              .toList();
      // warningPrint("branch List =${branchList.length}");
      emit(
        state.copyWith(isPickUpBranchLoading: false, branchList: branchList),
      );
    } on RestException catch (e) {
      emit(state.copyWith(isPickUpBranchLoading: false));
    }
  }

  Future<void> _individualCreation(
    IndividualUserCreationEvent event,
    Emitter<UserState> emit,
  ) async {
    emit(state.copyWith(isIndividualUserLoading: true));
    try {
      List<AddressModal> tempAddressDataList = [];
      tempAddressDataList.add(
        event.individualUserCreationUiModal.presentAddressModal,
      );
      tempAddressDataList.add(
        event.individualUserCreationUiModal.permanentAddressModal,
      );
      customPrint("address data list length == ${tempAddressDataList.length}");

      List<xml.XmlElement> presentXmllist = [];
      List<xml.XmlElement> permanentXmllist = [];

      for (var address in tempAddressDataList) {
        if (address.addressType.toLowerCase() == "present") {
          presentXmllist.add(address.toXml());
        } else if (address.addressType.toLowerCase() == "permanent") {
          permanentXmllist.add(address.toXml());
        }
      }

      var presentAddRoot = xml.XmlElement(xml.XmlName('root'));
      var permanentAddRoot = xml.XmlElement(xml.XmlName('root'));

      for (var xmlElement in presentXmllist) {
        presentAddRoot.children.add(xmlElement);
      }
      for (var xmlElement in permanentXmllist) {
        permanentAddRoot.children.add(xmlElement);
      }
      String permanentXmlString = permanentAddRoot.toXmlString(pretty: true);
      String presentXmlString = presentAddRoot.toXmlString(pretty: true);
      // warningPrint("permanent string==$permanentXmlString");
      // warningPrint("present string==$presentXmlString");
      final requestModel = IndividualUserRequestModel(
        refID: event.individualUserCreationUiModal.refID,
        cmpCode: event.individualUserCreationUiModal.cmpCode,
        brCode: event.individualUserCreationUiModal.brCode,
        custTypeCode: event.individualUserCreationUiModal.custTypeCode,
        custTitleCode: event.individualUserCreationUiModal.custTitleCode,
        custFirstName: event.individualUserCreationUiModal.custFirstName,
        custMiddleName:
            event.individualUserCreationUiModal.custMiddleName ?? "",
        custLastName: event.individualUserCreationUiModal.custLastName,
        custFatherName: event.individualUserCreationUiModal.custFatherName,
        custMotherName: event.individualUserCreationUiModal.custMotherName,
        custSpouseName: event.individualUserCreationUiModal.custSpouseName,
        custDobInc: event.individualUserCreationUiModal.custDobInc,
        custGender: event.individualUserCreationUiModal.custGender,
        custPrimaryMobile:
            event.individualUserCreationUiModal.custPrimaryMobileNo,
        custPrimaryEmail: event.individualUserCreationUiModal.custEmail,
        custAdhaarNo: event.individualUserCreationUiModal.custAdhaarNo,
        custPanCard: event.individualUserCreationUiModal.custPanCardNo,
        presentAddXml: presentXmlString,
        permanentAddXml: permanentXmlString,
        communicationAddXml:
            event.individualUserCreationUiModal.communiCationAddress
                        .toLowerCase() ==
                    "present"
                ? "Present"
                : "Permanent",
        accountType: event.individualUserCreationUiModal.accountType,
        photoImage: event.individualUserCreationUiModal.custImage,
        signatureImage: event.individualUserCreationUiModal.custSignature,
        aadhaarFrontImage: event.individualUserCreationUiModal.aadhaarCardFront,
        aadhaarBackImage: event.individualUserCreationUiModal.aadhaarCardBack,
        panImage: event.individualUserCreationUiModal.panCardFront,
      );

      warningPrint("requestModel user Creation Individual =$requestModel");

      final response = await RestAPI().post(
        APis.individualUserCreation,
        params: requestModel.toJson(),
      );

      final parsedResponse = IndividualUserResponseModel.fromJson(response);
      emit(
        state.copyWith(
          isIndividualUserLoading: false,
          individualResponse: parsedResponse,
          individualUserCreationError: response["ProceedMessage"],
        ),
      );
      successPrint("user creation success - Individual");
    } on RestException catch (e) {
      emit(
        state.copyWith(
          isIndividualUserLoading: false,
          individualUserCreationError:
              e.message["ProceedMessage"] ?? "Request failed",
          individualResponse: null,
        ),
      );
      errorPrint("Rest exception in user creation - Individual = $e");
    } catch (e) {
      errorPrint("catch in user creation - Individual = $e");
      emit(
        state.copyWith(
          isIndividualUserLoading: false,
          individualUserCreationError:
              "Something went wrong. Please try again.",
          individualResponse: null,
        ),
      );
    }
  }

  Future<void> _institutionCreation(
    InstitutionUserCreationEvent event,
    Emitter<UserState> emit,
  ) async {
    emit(state.copyWith(isInstitutionCreationLoading: true));

    try {
      List<InstitutionAddressModal> tempAddressDataList = [];
      List<ProprietorModal> tempProprietorAddressDataList = [];
      tempAddressDataList.add(event.institutionUiModal.presentAddressXml);
      tempAddressDataList.add(event.institutionUiModal.permanentAddressXml);

      tempProprietorAddressDataList.addAll(
        event.institutionUiModal.proprietorsXml,
      );
      customPrint("address data list length == ${tempAddressDataList.length}");

      List<xml.XmlElement> presentXmllist = [];
      List<xml.XmlElement> permanentXmllist = [];
      List<xml.XmlElement> proprietorsXmllist = [];

      for (var address in tempAddressDataList) {
        if (address.addType.toLowerCase() == "present") {
          presentXmllist.add(address.toXml());
        } else if (address.addType.toLowerCase() == "permanent") {
          permanentXmllist.add(address.toXml());
        }
      }

      var presentAddRoot = xml.XmlElement(xml.XmlName('root'));
      var permanentAddRoot = xml.XmlElement(xml.XmlName('root'));
      var proprietorsAddRoot = xml.XmlElement(xml.XmlName('root'));

      for (var xmlElement in presentXmllist) {
        presentAddRoot.children.add(xmlElement);
      }
      for (var xmlElement in permanentXmllist) {
        permanentAddRoot.children.add(xmlElement);
      }
      for (var xmlElement in tempProprietorAddressDataList) {
        proprietorsAddRoot.children.add(xmlElement.toXml());
      }
      String permanentXmlString = permanentAddRoot.toXmlString(pretty: true);
      String presentXmlString = presentAddRoot.toXmlString(pretty: true);
      String proprietorsXmlString = proprietorsAddRoot.toXmlString(
        pretty: true,
      );

      final institiutionReqModel = InstitutionReqModal(
        cmpCode: event.institutionUiModal.cmpCode,
        brCode: event.institutionUiModal.brCode,
        custTypeCode: event.institutionUiModal.custTypeCode,
        firmName: event.institutionUiModal.firmName,
        firmRegType: event.institutionUiModal.firmRegType,
        firmRegNo: event.institutionUiModal.firmRegNo,
        firmStartDate: event.institutionUiModal.firmStartDate,
        firmPlaceInc: event.institutionUiModal.firmPlaceInc,
        firmPanNo: event.institutionUiModal.firmPanNo,
        firmPrimaryEmail: event.institutionUiModal.firmPrimaryEmail,
        firmGstin: event.institutionUiModal.firmGstin,
        presentAddressXml: permanentXmlString,
        permanentAddressXml: presentXmlString,
        communicationAddress: event.institutionUiModal.communicationAddress,
        proprietorsXml: proprietorsXmlString,
        accountType: event.institutionUiModal.accountType,
        refID: event.institutionUiModal.refID,
        aadhaarFrontImage: event.institutionUiModal.aadhaarFrontImage,
        aadhaarBackImage: event.institutionUiModal.aadhaarBackImage,
        panImage: event.institutionUiModal.panImage,
        proprietorName: event.institutionUiModal.proprietorName,
        proprietorEducation: event.institutionUiModal.proprietorEducation,
        proprietorDOB: event.institutionUiModal.proprietorDOB,
        proprietorExperience: event.institutionUiModal.proprietorExperience,
      );
      // Prepare your request model
      // alertPrint("Institution Request modal $institiutionReqModel");
      // log("Institution Pan Image ${institiutionReqModel.panImage}");
      log("Institution Request modal $institiutionReqModel");

      final response = await RestAPI().post(
        APis.institutionUserCreation,
        params: institiutionReqModel.toJson(),
      );

      final parsedResponse = InstitutionResponseModal.fromJson(response);

      emit(
        state.copyWith(
          isInstitutionCreationLoading: false,
          institutionResponse: parsedResponse,
          institutionCreationError: response["ProceedMessage"],
        ),
      );

      successPrint("✅ Institution creation success");
    } on RestException catch (e) {
      emit(
        state.copyWith(
          isInstitutionCreationLoading: false,
          institutionResponse: null,
          institutionCreationError:
              e.message["ProceedMessage"] ?? "Request failed",
        ),
      );
      errorPrint("❌ Institution creation Rest exception: $e");
    } on SocketException catch (e) {
      emit(
        state.copyWith(
          isInstitutionCreationLoading: false,
          institutionResponse: null,
          institutionCreationError: "Network error. Please try again.",
        ),
      );
      customPrint("❌ Institution creation Socket exception: $e");
    } catch (e) {
      emit(
        state.copyWith(
          isInstitutionCreationLoading: false,
          institutionResponse: null,
          institutionCreationError: "Institution creation failed",
        ),
      );
      errorPrint("❌ Institution creation error: $e");
    }
  }

  Future<void> _validateRefID(
    ValidateRefIDEvent event,
    Emitter<UserState> emit,
  ) async {
    emit(state.copyWith(validateRefIDLoading: true));
    try {
      final requestModel = ValidateRefIDReqModal(
        cmpCode: event.cmpCode,
        custId: event.refID,
      );

      final response = await RestAPI().post(
        APis.validateRefID,
        params: requestModel.toJson(),
      );
      final parsedResponse = ValidateRefIDResponseModal.fromJson(response);
      customPrint("parsed res= ${parsedResponse.data.first.toJson()}");
      emit(
        state.copyWith(
          validateRefIDLoading: false,
          validateRefidResponse: parsedResponse,
          referenceID:
              parsedResponse.data.isNotEmpty &&
                      parsedResponse.data.first.custName.isNotEmpty
                  ? event.refID
                  : "",
        ),
      );
    } on SocketException catch (e) {
      emit(
        state.copyWith(
          validateRefIDLoading: false,
          validateRefidResponse: null,
        ),
      );
      customPrint("socket exception");
    } on RestException catch (e) {
      emit(
        state.copyWith(
          validateRefIDLoading: false,
          validateRefidResponse: null,
        ),
      );
      customPrint("rest exception");
    } catch (e) {
      emit(
        state.copyWith(
          validateRefIDLoading: false,
          validateRefidResponse: null,
        ),
      );
      customPrint("catch exception");
    }
  }

  void _clearRef(ClearRefEvent event, Emitter<UserState> emit) {
    emit(state.copyWith(validateRefidResponse: null));
  }

  void _clearDob(ClearDobEvent event, Emitter<UserState> emit) {
    emit(state.copyWith(dobCustomer: null));
  }

  static UserBloc get(context) => BlocProvider.of(context);
}
