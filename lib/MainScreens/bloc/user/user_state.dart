part of 'user_bloc.dart';

@freezed
class UserState with _$UserState {
  const factory UserState({
    String? slectedBranch,
    int? selectedCustomerTypeCode,
    @Default(false) bool isPickupCustomerTypeLoading,
    @Default(false) bool isPickupTitleeLoading,
    @Default(false) bool isPickupGenderLoading,
    @Default(false) bool isPickUpBranchLoading,
    @Default([]) List<PickUpTypeResponseModal> pickUpCustomerTypeList,
    @Default([]) List<PickUpTypeResponseModal> pickUpTitileList,
    @Default([]) List<PickUpTypeResponseModal> pickUpGenderList,
    @Default([]) List<BranchData> branchList,
    @Default(false) bool validateRefIDLoading,
    final ValidateRefIDResponseModal? validateRefidResponse,
    final IndividualUserResponseModel? individualResponse,
    @Default(false) bool isIndividualUserLoading,
    String? individualUserCreationError,
    String? referenceID,
    String? dobCustomer,
    final InstitutionResponseModal? institutionResponse,
    @Default(false) bool isInstitutionCreationLoading,
    String? institutionCreationError,
  }) = NewUserState;

  factory UserState.initial() => UserState();
}
