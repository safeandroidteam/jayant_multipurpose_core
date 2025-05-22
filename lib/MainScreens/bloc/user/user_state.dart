part of 'user_bloc.dart';

abstract class UserState extends Equatable {
  const UserState();

  @override
  List<Object> get props => [];
}

class UserInitial extends UserState {}

class UserTypeSelectionState extends UserState {
  final int id;

  UserTypeSelectionState(this.id);
  @override
  List<Object> get props => [id];
}

class UserTypeSelectionStateLoading extends UserState {}
