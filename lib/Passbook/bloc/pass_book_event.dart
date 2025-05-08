part of 'pass_book_bloc.dart';

abstract class PassBookEvent extends Equatable {
  const PassBookEvent();

  @override
  List<Object> get props => [];
}

class PassBookDPSHCardEvent extends PassBookEvent {
  final String custID;
  final String widgetType;

  const PassBookDPSHCardEvent(this.custID, this.widgetType);

  @override
  List<Object> get props => [custID];
}

class DepositShareTransactionEvent extends PassBookEvent {
  final bool isShare;
  final String custID;
  final String accNo;
  final String schCode;
  final String brCode;

  const DepositShareTransactionEvent(
    this.custID,
    this.isShare,
    this.accNo,
    this.schCode,
    this.brCode,
  );

  @override
  List<Object> get props => [custID, isShare, accNo, schCode, brCode];
}

class CurrentPageChanged extends PassBookEvent {
  final int currentPage;

  const CurrentPageChanged(this.currentPage);

  @override
  List<Object> get props => [currentPage];
}

class ChittyLoanEvent extends PassBookEvent {
  final String custID;
  final String type;

  const ChittyLoanEvent(this.custID, this.type);

  @override
  List<Object> get props => [custID, type];
}

class LoanTransEvent extends PassBookEvent {
  final String accNo;

  const LoanTransEvent(this.accNo);

  @override
  List<Object> get props => [accNo];
}
