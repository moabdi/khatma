// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'khatma_history.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

KhatmaHistory _$KhatmaHistoryFromJson(Map<String, dynamic> json) {
  switch (json['runtimeType']) {
    case 'private':
      return PrivateKhatmaHistory.fromJson(json);
    case 'shared':
      return SharedKhatmaHistory.fromJson(json);

    default:
      throw CheckedFromJsonException(json, 'runtimeType', 'KhatmaHistory',
          'Invalid union type "${json['runtimeType']}"!');
  }
}

/// @nodoc
mixin _$KhatmaHistory {
  String get id => throw _privateConstructorUsedError;
  SplitUnit get unit => throw _privateConstructorUsedError;
  @DateConverter()
  DateTime get startDate => throw _privateConstructorUsedError;
  @DateConverter()
  DateTime get endDate => throw _privateConstructorUsedError;
  String get userId => throw _privateConstructorUsedError;
  Object get parts => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(
            String id,
            SplitUnit unit,
            @DateConverter() DateTime startDate,
            @DateConverter() DateTime endDate,
            String userId,
            List<KhatmaPartHistory> parts)
        private,
    required TResult Function(
            String id,
            SplitUnit unit,
            @DateConverter() DateTime startDate,
            @DateConverter() DateTime endDate,
            String userId,
            Map<String, List<KhatmaPartHistory>> parts)
        shared,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(
            String id,
            SplitUnit unit,
            @DateConverter() DateTime startDate,
            @DateConverter() DateTime endDate,
            String userId,
            List<KhatmaPartHistory> parts)?
        private,
    TResult? Function(
            String id,
            SplitUnit unit,
            @DateConverter() DateTime startDate,
            @DateConverter() DateTime endDate,
            String userId,
            Map<String, List<KhatmaPartHistory>> parts)?
        shared,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(
            String id,
            SplitUnit unit,
            @DateConverter() DateTime startDate,
            @DateConverter() DateTime endDate,
            String userId,
            List<KhatmaPartHistory> parts)?
        private,
    TResult Function(
            String id,
            SplitUnit unit,
            @DateConverter() DateTime startDate,
            @DateConverter() DateTime endDate,
            String userId,
            Map<String, List<KhatmaPartHistory>> parts)?
        shared,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(PrivateKhatmaHistory value) private,
    required TResult Function(SharedKhatmaHistory value) shared,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(PrivateKhatmaHistory value)? private,
    TResult? Function(SharedKhatmaHistory value)? shared,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(PrivateKhatmaHistory value)? private,
    TResult Function(SharedKhatmaHistory value)? shared,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $KhatmaHistoryCopyWith<KhatmaHistory> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $KhatmaHistoryCopyWith<$Res> {
  factory $KhatmaHistoryCopyWith(
          KhatmaHistory value, $Res Function(KhatmaHistory) then) =
      _$KhatmaHistoryCopyWithImpl<$Res, KhatmaHistory>;
  @useResult
  $Res call(
      {String id,
      SplitUnit unit,
      @DateConverter() DateTime startDate,
      @DateConverter() DateTime endDate,
      String userId});
}

/// @nodoc
class _$KhatmaHistoryCopyWithImpl<$Res, $Val extends KhatmaHistory>
    implements $KhatmaHistoryCopyWith<$Res> {
  _$KhatmaHistoryCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? unit = null,
    Object? startDate = null,
    Object? endDate = null,
    Object? userId = null,
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      unit: null == unit
          ? _value.unit
          : unit // ignore: cast_nullable_to_non_nullable
              as SplitUnit,
      startDate: null == startDate
          ? _value.startDate
          : startDate // ignore: cast_nullable_to_non_nullable
              as DateTime,
      endDate: null == endDate
          ? _value.endDate
          : endDate // ignore: cast_nullable_to_non_nullable
              as DateTime,
      userId: null == userId
          ? _value.userId
          : userId // ignore: cast_nullable_to_non_nullable
              as String,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$PrivateKhatmaHistoryImplCopyWith<$Res>
    implements $KhatmaHistoryCopyWith<$Res> {
  factory _$$PrivateKhatmaHistoryImplCopyWith(_$PrivateKhatmaHistoryImpl value,
          $Res Function(_$PrivateKhatmaHistoryImpl) then) =
      __$$PrivateKhatmaHistoryImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String id,
      SplitUnit unit,
      @DateConverter() DateTime startDate,
      @DateConverter() DateTime endDate,
      String userId,
      List<KhatmaPartHistory> parts});
}

