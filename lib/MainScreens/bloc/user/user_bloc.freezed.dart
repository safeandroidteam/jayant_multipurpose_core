// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'user_bloc.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

/// @nodoc
mixin _$UserEvent {
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(int cmpCode, int pickUpType) fillPickUpTypesEvent,
    required TResult Function(int selectedItem) selectCustomerType,
    required TResult Function(String dob) pickCustomerDob,
    required TResult Function() getBranches,
    required TResult Function(
      IndividualUserCreationUIModal individualUserCreationUiModal,
    )
    individualUserCreation,
    required TResult Function(String cmpCode, String refID) validateRefID,
    required TResult Function() clearRefValidation,
    required TResult Function() clearDobSelection,
    required TResult Function(InstituitionUiReqModel institutionUiModal)
    institutionCreation,
  }) => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(int cmpCode, int pickUpType)? fillPickUpTypesEvent,
    TResult? Function(int selectedItem)? selectCustomerType,
    TResult? Function(String dob)? pickCustomerDob,
    TResult? Function()? getBranches,
    TResult? Function(
      IndividualUserCreationUIModal individualUserCreationUiModal,
    )?
    individualUserCreation,
    TResult? Function(String cmpCode, String refID)? validateRefID,
    TResult? Function()? clearRefValidation,
    TResult? Function()? clearDobSelection,
    TResult? Function(InstituitionUiReqModel institutionUiModal)?
    institutionCreation,
  }) => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(int cmpCode, int pickUpType)? fillPickUpTypesEvent,
    TResult Function(int selectedItem)? selectCustomerType,
    TResult Function(String dob)? pickCustomerDob,
    TResult Function()? getBranches,
    TResult Function(
      IndividualUserCreationUIModal individualUserCreationUiModal,
    )?
    individualUserCreation,
    TResult Function(String cmpCode, String refID)? validateRefID,
    TResult Function()? clearRefValidation,
    TResult Function()? clearDobSelection,
    TResult Function(InstituitionUiReqModel institutionUiModal)?
    institutionCreation,
    required TResult orElse(),
  }) => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(FillPickUpTypesEvent value) fillPickUpTypesEvent,
    required TResult Function(selectCustomerTypeEvent value) selectCustomerType,
    required TResult Function(PickCustomerDobEvent value) pickCustomerDob,
    required TResult Function(GetBranchesEvent value) getBranches,
    required TResult Function(IndividualUserCreationEvent value)
    individualUserCreation,
    required TResult Function(ValidateRefIDEvent value) validateRefID,
    required TResult Function(ClearRefEvent value) clearRefValidation,
    required TResult Function(ClearDobEvent value) clearDobSelection,
    required TResult Function(InstitutionUserCreationEvent value)
    institutionCreation,
  }) => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(FillPickUpTypesEvent value)? fillPickUpTypesEvent,
    TResult? Function(selectCustomerTypeEvent value)? selectCustomerType,
    TResult? Function(PickCustomerDobEvent value)? pickCustomerDob,
    TResult? Function(GetBranchesEvent value)? getBranches,
    TResult? Function(IndividualUserCreationEvent value)?
    individualUserCreation,
    TResult? Function(ValidateRefIDEvent value)? validateRefID,
    TResult? Function(ClearRefEvent value)? clearRefValidation,
    TResult? Function(ClearDobEvent value)? clearDobSelection,
    TResult? Function(InstitutionUserCreationEvent value)? institutionCreation,
  }) => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(FillPickUpTypesEvent value)? fillPickUpTypesEvent,
    TResult Function(selectCustomerTypeEvent value)? selectCustomerType,
    TResult Function(PickCustomerDobEvent value)? pickCustomerDob,
    TResult Function(GetBranchesEvent value)? getBranches,
    TResult Function(IndividualUserCreationEvent value)? individualUserCreation,
    TResult Function(ValidateRefIDEvent value)? validateRefID,
    TResult Function(ClearRefEvent value)? clearRefValidation,
    TResult Function(ClearDobEvent value)? clearDobSelection,
    TResult Function(InstitutionUserCreationEvent value)? institutionCreation,
    required TResult orElse(),
  }) => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $UserEventCopyWith<$Res> {
  factory $UserEventCopyWith(UserEvent value, $Res Function(UserEvent) then) =
      _$UserEventCopyWithImpl<$Res, UserEvent>;
}

/// @nodoc
class _$UserEventCopyWithImpl<$Res, $Val extends UserEvent>
    implements $UserEventCopyWith<$Res> {
  _$UserEventCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of UserEvent
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc
abstract class _$$FillPickUpTypesEventImplCopyWith<$Res> {
  factory _$$FillPickUpTypesEventImplCopyWith(
    _$FillPickUpTypesEventImpl value,
    $Res Function(_$FillPickUpTypesEventImpl) then,
  ) = __$$FillPickUpTypesEventImplCopyWithImpl<$Res>;
  @useResult
  $Res call({int cmpCode, int pickUpType});
}

/// @nodoc
class __$$FillPickUpTypesEventImplCopyWithImpl<$Res>
    extends _$UserEventCopyWithImpl<$Res, _$FillPickUpTypesEventImpl>
    implements _$$FillPickUpTypesEventImplCopyWith<$Res> {
  __$$FillPickUpTypesEventImplCopyWithImpl(
    _$FillPickUpTypesEventImpl _value,
    $Res Function(_$FillPickUpTypesEventImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of UserEvent
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? cmpCode = null, Object? pickUpType = null}) {
    return _then(
      _$FillPickUpTypesEventImpl(
        cmpCode:
            null == cmpCode
                ? _value.cmpCode
                : cmpCode // ignore: cast_nullable_to_non_nullable
                    as int,
        pickUpType:
            null == pickUpType
                ? _value.pickUpType
                : pickUpType // ignore: cast_nullable_to_non_nullable
                    as int,
      ),
    );
  }
}

/// @nodoc

class _$FillPickUpTypesEventImpl implements FillPickUpTypesEvent {
  const _$FillPickUpTypesEventImpl({
    required this.cmpCode,
    required this.pickUpType,
  });

  @override
  final int cmpCode;
  @override
  final int pickUpType;

  @override
  String toString() {
    return 'UserEvent.fillPickUpTypesEvent(cmpCode: $cmpCode, pickUpType: $pickUpType)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$FillPickUpTypesEventImpl &&
            (identical(other.cmpCode, cmpCode) || other.cmpCode == cmpCode) &&
            (identical(other.pickUpType, pickUpType) ||
                other.pickUpType == pickUpType));
  }

  @override
  int get hashCode => Object.hash(runtimeType, cmpCode, pickUpType);

  /// Create a copy of UserEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$FillPickUpTypesEventImplCopyWith<_$FillPickUpTypesEventImpl>
  get copyWith =>
      __$$FillPickUpTypesEventImplCopyWithImpl<_$FillPickUpTypesEventImpl>(
        this,
        _$identity,
      );

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(int cmpCode, int pickUpType) fillPickUpTypesEvent,
    required TResult Function(int selectedItem) selectCustomerType,
    required TResult Function(String dob) pickCustomerDob,
    required TResult Function() getBranches,
    required TResult Function(
      IndividualUserCreationUIModal individualUserCreationUiModal,
    )
    individualUserCreation,
    required TResult Function(String cmpCode, String refID) validateRefID,
    required TResult Function() clearRefValidation,
    required TResult Function() clearDobSelection,
    required TResult Function(InstituitionUiReqModel institutionUiModal)
    institutionCreation,
  }) {
    return fillPickUpTypesEvent(cmpCode, pickUpType);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(int cmpCode, int pickUpType)? fillPickUpTypesEvent,
    TResult? Function(int selectedItem)? selectCustomerType,
    TResult? Function(String dob)? pickCustomerDob,
    TResult? Function()? getBranches,
    TResult? Function(
      IndividualUserCreationUIModal individualUserCreationUiModal,
    )?
    individualUserCreation,
    TResult? Function(String cmpCode, String refID)? validateRefID,
    TResult? Function()? clearRefValidation,
    TResult? Function()? clearDobSelection,
    TResult? Function(InstituitionUiReqModel institutionUiModal)?
    institutionCreation,
  }) {
    return fillPickUpTypesEvent?.call(cmpCode, pickUpType);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(int cmpCode, int pickUpType)? fillPickUpTypesEvent,
    TResult Function(int selectedItem)? selectCustomerType,
    TResult Function(String dob)? pickCustomerDob,
    TResult Function()? getBranches,
    TResult Function(
      IndividualUserCreationUIModal individualUserCreationUiModal,
    )?
    individualUserCreation,
    TResult Function(String cmpCode, String refID)? validateRefID,
    TResult Function()? clearRefValidation,
    TResult Function()? clearDobSelection,
    TResult Function(InstituitionUiReqModel institutionUiModal)?
    institutionCreation,
    required TResult orElse(),
  }) {
    if (fillPickUpTypesEvent != null) {
      return fillPickUpTypesEvent(cmpCode, pickUpType);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(FillPickUpTypesEvent value) fillPickUpTypesEvent,
    required TResult Function(selectCustomerTypeEvent value) selectCustomerType,
    required TResult Function(PickCustomerDobEvent value) pickCustomerDob,
    required TResult Function(GetBranchesEvent value) getBranches,
    required TResult Function(IndividualUserCreationEvent value)
    individualUserCreation,
    required TResult Function(ValidateRefIDEvent value) validateRefID,
    required TResult Function(ClearRefEvent value) clearRefValidation,
    required TResult Function(ClearDobEvent value) clearDobSelection,
    required TResult Function(InstitutionUserCreationEvent value)
    institutionCreation,
  }) {
    return fillPickUpTypesEvent(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(FillPickUpTypesEvent value)? fillPickUpTypesEvent,
    TResult? Function(selectCustomerTypeEvent value)? selectCustomerType,
    TResult? Function(PickCustomerDobEvent value)? pickCustomerDob,
    TResult? Function(GetBranchesEvent value)? getBranches,
    TResult? Function(IndividualUserCreationEvent value)?
    individualUserCreation,
    TResult? Function(ValidateRefIDEvent value)? validateRefID,
    TResult? Function(ClearRefEvent value)? clearRefValidation,
    TResult? Function(ClearDobEvent value)? clearDobSelection,
    TResult? Function(InstitutionUserCreationEvent value)? institutionCreation,
  }) {
    return fillPickUpTypesEvent?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(FillPickUpTypesEvent value)? fillPickUpTypesEvent,
    TResult Function(selectCustomerTypeEvent value)? selectCustomerType,
    TResult Function(PickCustomerDobEvent value)? pickCustomerDob,
    TResult Function(GetBranchesEvent value)? getBranches,
    TResult Function(IndividualUserCreationEvent value)? individualUserCreation,
    TResult Function(ValidateRefIDEvent value)? validateRefID,
    TResult Function(ClearRefEvent value)? clearRefValidation,
    TResult Function(ClearDobEvent value)? clearDobSelection,
    TResult Function(InstitutionUserCreationEvent value)? institutionCreation,
    required TResult orElse(),
  }) {
    if (fillPickUpTypesEvent != null) {
      return fillPickUpTypesEvent(this);
    }
    return orElse();
  }
}

