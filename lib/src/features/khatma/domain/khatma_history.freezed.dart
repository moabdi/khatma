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

CompletionHistory _$CompletionHistoryFromJson(Map<String, dynamic> json) {
  return _KhatmaHistory.fromJson(json);
}

/// @nodoc
mixin _$CompletionHistory {
  String? get khatmaId => throw _privateConstructorUsedError;
  @DateConverter()
  DateTime get startDate => throw _privateConstructorUsedError;
  @DateConverter()
  DateTime get endDate => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $CompletionHistoryCopyWith<CompletionHistory> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $CompletionHistoryCopyWith<$Res> {
  factory $CompletionHistoryCopyWith(
          CompletionHistory value, $Res Function(CompletionHistory) then) =
      _$CompletionHistoryCopyWithImpl<$Res, CompletionHistory>;
  @useResult
  $Res call(
      {String? khatmaId,
      @DateConverter() DateTime startDate,
      @DateConverter() DateTime endDate});
}

/// @nodoc
class _$CompletionHistoryCopyWithImpl<$Res, $Val extends CompletionHistory>
    implements $CompletionHistoryCopyWith<$Res> {
  _$CompletionHistoryCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? khatmaId = freezed,
    Object? startDate = null,
    Object? endDate = null,
  }) {
    return _then(_value.copyWith(
      khatmaId: freezed == khatmaId
          ? _value.khatmaId
          : khatmaId // ignore: cast_nullable_to_non_nullable
              as String?,
      startDate: null == startDate
          ? _value.startDate
          : startDate // ignore: cast_nullable_to_non_nullable
              as DateTime,
      endDate: null == endDate
          ? _value.endDate
          : endDate // ignore: cast_nullable_to_non_nullable
              as DateTime,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$KhatmaHistoryImplCopyWith<$Res>
    implements $CompletionHistoryCopyWith<$Res> {
  factory _$$KhatmaHistoryImplCopyWith(
          _$KhatmaHistoryImpl value, $Res Function(_$KhatmaHistoryImpl) then) =
      __$$KhatmaHistoryImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String? khatmaId,
      @DateConverter() DateTime startDate,
      @DateConverter() DateTime endDate});
}

/// @nodoc
class __$$KhatmaHistoryImplCopyWithImpl<$Res>
    extends _$CompletionHistoryCopyWithImpl<$Res, _$KhatmaHistoryImpl>
    implements _$$KhatmaHistoryImplCopyWith<$Res> {
  __$$KhatmaHistoryImplCopyWithImpl(
      _$KhatmaHistoryImpl _value, $Res Function(_$KhatmaHistoryImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? khatmaId = freezed,
    Object? startDate = null,
    Object? endDate = null,
  }) {
    return _then(_$KhatmaHistoryImpl(
      khatmaId: freezed == khatmaId
          ? _value.khatmaId
          : khatmaId // ignore: cast_nullable_to_non_nullable
              as String?,
      startDate: null == startDate
          ? _value.startDate
          : startDate // ignore: cast_nullable_to_non_nullable
              as DateTime,
      endDate: null == endDate
          ? _value.endDate
          : endDate // ignore: cast_nullable_to_non_nullable
              as DateTime,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$KhatmaHistoryImpl implements _KhatmaHistory {
  const _$KhatmaHistoryImpl(
      {this.khatmaId,
      @DateConverter() required this.startDate,
      @DateConverter() required this.endDate});

  factory _$KhatmaHistoryImpl.fromJson(Map<String, dynamic> json) =>
      _$$KhatmaHistoryImplFromJson(json);

  @override
  final String? khatmaId;
  @override
  @DateConverter()
  final DateTime startDate;
  @override
  @DateConverter()
  final DateTime endDate;

  @override
  String toString() {
    return 'CompletionHistory(khatmaId: $khatmaId, startDate: $startDate, endDate: $endDate)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$KhatmaHistoryImpl &&
            (identical(other.khatmaId, khatmaId) ||
                other.khatmaId == khatmaId) &&
            (identical(other.startDate, startDate) ||
                other.startDate == startDate) &&
            (identical(other.endDate, endDate) || other.endDate == endDate));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, khatmaId, startDate, endDate);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$KhatmaHistoryImplCopyWith<_$KhatmaHistoryImpl> get copyWith =>
      __$$KhatmaHistoryImplCopyWithImpl<_$KhatmaHistoryImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$KhatmaHistoryImplToJson(
      this,
    );
  }
}

abstract class _KhatmaHistory implements CompletionHistory {
  const factory _KhatmaHistory(
      {final String? khatmaId,
      @DateConverter() required final DateTime startDate,
      @DateConverter() required final DateTime endDate}) = _$KhatmaHistoryImpl;

  factory _KhatmaHistory.fromJson(Map<String, dynamic> json) =
      _$KhatmaHistoryImpl.fromJson;

  @override
  String? get khatmaId;
  @override
  @DateConverter()
  DateTime get startDate;
  @override
  @DateConverter()
  DateTime get endDate;
  @override
  @JsonKey(ignore: true)
  _$$KhatmaHistoryImplCopyWith<_$KhatmaHistoryImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