/// @nodoc
class __$$PrivateKhatmaHistoryImplCopyWithImpl<$Res>
    extends _$KhatmaHistoryCopyWithImpl<$Res, _$PrivateKhatmaHistoryImpl>
    implements _$$PrivateKhatmaHistoryImplCopyWith<$Res> {
  __$$PrivateKhatmaHistoryImplCopyWithImpl(_$PrivateKhatmaHistoryImpl _value,
      $Res Function(_$PrivateKhatmaHistoryImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? unit = null,
    Object? startDate = null,
    Object? endDate = null,
    Object? userId = null,
    Object? parts = null,
  }) {
    return _then(_$PrivateKhatmaHistoryImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      unit: null == unit
          ? _value.unit
          : unit // ignore: cast_nullable_to_non_nullable
              as SplitUnit,
      startDate: null == startDate
          ? _value.startDate
          : startDate // ignore: cast_nullable_to_non_nullable
              as DateTime,
      endDate: null == endDate
          ? _value.endDate
          : endDate // ignore: cast_nullable_to_non_nullable
              as DateTime,
      userId: null == userId
          ? _value.userId
          : userId // ignore: cast_nullable_to_non_nullable
              as String,
      parts: null == parts
          ? _value._parts
          : parts // ignore: cast_nullable_to_non_nullable
              as List<KhatmaPartHistory>,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$PrivateKhatmaHistoryImpl implements PrivateKhatmaHistory {
  const _$PrivateKhatmaHistoryImpl(
      {required this.id,
      required this.unit,
      @DateConverter() required this.startDate,
      @DateConverter() required this.endDate,
      required this.userId,
      required final List<KhatmaPartHistory> parts,
      final String? $type})
      : _parts = parts,
        $type = $type ?? 'private';

  factory _$PrivateKhatmaHistoryImpl.fromJson(Map<String, dynamic> json) =>
      _$$PrivateKhatmaHistoryImplFromJson(json);

  @override
  final String id;
  @override
  final SplitUnit unit;
  @override
  @DateConverter()
  final DateTime startDate;
  @override
  @DateConverter()
  final DateTime endDate;
  @override
  final String userId;
  final List<KhatmaPartHistory> _parts;
  @override
  List<KhatmaPartHistory> get parts {
    if (_parts is EqualUnmodifiableListView) return _parts;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_parts);
  }

  @JsonKey(name: 'runtimeType')
  final String $type;

  @override
  String toString() {
    return 'KhatmaHistory.private(id: $id, unit: $unit, startDate: $startDate, endDate: $endDate, userId: $userId, parts: $parts)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$PrivateKhatmaHistoryImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.unit, unit) || other.unit == unit) &&
            (identical(other.startDate, startDate) ||
                other.startDate == startDate) &&
            (identical(other.endDate, endDate) || other.endDate == endDate) &&
            (identical(other.userId, userId) || other.userId == userId) &&
            const DeepCollectionEquality().equals(other._parts, _parts));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, id, unit, startDate, endDate,
      userId, const DeepCollectionEquality().hash(_parts));

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$PrivateKhatmaHistoryImplCopyWith<_$PrivateKhatmaHistoryImpl>
      get copyWith =>
          __$$PrivateKhatmaHistoryImplCopyWithImpl<_$PrivateKhatmaHistoryImpl>(
              this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(
            String id,
            SplitUnit unit,
            @DateConverter() DateTime startDate,
            @DateConverter() DateTime endDate,
            String userId,
            List<KhatmaPartHistory> parts)
        private,
    required TResult Function(
            String id,
            SplitUnit unit,
            @DateConverter() DateTime startDate,
            @DateConverter() DateTime endDate,
            String userId,
            Map<String, List<KhatmaPartHistory>> parts)
        shared,
  }) {
    return private(id, unit, startDate, endDate, userId, parts);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(
            String id,
            SplitUnit unit,
            @DateConverter() DateTime startDate,
            @DateConverter() DateTime endDate,
            String userId,
            List<KhatmaPartHistory> parts)?
        private,
    TResult? Function(
            String id,
            SplitUnit unit,
            @DateConverter() DateTime startDate,
            @DateConverter() DateTime endDate,
            String userId,
            Map<String, List<KhatmaPartHistory>> parts)?
        shared,
  }) {
    return private?.call(id, unit, startDate, endDate, userId, parts);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(
            String id,
            SplitUnit unit,
            @DateConverter() DateTime startDate,
            @DateConverter() DateTime endDate,
            String userId,
            List<KhatmaPartHistory> parts)?
        private,
    TResult Function(
            String id,
            SplitUnit unit,
            @DateConverter() DateTime startDate,
            @DateConverter() DateTime endDate,
            String userId,
            Map<String, List<KhatmaPartHistory>> parts)?
        shared,
    required TResult orElse(),
  }) {
    if (private != null) {
      return private(id, unit, startDate, endDate, userId, parts);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(PrivateKhatmaHistory value) private,
    required TResult Function(SharedKhatmaHistory value) shared,
  }) {
    return private(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(PrivateKhatmaHistory value)? private,
    TResult? Function(SharedKhatmaHistory value)? shared,
  }) {
    return private?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(PrivateKhatmaHistory value)? private,
    TResult Function(SharedKhatmaHistory value)? shared,
    required TResult orElse(),
  }) {
    if (private != null) {
      return private(this);
    }
    return orElse();
  }

  @override
  Map<String, dynamic> toJson() {
    return _$$PrivateKhatmaHistoryImplToJson(
      this,
    );
  }
}

