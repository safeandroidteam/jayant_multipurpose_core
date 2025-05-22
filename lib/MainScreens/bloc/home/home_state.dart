import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:passbook_core_jayant/Account/Model/AccountsDepositModel.dart';
import 'package:passbook_core_jayant/Account/Model/AccountsLoanModel.dart';
import 'package:passbook_core_jayant/Passbook/Model/PassbookListModel.dart';


@immutable
abstract class HomeState extends Equatable {}

class InitialHomeState extends HomeState {
  @override
  List<Object> get props => [];
}

class AccDepositLoading extends HomeState {
  final bool isAccLoading = false;
  @override
  List<Object> get props => [];
}

class AccDepositResponse extends HomeState {
  final AccountsDepositModel accountsDepositModel;

  AccDepositResponse(this.accountsDepositModel);

  @override
  List<Object> get props => [accountsDepositModel];
}

class AccDepositErrorException extends HomeState {
  final error;

  AccDepositErrorException(this.error);

  @override
  List<Object> get props => [error];
}
class AccLoanLoading extends HomeState {
  @override
  List<Object> get props => [];
}

class AccLoanResponse extends HomeState {
  final AccountsLoanModel accountsLoanModel;

  AccLoanResponse(this.accountsLoanModel);

  @override
  List<Object> get props => [accountsLoanModel];
}

class AccLoanResponseErrorException extends HomeState {
  final error;

  AccLoanResponseErrorException(this.error);

  @override
  List<Object> get props => [error];
}
class ShareLoading extends HomeState {
  @override
  List<Object> get props => [];
}

class ShareResponse extends HomeState {
  final PassbookListModel shareListModel;

  ShareResponse(this.shareListModel);

  @override
  List<Object> get props => [shareListModel];
}
class ShareResponseErrorException extends HomeState {
  final error;

  ShareResponseErrorException(this.error);

  @override
  List<Object> get props => [error];
}
class ChittyLoading extends HomeState {
  @override
  List<Object> get props => [];
}

class ChittyResponse extends HomeState {
  final PassbookListModel chittyListModel;

  ChittyResponse(this.chittyListModel);

  @override
  List<Object> get props => [chittyListModel];
}
class ChittyResponseErrorException extends HomeState {
  final error;

  ChittyResponseErrorException(this.error);

  @override
  List<Object> get props => [error];
}




class PassLoanLoading extends HomeState {
  @override
  List<Object> get props => [];
}

class PassLoanResponse extends HomeState {
  final PassbookListModel passbookLoanListModel;

  PassLoanResponse(this.passbookLoanListModel);

  @override
  List<Object> get props => [passbookLoanListModel];
}

class ErrorException extends HomeState {
  final error;

  ErrorException(this.error);

  @override
  List<Object> get props => [error];
}
