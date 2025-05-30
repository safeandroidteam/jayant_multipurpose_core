part of 'search_bloc.dart';

abstract class SearchState extends Equatable {
  const SearchState();

  @override
  List<Object> get props => [];
}

class SearchInitial extends SearchState {}

class AccDepositLoading extends SearchState {
  final bool isAccDepositLoading = false;
  @override
  List<Object> get props => [];
}

class AccDepositResponse extends SearchState {
  final List<AccNoData> accNoData;

  const AccDepositResponse(this.accNoData);
}

class AccDepositErrorException extends SearchState {
  final error;

  const AccDepositErrorException(this.error);

  @override
  List<Object> get props => [error];
}

class PdfDownloadStateInitial extends SearchState {}

class PdfDownloadSucess extends SearchState {}

class PdfDownloadLoading extends SearchState {}
class PdfDownloadError extends SearchState {}
