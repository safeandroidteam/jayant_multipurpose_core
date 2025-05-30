part of 'search_bloc.dart';

abstract class SearchEvent extends Equatable {
  const SearchEvent();

  @override
  List<Object> get props => [];
}

class AccNoDepositEvent extends SearchEvent {
  final String cmpCode;
  final String custId;

  const AccNoDepositEvent(this.cmpCode, this.custId);

  @override
  List<Object> get props => [cmpCode, custId];
}

class PdfDownloadEvent extends SearchEvent {
  final List<AccStatementSearchData> transList;
  final String fromDate;
  final String toDate;
  final BuildContext context;

  const PdfDownloadEvent(
    this.transList,
    this.fromDate,
    this.toDate,
    this.context,
  );
}
