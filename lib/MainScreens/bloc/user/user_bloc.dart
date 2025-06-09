import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:passbook_core_jayant/MainScreens/Model/fill_pickUp_response_modal.dart';
import 'package:passbook_core_jayant/REST/RestAPI.dart';
import 'package:passbook_core_jayant/Util/custom_print.dart';

part 'user_event.dart';
part 'user_state.dart';
part 'user_bloc.freezed.dart'; // GENERATED FILE

class UserBloc extends Bloc<UserEvent, UserState> {
  UserBloc() : super(UserState.initial()) {
    on<FillPickUpTypesEvent>(_FillPickUpTypesEvent);
    on<selectCustomerTypeEvent>(_onSelectCustomerType);
    on<PickCustomerDobEvent>(_pickDobOfCustomer);
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

      successPrint("Data ${data.first.toString()}");

      successPrint("List Starting $list");

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
    warningPrint("_onSelectCustomerType Loading");
    emit(state.copyWith(selectedCustomerTypeCode: event.selectedItem));
    warningPrint("_onSelectCustomerType ${state.runtimeType}");
  }

  void _pickDobOfCustomer(PickCustomerDobEvent event, Emitter<UserState> emit) {
    emit(state.copyWith(dobCustomer: event.dob));
  }

  static UserBloc get(context) => BlocProvider.of(context);
}
