import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:passbook_core_jayant/FundTransfer/Model/beneficiaryResModal.dart';
import 'package:passbook_core_jayant/FundTransfer/Model/fundTransferTypeModal.dart';
import 'package:passbook_core_jayant/FundTransfer/Model/userAccResModal.dart';
import 'package:passbook_core_jayant/REST/RestAPI.dart';
import 'package:passbook_core_jayant/REST/app_exceptions.dart';
import 'package:passbook_core_jayant/Util/custom_print.dart';

import './bloc.dart';

class TransferBloc extends Bloc<TransferEvent, TransferState> {
  TransferBloc() : super(InitialTransferState()) {
    on<SendDetails>(_onSendDetails);
    on<FetchCustomerAccNo>(_onFetchCustomerAccNo);
    on<FetchCustomerFromAccNo>(_handleFromAcc);
    on<FetchFundTransferType>(_fetchFundTransferType);
    on<FetchBenificiaryevent>(_fetchBeneficiaryType);
  }

  Future<void> _onSendDetails(
    SendDetails event,
    Emitter<TransferState> emit,
  ) async {
    emit(DetailsLoadingState());
    try {
      final response = await RestAPI().get(event.url);
      emit(DetailsResponse(response));
      successPrint("sendetails res in bloc ==$response");
    } on RestException catch (e) {
      emit(DetailsError(e));
    }
  }

  Future<void> _onFetchCustomerAccNo(
    FetchCustomerAccNo event,
    Emitter<TransferState> emit,
  ) async {
    emit(LoadingTransferState());
    try {
      final response = await RestAPI().get(APis.fetchAccNo(event.mobileNo));
      emit(CustAccNoResponse(response));
    } on RestException catch (e) {
      emit(CustAccNoError(e.toString()));
    }
  }

  Future<void> _handleFromAcc(
    FetchCustomerFromAccNo event,
    Emitter<TransferState> emit,
  ) async {
    emit(FromAccResponseLoading());
    try {
      final fromAcReponse = await RestAPI().get(
        APis.fetchFundTransferBal(event.userId),
      );
      successPrint("Frm Acc =$fromAcReponse");

      // Validate the structure of the response
      if (fromAcReponse["Table"] is List) {
        // Map the response to a List<UserAccTable>
        final userAccList =
            (fromAcReponse["Table"] as List<dynamic>)
                .map(
                  (account) => UserAccTable(
                    accNo: account["AccNo"] ?? "",
                    balAmt: account["BalAmt"] ?? "",
                    accType: account["Types"] ?? "",
                  ),
                )
                .toList();
        // userAccList.add(UserAccTable(
        //   accNo: "10", // Add your custom AccNo here
        //   balAmt: 12, // Add your custom BalAmt here
        // ));
        successPrint("User Acc List =${userAccList.length}");
        emit(FromAccResponse(userAccList));
      } else {
        throw Exception("Invalid response format: 'Table' is not a list");
      }
    } on RestException catch (e) {
      emit(FromAccResponseError(e.toString()));
    }
  }

  Future<void> _fetchFundTransferType(
    FetchFundTransferType event,
    Emitter<TransferState> emit,
  ) async {
    emit(FetchFundTransferTypeLoading());
    warningPrint("State: FetchFundTransferTypeLoading");
    try {
      final response = await RestAPI().get(APis.fetchFundTransferType);

      final transferList =
          (response["Table"] as List<dynamic>)
              .map(
                (e) =>
                    FetchFundTransferTypeDatum(typeName: e["TYPE_NAME"] ?? ""),
              )
              .toList();
      emit(FetchFundTransferTypeResponse(transferList));
      warningPrint("State: FetchFundTransferTypeResponse");
      successPrint("fetchTrasnferList=${transferList.first.toJson()}");
    } on RestException catch (e) {
      warningPrint("State: FetchFundTransferTypeError - $e");
      emit(FetchFundTransferTypeError(e.toString()));
    }
  }

  Future<void> _fetchBeneficiaryType(
    FetchBenificiaryevent event,
    Emitter<TransferState> emit,
  ) async {
    emit(FetchBenificiaryLoading());
    warningPrint("State: FetchBenificiaryLoading");
    try {
      final response = await RestAPI().get(APis.fetchBeneficiary(event.id));

      final beneficiaryList =
          (response["Table"] as List<dynamic>)
              .map(
                (e) => BeneficiaryDatum(
                  recieverAccno: e["Reciever_Accno"] ?? "",
                  recieverId: e["Reciever_Id"] ?? "",
                  recieverIfsc: e["Reciever_Ifsc"] ?? "",
                  recieverMob: e["Reciever_Mob"] ?? "",
                  recieverName: e["Reciever_Name"] ?? "",
                ),
              )
              .toList();
      emit(FetchBenificiaryResponse(beneficiaryList));
      warningPrint("State: FetchBenificiaryResponse");
      successPrint("fetchBeneficiaryList=${beneficiaryList.first.toJson()}");
    } on RestException catch (e) {
      warningPrint("State: FetchFundTransferTypeError - $e");
      emit(FetchBenificiaryError(e.toString()));
    }
  }

  static TransferBloc get(context) => BlocProvider.of(context);
}
