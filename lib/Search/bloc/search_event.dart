part of 'search_bloc.dart';

abstract class SearchEvent extends Equatable {
  const SearchEvent();

  @override
  List<Object> get props => [];
}
class AccNoDepositEvent extends SearchEvent {
  final String cust_id;
  final String acc_Type;

  const AccNoDepositEvent(this.cust_id,this.acc_Type);

  @override
  List<Object> get props => [cust_id, acc_Type];
}