abstract class FillPickUpTypesEvent implements UserEvent {
  const factory FillPickUpTypesEvent({
    required final int cmpCode,
    required final int pickUpType,
  }) = _$FillPickUpTypesEventImpl;

  int get cmpCode;
  int get pickUpType;

  /// Create a copy of UserEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$FillPickUpTypesEventImplCopyWith<_$FillPickUpTypesEventImpl>
  get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$selectCustomerTypeEventImplCopyWith<$Res> {
  factory _$$selectCustomerTypeEventImplCopyWith(
    _$selectCustomerTypeEventImpl value,
    $Res Function(_$selectCustomerTypeEventImpl) then,
  ) = __$$selectCustomerTypeEventImplCopyWithImpl<$Res>;
  @useResult
  $Res call({int selectedItem});
}

/// @nodoc
class __$$selectCustomerTypeEventImplCopyWithImpl<$Res>
    extends _$UserEventCopyWithImpl<$Res, _$selectCustomerTypeEventImpl>
    implements _$$selectCustomerTypeEventImplCopyWith<$Res> {
  __$$selectCustomerTypeEventImplCopyWithImpl(
    _$selectCustomerTypeEventImpl _value,
    $Res Function(_$selectCustomerTypeEventImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of UserEvent
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? selectedItem = null}) {
    return _then(
      _$selectCustomerTypeEventImpl(
        null == selectedItem
            ? _value.selectedItem
            : selectedItem // ignore: cast_nullable_to_non_nullable
                as int,
      ),
    );
  }
}

/// @nodoc

class _$selectCustomerTypeEventImpl implements selectCustomerTypeEvent {
  const _$selectCustomerTypeEventImpl(this.selectedItem);

  @override
  final int selectedItem;

  @override
  String toString() {
    return 'UserEvent.selectCustomerType(selectedItem: $selectedItem)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$selectCustomerTypeEventImpl &&
            (identical(other.selectedItem, selectedItem) ||
                other.selectedItem == selectedItem));
  }

  @override
  int get hashCode => Object.hash(runtimeType, selectedItem);

  /// Create a copy of UserEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$selectCustomerTypeEventImplCopyWith<_$selectCustomerTypeEventImpl>
  get copyWith => __$$selectCustomerTypeEventImplCopyWithImpl<
    _$selectCustomerTypeEventImpl
  >(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(int cmpCode, int pickUpType) fillPickUpTypesEvent,
    required TResult Function(int selectedItem) selectCustomerType,
    required TResult Function(String dob) pickCustomerDob,
    required TResult Function() getBranches,
    required TResult Function(
      IndividualUserCreationUIModal individualUserCreationUiModal,
    )
    individualUserCreation,
    required TResult Function(String cmpCode, String refID) validateRefID,
    required TResult Function() clearRefValidation,
    required TResult Function() clearDobSelection,
    required TResult Function(InstituitionUiReqModel institutionUiModal)
    institutionCreation,
  }) {
    return selectCustomerType(selectedItem);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(int cmpCode, int pickUpType)? fillPickUpTypesEvent,
    TResult? Function(int selectedItem)? selectCustomerType,
    TResult? Function(String dob)? pickCustomerDob,
    TResult? Function()? getBranches,
    TResult? Function(
      IndividualUserCreationUIModal individualUserCreationUiModal,
    )?
    individualUserCreation,
    TResult? Function(String cmpCode, String refID)? validateRefID,
    TResult? Function()? clearRefValidation,
    TResult? Function()? clearDobSelection,
    TResult? Function(InstituitionUiReqModel institutionUiModal)?
    institutionCreation,
  }) {
    return selectCustomerType?.call(selectedItem);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(int cmpCode, int pickUpType)? fillPickUpTypesEvent,
    TResult Function(int selectedItem)? selectCustomerType,
    TResult Function(String dob)? pickCustomerDob,
    TResult Function()? getBranches,
    TResult Function(
      IndividualUserCreationUIModal individualUserCreationUiModal,
    )?
    individualUserCreation,
    TResult Function(String cmpCode, String refID)? validateRefID,
    TResult Function()? clearRefValidation,
    TResult Function()? clearDobSelection,
    TResult Function(InstituitionUiReqModel institutionUiModal)?
    institutionCreation,
    required TResult orElse(),
  }) {
    if (selectCustomerType != null) {
      return selectCustomerType(selectedItem);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(FillPickUpTypesEvent value) fillPickUpTypesEvent,
    required TResult Function(selectCustomerTypeEvent value) selectCustomerType,
    required TResult Function(PickCustomerDobEvent value) pickCustomerDob,
    required TResult Function(GetBranchesEvent value) getBranches,
    required TResult Function(IndividualUserCreationEvent value)
    individualUserCreation,
    required TResult Function(ValidateRefIDEvent value) validateRefID,
    required TResult Function(ClearRefEvent value) clearRefValidation,
    required TResult Function(ClearDobEvent value) clearDobSelection,
    required TResult Function(InstitutionUserCreationEvent value)
    institutionCreation,
  }) {
    return selectCustomerType(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(FillPickUpTypesEvent value)? fillPickUpTypesEvent,
    TResult? Function(selectCustomerTypeEvent value)? selectCustomerType,
    TResult? Function(PickCustomerDobEvent value)? pickCustomerDob,
    TResult? Function(GetBranchesEvent value)? getBranches,
    TResult? Function(IndividualUserCreationEvent value)?
    individualUserCreation,
    TResult? Function(ValidateRefIDEvent value)? validateRefID,
    TResult? Function(ClearRefEvent value)? clearRefValidation,
    TResult? Function(ClearDobEvent value)? clearDobSelection,
    TResult? Function(InstitutionUserCreationEvent value)? institutionCreation,
  }) {
    return selectCustomerType?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(FillPickUpTypesEvent value)? fillPickUpTypesEvent,
    TResult Function(selectCustomerTypeEvent value)? selectCustomerType,
    TResult Function(PickCustomerDobEvent value)? pickCustomerDob,
    TResult Function(GetBranchesEvent value)? getBranches,
    TResult Function(IndividualUserCreationEvent value)? individualUserCreation,
    TResult Function(ValidateRefIDEvent value)? validateRefID,
    TResult Function(ClearRefEvent value)? clearRefValidation,
    TResult Function(ClearDobEvent value)? clearDobSelection,
    TResult Function(InstitutionUserCreationEvent value)? institutionCreation,
    required TResult orElse(),
  }) {
    if (selectCustomerType != null) {
      return selectCustomerType(this);
    }
    return orElse();
  }
}

abstract class selectCustomerTypeEvent implements UserEvent {
  const factory selectCustomerTypeEvent(final int selectedItem) =
      _$selectCustomerTypeEventImpl;

  int get selectedItem;

  /// Create a copy of UserEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$selectCustomerTypeEventImplCopyWith<_$selectCustomerTypeEventImpl>
  get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$PickCustomerDobEventImplCopyWith<$Res> {
  factory _$$PickCustomerDobEventImplCopyWith(
    _$PickCustomerDobEventImpl value,
    $Res Function(_$PickCustomerDobEventImpl) then,
  ) = __$$PickCustomerDobEventImplCopyWithImpl<$Res>;
  @useResult
  $Res call({String dob});
}

/// @nodoc
class __$$PickCustomerDobEventImplCopyWithImpl<$Res>
    extends _$UserEventCopyWithImpl<$Res, _$PickCustomerDobEventImpl>
    implements _$$PickCustomerDobEventImplCopyWith<$Res> {
  __$$PickCustomerDobEventImplCopyWithImpl(
    _$PickCustomerDobEventImpl _value,
    $Res Function(_$PickCustomerDobEventImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of UserEvent
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? dob = null}) {
    return _then(
      _$PickCustomerDobEventImpl(
        null == dob
            ? _value.dob
            : dob // ignore: cast_nullable_to_non_nullable
                as String,
      ),
    );
  }
}

/// @nodoc

class _$PickCustomerDobEventImpl implements PickCustomerDobEvent {
  const _$PickCustomerDobEventImpl(this.dob);

  @override
  final String dob;

  @override
  String toString() {
    return 'UserEvent.pickCustomerDob(dob: $dob)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$PickCustomerDobEventImpl &&
            (identical(other.dob, dob) || other.dob == dob));
  }

  @override
  int get hashCode => Object.hash(runtimeType, dob);

