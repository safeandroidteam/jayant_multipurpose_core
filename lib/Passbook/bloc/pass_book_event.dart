part of 'pass_book_bloc.dart';

abstract class PassBookEvent extends Equatable {
  const PassBookEvent();

  @override
  List<Object> get props => [];
}

class PassBookDPSHCardEvent extends PassBookEvent {
  final String custID;
  final String cmpCode;
  final String section;

  const PassBookDPSHCardEvent(this.custID, this.cmpCode, this.section);

  @override
  List<Object> get props => [custID];
}

class DepositShareTransactionEvent extends PassBookEvent {
    final String cmpCode;
  final String accid;

  const DepositShareTransactionEvent(
    this.cmpCode,
    this.accid,

  );

  @override
  List<Object> get props => [cmpCode, accid ];
}

class CurrentPageChanged extends PassBookEvent {
  final int currentPage;

  const CurrentPageChanged(this.currentPage);

  @override
  List<Object> get props => [currentPage];
}

class ChittyLoanEvent extends PassBookEvent {
   final String custID;
  final String cmpCode;
  final String section;
  const ChittyLoanEvent(this.custID, this.cmpCode,this.section);

  @override
  List<Object> get props => [custID, cmpCode,section];
}

class LoanTransEvent extends PassBookEvent {
  final String accNo;

  const LoanTransEvent(this.accNo);

  @override
  List<Object> get props => [accNo];
}
