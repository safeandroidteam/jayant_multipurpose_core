import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:passbook_core_jayant/FundTransfer/Model/beneficiaryResModal.dart';
import 'package:passbook_core_jayant/FundTransfer/Model/fetchUserLimitRightModal.dart';
import 'package:passbook_core_jayant/FundTransfer/Model/fundTransferTypeModal.dart';
import 'package:passbook_core_jayant/FundTransfer/Model/userAccResModal.dart';
import 'package:passbook_core_jayant/REST/RestAPI.dart';
import 'package:passbook_core_jayant/REST/app_exceptions.dart';
import 'package:passbook_core_jayant/Util/custom_print.dart';

import './bloc.dart';

class TransferBloc extends Bloc<TransferEvent, TransferState> {
  TransferBloc() : super(InitialTransferState()) {
    on<SendDetails>(_onSendDetails);
    on<FetchToAccNo>(_onFetchToAccNo);
    on<FetchCustomerFromAccNo>(_fetchCustFromAccNo);
    on<FetchFundTransferType>(_fetchFundTransferType);
    on<FetchBenificiaryevent>(_fetchBeneficiaryType);
    on<FetchUserLimitevent>(_fetchUserLimit);
  }

  Future<void> _onSendDetails(
    SendDetails event,
    Emitter<TransferState> emit,
  ) async {
    emit(DetailsLoadingState());
    try {
      final response = await RestAPI().get(event.url);
      emit(DetailsResponse(response));
      successPrint("send Details res in bloc ==$response");
    } on RestException catch (e) {
      emit(DetailsError(e));
    }
  }

  Future<void> _onFetchToAccNo(
    FetchToAccNo event,
    Emitter<TransferState> emit,
  ) async {
    emit(LoadingTransferState());
    try {
      Map<String, dynamic> ownBanlToaccNoBody = {
        "Cmp_Code": event.cmpCode,
        "Mobile_No": event.mobileNo,
      };
      final response = await RestAPI().post(
        APis.ownBankToAccNo,
        params: ownBanlToaccNoBody,
      );
      emit(FetchToAccNoResponse(response));
    } on RestException catch (e) {
      emit(FetchToAccNoError(e.toString()));
    }
  }

  Future<void> _fetchCustFromAccNo(
    FetchCustomerFromAccNo event,
    Emitter<TransferState> emit,
  ) async {
    emit(FetchCustFromAccResponseLoading());
    try {
      Map<String, dynamic> fetchCustomerSBBody = {
        "Cmp_Code": event.cmpCode,
        "Cust_ID": event.custID,
        // "Cust_ID": "3629",
      };
      final fromAcReponse = await RestAPI().post(
        APis.fetchCustomerSB,
        params: fetchCustomerSBBody,
      );
      successPrint("Frm Acc =$fromAcReponse");

      // Validate the structure of the response
      if (fromAcReponse["Data"] is List) {
        // Map the response to a List<UserAccTable>
        final userAccList =
            (fromAcReponse["Data"] as List<dynamic>)
                .map(
                  (account) => UserAccTable(
                    accNo: account["Acc_No"] ?? "",
                    balance: account["Balance"].toString() ?? "",
                    schName: account["Sch_Name"] ?? "",
                  ),
                )
                .toList();
        // userAccList.add(UserAccTable(
        //   accNo: "10", // Add your custom AccNo here
        //   balAmt: 12, // Add your custom BalAmt here
        // ));
        successPrint("User Acc List =${userAccList.length}");
        emit(FetchCustFromAccResponse(userAccList));
      } else {
        throw Exception("Invalid response format: 'Table' is not a list");
      }
    } on RestException catch (e) {
      emit(FetchCustFromAccResponseError(e.toString()));
    }
  }

  Future<void> _fetchFundTransferType(
    FetchFundTransferType event,
    Emitter<TransferState> emit,
  ) async {
    emit(FetchFundTransferTypeLoading());
    warningPrint("State: FetchFundTransferTypeLoading");
    try {
      // final response = await RestAPI().get(APis.fetchFundTransferType);
      final response = await RestAPI().get(APis.fillTransferTypeDetails);

      final transferList =
          (response["Data"] as List<dynamic>)
              .map(
                (e) => FetchFundTransferTypeData(
                  slNo: e["SlNo"] ?? 0,
                  typeName: e["TYPE_NAME"] ?? "",
                ),
              )
              .toList();
      emit(FetchFundTransferTypeRes(transferList));
      warningPrint("State: FetchFundTransferTypeResponse");
      successPrint("fetchTrasnferList=${transferList.first.toJson()}");
    } on RestException catch (e) {
      warningPrint("State: FetchFundTransferTypeError - $e");
      emit(FetchFundTransferTypeError(e.message["ProceedMessage"]));
    }
  }

  Future<void> _fetchBeneficiaryType(
    FetchBenificiaryevent event,
    Emitter<TransferState> emit,
  ) async {
    emit(FetchBenificiaryLoading());
    warningPrint("State: FetchBenificiaryLoading");
    try {
      Map<String, dynamic> fetchBeneficiaryListBody = {
        "Cmp_Code": event.cmpCode,
        "Cust_ID": event.custID,
        // "Cust_ID": "1139",
      };
      final response = await RestAPI().post(
        APis.fetchBeneficiaryList,
        params: fetchBeneficiaryListBody,
      );

      final beneficiaryList =
          (response["Data"] as List<dynamic>)
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
      warningPrint("Cust id- ${event.custID}");
      successPrint("fetchBeneficiaryList=${beneficiaryList.first.toJson()}");
      successPrint("fetchBeneficiaryList length=${beneficiaryList.length}");
    } on RestException catch(e){

      warningPrint("State:  Account Not Found  - $e");
      emit(FetchBenificiaryError(e.message["ProceedMessage"]));
    }
  }

  Future<void> _fetchUserLimit(
    FetchUserLimitevent event,
    Emitter<TransferState> emit,
  ) async {
    emit(FetchUserLimitLoading());
    warningPrint("State: FetchUserLimitLoading");
    try {
      Map<String, dynamic> fetchUserLimitListBody = {
        "Cmp_Code": event.cmpCode,
        "Cust_Type": event.custType,
      };
      final response = await RestAPI().post(
        APis.fetchUserLimit,
        params: fetchUserLimitListBody,
      );
      final userLimitList =
          (response["Data"] as List<dynamic>)
              .map(
                (e) => UserLimitData(
                  cmpCode: e['Cmp_Code'] ?? 0,
                  custType: e['Cust_Type'] ?? 0,
                  minRcghBal: e['Min_rcghbal'] ?? '',
                  minFundTranBal: e['Min_fundtranbal'] ?? '',
                  maxRcghBal: e['Max_rcghbal'] ?? '',
                  maxFundTranBal: e['Max_fundtranbal'] ?? '',
                  maxInterFundTranBal: e['Max_interfundtranbal'] ?? '',
                ),
              )
              .toList();
      emit(FetchUserLimitResponse(userLimitList));
      warningPrint("State: FetchUserLimitResponse");
      successPrint("fetchUserLimitList=${userLimitList.first.toJson()}");
    } on RestException catch (e) {
      warningPrint("State:  FetchUserLimitError  - $e");
      emit(FetchUserLimitError(e.message["ProceedMessage"]));
    }
  }

  static TransferBloc get(context) => BlocProvider.of(context);
}
