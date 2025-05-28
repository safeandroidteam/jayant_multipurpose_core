import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

@immutable
abstract class HomeEvent extends Equatable {
  const HomeEvent(); // Default constructor without redundant props parameter.
}

class AccDepositEvent extends HomeEvent {
  final String custID;
  final String cmpCode;
  final String section;

  const AccDepositEvent(this.custID,this.cmpCode,this.section);

  @override
  List<Object> get props => [custID];
}

class AccLoanEvent extends HomeEvent {
   final String custID;
  final String cmpCode;
  final String section;

  const AccLoanEvent(this.custID,this.cmpCode,this.section);

  @override
  List<Object> get props => [custID];
}

class ShareEvent extends HomeEvent {
  final String custID;

  const ShareEvent(this.custID);

  @override
  List<Object> get props => [custID];
}

class ChittyEvent extends HomeEvent {
  final String custID;

  const ChittyEvent(this.custID);

  @override
  List<Object> get props => [custID];
}