  /// Create a copy of UserEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$PickCustomerDobEventImplCopyWith<_$PickCustomerDobEventImpl>
  get copyWith =>
      __$$PickCustomerDobEventImplCopyWithImpl<_$PickCustomerDobEventImpl>(
        this,
        _$identity,
      );

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(int cmpCode, int pickUpType) fillPickUpTypesEvent,
    required TResult Function(int selectedItem) selectCustomerType,
    required TResult Function(String dob) pickCustomerDob,
    required TResult Function() getBranches,
    required TResult Function(
      IndividualUserCreationUIModal individualUserCreationUiModal,
    )
    individualUserCreation,
    required TResult Function(String cmpCode, String refID) validateRefID,
    required TResult Function() clearRefValidation,
    required TResult Function() clearDobSelection,
    required TResult Function(InstituitionUiReqModel institutionUiModal)
    institutionCreation,
  }) {
    return pickCustomerDob(dob);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(int cmpCode, int pickUpType)? fillPickUpTypesEvent,
    TResult? Function(int selectedItem)? selectCustomerType,
    TResult? Function(String dob)? pickCustomerDob,
    TResult? Function()? getBranches,
    TResult? Function(
      IndividualUserCreationUIModal individualUserCreationUiModal,
    )?
    individualUserCreation,
    TResult? Function(String cmpCode, String refID)? validateRefID,
    TResult? Function()? clearRefValidation,
    TResult? Function()? clearDobSelection,
    TResult? Function(InstituitionUiReqModel institutionUiModal)?
    institutionCreation,
  }) {
    return pickCustomerDob?.call(dob);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(int cmpCode, int pickUpType)? fillPickUpTypesEvent,
    TResult Function(int selectedItem)? selectCustomerType,
    TResult Function(String dob)? pickCustomerDob,
    TResult Function()? getBranches,
    TResult Function(
      IndividualUserCreationUIModal individualUserCreationUiModal,
    )?
    individualUserCreation,
    TResult Function(String cmpCode, String refID)? validateRefID,
    TResult Function()? clearRefValidation,
    TResult Function()? clearDobSelection,
    TResult Function(InstituitionUiReqModel institutionUiModal)?
    institutionCreation,
    required TResult orElse(),
  }) {
    if (pickCustomerDob != null) {
      return pickCustomerDob(dob);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(FillPickUpTypesEvent value) fillPickUpTypesEvent,
    required TResult Function(selectCustomerTypeEvent value) selectCustomerType,
    required TResult Function(PickCustomerDobEvent value) pickCustomerDob,
    required TResult Function(GetBranchesEvent value) getBranches,
    required TResult Function(IndividualUserCreationEvent value)
    individualUserCreation,
    required TResult Function(ValidateRefIDEvent value) validateRefID,
    required TResult Function(ClearRefEvent value) clearRefValidation,
    required TResult Function(ClearDobEvent value) clearDobSelection,
    required TResult Function(InstitutionUserCreationEvent value)
    institutionCreation,
  }) {
    return pickCustomerDob(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(FillPickUpTypesEvent value)? fillPickUpTypesEvent,
    TResult? Function(selectCustomerTypeEvent value)? selectCustomerType,
    TResult? Function(PickCustomerDobEvent value)? pickCustomerDob,
    TResult? Function(GetBranchesEvent value)? getBranches,
    TResult? Function(IndividualUserCreationEvent value)?
    individualUserCreation,
    TResult? Function(ValidateRefIDEvent value)? validateRefID,
    TResult? Function(ClearRefEvent value)? clearRefValidation,
    TResult? Function(ClearDobEvent value)? clearDobSelection,
    TResult? Function(InstitutionUserCreationEvent value)? institutionCreation,
  }) {
    return pickCustomerDob?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(FillPickUpTypesEvent value)? fillPickUpTypesEvent,
    TResult Function(selectCustomerTypeEvent value)? selectCustomerType,
    TResult Function(PickCustomerDobEvent value)? pickCustomerDob,
    TResult Function(GetBranchesEvent value)? getBranches,
    TResult Function(IndividualUserCreationEvent value)? individualUserCreation,
    TResult Function(ValidateRefIDEvent value)? validateRefID,
    TResult Function(ClearRefEvent value)? clearRefValidation,
    TResult Function(ClearDobEvent value)? clearDobSelection,
    TResult Function(InstitutionUserCreationEvent value)? institutionCreation,
    required TResult orElse(),
  }) {
    if (pickCustomerDob != null) {
      return pickCustomerDob(this);
    }
    return orElse();
  }
}

abstract class PickCustomerDobEvent implements UserEvent {
  const factory PickCustomerDobEvent(final String dob) =
      _$PickCustomerDobEventImpl;

  String get dob;

  /// Create a copy of UserEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$PickCustomerDobEventImplCopyWith<_$PickCustomerDobEventImpl>
  get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$GetBranchesEventImplCopyWith<$Res> {
  factory _$$GetBranchesEventImplCopyWith(
    _$GetBranchesEventImpl value,
    $Res Function(_$GetBranchesEventImpl) then,
  ) = __$$GetBranchesEventImplCopyWithImpl<$Res>;
}

/// @nodoc
class __$$GetBranchesEventImplCopyWithImpl<$Res>
    extends _$UserEventCopyWithImpl<$Res, _$GetBranchesEventImpl>
    implements _$$GetBranchesEventImplCopyWith<$Res> {
  __$$GetBranchesEventImplCopyWithImpl(
    _$GetBranchesEventImpl _value,
    $Res Function(_$GetBranchesEventImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of UserEvent
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc

class _$GetBranchesEventImpl implements GetBranchesEvent {
  const _$GetBranchesEventImpl();

  @override
  String toString() {
    return 'UserEvent.getBranches()';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _$GetBranchesEventImpl);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(int cmpCode, int pickUpType) fillPickUpTypesEvent,
    required TResult Function(int selectedItem) selectCustomerType,
    required TResult Function(String dob) pickCustomerDob,
    required TResult Function() getBranches,
    required TResult Function(
      IndividualUserCreationUIModal individualUserCreationUiModal,
    )
    individualUserCreation,
    required TResult Function(String cmpCode, String refID) validateRefID,
    required TResult Function() clearRefValidation,
    required TResult Function() clearDobSelection,
    required TResult Function(InstituitionUiReqModel institutionUiModal)
    institutionCreation,
  }) {
    return getBranches();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(int cmpCode, int pickUpType)? fillPickUpTypesEvent,
    TResult? Function(int selectedItem)? selectCustomerType,
    TResult? Function(String dob)? pickCustomerDob,
    TResult? Function()? getBranches,
    TResult? Function(
      IndividualUserCreationUIModal individualUserCreationUiModal,
    )?
    individualUserCreation,
    TResult? Function(String cmpCode, String refID)? validateRefID,
    TResult? Function()? clearRefValidation,
    TResult? Function()? clearDobSelection,
    TResult? Function(InstituitionUiReqModel institutionUiModal)?
    institutionCreation,
  }) {
    return getBranches?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(int cmpCode, int pickUpType)? fillPickUpTypesEvent,
    TResult Function(int selectedItem)? selectCustomerType,
    TResult Function(String dob)? pickCustomerDob,
    TResult Function()? getBranches,
    TResult Function(
      IndividualUserCreationUIModal individualUserCreationUiModal,
    )?
    individualUserCreation,
    TResult Function(String cmpCode, String refID)? validateRefID,
    TResult Function()? clearRefValidation,
    TResult Function()? clearDobSelection,
    TResult Function(InstituitionUiReqModel institutionUiModal)?
    institutionCreation,
    required TResult orElse(),
  }) {
    if (getBranches != null) {
      return getBranches();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(FillPickUpTypesEvent value) fillPickUpTypesEvent,
    required TResult Function(selectCustomerTypeEvent value) selectCustomerType,
    required TResult Function(PickCustomerDobEvent value) pickCustomerDob,
    required TResult Function(GetBranchesEvent value) getBranches,
    required TResult Function(IndividualUserCreationEvent value)
    individualUserCreation,
    required TResult Function(ValidateRefIDEvent value) validateRefID,
    required TResult Function(ClearRefEvent value) clearRefValidation,
    required TResult Function(ClearDobEvent value) clearDobSelection,
    required TResult Function(InstitutionUserCreationEvent value)
    institutionCreation,
  }) {
    return getBranches(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(FillPickUpTypesEvent value)? fillPickUpTypesEvent,
    TResult? Function(selectCustomerTypeEvent value)? selectCustomerType,
    TResult? Function(PickCustomerDobEvent value)? pickCustomerDob,
    TResult? Function(GetBranchesEvent value)? getBranches,
    TResult? Function(IndividualUserCreationEvent value)?
    individualUserCreation,
    TResult? Function(ValidateRefIDEvent value)? validateRefID,
    TResult? Function(ClearRefEvent value)? clearRefValidation,
    TResult? Function(ClearDobEvent value)? clearDobSelection,
    TResult? Function(InstitutionUserCreationEvent value)? institutionCreation,
  }) {
    return getBranches?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(FillPickUpTypesEvent value)? fillPickUpTypesEvent,
    TResult Function(selectCustomerTypeEvent value)? selectCustomerType,
    TResult Function(PickCustomerDobEvent value)? pickCustomerDob,
    TResult Function(GetBranchesEvent value)? getBranches,
    TResult Function(IndividualUserCreationEvent value)? individualUserCreation,
    TResult Function(ValidateRefIDEvent value)? validateRefID,
    TResult Function(ClearRefEvent value)? clearRefValidation,
    TResult Function(ClearDobEvent value)? clearDobSelection,
    TResult Function(InstitutionUserCreationEvent value)? institutionCreation,
    required TResult orElse(),
  }) {
    if (getBranches != null) {
      return getBranches(this);
    }
    return orElse();
  }
}

abstract class GetBranchesEvent implements UserEvent {
  const factory GetBranchesEvent() = _$GetBranchesEventImpl;
}

/// @nodoc
abstract class _$$IndividualUserCreationEventImplCopyWith<$Res> {
  factory _$$IndividualUserCreationEventImplCopyWith(
    _$IndividualUserCreationEventImpl value,
    $Res Function(_$IndividualUserCreationEventImpl) then,
  ) = __$$IndividualUserCreationEventImplCopyWithImpl<$Res>;
  @useResult
  $Res call({IndividualUserCreationUIModal individualUserCreationUiModal});
}

/// @nodoc
class __$$IndividualUserCreationEventImplCopyWithImpl<$Res>
    extends _$UserEventCopyWithImpl<$Res, _$IndividualUserCreationEventImpl>
    implements _$$IndividualUserCreationEventImplCopyWith<$Res> {
  __$$IndividualUserCreationEventImplCopyWithImpl(
    _$IndividualUserCreationEventImpl _value,
    $Res Function(_$IndividualUserCreationEventImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of UserEvent
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? individualUserCreationUiModal = null}) {
    return _then(
      _$IndividualUserCreationEventImpl(
        individualUserCreationUiModal:
            null == individualUserCreationUiModal
                ? _value.individualUserCreationUiModal
                : individualUserCreationUiModal // ignore: cast_nullable_to_non_nullable
                    as IndividualUserCreationUIModal,
      ),
    );
  }
}

/// @nodoc

class _$IndividualUserCreationEventImpl implements IndividualUserCreationEvent {
  const _$IndividualUserCreationEventImpl({
    required this.individualUserCreationUiModal,
  });

  @override
  final IndividualUserCreationUIModal individualUserCreationUiModal;

