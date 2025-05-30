part of 'search_bloc.dart';

abstract class SearchEvent extends Equatable {
  const SearchEvent();

  @override
  List<Object> get props => [];
}

class AccNoDepositEvent extends SearchEvent {
  // final String cust_id;
  // final String acc_Type;
  final String cmp_Code;
  final String cust_Id;

  // const AccNoDepositEvent(this.cust_id, this.acc_Type);
  const AccNoDepositEvent(this.cmp_Code, this.cust_Id);

  @override
  // List<Object> get props => [cust_id, acc_Type];
  List<Object> get props => [cmp_Code, cust_Id];
}
