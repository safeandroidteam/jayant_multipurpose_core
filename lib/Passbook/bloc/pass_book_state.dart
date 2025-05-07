part of 'pass_book_bloc.dart';

abstract class PassBookState extends Equatable {
  const PassBookState();

  @override
  List<Object> get props => [];
}

class PassBookBlocInitial extends PassBookState {}

class InitialHomeState extends PassBookState {
  @override
  List<Object> get props => [];
}

class DPSHCardLoading extends PassBookState {
  final bool isDPSHCardLoading = false;
  @override
  List<Object> get props => [];
}

class DPSHCardResponse extends PassBookState {
  final List<PassbookItem> passbookItemList;

  const DPSHCardResponse(this.passbookItemList);

}

class DPSHCardErrorException extends PassBookState {
  final error;

  const DPSHCardErrorException(this.error);

  @override
  List<Object> get props => [error];
}


class DepositShareTransactionLoading extends PassBookState {
  final bool isDPSHCardLoading = false;
  @override
  List<Object> get props => [];
}

class DepositShareTransactionResponse extends PassBookState {
  final List<TransactionItem> transactionList;

  const DepositShareTransactionResponse(this.transactionList);
}

class DepositShareTransactionErrorException extends PassBookState {
  final error;

  const DepositShareTransactionErrorException(this.error);

  @override
  List<Object> get props => [error];
}

class CurrentPageState extends PassBookState {
  final int currentPage;

  const CurrentPageState(this.currentPage);

  @override
  List<Object> get props => [currentPage];
}

