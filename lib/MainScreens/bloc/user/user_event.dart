part of 'user_bloc.dart';

abstract class UserEvent extends Equatable {
  const UserEvent();

  @override
  List<Object> get props => [];
}

class FillPickUpTypesEvent extends UserEvent {}

class SelectFillPickUpTypeEvent extends UserEvent {
  final PickUpTypeData selectedType;

  const SelectFillPickUpTypeEvent(this.selectedType);

  @override
  List<Object> get props => [selectedType];
}

///old already existed
class UserCreationType extends UserEvent {
  final int userCreationId;

  const UserCreationType(this.userCreationId);

  @override
  List<Object> get props => [userCreationId];
}
