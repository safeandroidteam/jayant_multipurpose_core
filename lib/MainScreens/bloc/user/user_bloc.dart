import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../Model/fill_pickUP_request_modal.dart';

part 'user_event.dart';
part 'user_state.dart';

class UserBloc extends Bloc<UserEvent, UserState> {
  List<PickUpTypeData> pickUpList = [];

  UserBloc() : super(UserInitial()) {
    on<FillPickUpTypesEvent>(_onFetchCustomerTypes); //FetchCustomerTypesEvent
    on<SelectFillPickUpTypeEvent>(
      _onSelectCustomerType,
    ); //SelectFillPickUpTypeEvent
  }
  Future<void> _onFetchCustomerTypes(
    FillPickUpTypesEvent event,
    Emitter<UserState> emit,
  ) async {
    emit(UserLoading());

    try {
      // Replace with actual API call if needed
      await Future.delayed(Duration(seconds: 1));
      pickUpList = [
        PickUpTypeData(pkcCode: 46, pkcDescription: 'Individual'),
        PickUpTypeData(pkcCode: 11473, pkcDescription: 'Institution'),
      ];
      emit(UserTypeLoaded(pickUpList: pickUpList));
    } catch (e) {
      emit(UserTypeError("Failed to load customer types."));
    }
  }

  void _onSelectCustomerType(
    SelectFillPickUpTypeEvent event,
    Emitter<UserState> emit,
  ) {
    emit(
      UserTypeLoaded(pickUpList: pickUpList, selectedType: event.selectedType),
    );
  }

  static UserBloc get(context) => BlocProvider.of(context);
}

// Future<void> _userCreation(
//     UserCreationType event,
//     Emitter<UserState> emit,
//     ) async {
//   emit(UserTypeSelectionStateLoading());
//
//   try {
//     emit(UserTypeSelectionState(event.userCreationId));
//     successPrint("user type selection changed to=${event.userCreationId}");
//   } catch (e) {
//     emit(UserTypeSelectionState(0));
//     errorPrint("user type selection changedError=$e");
//   }
// }
// on<UserCreationType>(_userCreation);
