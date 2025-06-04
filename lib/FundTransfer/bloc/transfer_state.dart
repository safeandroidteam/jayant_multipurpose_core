import 'package:meta/meta.dart';
import 'package:passbook_core_jayant/FundTransfer/Model/beneficiaryResModal.dart';
import 'package:passbook_core_jayant/FundTransfer/Model/fundTransferTypeModal.dart';
import 'package:passbook_core_jayant/FundTransfer/Model/userAccResModal.dart';

import '../Model/fetchBeniBankDetailModal.dart';
import '../Model/fetchUserLimitRightModal.dart';
import '../Model/saveBenificiaryModal.dart';

@immutable
abstract class TransferState {}

class InitialTransferState extends TransferState {}

class LoadingTransferState extends TransferState {}

class DetailsLoadingState extends TransferState {}

class DetailsResponse extends TransferState {
  final Map response;

  DetailsResponse(this.response);
}

class FetchToAccNoResponse extends TransferState {
  final Map ownBankToAccResponse;

  FetchToAccNoResponse(this.ownBankToAccResponse);
}

class FetchToAccNoError extends TransferState {
  final String error;

  FetchToAccNoError(this.error);
}

class DetailsError extends TransferState {
  final error;

  DetailsError(this.error);
}

class FetchCustFromAccResponse extends TransferState {
  final List<UserAccTable> accounts;

  FetchCustFromAccResponse(this.accounts);

  @override
  List<Object?> get props => [accounts];
}

class FetchCustFromAccResponseLoading extends TransferState {}

class FetchCustFromAccResponseError extends TransferState {
  final String error;

  FetchCustFromAccResponseError(this.error);
}

class FetchFundTransferTypeLoading extends TransferState {}

class FetchFundTransferTypeRes extends TransferState {
  final List<FetchFundTransferTypeData> transferTypeList;

  FetchFundTransferTypeRes(this.transferTypeList);
}

class FetchFundTransferTypeError extends TransferState {
  final String error;

  FetchFundTransferTypeError(this.error);
}

class FetchBenificiaryLoading extends TransferState {}

class FetchBenificiaryResponse extends TransferState {
  final List<BeneficiaryDatum> beneficiaryList;

  FetchBenificiaryResponse(this.beneficiaryList);
}

class FetchBenificiaryError extends TransferState {
  final String error;

  FetchBenificiaryError(this.error);
}

//saveBeneficiary

class SaveBeneficiaryLoading extends TransferState {}

class SaveBeneficiaryResponse extends TransferState {
  final List<SaveBeneficiaryData> saveBeneficiaryList;

  SaveBeneficiaryResponse(this.saveBeneficiaryList);
}

class SaveBeneficiaryError extends TransferState {
  final String error;

  SaveBeneficiaryError(this.error);
}

//check IFSC
class FetchBeneficiaryBankDetailsLoading extends TransferState {}

class FetchBeneficiaryBankDetailsResponse extends TransferState {
  final List<FetchBankDetailData> fetchBeneficiaryBankDetailsList;

  FetchBeneficiaryBankDetailsResponse(this.fetchBeneficiaryBankDetailsList);
}

class FetchBeneficiaryBankDetailsError extends TransferState {
  final String error;

  FetchBeneficiaryBankDetailsError(this.error);
}

//fetchuserlimit

class FetchUserLimitLoading extends TransferState {}

class FetchUserLimitResponse extends TransferState {
  final List<UserLimitData> userLimitList;

  FetchUserLimitResponse(this.userLimitList);
}

class FetchUserLimitError extends TransferState {
  final String error;

  FetchUserLimitError(this.error);
}

