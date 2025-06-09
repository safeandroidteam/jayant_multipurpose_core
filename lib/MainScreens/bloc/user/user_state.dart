part of 'user_bloc.dart';

@freezed
class UserState with _$UserState {
  const factory UserState({
    String? slectedBranch,
    int? selectedCustomerTypeCode,
    @Default(false) bool isPickupCustomerTypeLoading,
    @Default(false) bool isPickupTitleeLoading,
    @Default(false) bool isPickupGenderLoading,
    @Default([]) List<PickUpTypeResponseModal> pickUpCustomerTypeList,
    @Default([]) List<PickUpTypeResponseModal> pickUpTitileList,
    @Default([]) List<PickUpTypeResponseModal> pickUpGenderList,
    String? dobCustomer,
  }) = NewUserState;

  factory UserState.initial() => UserState();
}
