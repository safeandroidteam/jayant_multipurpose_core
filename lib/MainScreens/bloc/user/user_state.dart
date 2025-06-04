part of 'user_bloc.dart';

abstract class UserState extends Equatable {
  const UserState();

  @override
  List<Object?> get props => [];
}

class UserInitial extends UserState {}

class PickUpLoading extends UserState {}

///Pick up customer type
class PickUpCustomerTypeLoading extends UserState {}

class PickUpCustomerTypeResponse extends UserState {
  final List<PickUpTypeResponseModal> pickUpCustomerTypeList;

  const PickUpCustomerTypeResponse({required this.pickUpCustomerTypeList});

  @override
  List<Object?> get props => [pickUpCustomerTypeList];
}

class PickUpCustomerTypeError extends UserState {
  final String message;

  const PickUpCustomerTypeError(this.message);

  @override
  List<Object?> get props => [message];
}

///pick up type title
class PickUpTitleTypeLoading extends UserState {}

class PickUpTitleTypeResponse extends UserState {
  final List<PickUpTypeResponseModal> pickUpTitleTypeList;

  const PickUpTitleTypeResponse({required this.pickUpTitleTypeList});
  @override
  List<Object?> get props => [pickUpTitleTypeList];
}

class PickUpTitleTypeError extends UserState {
  final String error;
  const PickUpTitleTypeError(this.error);
  @override
  List<Object?> get props => [error];
}

///pick up type gender
class PickUpGenderTypeLoading extends UserState {}

class PickUpGenderTypeResponse extends UserState {
  final List<PickUpTypeResponseModal> pickUpGenderTypeList;
  const PickUpGenderTypeResponse({required this.pickUpGenderTypeList});
  @override
  List<Object?> get props => [pickUpGenderTypeList];
}

class PickUpGenderTypeError extends UserState {
  final String error;
  const PickUpGenderTypeError(this.error);
  @override
  List<Object?> get props => [error];
}

class UserSelectedCustomerTypeLoading extends UserState {}

class UserSelectedCustomerType extends UserState {
  final int selectedCustomerTypeCode;

  UserSelectedCustomerType(this.selectedCustomerTypeCode);
}