  @override
  String toString() {
    return 'UserEvent.individualUserCreation(individualUserCreationUiModal: $individualUserCreationUiModal)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$IndividualUserCreationEventImpl &&
            (identical(
                  other.individualUserCreationUiModal,
                  individualUserCreationUiModal,
                ) ||
                other.individualUserCreationUiModal ==
                    individualUserCreationUiModal));
  }

  @override
  int get hashCode => Object.hash(runtimeType, individualUserCreationUiModal);

  /// Create a copy of UserEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$IndividualUserCreationEventImplCopyWith<_$IndividualUserCreationEventImpl>
  get copyWith => __$$IndividualUserCreationEventImplCopyWithImpl<
    _$IndividualUserCreationEventImpl
  >(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(int cmpCode, int pickUpType) fillPickUpTypesEvent,
    required TResult Function(int selectedItem) selectCustomerType,
    required TResult Function(String dob) pickCustomerDob,
    required TResult Function() getBranches,
    required TResult Function(
      IndividualUserCreationUIModal individualUserCreationUiModal,
    )
    individualUserCreation,
    required TResult Function(String cmpCode, String refID) validateRefID,
    required TResult Function() clearRefValidation,
    required TResult Function() clearDobSelection,
    required TResult Function(InstituitionUiReqModel institutionUiModal)
    institutionCreation,
  }) {
    return individualUserCreation(individualUserCreationUiModal);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(int cmpCode, int pickUpType)? fillPickUpTypesEvent,
    TResult? Function(int selectedItem)? selectCustomerType,
    TResult? Function(String dob)? pickCustomerDob,
    TResult? Function()? getBranches,
    TResult? Function(
      IndividualUserCreationUIModal individualUserCreationUiModal,
    )?
    individualUserCreation,
    TResult? Function(String cmpCode, String refID)? validateRefID,
    TResult? Function()? clearRefValidation,
    TResult? Function()? clearDobSelection,
    TResult? Function(InstituitionUiReqModel institutionUiModal)?
    institutionCreation,
  }) {
    return individualUserCreation?.call(individualUserCreationUiModal);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(int cmpCode, int pickUpType)? fillPickUpTypesEvent,
    TResult Function(int selectedItem)? selectCustomerType,
    TResult Function(String dob)? pickCustomerDob,
    TResult Function()? getBranches,
    TResult Function(
      IndividualUserCreationUIModal individualUserCreationUiModal,
    )?
    individualUserCreation,
    TResult Function(String cmpCode, String refID)? validateRefID,
    TResult Function()? clearRefValidation,
    TResult Function()? clearDobSelection,
    TResult Function(InstituitionUiReqModel institutionUiModal)?
    institutionCreation,
    required TResult orElse(),
  }) {
    if (individualUserCreation != null) {
      return individualUserCreation(individualUserCreationUiModal);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(FillPickUpTypesEvent value) fillPickUpTypesEvent,
    required TResult Function(selectCustomerTypeEvent value) selectCustomerType,
    required TResult Function(PickCustomerDobEvent value) pickCustomerDob,
    required TResult Function(GetBranchesEvent value) getBranches,
    required TResult Function(IndividualUserCreationEvent value)
    individualUserCreation,
    required TResult Function(ValidateRefIDEvent value) validateRefID,
    required TResult Function(ClearRefEvent value) clearRefValidation,
    required TResult Function(ClearDobEvent value) clearDobSelection,
    required TResult Function(InstitutionUserCreationEvent value)
    institutionCreation,
  }) {
    return individualUserCreation(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(FillPickUpTypesEvent value)? fillPickUpTypesEvent,
    TResult? Function(selectCustomerTypeEvent value)? selectCustomerType,
    TResult? Function(PickCustomerDobEvent value)? pickCustomerDob,
    TResult? Function(GetBranchesEvent value)? getBranches,
    TResult? Function(IndividualUserCreationEvent value)?
    individualUserCreation,
    TResult? Function(ValidateRefIDEvent value)? validateRefID,
    TResult? Function(ClearRefEvent value)? clearRefValidation,
    TResult? Function(ClearDobEvent value)? clearDobSelection,
    TResult? Function(InstitutionUserCreationEvent value)? institutionCreation,
  }) {
    return individualUserCreation?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(FillPickUpTypesEvent value)? fillPickUpTypesEvent,
    TResult Function(selectCustomerTypeEvent value)? selectCustomerType,
    TResult Function(PickCustomerDobEvent value)? pickCustomerDob,
    TResult Function(GetBranchesEvent value)? getBranches,
    TResult Function(IndividualUserCreationEvent value)? individualUserCreation,
    TResult Function(ValidateRefIDEvent value)? validateRefID,
    TResult Function(ClearRefEvent value)? clearRefValidation,
    TResult Function(ClearDobEvent value)? clearDobSelection,
    TResult Function(InstitutionUserCreationEvent value)? institutionCreation,
    required TResult orElse(),
  }) {
    if (individualUserCreation != null) {
      return individualUserCreation(this);
    }
    return orElse();
  }
}

abstract class IndividualUserCreationEvent implements UserEvent {
  const factory IndividualUserCreationEvent({
    required final IndividualUserCreationUIModal individualUserCreationUiModal,
  }) = _$IndividualUserCreationEventImpl;

  IndividualUserCreationUIModal get individualUserCreationUiModal;

  /// Create a copy of UserEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$IndividualUserCreationEventImplCopyWith<_$IndividualUserCreationEventImpl>
  get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$ValidateRefIDEventImplCopyWith<$Res> {
  factory _$$ValidateRefIDEventImplCopyWith(
    _$ValidateRefIDEventImpl value,
    $Res Function(_$ValidateRefIDEventImpl) then,
  ) = __$$ValidateRefIDEventImplCopyWithImpl<$Res>;
  @useResult
  $Res call({String cmpCode, String refID});
}

/// @nodoc
class __$$ValidateRefIDEventImplCopyWithImpl<$Res>
    extends _$UserEventCopyWithImpl<$Res, _$ValidateRefIDEventImpl>
    implements _$$ValidateRefIDEventImplCopyWith<$Res> {
  __$$ValidateRefIDEventImplCopyWithImpl(
    _$ValidateRefIDEventImpl _value,
    $Res Function(_$ValidateRefIDEventImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of UserEvent
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? cmpCode = null, Object? refID = null}) {
    return _then(
      _$ValidateRefIDEventImpl(
        null == cmpCode
            ? _value.cmpCode
            : cmpCode // ignore: cast_nullable_to_non_nullable
                as String,
        null == refID
            ? _value.refID
            : refID // ignore: cast_nullable_to_non_nullable
                as String,
      ),
    );
  }
}

/// @nodoc

class _$ValidateRefIDEventImpl implements ValidateRefIDEvent {
  const _$ValidateRefIDEventImpl(this.cmpCode, this.refID);

  @override
  final String cmpCode;
  @override
  final String refID;

  @override
  String toString() {
    return 'UserEvent.validateRefID(cmpCode: $cmpCode, refID: $refID)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ValidateRefIDEventImpl &&
            (identical(other.cmpCode, cmpCode) || other.cmpCode == cmpCode) &&
            (identical(other.refID, refID) || other.refID == refID));
  }

  @override
  int get hashCode => Object.hash(runtimeType, cmpCode, refID);

  /// Create a copy of UserEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$ValidateRefIDEventImplCopyWith<_$ValidateRefIDEventImpl> get copyWith =>
      __$$ValidateRefIDEventImplCopyWithImpl<_$ValidateRefIDEventImpl>(
        this,
        _$identity,
      );

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(int cmpCode, int pickUpType) fillPickUpTypesEvent,
    required TResult Function(int selectedItem) selectCustomerType,
    required TResult Function(String dob) pickCustomerDob,
    required TResult Function() getBranches,
    required TResult Function(
      IndividualUserCreationUIModal individualUserCreationUiModal,
    )
    individualUserCreation,
    required TResult Function(String cmpCode, String refID) validateRefID,
    required TResult Function() clearRefValidation,
    required TResult Function() clearDobSelection,
    required TResult Function(InstituitionUiReqModel institutionUiModal)
    institutionCreation,
  }) {
    return validateRefID(cmpCode, refID);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(int cmpCode, int pickUpType)? fillPickUpTypesEvent,
    TResult? Function(int selectedItem)? selectCustomerType,
    TResult? Function(String dob)? pickCustomerDob,
    TResult? Function()? getBranches,
    TResult? Function(
      IndividualUserCreationUIModal individualUserCreationUiModal,
    )?
    individualUserCreation,
    TResult? Function(String cmpCode, String refID)? validateRefID,
    TResult? Function()? clearRefValidation,
    TResult? Function()? clearDobSelection,
    TResult? Function(InstituitionUiReqModel institutionUiModal)?
    institutionCreation,
  }) {
    return validateRefID?.call(cmpCode, refID);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(int cmpCode, int pickUpType)? fillPickUpTypesEvent,
    TResult Function(int selectedItem)? selectCustomerType,
    TResult Function(String dob)? pickCustomerDob,
    TResult Function()? getBranches,
    TResult Function(
      IndividualUserCreationUIModal individualUserCreationUiModal,
    )?
    individualUserCreation,
    TResult Function(String cmpCode, String refID)? validateRefID,
    TResult Function()? clearRefValidation,
    TResult Function()? clearDobSelection,
    TResult Function(InstituitionUiReqModel institutionUiModal)?
    institutionCreation,
    required TResult orElse(),
  }) {
    if (validateRefID != null) {
      return validateRefID(cmpCode, refID);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(FillPickUpTypesEvent value) fillPickUpTypesEvent,
    required TResult Function(selectCustomerTypeEvent value) selectCustomerType,
    required TResult Function(PickCustomerDobEvent value) pickCustomerDob,
    required TResult Function(GetBranchesEvent value) getBranches,
    required TResult Function(IndividualUserCreationEvent value)
    individualUserCreation,
    required TResult Function(ValidateRefIDEvent value) validateRefID,
    required TResult Function(ClearRefEvent value) clearRefValidation,
    required TResult Function(ClearDobEvent value) clearDobSelection,
    required TResult Function(InstitutionUserCreationEvent value)
    institutionCreation,
  }) {
    return validateRefID(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(FillPickUpTypesEvent value)? fillPickUpTypesEvent,
    TResult? Function(selectCustomerTypeEvent value)? selectCustomerType,
    TResult? Function(PickCustomerDobEvent value)? pickCustomerDob,
    TResult? Function(GetBranchesEvent value)? getBranches,
    TResult? Function(IndividualUserCreationEvent value)?
    individualUserCreation,
    TResult? Function(ValidateRefIDEvent value)? validateRefID,
    TResult? Function(ClearRefEvent value)? clearRefValidation,
    TResult? Function(ClearDobEvent value)? clearDobSelection,
    TResult? Function(InstitutionUserCreationEvent value)? institutionCreation,
  }) {
    return validateRefID?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(FillPickUpTypesEvent value)? fillPickUpTypesEvent,
    TResult Function(selectCustomerTypeEvent value)? selectCustomerType,
    TResult Function(PickCustomerDobEvent value)? pickCustomerDob,
    TResult Function(GetBranchesEvent value)? getBranches,
    TResult Function(IndividualUserCreationEvent value)? individualUserCreation,
    TResult Function(ValidateRefIDEvent value)? validateRefID,
    TResult Function(ClearRefEvent value)? clearRefValidation,
    TResult Function(ClearDobEvent value)? clearDobSelection,
    TResult Function(InstitutionUserCreationEvent value)? institutionCreation,
    required TResult orElse(),
  }) {
    if (validateRefID != null) {
      return validateRefID(this);
    }
    return orElse();
  }
}

