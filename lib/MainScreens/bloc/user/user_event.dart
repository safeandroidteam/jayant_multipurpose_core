part of 'user_bloc.dart';

@freezed
class UserEvent with _$UserEvent {
  const factory UserEvent.fillPickUpTypesEvent({
    required int cmpCode,
    required int pickUpType,
  }) = FillPickUpTypesEvent;

  const factory UserEvent.selectCustomerType(int selectedItem) =
      selectCustomerTypeEvent;
  const factory UserEvent.pickCustomerDob(String dob) = PickCustomerDobEvent;
}
