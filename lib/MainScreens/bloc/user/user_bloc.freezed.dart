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
  }) => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(int cmpCode, int pickUpType)? fillPickUpTypesEvent,
    TResult? Function(int selectedItem)? selectCustomerType,
    TResult? Function(String dob)? pickCustomerDob,
  }) => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(int cmpCode, int pickUpType)? fillPickUpTypesEvent,
    TResult Function(int selectedItem)? selectCustomerType,
    TResult Function(String dob)? pickCustomerDob,
    required TResult orElse(),
  }) => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(FillPickUpTypesEvent value) fillPickUpTypesEvent,
    required TResult Function(selectCustomerTypeEvent value) selectCustomerType,
    required TResult Function(PickCustomerDobEvent value) pickCustomerDob,
  }) => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(FillPickUpTypesEvent value)? fillPickUpTypesEvent,
    TResult? Function(selectCustomerTypeEvent value)? selectCustomerType,
    TResult? Function(PickCustomerDobEvent value)? pickCustomerDob,
  }) => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(FillPickUpTypesEvent value)? fillPickUpTypesEvent,
    TResult Function(selectCustomerTypeEvent value)? selectCustomerType,
    TResult Function(PickCustomerDobEvent value)? pickCustomerDob,
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
  }) {
    return fillPickUpTypesEvent(cmpCode, pickUpType);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(int cmpCode, int pickUpType)? fillPickUpTypesEvent,
    TResult? Function(int selectedItem)? selectCustomerType,
    TResult? Function(String dob)? pickCustomerDob,
  }) {
    return fillPickUpTypesEvent?.call(cmpCode, pickUpType);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(int cmpCode, int pickUpType)? fillPickUpTypesEvent,
    TResult Function(int selectedItem)? selectCustomerType,
    TResult Function(String dob)? pickCustomerDob,
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
  }) {
    return fillPickUpTypesEvent(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(FillPickUpTypesEvent value)? fillPickUpTypesEvent,
    TResult? Function(selectCustomerTypeEvent value)? selectCustomerType,
    TResult? Function(PickCustomerDobEvent value)? pickCustomerDob,
  }) {
    return fillPickUpTypesEvent?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(FillPickUpTypesEvent value)? fillPickUpTypesEvent,
    TResult Function(selectCustomerTypeEvent value)? selectCustomerType,
    TResult Function(PickCustomerDobEvent value)? pickCustomerDob,
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
  }) {
    return selectCustomerType(selectedItem);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(int cmpCode, int pickUpType)? fillPickUpTypesEvent,
    TResult? Function(int selectedItem)? selectCustomerType,
    TResult? Function(String dob)? pickCustomerDob,
  }) {
    return selectCustomerType?.call(selectedItem);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(int cmpCode, int pickUpType)? fillPickUpTypesEvent,
    TResult Function(int selectedItem)? selectCustomerType,
    TResult Function(String dob)? pickCustomerDob,
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
  }) {
    return selectCustomerType(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(FillPickUpTypesEvent value)? fillPickUpTypesEvent,
    TResult? Function(selectCustomerTypeEvent value)? selectCustomerType,
    TResult? Function(PickCustomerDobEvent value)? pickCustomerDob,
  }) {
    return selectCustomerType?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(FillPickUpTypesEvent value)? fillPickUpTypesEvent,
    TResult Function(selectCustomerTypeEvent value)? selectCustomerType,
    TResult Function(PickCustomerDobEvent value)? pickCustomerDob,
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
  }) {
    return pickCustomerDob(dob);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(int cmpCode, int pickUpType)? fillPickUpTypesEvent,
    TResult? Function(int selectedItem)? selectCustomerType,
    TResult? Function(String dob)? pickCustomerDob,
  }) {
    return pickCustomerDob?.call(dob);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(int cmpCode, int pickUpType)? fillPickUpTypesEvent,
    TResult Function(int selectedItem)? selectCustomerType,
    TResult Function(String dob)? pickCustomerDob,
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
  }) {
    return pickCustomerDob(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(FillPickUpTypesEvent value)? fillPickUpTypesEvent,
    TResult? Function(selectCustomerTypeEvent value)? selectCustomerType,
    TResult? Function(PickCustomerDobEvent value)? pickCustomerDob,
  }) {
    return pickCustomerDob?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(FillPickUpTypesEvent value)? fillPickUpTypesEvent,
    TResult Function(selectCustomerTypeEvent value)? selectCustomerType,
    TResult Function(PickCustomerDobEvent value)? pickCustomerDob,
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
mixin _$UserState {
  String? get slectedBranch => throw _privateConstructorUsedError;
  int? get selectedCustomerTypeCode => throw _privateConstructorUsedError;
  bool get isPickupCustomerTypeLoading => throw _privateConstructorUsedError;
  bool get isPickupTitleeLoading => throw _privateConstructorUsedError;
  bool get isPickupGenderLoading => throw _privateConstructorUsedError;
  List<PickUpTypeResponseModal> get pickUpCustomerTypeList =>
      throw _privateConstructorUsedError;
  List<PickUpTypeResponseModal> get pickUpTitileList =>
      throw _privateConstructorUsedError;
  List<PickUpTypeResponseModal> get pickUpGenderList =>
      throw _privateConstructorUsedError;
  String? get dobCustomer => throw _privateConstructorUsedError;

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
    List<PickUpTypeResponseModal> pickUpCustomerTypeList,
    List<PickUpTypeResponseModal> pickUpTitileList,
    List<PickUpTypeResponseModal> pickUpGenderList,
    String? dobCustomer,
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
    Object? pickUpCustomerTypeList = null,
    Object? pickUpTitileList = null,
    Object? pickUpGenderList = null,
    Object? dobCustomer = freezed,
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
            dobCustomer:
                freezed == dobCustomer
                    ? _value.dobCustomer
                    : dobCustomer // ignore: cast_nullable_to_non_nullable
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
    List<PickUpTypeResponseModal> pickUpCustomerTypeList,
    List<PickUpTypeResponseModal> pickUpTitileList,
    List<PickUpTypeResponseModal> pickUpGenderList,
    String? dobCustomer,
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
    Object? pickUpCustomerTypeList = null,
    Object? pickUpTitileList = null,
    Object? pickUpGenderList = null,
    Object? dobCustomer = freezed,
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
        dobCustomer:
            freezed == dobCustomer
                ? _value.dobCustomer
                : dobCustomer // ignore: cast_nullable_to_non_nullable
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
    final List<PickUpTypeResponseModal> pickUpCustomerTypeList = const [],
    final List<PickUpTypeResponseModal> pickUpTitileList = const [],
    final List<PickUpTypeResponseModal> pickUpGenderList = const [],
    this.dobCustomer,
  }) : _pickUpCustomerTypeList = pickUpCustomerTypeList,
       _pickUpTitileList = pickUpTitileList,
       _pickUpGenderList = pickUpGenderList;

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

  @override
  final String? dobCustomer;

  @override
  String toString() {
    return 'UserState(slectedBranch: $slectedBranch, selectedCustomerTypeCode: $selectedCustomerTypeCode, isPickupCustomerTypeLoading: $isPickupCustomerTypeLoading, isPickupTitleeLoading: $isPickupTitleeLoading, isPickupGenderLoading: $isPickupGenderLoading, pickUpCustomerTypeList: $pickUpCustomerTypeList, pickUpTitileList: $pickUpTitileList, pickUpGenderList: $pickUpGenderList, dobCustomer: $dobCustomer)';
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
            (identical(other.dobCustomer, dobCustomer) ||
                other.dobCustomer == dobCustomer));
  }

  @override
  int get hashCode => Object.hash(
    runtimeType,
    slectedBranch,
    selectedCustomerTypeCode,
    isPickupCustomerTypeLoading,
    isPickupTitleeLoading,
    isPickupGenderLoading,
    const DeepCollectionEquality().hash(_pickUpCustomerTypeList),
    const DeepCollectionEquality().hash(_pickUpTitileList),
    const DeepCollectionEquality().hash(_pickUpGenderList),
    dobCustomer,
  );

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
    final List<PickUpTypeResponseModal> pickUpCustomerTypeList,
    final List<PickUpTypeResponseModal> pickUpTitileList,
    final List<PickUpTypeResponseModal> pickUpGenderList,
    final String? dobCustomer,
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
  List<PickUpTypeResponseModal> get pickUpCustomerTypeList;
  @override
  List<PickUpTypeResponseModal> get pickUpTitileList;
  @override
  List<PickUpTypeResponseModal> get pickUpGenderList;
  @override
  String? get dobCustomer;

  /// Create a copy of UserState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$NewUserStateImplCopyWith<_$NewUserStateImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