abstract class ValidateRefIDEvent implements UserEvent {
  const factory ValidateRefIDEvent(final String cmpCode, final String refID) =
      _$ValidateRefIDEventImpl;

  String get cmpCode;
  String get refID;

  /// Create a copy of UserEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$ValidateRefIDEventImplCopyWith<_$ValidateRefIDEventImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$ClearRefEventImplCopyWith<$Res> {
  factory _$$ClearRefEventImplCopyWith(
    _$ClearRefEventImpl value,
    $Res Function(_$ClearRefEventImpl) then,
  ) = __$$ClearRefEventImplCopyWithImpl<$Res>;
}

/// @nodoc
class __$$ClearRefEventImplCopyWithImpl<$Res>
    extends _$UserEventCopyWithImpl<$Res, _$ClearRefEventImpl>
    implements _$$ClearRefEventImplCopyWith<$Res> {
  __$$ClearRefEventImplCopyWithImpl(
    _$ClearRefEventImpl _value,
    $Res Function(_$ClearRefEventImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of UserEvent
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc

class _$ClearRefEventImpl implements ClearRefEvent {
  const _$ClearRefEventImpl();

  @override
  String toString() {
    return 'UserEvent.clearRefValidation()';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _$ClearRefEventImpl);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(int cmpCode, int pickUpType) fillPickUpTypesEvent,
    required TResult Function(int selectedItem) selectCustomerType,
    required TResult Function(String dob) pickCustomerDob,
    required TResult Function() getBranches,
    required TResult Function(
      IndividualUserCreationUIModal individualUserCreationUiModal,
    )
    individualUserCreation,
    required TResult Function(String cmpCode, String refID) validateRefID,
    required TResult Function() clearRefValidation,
    required TResult Function() clearDobSelection,
    required TResult Function(InstituitionUiReqModel institutionUiModal)
    institutionCreation,
  }) {
    return clearRefValidation();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(int cmpCode, int pickUpType)? fillPickUpTypesEvent,
    TResult? Function(int selectedItem)? selectCustomerType,
    TResult? Function(String dob)? pickCustomerDob,
    TResult? Function()? getBranches,
    TResult? Function(
      IndividualUserCreationUIModal individualUserCreationUiModal,
    )?
    individualUserCreation,
    TResult? Function(String cmpCode, String refID)? validateRefID,
    TResult? Function()? clearRefValidation,
    TResult? Function()? clearDobSelection,
    TResult? Function(InstituitionUiReqModel institutionUiModal)?
    institutionCreation,
  }) {
    return clearRefValidation?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(int cmpCode, int pickUpType)? fillPickUpTypesEvent,
    TResult Function(int selectedItem)? selectCustomerType,
    TResult Function(String dob)? pickCustomerDob,
    TResult Function()? getBranches,
    TResult Function(
      IndividualUserCreationUIModal individualUserCreationUiModal,
    )?
    individualUserCreation,
    TResult Function(String cmpCode, String refID)? validateRefID,
    TResult Function()? clearRefValidation,
    TResult Function()? clearDobSelection,
    TResult Function(InstituitionUiReqModel institutionUiModal)?
    institutionCreation,
    required TResult orElse(),
  }) {
    if (clearRefValidation != null) {
      return clearRefValidation();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(FillPickUpTypesEvent value) fillPickUpTypesEvent,
    required TResult Function(selectCustomerTypeEvent value) selectCustomerType,
    required TResult Function(PickCustomerDobEvent value) pickCustomerDob,
    required TResult Function(GetBranchesEvent value) getBranches,
    required TResult Function(IndividualUserCreationEvent value)
    individualUserCreation,
    required TResult Function(ValidateRefIDEvent value) validateRefID,
    required TResult Function(ClearRefEvent value) clearRefValidation,
    required TResult Function(ClearDobEvent value) clearDobSelection,
    required TResult Function(InstitutionUserCreationEvent value)
    institutionCreation,
  }) {
    return clearRefValidation(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(FillPickUpTypesEvent value)? fillPickUpTypesEvent,
    TResult? Function(selectCustomerTypeEvent value)? selectCustomerType,
    TResult? Function(PickCustomerDobEvent value)? pickCustomerDob,
    TResult? Function(GetBranchesEvent value)? getBranches,
    TResult? Function(IndividualUserCreationEvent value)?
    individualUserCreation,
    TResult? Function(ValidateRefIDEvent value)? validateRefID,
    TResult? Function(ClearRefEvent value)? clearRefValidation,
    TResult? Function(ClearDobEvent value)? clearDobSelection,
    TResult? Function(InstitutionUserCreationEvent value)? institutionCreation,
  }) {
    return clearRefValidation?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(FillPickUpTypesEvent value)? fillPickUpTypesEvent,
    TResult Function(selectCustomerTypeEvent value)? selectCustomerType,
    TResult Function(PickCustomerDobEvent value)? pickCustomerDob,
    TResult Function(GetBranchesEvent value)? getBranches,
    TResult Function(IndividualUserCreationEvent value)? individualUserCreation,
    TResult Function(ValidateRefIDEvent value)? validateRefID,
    TResult Function(ClearRefEvent value)? clearRefValidation,
    TResult Function(ClearDobEvent value)? clearDobSelection,
    TResult Function(InstitutionUserCreationEvent value)? institutionCreation,
    required TResult orElse(),
  }) {
    if (clearRefValidation != null) {
      return clearRefValidation(this);
    }
    return orElse();
  }
}

abstract class ClearRefEvent implements UserEvent {
  const factory ClearRefEvent() = _$ClearRefEventImpl;
}

/// @nodoc
abstract class _$$ClearDobEventImplCopyWith<$Res> {
  factory _$$ClearDobEventImplCopyWith(
    _$ClearDobEventImpl value,
    $Res Function(_$ClearDobEventImpl) then,
  ) = __$$ClearDobEventImplCopyWithImpl<$Res>;
}

/// @nodoc
class __$$ClearDobEventImplCopyWithImpl<$Res>
    extends _$UserEventCopyWithImpl<$Res, _$ClearDobEventImpl>
    implements _$$ClearDobEventImplCopyWith<$Res> {
  __$$ClearDobEventImplCopyWithImpl(
    _$ClearDobEventImpl _value,
    $Res Function(_$ClearDobEventImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of UserEvent
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc

class _$ClearDobEventImpl implements ClearDobEvent {
  const _$ClearDobEventImpl();

  @override
  String toString() {
    return 'UserEvent.clearDobSelection()';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _$ClearDobEventImpl);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(int cmpCode, int pickUpType) fillPickUpTypesEvent,
    required TResult Function(int selectedItem) selectCustomerType,
    required TResult Function(String dob) pickCustomerDob,
    required TResult Function() getBranches,
    required TResult Function(
      IndividualUserCreationUIModal individualUserCreationUiModal,
    )
    individualUserCreation,
    required TResult Function(String cmpCode, String refID) validateRefID,
    required TResult Function() clearRefValidation,
    required TResult Function() clearDobSelection,
    required TResult Function(InstituitionUiReqModel institutionUiModal)
    institutionCreation,
  }) {
    return clearDobSelection();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(int cmpCode, int pickUpType)? fillPickUpTypesEvent,
    TResult? Function(int selectedItem)? selectCustomerType,
    TResult? Function(String dob)? pickCustomerDob,
    TResult? Function()? getBranches,
    TResult? Function(
      IndividualUserCreationUIModal individualUserCreationUiModal,
    )?
    individualUserCreation,
    TResult? Function(String cmpCode, String refID)? validateRefID,
    TResult? Function()? clearRefValidation,
    TResult? Function()? clearDobSelection,
    TResult? Function(InstituitionUiReqModel institutionUiModal)?
    institutionCreation,
  }) {
    return clearDobSelection?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(int cmpCode, int pickUpType)? fillPickUpTypesEvent,
    TResult Function(int selectedItem)? selectCustomerType,
    TResult Function(String dob)? pickCustomerDob,
    TResult Function()? getBranches,
    TResult Function(
      IndividualUserCreationUIModal individualUserCreationUiModal,
    )?
    individualUserCreation,
    TResult Function(String cmpCode, String refID)? validateRefID,
    TResult Function()? clearRefValidation,
    TResult Function()? clearDobSelection,
    TResult Function(InstituitionUiReqModel institutionUiModal)?
    institutionCreation,
    required TResult orElse(),
  }) {
    if (clearDobSelection != null) {
      return clearDobSelection();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(FillPickUpTypesEvent value) fillPickUpTypesEvent,
    required TResult Function(selectCustomerTypeEvent value) selectCustomerType,
    required TResult Function(PickCustomerDobEvent value) pickCustomerDob,
    required TResult Function(GetBranchesEvent value) getBranches,
    required TResult Function(IndividualUserCreationEvent value)
    individualUserCreation,
    required TResult Function(ValidateRefIDEvent value) validateRefID,
    required TResult Function(ClearRefEvent value) clearRefValidation,
    required TResult Function(ClearDobEvent value) clearDobSelection,
    required TResult Function(InstitutionUserCreationEvent value)
    institutionCreation,
  }) {
    return clearDobSelection(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(FillPickUpTypesEvent value)? fillPickUpTypesEvent,
    TResult? Function(selectCustomerTypeEvent value)? selectCustomerType,
    TResult? Function(PickCustomerDobEvent value)? pickCustomerDob,
    TResult? Function(GetBranchesEvent value)? getBranches,
    TResult? Function(IndividualUserCreationEvent value)?
    individualUserCreation,
    TResult? Function(ValidateRefIDEvent value)? validateRefID,
    TResult? Function(ClearRefEvent value)? clearRefValidation,
    TResult? Function(ClearDobEvent value)? clearDobSelection,
    TResult? Function(InstitutionUserCreationEvent value)? institutionCreation,
  }) {
    return clearDobSelection?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(FillPickUpTypesEvent value)? fillPickUpTypesEvent,
    TResult Function(selectCustomerTypeEvent value)? selectCustomerType,
    TResult Function(PickCustomerDobEvent value)? pickCustomerDob,
    TResult Function(GetBranchesEvent value)? getBranches,
    TResult Function(IndividualUserCreationEvent value)? individualUserCreation,
    TResult Function(ValidateRefIDEvent value)? validateRefID,
    TResult Function(ClearRefEvent value)? clearRefValidation,
    TResult Function(ClearDobEvent value)? clearDobSelection,
    TResult Function(InstitutionUserCreationEvent value)? institutionCreation,
    required TResult orElse(),
  }) {
    if (clearDobSelection != null) {
      return clearDobSelection(this);
    }
    return orElse();
  }
}

