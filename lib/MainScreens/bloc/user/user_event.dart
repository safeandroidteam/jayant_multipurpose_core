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
  const factory UserEvent.getBranches() = GetBranchesEvent;
  const factory UserEvent.individualUserCreation({
    required IndividualUserCreationUIModal individualUserCreationUiModal,
  }) = IndividualUserCreationEvent;
  const factory UserEvent.validateRefID(String cmpCode, String refID) =
      ValidateRefIDEvent;
  const factory UserEvent.clearRefValidation() = ClearRefEvent;
  const factory UserEvent.clearDobSelection() = ClearDobEvent;
  // const factory UserEvent.institutionCreation({
  //   required InstitutionUiModal institutionUiModal,
  // }) = InstitutionUserCreationEvent;
}
