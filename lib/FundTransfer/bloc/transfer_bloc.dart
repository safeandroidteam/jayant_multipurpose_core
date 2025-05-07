import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:passbook_core_jayant/REST/RestAPI.dart';
import 'package:passbook_core_jayant/REST/app_exceptions.dart';

import './bloc.dart';

class TransferBloc extends Bloc<TransferEvent, TransferState> {
  TransferBloc({required TransferState initialState}) : super(initialState);

  @override
  Stream<TransferState> mapEventToState(TransferEvent event) async* {
    if (event is SendDetails) {
      debugPrint("Transfer Bloc Before URL Loading");
      yield LoadingTransferState();
      yield LoadingCompletedState();
      debugPrint("Transfer Bloc After URL Loading");
      try {
        yield DetailsResponse(await RestAPI().get(event.url));
        debugPrint("Transfer Bloc URL");
      } on RestException catch (e) {
        yield throw e;
      }
    } else if (event is FetchCustomerAccNo) {
      yield LoadingTransferState();
      yield LoadingCompletedState();
      debugPrint("Transfer Bloc Fetch Customer Acc No. Loading");
      try {
        yield CustAccNoResponse(
          await RestAPI().get(APis.fetchAccNo(event.mobileNo)),
        );
      } on RestException catch (e) {
        yield throw e;
      }
    }
  }
}