abstract class ClearDobEvent implements UserEvent {
  const factory ClearDobEvent() = _$ClearDobEventImpl;
}

/// @nodoc
abstract class _$$InstitutionUserCreationEventImplCopyWith<$Res> {
  factory _$$InstitutionUserCreationEventImplCopyWith(
    _$InstitutionUserCreationEventImpl value,
    $Res Function(_$InstitutionUserCreationEventImpl) then,
  ) = __$$InstitutionUserCreationEventImplCopyWithImpl<$Res>;
  @useResult
  $Res call({InstituitionUiReqModel institutionUiModal});
}

/// @nodoc
class __$$InstitutionUserCreationEventImplCopyWithImpl<$Res>
    extends _$UserEventCopyWithImpl<$Res, _$InstitutionUserCreationEventImpl>
    implements _$$InstitutionUserCreationEventImplCopyWith<$Res> {
  __$$InstitutionUserCreationEventImplCopyWithImpl(
    _$InstitutionUserCreationEventImpl _value,
    $Res Function(_$InstitutionUserCreationEventImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of UserEvent
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? institutionUiModal = null}) {
    return _then(
      _$InstitutionUserCreationEventImpl(
        institutionUiModal:
            null == institutionUiModal
                ? _value.institutionUiModal
                : institutionUiModal // ignore: cast_nullable_to_non_nullable
                    as InstituitionUiReqModel,
      ),
    );
  }
}

/// @nodoc

class _$InstitutionUserCreationEventImpl
    implements InstitutionUserCreationEvent {
  const _$InstitutionUserCreationEventImpl({required this.institutionUiModal});

  @override
  final InstituitionUiReqModel institutionUiModal;

  @override
  String toString() {
    return 'UserEvent.institutionCreation(institutionUiModal: $institutionUiModal)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$InstitutionUserCreationEventImpl &&
            (identical(other.institutionUiModal, institutionUiModal) ||
                other.institutionUiModal == institutionUiModal));
  }

  @override
  int get hashCode => Object.hash(runtimeType, institutionUiModal);

  /// Create a copy of UserEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$InstitutionUserCreationEventImplCopyWith<
    _$InstitutionUserCreationEventImpl
  >
  get copyWith => __$$InstitutionUserCreationEventImplCopyWithImpl<
    _$InstitutionUserCreationEventImpl
  >(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(int cmpCode, int pickUpType) fillPickUpTypesEvent,
    required TResult Function(int selectedItem) selectCustomerType,
    required TResult Function(String dob) pickCustomerDob,
    required TResult Function() getBranches,
    required TResult Function(
      IndividualUserCreationUIModal individualUserCreationUiModal,
    )
    individualUserCreation,
    required TResult Function(String cmpCode, String refID) validateRefID,
    required TResult Function() clearRefValidation,
    required TResult Function() clearDobSelection,
    required TResult Function(InstituitionUiReqModel institutionUiModal)
    institutionCreation,
  }) {
    return institutionCreation(institutionUiModal);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(int cmpCode, int pickUpType)? fillPickUpTypesEvent,
    TResult? Function(int selectedItem)? selectCustomerType,
    TResult? Function(String dob)? pickCustomerDob,
    TResult? Function()? getBranches,
    TResult? Function(
      IndividualUserCreationUIModal individualUserCreationUiModal,
    )?
    individualUserCreation,
    TResult? Function(String cmpCode, String refID)? validateRefID,
    TResult? Function()? clearRefValidation,
    TResult? Function()? clearDobSelection,
    TResult? Function(InstituitionUiReqModel institutionUiModal)?
    institutionCreation,
  }) {
    return institutionCreation?.call(institutionUiModal);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(int cmpCode, int pickUpType)? fillPickUpTypesEvent,
    TResult Function(int selectedItem)? selectCustomerType,
    TResult Function(String dob)? pickCustomerDob,
    TResult Function()? getBranches,
    TResult Function(
      IndividualUserCreationUIModal individualUserCreationUiModal,
    )?
    individualUserCreation,
    TResult Function(String cmpCode, String refID)? validateRefID,
    TResult Function()? clearRefValidation,
    TResult Function()? clearDobSelection,
    TResult Function(InstituitionUiReqModel institutionUiModal)?
    institutionCreation,
    required TResult orElse(),
  }) {
    if (institutionCreation != null) {
      return institutionCreation(institutionUiModal);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(FillPickUpTypesEvent value) fillPickUpTypesEvent,
    required TResult Function(selectCustomerTypeEvent value) selectCustomerType,
    required TResult Function(PickCustomerDobEvent value) pickCustomerDob,
    required TResult Function(GetBranchesEvent value) getBranches,
    required TResult Function(IndividualUserCreationEvent value)
    individualUserCreation,
    required TResult Function(ValidateRefIDEvent value) validateRefID,
    required TResult Function(ClearRefEvent value) clearRefValidation,
    required TResult Function(ClearDobEvent value) clearDobSelection,
    required TResult Function(InstitutionUserCreationEvent value)
    institutionCreation,
  }) {
    return institutionCreation(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(FillPickUpTypesEvent value)? fillPickUpTypesEvent,
    TResult? Function(selectCustomerTypeEvent value)? selectCustomerType,
    TResult? Function(PickCustomerDobEvent value)? pickCustomerDob,
    TResult? Function(GetBranchesEvent value)? getBranches,
    TResult? Function(IndividualUserCreationEvent value)?
    individualUserCreation,
    TResult? Function(ValidateRefIDEvent value)? validateRefID,
    TResult? Function(ClearRefEvent value)? clearRefValidation,
    TResult? Function(ClearDobEvent value)? clearDobSelection,
    TResult? Function(InstitutionUserCreationEvent value)? institutionCreation,
  }) {
    return institutionCreation?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(FillPickUpTypesEvent value)? fillPickUpTypesEvent,
    TResult Function(selectCustomerTypeEvent value)? selectCustomerType,
    TResult Function(PickCustomerDobEvent value)? pickCustomerDob,
    TResult Function(GetBranchesEvent value)? getBranches,
    TResult Function(IndividualUserCreationEvent value)? individualUserCreation,
    TResult Function(ValidateRefIDEvent value)? validateRefID,
    TResult Function(ClearRefEvent value)? clearRefValidation,
    TResult Function(ClearDobEvent value)? clearDobSelection,
    TResult Function(InstitutionUserCreationEvent value)? institutionCreation,
    required TResult orElse(),
  }) {
    if (institutionCreation != null) {
      return institutionCreation(this);
    }
    return orElse();
  }
}

abstract class InstitutionUserCreationEvent implements UserEvent {
  const factory InstitutionUserCreationEvent({
    required final InstituitionUiReqModel institutionUiModal,
  }) = _$InstitutionUserCreationEventImpl;

  InstituitionUiReqModel get institutionUiModal;