abstract class PrivateKhatmaHistory implements KhatmaHistory {
  const factory PrivateKhatmaHistory(
          {required final String id,
          required final SplitUnit unit,
          @DateConverter() required final DateTime startDate,
          @DateConverter() required final DateTime endDate,
          required final String userId,
          required final List<KhatmaPartHistory> parts}) =
      _$PrivateKhatmaHistoryImpl;

  factory PrivateKhatmaHistory.fromJson(Map<String, dynamic> json) =
      _$PrivateKhatmaHistoryImpl.fromJson;

  @override
  String get id;
  @override
  SplitUnit get unit;
  @override
  @DateConverter()
  DateTime get startDate;
  @override
  @DateConverter()
  DateTime get endDate;
  @override
  String get userId;
  @override
  List<KhatmaPartHistory> get parts;
  @override
  @JsonKey(ignore: true)
  _$$PrivateKhatmaHistoryImplCopyWith<_$PrivateKhatmaHistoryImpl>
      get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$SharedKhatmaHistoryImplCopyWith<$Res>
    implements $KhatmaHistoryCopyWith<$Res> {
  factory _$$SharedKhatmaHistoryImplCopyWith(_$SharedKhatmaHistoryImpl value,
          $Res Function(_$SharedKhatmaHistoryImpl) then) =
      __$$SharedKhatmaHistoryImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String id,
      SplitUnit unit,
      @DateConverter() DateTime startDate,
      @DateConverter() DateTime endDate,
      String userId,
      Map<String, List<KhatmaPartHistory>> parts});
}

