part of 'user_bloc.dart';

abstract class UserState extends Equatable {
  const UserState();

  @override
  List<Object?> get props => [];
}

class UserInitial extends UserState {}

class UserLoading extends UserState {}

class UserTypeLoaded extends UserState {
  final List<PickUpTypeData> pickUpList;
  final PickUpTypeData? selectedType;

  const UserTypeLoaded({required this.pickUpList, this.selectedType});

  @override
  List<Object?> get props => [pickUpList, selectedType];
}

class UserTypeError extends UserState {
  final String message;

  const UserTypeError(this.message);

  @override
  List<Object?> get props => [message];
}

/// old one already exist

class UserTypeSelectionState extends UserState {
  final int id;

  UserTypeSelectionState(this.id);
  @override
  List<Object> get props => [id];
}

class UserTypeSelectionStateLoading extends UserState {}