  /// Create a copy of UserEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$InstitutionUserCreationEventImplCopyWith<
    _$InstitutionUserCreationEventImpl
  >
  get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
mixin _$UserState {
  String? get slectedBranch => throw _privateConstructorUsedError;
  int? get selectedCustomerTypeCode => throw _privateConstructorUsedError;
  bool get isPickupCustomerTypeLoading => throw _privateConstructorUsedError;
  bool get isPickupTitleeLoading => throw _privateConstructorUsedError;
  bool get isPickupGenderLoading => throw _privateConstructorUsedError;
  bool get isPickUpBranchLoading => throw _privateConstructorUsedError;
  List<PickUpTypeResponseModal> get pickUpCustomerTypeList =>
      throw _privateConstructorUsedError;
  List<PickUpTypeResponseModal> get pickUpTitileList =>
      throw _privateConstructorUsedError;
  List<PickUpTypeResponseModal> get pickUpGenderList =>
      throw _privateConstructorUsedError;
  List<BranchData> get branchList => throw _privateConstructorUsedError;
  bool get validateRefIDLoading => throw _privateConstructorUsedError;
  ValidateRefIDResponseModal? get validateRefidResponse =>
      throw _privateConstructorUsedError;
  IndividualUserResponseModel? get individualResponse =>
      throw _privateConstructorUsedError;
  bool get isIndividualUserLoading => throw _privateConstructorUsedError;
  String? get individualUserCreationError => throw _privateConstructorUsedError;
  String? get referenceID => throw _privateConstructorUsedError;
  String? get dobCustomer => throw _privateConstructorUsedError;
  InstitutionResponseModal? get institutionResponse =>
      throw _privateConstructorUsedError;
  bool get isInstitutionCreationLoading => throw _privateConstructorUsedError;
  String? get institutionCreationError => throw _privateConstructorUsedError;

  /// Create a copy of UserState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $UserStateCopyWith<UserState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $UserStateCopyWith<$Res> {
  factory $UserStateCopyWith(UserState value, $Res Function(UserState) then) =
      _$UserStateCopyWithImpl<$Res, UserState>;
  @useResult
  $Res call({
    String? slectedBranch,
    int? selectedCustomerTypeCode,
    bool isPickupCustomerTypeLoading,
    bool isPickupTitleeLoading,
    bool isPickupGenderLoading,
    bool isPickUpBranchLoading,
    List<PickUpTypeResponseModal> pickUpCustomerTypeList,
    List<PickUpTypeResponseModal> pickUpTitileList,
    List<PickUpTypeResponseModal> pickUpGenderList,
    List<BranchData> branchList,
    bool validateRefIDLoading,
    ValidateRefIDResponseModal? validateRefidResponse,
    IndividualUserResponseModel? individualResponse,
    bool isIndividualUserLoading,
    String? individualUserCreationError,
    String? referenceID,
    String? dobCustomer,
    InstitutionResponseModal? institutionResponse,
    bool isInstitutionCreationLoading,
    String? institutionCreationError,
  });
}

/// @nodoc
class _$UserStateCopyWithImpl<$Res, $Val extends UserState>
    implements $UserStateCopyWith<$Res> {
  _$UserStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of UserState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? slectedBranch = freezed,
    Object? selectedCustomerTypeCode = freezed,
    Object? isPickupCustomerTypeLoading = null,
    Object? isPickupTitleeLoading = null,
    Object? isPickupGenderLoading = null,
    Object? isPickUpBranchLoading = null,
    Object? pickUpCustomerTypeList = null,
    Object? pickUpTitileList = null,
    Object? pickUpGenderList = null,
    Object? branchList = null,
    Object? validateRefIDLoading = null,
    Object? validateRefidResponse = freezed,
    Object? individualResponse = freezed,
    Object? isIndividualUserLoading = null,
    Object? individualUserCreationError = freezed,
    Object? referenceID = freezed,
    Object? dobCustomer = freezed,
    Object? institutionResponse = freezed,
    Object? isInstitutionCreationLoading = null,
    Object? institutionCreationError = freezed,
  }) {
    return _then(
      _value.copyWith(
            slectedBranch:
                freezed == slectedBranch
                    ? _value.slectedBranch
                    : slectedBranch // ignore: cast_nullable_to_non_nullable
                        as String?,
            selectedCustomerTypeCode:
                freezed == selectedCustomerTypeCode
                    ? _value.selectedCustomerTypeCode
                    : selectedCustomerTypeCode // ignore: cast_nullable_to_non_nullable
                        as int?,
            isPickupCustomerTypeLoading:
                null == isPickupCustomerTypeLoading
                    ? _value.isPickupCustomerTypeLoading
                    : isPickupCustomerTypeLoading // ignore: cast_nullable_to_non_nullable
                        as bool,
            isPickupTitleeLoading:
                null == isPickupTitleeLoading
                    ? _value.isPickupTitleeLoading
                    : isPickupTitleeLoading // ignore: cast_nullable_to_non_nullable
                        as bool,
            isPickupGenderLoading:
                null == isPickupGenderLoading
                    ? _value.isPickupGenderLoading
                    : isPickupGenderLoading // ignore: cast_nullable_to_non_nullable
                        as bool,
            isPickUpBranchLoading:
                null == isPickUpBranchLoading
                    ? _value.isPickUpBranchLoading
                    : isPickUpBranchLoading // ignore: cast_nullable_to_non_nullable
                        as bool,
            pickUpCustomerTypeList:
                null == pickUpCustomerTypeList
                    ? _value.pickUpCustomerTypeList
                    : pickUpCustomerTypeList // ignore: cast_nullable_to_non_nullable
                        as List<PickUpTypeResponseModal>,
            pickUpTitileList:
                null == pickUpTitileList
                    ? _value.pickUpTitileList
                    : pickUpTitileList // ignore: cast_nullable_to_non_nullable
                        as List<PickUpTypeResponseModal>,
            pickUpGenderList:
                null == pickUpGenderList
                    ? _value.pickUpGenderList
                    : pickUpGenderList // ignore: cast_nullable_to_non_nullable
                        as List<PickUpTypeResponseModal>,
            branchList:
                null == branchList
                    ? _value.branchList
                    : branchList // ignore: cast_nullable_to_non_nullable
                        as List<BranchData>,
            validateRefIDLoading:
                null == validateRefIDLoading
                    ? _value.validateRefIDLoading
                    : validateRefIDLoading // ignore: cast_nullable_to_non_nullable
                        as bool,
            validateRefidResponse:
                freezed == validateRefidResponse
                    ? _value.validateRefidResponse
                    : validateRefidResponse // ignore: cast_nullable_to_non_nullable
                        as ValidateRefIDResponseModal?,
            individualResponse:
                freezed == individualResponse
                    ? _value.individualResponse
                    : individualResponse // ignore: cast_nullable_to_non_nullable
                        as IndividualUserResponseModel?,
            isIndividualUserLoading:
                null == isIndividualUserLoading
                    ? _value.isIndividualUserLoading
                    : isIndividualUserLoading // ignore: cast_nullable_to_non_nullable
                        as bool,
            individualUserCreationError:
                freezed == individualUserCreationError
                    ? _value.individualUserCreationError
                    : individualUserCreationError // ignore: cast_nullable_to_non_nullable
                        as String?,
            referenceID:
                freezed == referenceID
                    ? _value.referenceID
                    : referenceID // ignore: cast_nullable_to_non_nullable
                        as String?,
            dobCustomer:
                freezed == dobCustomer
                    ? _value.dobCustomer
                    : dobCustomer // ignore: cast_nullable_to_non_nullable
                        as String?,
            institutionResponse:
                freezed == institutionResponse
                    ? _value.institutionResponse
                    : institutionResponse // ignore: cast_nullable_to_non_nullable
                        as InstitutionResponseModal?,
            isInstitutionCreationLoading:
                null == isInstitutionCreationLoading
                    ? _value.isInstitutionCreationLoading
                    : isInstitutionCreationLoading // ignore: cast_nullable_to_non_nullable
                        as bool,
            institutionCreationError:
                freezed == institutionCreationError
                    ? _value.institutionCreationError
                    : institutionCreationError // ignore: cast_nullable_to_non_nullable
                        as String?,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$NewUserStateImplCopyWith<$Res>
    implements $UserStateCopyWith<$Res> {
  factory _$$NewUserStateImplCopyWith(
    _$NewUserStateImpl value,
    $Res Function(_$NewUserStateImpl) then,
  ) = __$$NewUserStateImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    String? slectedBranch,
    int? selectedCustomerTypeCode,
    bool isPickupCustomerTypeLoading,
    bool isPickupTitleeLoading,
    bool isPickupGenderLoading,
    bool isPickUpBranchLoading,
    List<PickUpTypeResponseModal> pickUpCustomerTypeList,
    List<PickUpTypeResponseModal> pickUpTitileList,
    List<PickUpTypeResponseModal> pickUpGenderList,
    List<BranchData> branchList,
    bool validateRefIDLoading,
    ValidateRefIDResponseModal? validateRefidResponse,
    IndividualUserResponseModel? individualResponse,
    bool isIndividualUserLoading,
    String? individualUserCreationError,
    String? referenceID,
    String? dobCustomer,
    InstitutionResponseModal? institutionResponse,
    bool isInstitutionCreationLoading,
    String? institutionCreationError,
  });
}

/// @nodoc
class __$$NewUserStateImplCopyWithImpl<$Res>
    extends _$UserStateCopyWithImpl<$Res, _$NewUserStateImpl>
    implements _$$NewUserStateImplCopyWith<$Res> {
  __$$NewUserStateImplCopyWithImpl(
    _$NewUserStateImpl _value,
    $Res Function(_$NewUserStateImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of UserState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? slectedBranch = freezed,
    Object? selectedCustomerTypeCode = freezed,
    Object? isPickupCustomerTypeLoading = null,
    Object? isPickupTitleeLoading = null,
    Object? isPickupGenderLoading = null,
    Object? isPickUpBranchLoading = null,
    Object? pickUpCustomerTypeList = null,
    Object? pickUpTitileList = null,
    Object? pickUpGenderList = null,
    Object? branchList = null,
    Object? validateRefIDLoading = null,
    Object? validateRefidResponse = freezed,
    Object? individualResponse = freezed,
    Object? isIndividualUserLoading = null,
    Object? individualUserCreationError = freezed,
    Object? referenceID = freezed,
    Object? dobCustomer = freezed,
    Object? institutionResponse = freezed,
    Object? isInstitutionCreationLoading = null,
    Object? institutionCreationError = freezed,
  }) {
    return _then(
      _$NewUserStateImpl(
        slectedBranch:
            freezed == slectedBranch
                ? _value.slectedBranch
                : slectedBranch // ignore: cast_nullable_to_non_nullable
                    as String?,
        selectedCustomerTypeCode:
            freezed == selectedCustomerTypeCode
                ? _value.selectedCustomerTypeCode
                : selectedCustomerTypeCode // ignore: cast_nullable_to_non_nullable
                    as int?,
        isPickupCustomerTypeLoading:
            null == isPickupCustomerTypeLoading
                ? _value.isPickupCustomerTypeLoading
                : isPickupCustomerTypeLoading // ignore: cast_nullable_to_non_nullable
                    as bool,
        isPickupTitleeLoading:
            null == isPickupTitleeLoading
                ? _value.isPickupTitleeLoading
                : isPickupTitleeLoading // ignore: cast_nullable_to_non_nullable
                    as bool,
        isPickupGenderLoading:
            null == isPickupGenderLoading
                ? _value.isPickupGenderLoading
                : isPickupGenderLoading // ignore: cast_nullable_to_non_nullable
                    as bool,
        isPickUpBranchLoading:
            null == isPickUpBranchLoading
                ? _value.isPickUpBranchLoading
                : isPickUpBranchLoading // ignore: cast_nullable_to_non_nullable
                    as bool,
        pickUpCustomerTypeList:
            null == pickUpCustomerTypeList
                ? _value._pickUpCustomerTypeList
                : pickUpCustomerTypeList // ignore: cast_nullable_to_non_nullable
                    as List<PickUpTypeResponseModal>,
        pickUpTitileList:
            null == pickUpTitileList
                ? _value._pickUpTitileList
                : pickUpTitileList // ignore: cast_nullable_to_non_nullable
                    as List<PickUpTypeResponseModal>,
        pickUpGenderList:
            null == pickUpGenderList
                ? _value._pickUpGenderList
                : pickUpGenderList // ignore: cast_nullable_to_non_nullable
                    as List<PickUpTypeResponseModal>,
        branchList:
            null == branchList
                ? _value._branchList
                : branchList // ignore: cast_nullable_to_non_nullable
                    as List<BranchData>,
        validateRefIDLoading:
            null == validateRefIDLoading
                ? _value.validateRefIDLoading
                : validateRefIDLoading // ignore: cast_nullable_to_non_nullable
                    as bool,
        validateRefidResponse:
            freezed == validateRefidResponse
                ? _value.validateRefidResponse
                : validateRefidResponse // ignore: cast_nullable_to_non_nullable
                    as ValidateRefIDResponseModal?,
        individualResponse:
            freezed == individualResponse
                ? _value.individualResponse
                : individualResponse // ignore: cast_nullable_to_non_nullable
                    as IndividualUserResponseModel?,
        isIndividualUserLoading:
            null == isIndividualUserLoading
                ? _value.isIndividualUserLoading
                : isIndividualUserLoading // ignore: cast_nullable_to_non_nullable
                    as bool,
        individualUserCreationError:
            freezed == individualUserCreationError
                ? _value.individualUserCreationError
                : individualUserCreationError // ignore: cast_nullable_to_non_nullable
                    as String?,
        referenceID:
            freezed == referenceID
                ? _value.referenceID
                : referenceID // ignore: cast_nullable_to_non_nullable
                    as String?,
        dobCustomer:
            freezed == dobCustomer
                ? _value.dobCustomer
                : dobCustomer // ignore: cast_nullable_to_non_nullable
                    as String?,
        institutionResponse:
            freezed == institutionResponse
                ? _value.institutionResponse
                : institutionResponse // ignore: cast_nullable_to_non_nullable
                    as InstitutionResponseModal?,
        isInstitutionCreationLoading:
            null == isInstitutionCreationLoading
                ? _value.isInstitutionCreationLoading
                : isInstitutionCreationLoading // ignore: cast_nullable_to_non_nullable
                    as bool,
        institutionCreationError:
            freezed == institutionCreationError
                ? _value.institutionCreationError
                : institutionCreationError // ignore: cast_nullable_to_non_nullable
                    as String?,
      ),
    );
  }
}

/// @nodoc

class _$NewUserStateImpl implements NewUserState {
  const _$NewUserStateImpl({
    this.slectedBranch,
    this.selectedCustomerTypeCode,
    this.isPickupCustomerTypeLoading = false,
    this.isPickupTitleeLoading = false,
    this.isPickupGenderLoading = false,
    this.isPickUpBranchLoading = false,
    final List<PickUpTypeResponseModal> pickUpCustomerTypeList = const [],
    final List<PickUpTypeResponseModal> pickUpTitileList = const [],
    final List<PickUpTypeResponseModal> pickUpGenderList = const [],
    final List<BranchData> branchList = const [],
    this.validateRefIDLoading = false,
    this.validateRefidResponse,
    this.individualResponse,
    this.isIndividualUserLoading = false,
    this.individualUserCreationError,
    this.referenceID,
    this.dobCustomer,
    this.institutionResponse,
    this.isInstitutionCreationLoading = false,
    this.institutionCreationError,
  }) : _pickUpCustomerTypeList = pickUpCustomerTypeList,
       _pickUpTitileList = pickUpTitileList,
       _pickUpGenderList = pickUpGenderList,
       _branchList = branchList;

  @override
  final String? slectedBranch;
  @override
  final int? selectedCustomerTypeCode;
  @override
  @JsonKey()
  final bool isPickupCustomerTypeLoading;
  @override
  @JsonKey()
  final bool isPickupTitleeLoading;
  @override
  @JsonKey()
  final bool isPickupGenderLoading;
  @override
  @JsonKey()
  final bool isPickUpBranchLoading;
  final List<PickUpTypeResponseModal> _pickUpCustomerTypeList;
  @override
  @JsonKey()
  List<PickUpTypeResponseModal> get pickUpCustomerTypeList {
    if (_pickUpCustomerTypeList is EqualUnmodifiableListView)
      return _pickUpCustomerTypeList;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_pickUpCustomerTypeList);
  }

  final List<PickUpTypeResponseModal> _pickUpTitileList;
  @override
  @JsonKey()
  List<PickUpTypeResponseModal> get pickUpTitileList {
    if (_pickUpTitileList is EqualUnmodifiableListView)
      return _pickUpTitileList;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_pickUpTitileList);
  }

  final List<PickUpTypeResponseModal> _pickUpGenderList;
  @override
  @JsonKey()
  List<PickUpTypeResponseModal> get pickUpGenderList {
    if (_pickUpGenderList is EqualUnmodifiableListView)
      return _pickUpGenderList;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_pickUpGenderList);
  }

  final List<BranchData> _branchList;
  @override
  @JsonKey()
  List<BranchData> get branchList {
    if (_branchList is EqualUnmodifiableListView) return _branchList;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_branchList);
  }

  @override
  @JsonKey()
  final bool validateRefIDLoading;
  @override
  final ValidateRefIDResponseModal? validateRefidResponse;
  @override
  final IndividualUserResponseModel? individualResponse;
  @override
  @JsonKey()
  final bool isIndividualUserLoading;
  @override
  final String? individualUserCreationError;
  @override
  final String? referenceID;
  @override
  final String? dobCustomer;
  @override
  final InstitutionResponseModal? institutionResponse;
  @override
  @JsonKey()
  final bool isInstitutionCreationLoading;
  @override
  final String? institutionCreationError;

  @override
  String toString() {
    return 'UserState(slectedBranch: $slectedBranch, selectedCustomerTypeCode: $selectedCustomerTypeCode, isPickupCustomerTypeLoading: $isPickupCustomerTypeLoading, isPickupTitleeLoading: $isPickupTitleeLoading, isPickupGenderLoading: $isPickupGenderLoading, isPickUpBranchLoading: $isPickUpBranchLoading, pickUpCustomerTypeList: $pickUpCustomerTypeList, pickUpTitileList: $pickUpTitileList, pickUpGenderList: $pickUpGenderList, branchList: $branchList, validateRefIDLoading: $validateRefIDLoading, validateRefidResponse: $validateRefidResponse, individualResponse: $individualResponse, isIndividualUserLoading: $isIndividualUserLoading, individualUserCreationError: $individualUserCreationError, referenceID: $referenceID, dobCustomer: $dobCustomer, institutionResponse: $institutionResponse, isInstitutionCreationLoading: $isInstitutionCreationLoading, institutionCreationError: $institutionCreationError)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$NewUserStateImpl &&
            (identical(other.slectedBranch, slectedBranch) ||
                other.slectedBranch == slectedBranch) &&
            (identical(
                  other.selectedCustomerTypeCode,
                  selectedCustomerTypeCode,
                ) ||
                other.selectedCustomerTypeCode == selectedCustomerTypeCode) &&
            (identical(
                  other.isPickupCustomerTypeLoading,
                  isPickupCustomerTypeLoading,
                ) ||
                other.isPickupCustomerTypeLoading ==
                    isPickupCustomerTypeLoading) &&
            (identical(other.isPickupTitleeLoading, isPickupTitleeLoading) ||
                other.isPickupTitleeLoading == isPickupTitleeLoading) &&
            (identical(other.isPickupGenderLoading, isPickupGenderLoading) ||
                other.isPickupGenderLoading == isPickupGenderLoading) &&
            (identical(other.isPickUpBranchLoading, isPickUpBranchLoading) ||
                other.isPickUpBranchLoading == isPickUpBranchLoading) &&
            const DeepCollectionEquality().equals(
              other._pickUpCustomerTypeList,
              _pickUpCustomerTypeList,
            ) &&
            const DeepCollectionEquality().equals(
              other._pickUpTitileList,
              _pickUpTitileList,
            ) &&
            const DeepCollectionEquality().equals(
              other._pickUpGenderList,
              _pickUpGenderList,
            ) &&
            const DeepCollectionEquality().equals(
              other._branchList,
              _branchList,
            ) &&
            (identical(other.validateRefIDLoading, validateRefIDLoading) ||
                other.validateRefIDLoading == validateRefIDLoading) &&
            (identical(other.validateRefidResponse, validateRefidResponse) ||
                other.validateRefidResponse == validateRefidResponse) &&
            (identical(other.individualResponse, individualResponse) ||
                other.individualResponse == individualResponse) &&
            (identical(
                  other.isIndividualUserLoading,
                  isIndividualUserLoading,
                ) ||
                other.isIndividualUserLoading == isIndividualUserLoading) &&
            (identical(
                  other.individualUserCreationError,
                  individualUserCreationError,
                ) ||
                other.individualUserCreationError ==
                    individualUserCreationError) &&
            (identical(other.referenceID, referenceID) ||
                other.referenceID == referenceID) &&
            (identical(other.dobCustomer, dobCustomer) ||
                other.dobCustomer == dobCustomer) &&
            (identical(other.institutionResponse, institutionResponse) ||
                other.institutionResponse == institutionResponse) &&
            (identical(
                  other.isInstitutionCreationLoading,
                  isInstitutionCreationLoading,
                ) ||
                other.isInstitutionCreationLoading ==
                    isInstitutionCreationLoading) &&
            (identical(
                  other.institutionCreationError,
                  institutionCreationError,
                ) ||
                other.institutionCreationError == institutionCreationError));
  }

  @override
  int get hashCode => Object.hashAll([
    runtimeType,
    slectedBranch,
    selectedCustomerTypeCode,
    isPickupCustomerTypeLoading,
    isPickupTitleeLoading,
    isPickupGenderLoading,
    isPickUpBranchLoading,
    const DeepCollectionEquality().hash(_pickUpCustomerTypeList),
    const DeepCollectionEquality().hash(_pickUpTitileList),
    const DeepCollectionEquality().hash(_pickUpGenderList),
    const DeepCollectionEquality().hash(_branchList),
    validateRefIDLoading,
    validateRefidResponse,
    individualResponse,
    isIndividualUserLoading,
    individualUserCreationError,
    referenceID,
    dobCustomer,
    institutionResponse,
    isInstitutionCreationLoading,
    institutionCreationError,
  ]);

  /// Create a copy of UserState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$NewUserStateImplCopyWith<_$NewUserStateImpl> get copyWith =>
      __$$NewUserStateImplCopyWithImpl<_$NewUserStateImpl>(this, _$identity);
}