/// @nodoc
class __$$SharedKhatmaHistoryImplCopyWithImpl<$Res>
    extends _$KhatmaHistoryCopyWithImpl<$Res, _$SharedKhatmaHistoryImpl>
    implements _$$SharedKhatmaHistoryImplCopyWith<$Res> {
  __$$SharedKhatmaHistoryImplCopyWithImpl(_$SharedKhatmaHistoryImpl _value,
      $Res Function(_$SharedKhatmaHistoryImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? unit = null,
    Object? startDate = null,
    Object? endDate = null,
    Object? userId = null,
    Object? parts = null,
  }) {
    return _then(_$SharedKhatmaHistoryImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      unit: null == unit
          ? _value.unit
          : unit // ignore: cast_nullable_to_non_nullable
              as SplitUnit,
      startDate: null == startDate
          ? _value.startDate
          : startDate // ignore: cast_nullable_to_non_nullable
              as DateTime,
      endDate: null == endDate
          ? _value.endDate
          : endDate // ignore: cast_nullable_to_non_nullable
              as DateTime,
      userId: null == userId
          ? _value.userId
          : userId // ignore: cast_nullable_to_non_nullable
              as String,
      parts: null == parts
          ? _value._parts
          : parts // ignore: cast_nullable_to_non_nullable
              as Map<String, List<KhatmaPartHistory>>,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$SharedKhatmaHistoryImpl implements SharedKhatmaHistory {
  const _$SharedKhatmaHistoryImpl(
      {required this.id,
      required this.unit,
      @DateConverter() required this.startDate,
      @DateConverter() required this.endDate,
      required this.userId,
      required final Map<String, List<KhatmaPartHistory>> parts,
      final String? $type})
      : _parts = parts,
        $type = $type ?? 'shared';

  factory _$SharedKhatmaHistoryImpl.fromJson(Map<String, dynamic> json) =>
      _$$SharedKhatmaHistoryImplFromJson(json);

  @override
  final String id;
  @override
  final SplitUnit unit;
  @override
  @DateConverter()
  final DateTime startDate;
  @override
  @DateConverter()
  final DateTime endDate;
  @override
  final String userId;
  final Map<String, List<KhatmaPartHistory>> _parts;
  @override
  Map<String, List<KhatmaPartHistory>> get parts {
    if (_parts is EqualUnmodifiableMapView) return _parts;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableMapView(_parts);
  }

  @JsonKey(name: 'runtimeType')
  final String $type;

  @override
  String toString() {
    return 'KhatmaHistory.shared(id: $id, unit: $unit, startDate: $startDate, endDate: $endDate, userId: $userId, parts: $parts)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$SharedKhatmaHistoryImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.unit, unit) || other.unit == unit) &&
            (identical(other.startDate, startDate) ||
                other.startDate == startDate) &&
            (identical(other.endDate, endDate) || other.endDate == endDate) &&
            (identical(other.userId, userId) || other.userId == userId) &&
            const DeepCollectionEquality().equals(other._parts, _parts));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, id, unit, startDate, endDate,
      userId, const DeepCollectionEquality().hash(_parts));

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$SharedKhatmaHistoryImplCopyWith<_$SharedKhatmaHistoryImpl> get copyWith =>
      __$$SharedKhatmaHistoryImplCopyWithImpl<_$SharedKhatmaHistoryImpl>(
          this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(
            String id,
            SplitUnit unit,
            @DateConverter() DateTime startDate,
            @DateConverter() DateTime endDate,
            String userId,
            List<KhatmaPartHistory> parts)
        private,
    required TResult Function(
            String id,
            SplitUnit unit,
            @DateConverter() DateTime startDate,
            @DateConverter() DateTime endDate,
            String userId,
            Map<String, List<KhatmaPartHistory>> parts)
        shared,
  }) {
    return shared(id, unit, startDate, endDate, userId, parts);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(
            String id,
            SplitUnit unit,
            @DateConverter() DateTime startDate,
            @DateConverter() DateTime endDate,
            String userId,
            List<KhatmaPartHistory> parts)?
        private,
    TResult? Function(
            String id,
            SplitUnit unit,
            @DateConverter() DateTime startDate,
            @DateConverter() DateTime endDate,
            String userId,
            Map<String, List<KhatmaPartHistory>> parts)?
        shared,
  }) {
    return shared?.call(id, unit, startDate, endDate, userId, parts);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(
            String id,
            SplitUnit unit,
            @DateConverter() DateTime startDate,
            @DateConverter() DateTime endDate,
            String userId,
            List<KhatmaPartHistory> parts)?
        private,
    TResult Function(
            String id,
            SplitUnit unit,
            @DateConverter() DateTime startDate,
            @DateConverter() DateTime endDate,
            String userId,
            Map<String, List<KhatmaPartHistory>> parts)?
        shared,
    required TResult orElse(),
  }) {
    if (shared != null) {
      return shared(id, unit, startDate, endDate, userId, parts);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(PrivateKhatmaHistory value) private,
    required TResult Function(SharedKhatmaHistory value) shared,
  }) {
    return shared(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(PrivateKhatmaHistory value)? private,
    TResult? Function(SharedKhatmaHistory value)? shared,
  }) {
    return shared?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(PrivateKhatmaHistory value)? private,
    TResult Function(SharedKhatmaHistory value)? shared,
    required TResult orElse(),
  }) {
    if (shared != null) {
      return shared(this);
    }
    return orElse();
  }

  @override
  Map<String, dynamic> toJson() {
    return _$$SharedKhatmaHistoryImplToJson(
      this,
    );
  }
}

abstract class SharedKhatmaHistory implements KhatmaHistory {
  const factory SharedKhatmaHistory(
          {required final String id,
          required final SplitUnit unit,
          @DateConverter() required final DateTime startDate,
          @DateConverter() required final DateTime endDate,
          required final String userId,
          required final Map<String, List<KhatmaPartHistory>> parts}) =
      _$SharedKhatmaHistoryImpl;

