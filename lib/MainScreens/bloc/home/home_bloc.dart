import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:passbook_core_jayant/Account/Model/AccountsDepositModel.dart';
import 'package:passbook_core_jayant/Account/Model/AccountsLoanModel.dart';
import 'package:passbook_core_jayant/Passbook/Model/PassbookListModel.dart';
import 'package:passbook_core_jayant/REST/RestAPI.dart';
import 'package:passbook_core_jayant/REST/app_exceptions.dart';
import 'package:passbook_core_jayant/Util/custom_print.dart';

import 'bloc.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  HomeBloc() : super(InitialHomeState()) {
    on<AccDepositEvent>(_onAccDepositEvent);
    on<AccLoanEvent>(_onAccLoanEvent);
    on<ChittyEvent>(_onChittyEvent);
    on<ShareEvent>(_onShareEvent);
  }

  Future<void> _onAccDepositEvent(
    AccDepositEvent event,
    Emitter<HomeState> emit,
  ) async {
    emit(AccDepositLoading());

    try {
      final response = await RestAPI().get(
        APis.getDepositDetailsList(event.custID),
      );
      emit(AccDepositResponse(AccountsDepositModel.fromJson(response)));
      successPrint("Deposit Data in Account=$response");
    } on RestException catch (e) {
      emit(AccDepositErrorException(e));
      errorPrint("Deposit Data in Account Error=$e");
    }
  }

  Future<void> _onAccLoanEvent(
    AccLoanEvent event,
    Emitter<HomeState> emit,
  ) async {
    emit(AccLoanLoading());
    try {
      final response = await RestAPI().get(
        APis.accountLoanListUrl(event.custID),
      );
      emit(AccLoanResponse(AccountsLoanModel.fromJson(response)));
      successPrint("Loan Data in Account=$response");
    } on RestException catch (e) {
      emit(AccLoanResponseErrorException(e));
      errorPrint("Loan Data in Account Error=$e");
    }
  }

  Future<void> _onChittyEvent(
    ChittyEvent event,
    Emitter<HomeState> emit,
  ) async {
    emit(ChittyLoading());
    customPrint("chitty Loading");
    try {
      final response = await RestAPI().get(
        "${APis.otherAccListInfo}${event.custID}&Acc_Type=MMBS",
      );
      customPrint("response=$response");
      emit(ChittyResponse(PassbookListModel.fromJson(response)));
      successPrint("chitty Data in Account=$response");
    } on RestException catch (e) {
      emit(ChittyResponseErrorException(e));
      errorPrint("chitty Data in Account Error=$e");
    }
  }

  Future<void> _onShareEvent(ShareEvent event, Emitter<HomeState> emit) async {
    emit(ShareLoading());
    try {
      final response = await RestAPI().get(
        "${APis.otherAccListInfo}${event.custID}&Acc_Type=SH",
      );
      emit(ShareResponse(PassbookListModel.fromJson(response)));
      successPrint("Share Data in Account=$response");
    } on RestException catch (e) {
      emit(ShareResponseErrorException(e));
      errorPrint("Share Data in Account Error=$e");
    }
  }
}