abstract class NewUserState implements UserState {
  const factory NewUserState({
    final String? slectedBranch,
    final int? selectedCustomerTypeCode,
    final bool isPickupCustomerTypeLoading,
    final bool isPickupTitleeLoading,
    final bool isPickupGenderLoading,
    final bool isPickUpBranchLoading,
    final List<PickUpTypeResponseModal> pickUpCustomerTypeList,
    final List<PickUpTypeResponseModal> pickUpTitileList,
    final List<PickUpTypeResponseModal> pickUpGenderList,
    final List<BranchData> branchList,
    final bool validateRefIDLoading,
    final ValidateRefIDResponseModal? validateRefidResponse,
    final IndividualUserResponseModel? individualResponse,
    final bool isIndividualUserLoading,
    final String? individualUserCreationError,
    final String? referenceID,
    final String? dobCustomer,
    final InstitutionResponseModal? institutionResponse,
    final bool isInstitutionCreationLoading,
    final String? institutionCreationError,
  }) = _$NewUserStateImpl;

  @override
  String? get slectedBranch;
  @override
  int? get selectedCustomerTypeCode;
  @override
  bool get isPickupCustomerTypeLoading;
  @override
  bool get isPickupTitleeLoading;
  @override
  bool get isPickupGenderLoading;
  @override
  bool get isPickUpBranchLoading;
  @override
  List<PickUpTypeResponseModal> get pickUpCustomerTypeList;
  @override
  List<PickUpTypeResponseModal> get pickUpTitileList;
  @override
  List<PickUpTypeResponseModal> get pickUpGenderList;
  @override
  List<BranchData> get branchList;
  @override
  bool get validateRefIDLoading;
  @override
  ValidateRefIDResponseModal? get validateRefidResponse;
  @override
  IndividualUserResponseModel? get individualResponse;
  @override
  bool get isIndividualUserLoading;
  @override
  String? get individualUserCreationError;
  @override
  String? get referenceID;
  @override
  String? get dobCustomer;
  @override
  InstitutionResponseModal? get institutionResponse;
  @override
  bool get isInstitutionCreationLoading;
  @override
  String? get institutionCreationError;

  /// Create a copy of UserState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$NewUserStateImplCopyWith<_$NewUserStateImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
