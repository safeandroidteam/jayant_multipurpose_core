import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:passbook_core_jayant/Util/custom_print.dart';

part 'user_event.dart';
part 'user_state.dart';

class UserBloc extends Bloc<UserEvent, UserState> {
  UserBloc() : super(UserInitial()) {
    on<UserCreationType>(_userCreation);
  }

  Future<void> _userCreation(
    UserCreationType event,
    Emitter<UserState> emit,
  ) async {
    emit(UserTypeSelectionStateLoading());

    try {
      emit(UserTypeSelectionState(event.userCreationId));
      successPrint("user type selection changed to=${event.userCreationId}");
    } catch (e) {
      emit(UserTypeSelectionState(0));
      errorPrint("user type selection changedError=$e");
    }
  }

  static UserBloc get(context) => BlocProvider.of(context);
}