  factory SharedKhatmaHistory.fromJson(Map<String, dynamic> json) =
      _$SharedKhatmaHistoryImpl.fromJson;

  @override
  String get id;
  @override
  SplitUnit get unit;
  @override
  @DateConverter()
  DateTime get startDate;
  @override
  @DateConverter()
  DateTime get endDate;
  @override
  String get userId;
  @override
  Map<String, List<KhatmaPartHistory>> get parts;
  @override
  @JsonKey(ignore: true)
  _$$SharedKhatmaHistoryImplCopyWith<_$SharedKhatmaHistoryImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

KhatmaPartHistory _$KhatmaPartHistoryFromJson(Map<String, dynamic> json) {
  return _KhatmaPartHistory.fromJson(json);
}

/// @nodoc
mixin _$KhatmaPartHistory {
  int get id => throw _privateConstructorUsedError;
  @DateConverter()
  DateTime get endDate => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $KhatmaPartHistoryCopyWith<KhatmaPartHistory> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $KhatmaPartHistoryCopyWith<$Res> {
  factory $KhatmaPartHistoryCopyWith(
          KhatmaPartHistory value, $Res Function(KhatmaPartHistory) then) =
      _$KhatmaPartHistoryCopyWithImpl<$Res, KhatmaPartHistory>;
  @useResult
  $Res call({int id, @DateConverter() DateTime endDate});
}

/// @nodoc
class _$KhatmaPartHistoryCopyWithImpl<$Res, $Val extends KhatmaPartHistory>
    implements $KhatmaPartHistoryCopyWith<$Res> {
  _$KhatmaPartHistoryCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? endDate = null,
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int,
      endDate: null == endDate
          ? _value.endDate
          : endDate // ignore: cast_nullable_to_non_nullable
              as DateTime,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$KhatmaPartHistoryImplCopyWith<$Res>
    implements $KhatmaPartHistoryCopyWith<$Res> {
  factory _$$KhatmaPartHistoryImplCopyWith(_$KhatmaPartHistoryImpl value,
          $Res Function(_$KhatmaPartHistoryImpl) then) =
      __$$KhatmaPartHistoryImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({int id, @DateConverter() DateTime endDate});
}

/// @nodoc
class __$$KhatmaPartHistoryImplCopyWithImpl<$Res>
    extends _$KhatmaPartHistoryCopyWithImpl<$Res, _$KhatmaPartHistoryImpl>
    implements _$$KhatmaPartHistoryImplCopyWith<$Res> {
  __$$KhatmaPartHistoryImplCopyWithImpl(_$KhatmaPartHistoryImpl _value,
      $Res Function(_$KhatmaPartHistoryImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? endDate = null,
  }) {
    return _then(_$KhatmaPartHistoryImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int,
      endDate: null == endDate
          ? _value.endDate
          : endDate // ignore: cast_nullable_to_non_nullable
              as DateTime,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$KhatmaPartHistoryImpl implements _KhatmaPartHistory {
  const _$KhatmaPartHistoryImpl(
      {required this.id, @DateConverter() required this.endDate});

  factory _$KhatmaPartHistoryImpl.fromJson(Map<String, dynamic> json) =>
      _$$KhatmaPartHistoryImplFromJson(json);

  @override
  final int id;
  @override
  @DateConverter()
  final DateTime endDate;

  @override
  String toString() {
    return 'KhatmaPartHistory(id: $id, endDate: $endDate)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$KhatmaPartHistoryImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.endDate, endDate) || other.endDate == endDate));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, id, endDate);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$KhatmaPartHistoryImplCopyWith<_$KhatmaPartHistoryImpl> get copyWith =>
      __$$KhatmaPartHistoryImplCopyWithImpl<_$KhatmaPartHistoryImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$KhatmaPartHistoryImplToJson(
      this,
    );
  }
}

abstract class _KhatmaPartHistory implements KhatmaPartHistory {
  const factory _KhatmaPartHistory(
          {required final int id,
          @DateConverter() required final DateTime endDate}) =
      _$KhatmaPartHistoryImpl;

  factory _KhatmaPartHistory.fromJson(Map<String, dynamic> json) =
      _$KhatmaPartHistoryImpl.fromJson;

  @override
  int get id;
  @override
  @DateConverter()
  DateTime get endDate;
  @override
  @JsonKey(ignore: true)
  _$$KhatmaPartHistoryImplCopyWith<_$KhatmaPartHistoryImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
