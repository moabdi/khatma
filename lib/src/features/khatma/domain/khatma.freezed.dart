// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'khatma.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

Khatma _$KhatmaFromJson(Map<String, dynamic> json) {
  return _Khatma.fromJson(json);
}

/// @nodoc
mixin _$Khatma {
  String? get id => throw _privateConstructorUsedError;
  String get name => throw _privateConstructorUsedError;
  String? get description => throw _privateConstructorUsedError;
  DateTime get createDate => throw _privateConstructorUsedError;
  DateTime? get endDate => throw _privateConstructorUsedError;
  String? get creator => throw _privateConstructorUsedError;
  KhatmaStyle get style => throw _privateConstructorUsedError;
  DateTime? get lastRead => throw _privateConstructorUsedError;
  List<KhatmaPart>? get parts => throw _privateConstructorUsedError;
  Recurrence get recurrence => throw _privateConstructorUsedError;
  SplitUnit get unit => throw _privateConstructorUsedError;
  KhatmaShare get share => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $KhatmaCopyWith<Khatma> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $KhatmaCopyWith<$Res> {
  factory $KhatmaCopyWith(Khatma value, $Res Function(Khatma) then) =
      _$KhatmaCopyWithImpl<$Res, Khatma>;
  @useResult
  $Res call(
      {String? id,
      String name,
      String? description,
      DateTime createDate,
      DateTime? endDate,
      String? creator,
      KhatmaStyle style,
      DateTime? lastRead,
      List<KhatmaPart>? parts,
      Recurrence recurrence,
      SplitUnit unit,
      KhatmaShare share});

  $KhatmaStyleCopyWith<$Res> get style;
  $RecurrenceCopyWith<$Res> get recurrence;
  $KhatmaShareCopyWith<$Res> get share;
}

/// @nodoc
class _$KhatmaCopyWithImpl<$Res, $Val extends Khatma>
    implements $KhatmaCopyWith<$Res> {
  _$KhatmaCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = freezed,
    Object? name = null,
    Object? description = freezed,
    Object? createDate = null,
    Object? endDate = freezed,
    Object? creator = freezed,
    Object? style = null,
    Object? lastRead = freezed,
    Object? parts = freezed,
    Object? recurrence = null,
    Object? unit = null,
    Object? share = null,
  }) {
    return _then(_value.copyWith(
      id: freezed == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String?,
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      description: freezed == description
          ? _value.description
          : description // ignore: cast_nullable_to_non_nullable
              as String?,
      createDate: null == createDate
          ? _value.createDate
          : createDate // ignore: cast_nullable_to_non_nullable
              as DateTime,
      endDate: freezed == endDate
          ? _value.endDate
          : endDate // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      creator: freezed == creator
          ? _value.creator
          : creator // ignore: cast_nullable_to_non_nullable
              as String?,
      style: null == style
          ? _value.style
          : style // ignore: cast_nullable_to_non_nullable
              as KhatmaStyle,
      lastRead: freezed == lastRead
          ? _value.lastRead
          : lastRead // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      parts: freezed == parts
          ? _value.parts
          : parts // ignore: cast_nullable_to_non_nullable
              as List<KhatmaPart>?,
      recurrence: null == recurrence
          ? _value.recurrence
          : recurrence // ignore: cast_nullable_to_non_nullable
              as Recurrence,
      unit: null == unit
          ? _value.unit
          : unit // ignore: cast_nullable_to_non_nullable
              as SplitUnit,
      share: null == share
          ? _value.share
          : share // ignore: cast_nullable_to_non_nullable
              as KhatmaShare,
    ) as $Val);
  }

  @override
  @pragma('vm:prefer-inline')
  $KhatmaStyleCopyWith<$Res> get style {
    return $KhatmaStyleCopyWith<$Res>(_value.style, (value) {
      return _then(_value.copyWith(style: value) as $Val);
    });
  }

  @override
  @pragma('vm:prefer-inline')
  $RecurrenceCopyWith<$Res> get recurrence {
    return $RecurrenceCopyWith<$Res>(_value.recurrence, (value) {
      return _then(_value.copyWith(recurrence: value) as $Val);
    });
  }

  @override
  @pragma('vm:prefer-inline')
  $KhatmaShareCopyWith<$Res> get share {
    return $KhatmaShareCopyWith<$Res>(_value.share, (value) {
      return _then(_value.copyWith(share: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$KhatmaImplCopyWith<$Res> implements $KhatmaCopyWith<$Res> {
  factory _$$KhatmaImplCopyWith(
          _$KhatmaImpl value, $Res Function(_$KhatmaImpl) then) =
      __$$KhatmaImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String? id,
      String name,
      String? description,
      DateTime createDate,
      DateTime? endDate,
      String? creator,
      KhatmaStyle style,
      DateTime? lastRead,
      List<KhatmaPart>? parts,
      Recurrence recurrence,
      SplitUnit unit,
      KhatmaShare share});

  @override
  $KhatmaStyleCopyWith<$Res> get style;
  @override
  $RecurrenceCopyWith<$Res> get recurrence;
  @override
  $KhatmaShareCopyWith<$Res> get share;
}

/// @nodoc
class __$$KhatmaImplCopyWithImpl<$Res>
    extends _$KhatmaCopyWithImpl<$Res, _$KhatmaImpl>
    implements _$$KhatmaImplCopyWith<$Res> {
  __$$KhatmaImplCopyWithImpl(
      _$KhatmaImpl _value, $Res Function(_$KhatmaImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = freezed,
    Object? name = null,
    Object? description = freezed,
    Object? createDate = null,
    Object? endDate = freezed,
    Object? creator = freezed,
    Object? style = null,
    Object? lastRead = freezed,
    Object? parts = freezed,
    Object? recurrence = null,
    Object? unit = null,
    Object? share = null,
  }) {
    return _then(_$KhatmaImpl(
      id: freezed == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String?,
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      description: freezed == description
          ? _value.description
          : description // ignore: cast_nullable_to_non_nullable
              as String?,
      createDate: null == createDate
          ? _value.createDate
          : createDate // ignore: cast_nullable_to_non_nullable
              as DateTime,
      endDate: freezed == endDate
          ? _value.endDate
          : endDate // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      creator: freezed == creator
          ? _value.creator
          : creator // ignore: cast_nullable_to_non_nullable
              as String?,
      style: null == style
          ? _value.style
          : style // ignore: cast_nullable_to_non_nullable
              as KhatmaStyle,
      lastRead: freezed == lastRead
          ? _value.lastRead
          : lastRead // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      parts: freezed == parts
          ? _value._parts
          : parts // ignore: cast_nullable_to_non_nullable
              as List<KhatmaPart>?,
      recurrence: null == recurrence
          ? _value.recurrence
          : recurrence // ignore: cast_nullable_to_non_nullable
              as Recurrence,
      unit: null == unit
          ? _value.unit
          : unit // ignore: cast_nullable_to_non_nullable
              as SplitUnit,
      share: null == share
          ? _value.share
          : share // ignore: cast_nullable_to_non_nullable
              as KhatmaShare,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$KhatmaImpl implements _Khatma {
  const _$KhatmaImpl(
      {this.id,
      required this.name,
      this.description,
      required this.createDate,
      this.endDate,
      this.creator,
      required this.style,
      this.lastRead,
      final List<KhatmaPart>? parts,
      required this.recurrence,
      required this.unit,
      required this.share})
      : _parts = parts;

  factory _$KhatmaImpl.fromJson(Map<String, dynamic> json) =>
      _$$KhatmaImplFromJson(json);

  @override
  final String? id;
  @override
  final String name;
  @override
  final String? description;
  @override
  final DateTime createDate;
  @override
  final DateTime? endDate;
  @override
  final String? creator;
  @override
  final KhatmaStyle style;
  @override
  final DateTime? lastRead;
  final List<KhatmaPart>? _parts;
  @override
  List<KhatmaPart>? get parts {
    final value = _parts;
    if (value == null) return null;
    if (_parts is EqualUnmodifiableListView) return _parts;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(value);
  }

  @override
  final Recurrence recurrence;
  @override
  final SplitUnit unit;
  @override
  final KhatmaShare share;

  @override
  String toString() {
    return 'Khatma(id: $id, name: $name, description: $description, createDate: $createDate, endDate: $endDate, creator: $creator, style: $style, lastRead: $lastRead, parts: $parts, recurrence: $recurrence, unit: $unit, share: $share)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$KhatmaImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.description, description) ||
                other.description == description) &&
            (identical(other.createDate, createDate) ||
                other.createDate == createDate) &&
            (identical(other.endDate, endDate) || other.endDate == endDate) &&
            (identical(other.creator, creator) || other.creator == creator) &&
            (identical(other.style, style) || other.style == style) &&
            (identical(other.lastRead, lastRead) ||
                other.lastRead == lastRead) &&
            const DeepCollectionEquality().equals(other._parts, _parts) &&
            (identical(other.recurrence, recurrence) ||
                other.recurrence == recurrence) &&
            (identical(other.unit, unit) || other.unit == unit) &&
            (identical(other.share, share) || other.share == share));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      id,
      name,
      description,
      createDate,
      endDate,
      creator,
      style,
      lastRead,
      const DeepCollectionEquality().hash(_parts),
      recurrence,
      unit,
      share);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$KhatmaImplCopyWith<_$KhatmaImpl> get copyWith =>
      __$$KhatmaImplCopyWithImpl<_$KhatmaImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$KhatmaImplToJson(
      this,
    );
  }
}

abstract class _Khatma implements Khatma {
  const factory _Khatma(
      {final String? id,
      required final String name,
      final String? description,
      required final DateTime createDate,
      final DateTime? endDate,
      final String? creator,
      required final KhatmaStyle style,
      final DateTime? lastRead,
      final List<KhatmaPart>? parts,
      required final Recurrence recurrence,
      required final SplitUnit unit,
      required final KhatmaShare share}) = _$KhatmaImpl;

  factory _Khatma.fromJson(Map<String, dynamic> json) = _$KhatmaImpl.fromJson;

  @override
  String? get id;
  @override
  String get name;
  @override
  String? get description;
  @override
  DateTime get createDate;
  @override
  DateTime? get endDate;
  @override
  String? get creator;
  @override
  KhatmaStyle get style;
  @override
  DateTime? get lastRead;
  @override
  List<KhatmaPart>? get parts;
  @override
  Recurrence get recurrence;
  @override
  SplitUnit get unit;
  @override
  KhatmaShare get share;
  @override
  @JsonKey(ignore: true)
  _$$KhatmaImplCopyWith<_$KhatmaImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

KhatmaStyle _$KhatmaStyleFromJson(Map<String, dynamic> json) {
  return _KhatmaStyle.fromJson(json);
}

/// @nodoc
mixin _$KhatmaStyle {
  String get color => throw _privateConstructorUsedError;
  String get icon => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $KhatmaStyleCopyWith<KhatmaStyle> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $KhatmaStyleCopyWith<$Res> {
  factory $KhatmaStyleCopyWith(
          KhatmaStyle value, $Res Function(KhatmaStyle) then) =
      _$KhatmaStyleCopyWithImpl<$Res, KhatmaStyle>;
  @useResult
  $Res call({String color, String icon});
}

/// @nodoc
class _$KhatmaStyleCopyWithImpl<$Res, $Val extends KhatmaStyle>
    implements $KhatmaStyleCopyWith<$Res> {
  _$KhatmaStyleCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? color = null,
    Object? icon = null,
  }) {
    return _then(_value.copyWith(
      color: null == color
          ? _value.color
          : color // ignore: cast_nullable_to_non_nullable
              as String,
      icon: null == icon
          ? _value.icon
          : icon // ignore: cast_nullable_to_non_nullable
              as String,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$KhatmaStyleImplCopyWith<$Res>
    implements $KhatmaStyleCopyWith<$Res> {
  factory _$$KhatmaStyleImplCopyWith(
          _$KhatmaStyleImpl value, $Res Function(_$KhatmaStyleImpl) then) =
      __$$KhatmaStyleImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String color, String icon});
}

/// @nodoc
class __$$KhatmaStyleImplCopyWithImpl<$Res>
    extends _$KhatmaStyleCopyWithImpl<$Res, _$KhatmaStyleImpl>
    implements _$$KhatmaStyleImplCopyWith<$Res> {
  __$$KhatmaStyleImplCopyWithImpl(
      _$KhatmaStyleImpl _value, $Res Function(_$KhatmaStyleImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? color = null,
    Object? icon = null,
  }) {
    return _then(_$KhatmaStyleImpl(
      color: null == color
          ? _value.color
          : color // ignore: cast_nullable_to_non_nullable
              as String,
      icon: null == icon
          ? _value.icon
          : icon // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$KhatmaStyleImpl implements _KhatmaStyle {
  const _$KhatmaStyleImpl({required this.color, required this.icon});

  factory _$KhatmaStyleImpl.fromJson(Map<String, dynamic> json) =>
      _$$KhatmaStyleImplFromJson(json);

  @override
  final String color;
  @override
  final String icon;

  @override
  String toString() {
    return 'KhatmaStyle(color: $color, icon: $icon)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$KhatmaStyleImpl &&
            (identical(other.color, color) || other.color == color) &&
            (identical(other.icon, icon) || other.icon == icon));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, color, icon);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$KhatmaStyleImplCopyWith<_$KhatmaStyleImpl> get copyWith =>
      __$$KhatmaStyleImplCopyWithImpl<_$KhatmaStyleImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$KhatmaStyleImplToJson(
      this,
    );
  }
}

abstract class _KhatmaStyle implements KhatmaStyle {
  const factory _KhatmaStyle(
      {required final String color,
      required final String icon}) = _$KhatmaStyleImpl;

  factory _KhatmaStyle.fromJson(Map<String, dynamic> json) =
      _$KhatmaStyleImpl.fromJson;

  @override
  String get color;
  @override
  String get icon;
  @override
  @JsonKey(ignore: true)
  _$$KhatmaStyleImplCopyWith<_$KhatmaStyleImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

Recurrence _$RecurrenceFromJson(Map<String, dynamic> json) {
  return _Recurrence.fromJson(json);
}

/// @nodoc
mixin _$Recurrence {
  bool get repeat => throw _privateConstructorUsedError;
  DateTime get startDate => throw _privateConstructorUsedError;
  DateTime get endDate => throw _privateConstructorUsedError;
  RepeatInterval get unit => throw _privateConstructorUsedError;
  List<int>? get days => throw _privateConstructorUsedError;
  int? get frequency => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $RecurrenceCopyWith<Recurrence> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $RecurrenceCopyWith<$Res> {
  factory $RecurrenceCopyWith(
          Recurrence value, $Res Function(Recurrence) then) =
      _$RecurrenceCopyWithImpl<$Res, Recurrence>;
  @useResult
  $Res call(
      {bool repeat,
      DateTime startDate,
      DateTime endDate,
      RepeatInterval unit,
      List<int>? days,
      int? frequency});
}

/// @nodoc
class _$RecurrenceCopyWithImpl<$Res, $Val extends Recurrence>
    implements $RecurrenceCopyWith<$Res> {
  _$RecurrenceCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? repeat = null,
    Object? startDate = null,
    Object? endDate = null,
    Object? unit = null,
    Object? days = freezed,
    Object? frequency = freezed,
  }) {
    return _then(_value.copyWith(
      repeat: null == repeat
          ? _value.repeat
          : repeat // ignore: cast_nullable_to_non_nullable
              as bool,
      startDate: null == startDate
          ? _value.startDate
          : startDate // ignore: cast_nullable_to_non_nullable
              as DateTime,
      endDate: null == endDate
          ? _value.endDate
          : endDate // ignore: cast_nullable_to_non_nullable
              as DateTime,
      unit: null == unit
          ? _value.unit
          : unit // ignore: cast_nullable_to_non_nullable
              as RepeatInterval,
      days: freezed == days
          ? _value.days
          : days // ignore: cast_nullable_to_non_nullable
              as List<int>?,
      frequency: freezed == frequency
          ? _value.frequency
          : frequency // ignore: cast_nullable_to_non_nullable
              as int?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$RecurrenceImplCopyWith<$Res>
    implements $RecurrenceCopyWith<$Res> {
  factory _$$RecurrenceImplCopyWith(
          _$RecurrenceImpl value, $Res Function(_$RecurrenceImpl) then) =
      __$$RecurrenceImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {bool repeat,
      DateTime startDate,
      DateTime endDate,
      RepeatInterval unit,
      List<int>? days,
      int? frequency});
}

/// @nodoc
class __$$RecurrenceImplCopyWithImpl<$Res>
    extends _$RecurrenceCopyWithImpl<$Res, _$RecurrenceImpl>
    implements _$$RecurrenceImplCopyWith<$Res> {
  __$$RecurrenceImplCopyWithImpl(
      _$RecurrenceImpl _value, $Res Function(_$RecurrenceImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? repeat = null,
    Object? startDate = null,
    Object? endDate = null,
    Object? unit = null,
    Object? days = freezed,
    Object? frequency = freezed,
  }) {
    return _then(_$RecurrenceImpl(
      repeat: null == repeat
          ? _value.repeat
          : repeat // ignore: cast_nullable_to_non_nullable
              as bool,
      startDate: null == startDate
          ? _value.startDate
          : startDate // ignore: cast_nullable_to_non_nullable
              as DateTime,
      endDate: null == endDate
          ? _value.endDate
          : endDate // ignore: cast_nullable_to_non_nullable
              as DateTime,
      unit: null == unit
          ? _value.unit
          : unit // ignore: cast_nullable_to_non_nullable
              as RepeatInterval,
      days: freezed == days
          ? _value._days
          : days // ignore: cast_nullable_to_non_nullable
              as List<int>?,
      frequency: freezed == frequency
          ? _value.frequency
          : frequency // ignore: cast_nullable_to_non_nullable
              as int?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$RecurrenceImpl implements _Recurrence {
  const _$RecurrenceImpl(
      {this.repeat = false,
      required this.startDate,
      required this.endDate,
      this.unit = RepeatInterval.auto,
      final List<int>? days,
      this.frequency})
      : _days = days;

  factory _$RecurrenceImpl.fromJson(Map<String, dynamic> json) =>
      _$$RecurrenceImplFromJson(json);

  @override
  @JsonKey()
  final bool repeat;
  @override
  final DateTime startDate;
  @override
  final DateTime endDate;
  @override
  @JsonKey()
  final RepeatInterval unit;
  final List<int>? _days;
  @override
  List<int>? get days {
    final value = _days;
    if (value == null) return null;
    if (_days is EqualUnmodifiableListView) return _days;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(value);
  }

  @override
  final int? frequency;

  @override
  String toString() {
    return 'Recurrence(repeat: $repeat, startDate: $startDate, endDate: $endDate, unit: $unit, days: $days, frequency: $frequency)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$RecurrenceImpl &&
            (identical(other.repeat, repeat) || other.repeat == repeat) &&
            (identical(other.startDate, startDate) ||
                other.startDate == startDate) &&
            (identical(other.endDate, endDate) || other.endDate == endDate) &&
            (identical(other.unit, unit) || other.unit == unit) &&
            const DeepCollectionEquality().equals(other._days, _days) &&
            (identical(other.frequency, frequency) ||
                other.frequency == frequency));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, repeat, startDate, endDate, unit,
      const DeepCollectionEquality().hash(_days), frequency);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$RecurrenceImplCopyWith<_$RecurrenceImpl> get copyWith =>
      __$$RecurrenceImplCopyWithImpl<_$RecurrenceImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$RecurrenceImplToJson(
      this,
    );
  }
}

abstract class _Recurrence implements Recurrence {
  const factory _Recurrence(
      {final bool repeat,
      required final DateTime startDate,
      required final DateTime endDate,
      final RepeatInterval unit,
      final List<int>? days,
      final int? frequency}) = _$RecurrenceImpl;

  factory _Recurrence.fromJson(Map<String, dynamic> json) =
      _$RecurrenceImpl.fromJson;

  @override
  bool get repeat;
  @override
  DateTime get startDate;
  @override
  DateTime get endDate;
  @override
  RepeatInterval get unit;
  @override
  List<int>? get days;
  @override
  int? get frequency;
  @override
  @JsonKey(ignore: true)
  _$$RecurrenceImplCopyWith<_$RecurrenceImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

KhatmaPart _$KhatmaPartFromJson(Map<String, dynamic> json) {
  return _KhatmaPart.fromJson(json);
}

/// @nodoc
mixin _$KhatmaPart {
  int get id => throw _privateConstructorUsedError;
  String? get userId => throw _privateConstructorUsedError;
  String? get userName => throw _privateConstructorUsedError;
  DateTime? get addedDate => throw _privateConstructorUsedError;
  DateTime? get finishedDate => throw _privateConstructorUsedError;
  int? get remindTimes => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $KhatmaPartCopyWith<KhatmaPart> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $KhatmaPartCopyWith<$Res> {
  factory $KhatmaPartCopyWith(
          KhatmaPart value, $Res Function(KhatmaPart) then) =
      _$KhatmaPartCopyWithImpl<$Res, KhatmaPart>;
  @useResult
  $Res call(
      {int id,
      String? userId,
      String? userName,
      DateTime? addedDate,
      DateTime? finishedDate,
      int? remindTimes});
}

/// @nodoc
class _$KhatmaPartCopyWithImpl<$Res, $Val extends KhatmaPart>
    implements $KhatmaPartCopyWith<$Res> {
  _$KhatmaPartCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? userId = freezed,
    Object? userName = freezed,
    Object? addedDate = freezed,
    Object? finishedDate = freezed,
    Object? remindTimes = freezed,
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int,
      userId: freezed == userId
          ? _value.userId
          : userId // ignore: cast_nullable_to_non_nullable
              as String?,
      userName: freezed == userName
          ? _value.userName
          : userName // ignore: cast_nullable_to_non_nullable
              as String?,
      addedDate: freezed == addedDate
          ? _value.addedDate
          : addedDate // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      finishedDate: freezed == finishedDate
          ? _value.finishedDate
          : finishedDate // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      remindTimes: freezed == remindTimes
          ? _value.remindTimes
          : remindTimes // ignore: cast_nullable_to_non_nullable
              as int?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$KhatmaPartImplCopyWith<$Res>
    implements $KhatmaPartCopyWith<$Res> {
  factory _$$KhatmaPartImplCopyWith(
          _$KhatmaPartImpl value, $Res Function(_$KhatmaPartImpl) then) =
      __$$KhatmaPartImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {int id,
      String? userId,
      String? userName,
      DateTime? addedDate,
      DateTime? finishedDate,
      int? remindTimes});
}

/// @nodoc
class __$$KhatmaPartImplCopyWithImpl<$Res>
    extends _$KhatmaPartCopyWithImpl<$Res, _$KhatmaPartImpl>
    implements _$$KhatmaPartImplCopyWith<$Res> {
  __$$KhatmaPartImplCopyWithImpl(
      _$KhatmaPartImpl _value, $Res Function(_$KhatmaPartImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? userId = freezed,
    Object? userName = freezed,
    Object? addedDate = freezed,
    Object? finishedDate = freezed,
    Object? remindTimes = freezed,
  }) {
    return _then(_$KhatmaPartImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int,
      userId: freezed == userId
          ? _value.userId
          : userId // ignore: cast_nullable_to_non_nullable
              as String?,
      userName: freezed == userName
          ? _value.userName
          : userName // ignore: cast_nullable_to_non_nullable
              as String?,
      addedDate: freezed == addedDate
          ? _value.addedDate
          : addedDate // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      finishedDate: freezed == finishedDate
          ? _value.finishedDate
          : finishedDate // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      remindTimes: freezed == remindTimes
          ? _value.remindTimes
          : remindTimes // ignore: cast_nullable_to_non_nullable
              as int?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$KhatmaPartImpl implements _KhatmaPart {
  const _$KhatmaPartImpl(
      {required this.id,
      this.userId,
      this.userName,
      this.addedDate,
      this.finishedDate,
      this.remindTimes});

  factory _$KhatmaPartImpl.fromJson(Map<String, dynamic> json) =>
      _$$KhatmaPartImplFromJson(json);

  @override
  final int id;
  @override
  final String? userId;
  @override
  final String? userName;
  @override
  final DateTime? addedDate;
  @override
  final DateTime? finishedDate;
  @override
  final int? remindTimes;

  @override
  String toString() {
    return 'KhatmaPart(id: $id, userId: $userId, userName: $userName, addedDate: $addedDate, finishedDate: $finishedDate, remindTimes: $remindTimes)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$KhatmaPartImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.userId, userId) || other.userId == userId) &&
            (identical(other.userName, userName) ||
                other.userName == userName) &&
            (identical(other.addedDate, addedDate) ||
                other.addedDate == addedDate) &&
            (identical(other.finishedDate, finishedDate) ||
                other.finishedDate == finishedDate) &&
            (identical(other.remindTimes, remindTimes) ||
                other.remindTimes == remindTimes));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType, id, userId, userName, addedDate, finishedDate, remindTimes);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$KhatmaPartImplCopyWith<_$KhatmaPartImpl> get copyWith =>
      __$$KhatmaPartImplCopyWithImpl<_$KhatmaPartImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$KhatmaPartImplToJson(
      this,
    );
  }
}

abstract class _KhatmaPart implements KhatmaPart {
  const factory _KhatmaPart(
      {required final int id,
      final String? userId,
      final String? userName,
      final DateTime? addedDate,
      final DateTime? finishedDate,
      final int? remindTimes}) = _$KhatmaPartImpl;

  factory _KhatmaPart.fromJson(Map<String, dynamic> json) =
      _$KhatmaPartImpl.fromJson;

  @override
  int get id;
  @override
  String? get userId;
  @override
  String? get userName;
  @override
  DateTime? get addedDate;
  @override
  DateTime? get finishedDate;
  @override
  int? get remindTimes;
  @override
  @JsonKey(ignore: true)
  _$$KhatmaPartImplCopyWith<_$KhatmaPartImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

KhatmaShare _$KhatmaShareFromJson(Map<String, dynamic> json) {
  return _KhatmaShare.fromJson(json);
}

/// @nodoc
mixin _$KhatmaShare {
  ShareVisibility get visibility => throw _privateConstructorUsedError;
  int? get maxPartToRead => throw _privateConstructorUsedError;
  int? get maxPartToReserve => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $KhatmaShareCopyWith<KhatmaShare> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $KhatmaShareCopyWith<$Res> {
  factory $KhatmaShareCopyWith(
          KhatmaShare value, $Res Function(KhatmaShare) then) =
      _$KhatmaShareCopyWithImpl<$Res, KhatmaShare>;
  @useResult
  $Res call(
      {ShareVisibility visibility, int? maxPartToRead, int? maxPartToReserve});
}

/// @nodoc
class _$KhatmaShareCopyWithImpl<$Res, $Val extends KhatmaShare>
    implements $KhatmaShareCopyWith<$Res> {
  _$KhatmaShareCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? visibility = null,
    Object? maxPartToRead = freezed,
    Object? maxPartToReserve = freezed,
  }) {
    return _then(_value.copyWith(
      visibility: null == visibility
          ? _value.visibility
          : visibility // ignore: cast_nullable_to_non_nullable
              as ShareVisibility,
      maxPartToRead: freezed == maxPartToRead
          ? _value.maxPartToRead
          : maxPartToRead // ignore: cast_nullable_to_non_nullable
              as int?,
      maxPartToReserve: freezed == maxPartToReserve
          ? _value.maxPartToReserve
          : maxPartToReserve // ignore: cast_nullable_to_non_nullable
              as int?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$KhatmaShareImplCopyWith<$Res>
    implements $KhatmaShareCopyWith<$Res> {
  factory _$$KhatmaShareImplCopyWith(
          _$KhatmaShareImpl value, $Res Function(_$KhatmaShareImpl) then) =
      __$$KhatmaShareImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {ShareVisibility visibility, int? maxPartToRead, int? maxPartToReserve});
}

/// @nodoc
class __$$KhatmaShareImplCopyWithImpl<$Res>
    extends _$KhatmaShareCopyWithImpl<$Res, _$KhatmaShareImpl>
    implements _$$KhatmaShareImplCopyWith<$Res> {
  __$$KhatmaShareImplCopyWithImpl(
      _$KhatmaShareImpl _value, $Res Function(_$KhatmaShareImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? visibility = null,
    Object? maxPartToRead = freezed,
    Object? maxPartToReserve = freezed,
  }) {
    return _then(_$KhatmaShareImpl(
      visibility: null == visibility
          ? _value.visibility
          : visibility // ignore: cast_nullable_to_non_nullable
              as ShareVisibility,
      maxPartToRead: freezed == maxPartToRead
          ? _value.maxPartToRead
          : maxPartToRead // ignore: cast_nullable_to_non_nullable
              as int?,
      maxPartToReserve: freezed == maxPartToReserve
          ? _value.maxPartToReserve
          : maxPartToReserve // ignore: cast_nullable_to_non_nullable
              as int?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$KhatmaShareImpl implements _KhatmaShare {
  const _$KhatmaShareImpl(
      {required this.visibility, this.maxPartToRead, this.maxPartToReserve});

  factory _$KhatmaShareImpl.fromJson(Map<String, dynamic> json) =>
      _$$KhatmaShareImplFromJson(json);

  @override
  final ShareVisibility visibility;
  @override
  final int? maxPartToRead;
  @override
  final int? maxPartToReserve;

  @override
  String toString() {
    return 'KhatmaShare(visibility: $visibility, maxPartToRead: $maxPartToRead, maxPartToReserve: $maxPartToReserve)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$KhatmaShareImpl &&
            (identical(other.visibility, visibility) ||
                other.visibility == visibility) &&
            (identical(other.maxPartToRead, maxPartToRead) ||
                other.maxPartToRead == maxPartToRead) &&
            (identical(other.maxPartToReserve, maxPartToReserve) ||
                other.maxPartToReserve == maxPartToReserve));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode =>
      Object.hash(runtimeType, visibility, maxPartToRead, maxPartToReserve);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$KhatmaShareImplCopyWith<_$KhatmaShareImpl> get copyWith =>
      __$$KhatmaShareImplCopyWithImpl<_$KhatmaShareImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$KhatmaShareImplToJson(
      this,
    );
  }
}

abstract class _KhatmaShare implements KhatmaShare {
  const factory _KhatmaShare(
      {required final ShareVisibility visibility,
      final int? maxPartToRead,
      final int? maxPartToReserve}) = _$KhatmaShareImpl;

  factory _KhatmaShare.fromJson(Map<String, dynamic> json) =
      _$KhatmaShareImpl.fromJson;

  @override
  ShareVisibility get visibility;
  @override
  int? get maxPartToRead;
  @override
  int? get maxPartToReserve;
  @override
  @JsonKey(ignore: true)
  _$$KhatmaShareImplCopyWith<_$KhatmaShareImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
