import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:passbook_core_jayant/Account/Model/AccountsDepositModel.dart';
import 'package:passbook_core_jayant/Account/Model/AccountsLoanModel.dart';
import 'package:passbook_core_jayant/Account/Model/AccountsShareModel.dart';
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
    on<AccShareEvent>(_onShareEvent);
  }

  Future<void> _onAccDepositEvent(
    AccDepositEvent event,
    Emitter<HomeState> emit,
  ) async {
    emit(AccDepositLoading());

    try {
      Map<String, dynamic> accDepositBody = {
        "Cmp_Code": event.cmpCode,
        "Cust_ID": event.custID,
        "Section": event.section,
      };
      final response = await RestAPI().post(
        APis.fetchAccDetailsbySection,
        params: accDepositBody,
      );
      successPrint("Acc deposit fetched");
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
      Map<String, dynamic> accLoanBody = {
        "Cmp_Code": event.cmpCode,
        "Cust_ID": event.custID,
        "Section": event.section,
      };
      final response = await RestAPI().post(
        APis.fetchAccDetailsbySection,
        params: accLoanBody,
      );
      successPrint("Acc loan fetched");
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
      Map<String, dynamic> accChittyBody = {
        "Cmp_Code": event.cmpCode,
        "Cust_ID": event.custID,
        "Section": event.section,
      };
      final response = await RestAPI().post(
        APis.fetchAccDetailsbySection,
        params: accChittyBody,
      );
      customPrint("response=$response");
      emit(ChittyResponse(PassbookListModel.fromJson(response)));
      successPrint("chitty Data in Account=$response");
    } on RestException catch (e) {
      emit(ChittyResponseErrorException(e));
      errorPrint("chitty Data in Account Error=$e");
    }
  }

  Future<void> _onShareEvent(
    AccShareEvent event,
    Emitter<HomeState> emit,
  ) async {
    emit(ShareLoading());
    try {
      Map<String, dynamic> accShareBody = {
        "Cmp_Code": event.cmpCode,
        "Cust_ID": event.custID,
        "Section": event.section,
      };
      final response = await RestAPI().post(
        APis.fetchAccDetailsbySection,
        params: accShareBody,
      );
      successPrint("Acc share fetched");
      // emit(ShareResponse(PassbookListModel.fromJson(response)));
      emit(ShareResponse(AccountsShareModel.fromJson(response)));
      successPrint("Share Data in Account=$response");
    } on RestException catch (e) {
      emit(ShareResponseErrorException(e));
      errorPrint("Share Data in Account Error=$e");
    }
  }
}
