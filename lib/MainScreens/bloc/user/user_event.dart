part of 'user_bloc.dart';

abstract class UserEvent extends Equatable {
  const UserEvent();

  @override
  List<Object> get props => [];
}

class UserCreationType extends UserEvent {
  final int userCreationId;

  const UserCreationType(this.userCreationId);

  @override
  List<Object> get props => [userCreationId];
}
