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
  @JsonKey(includeFromJson: true, includeToJson: false)
  String? get id => throw _privateConstructorUsedError;
  String get code => throw _privateConstructorUsedError;
  String get name => throw _privateConstructorUsedError;
  SplitUnit get unit => throw _privateConstructorUsedError;
  DateTime get createDate => throw _privateConstructorUsedError;
  DateTime get startDate => throw _privateConstructorUsedError;
  String? get description => throw _privateConstructorUsedError;
  int get repeats => throw _privateConstructorUsedError;
  Recurrence? get recurrence => throw _privateConstructorUsedError;
  KhatmaShare? get share => throw _privateConstructorUsedError;
  KhatmaTheme? get theme => throw _privateConstructorUsedError;
  DateTime? get endDate => throw _privateConstructorUsedError;
  DateTime? get lastRead => throw _privateConstructorUsedError;
  List<KhatmaPart>? get parts => throw _privateConstructorUsedError;

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
      {@JsonKey(includeFromJson: true, includeToJson: false) String? id,
      String code,
      String name,
      SplitUnit unit,
      DateTime createDate,
      DateTime startDate,
      String? description,
      int repeats,
      Recurrence? recurrence,
      KhatmaShare? share,
      KhatmaTheme? theme,
      DateTime? endDate,
      DateTime? lastRead,
      List<KhatmaPart>? parts});

  $RecurrenceCopyWith<$Res>? get recurrence;
  $KhatmaShareCopyWith<$Res>? get share;
  $KhatmaThemeCopyWith<$Res>? get theme;
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
    Object? code = null,
    Object? name = null,
    Object? unit = null,
    Object? createDate = null,
    Object? startDate = null,
    Object? description = freezed,
    Object? repeats = null,
    Object? recurrence = freezed,
    Object? share = freezed,
    Object? theme = freezed,
    Object? endDate = freezed,
    Object? lastRead = freezed,
    Object? parts = freezed,
  }) {
    return _then(_value.copyWith(
      id: freezed == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String?,
      code: null == code
          ? _value.code
          : code // ignore: cast_nullable_to_non_nullable
              as String,
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      unit: null == unit
          ? _value.unit
          : unit // ignore: cast_nullable_to_non_nullable
              as SplitUnit,
      createDate: null == createDate
          ? _value.createDate
          : createDate // ignore: cast_nullable_to_non_nullable
              as DateTime,
      startDate: null == startDate
          ? _value.startDate
          : startDate // ignore: cast_nullable_to_non_nullable
              as DateTime,
      description: freezed == description
          ? _value.description
          : description // ignore: cast_nullable_to_non_nullable
              as String?,
      repeats: null == repeats
          ? _value.repeats
          : repeats // ignore: cast_nullable_to_non_nullable
              as int,
      recurrence: freezed == recurrence
          ? _value.recurrence
          : recurrence // ignore: cast_nullable_to_non_nullable
              as Recurrence?,
      share: freezed == share
          ? _value.share
          : share // ignore: cast_nullable_to_non_nullable
              as KhatmaShare?,
      theme: freezed == theme
          ? _value.theme
          : theme // ignore: cast_nullable_to_non_nullable
              as KhatmaTheme?,
      endDate: freezed == endDate
          ? _value.endDate
          : endDate // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      lastRead: freezed == lastRead
          ? _value.lastRead
          : lastRead // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      parts: freezed == parts
          ? _value.parts
          : parts // ignore: cast_nullable_to_non_nullable
              as List<KhatmaPart>?,
    ) as $Val);
  }

  @override
  @pragma('vm:prefer-inline')
  $RecurrenceCopyWith<$Res>? get recurrence {
    if (_value.recurrence == null) {
      return null;
    }

    return $RecurrenceCopyWith<$Res>(_value.recurrence!, (value) {
      return _then(_value.copyWith(recurrence: value) as $Val);
    });
  }

  @override
  @pragma('vm:prefer-inline')
  $KhatmaShareCopyWith<$Res>? get share {
    if (_value.share == null) {
      return null;
    }

    return $KhatmaShareCopyWith<$Res>(_value.share!, (value) {
      return _then(_value.copyWith(share: value) as $Val);
    });
  }

  @override
  @pragma('vm:prefer-inline')
  $KhatmaThemeCopyWith<$Res>? get theme {
    if (_value.theme == null) {
      return null;
    }

    return $KhatmaThemeCopyWith<$Res>(_value.theme!, (value) {
      return _then(_value.copyWith(theme: value) as $Val);
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
      {@JsonKey(includeFromJson: true, includeToJson: false) String? id,
      String code,
      String name,
      SplitUnit unit,
      DateTime createDate,
      DateTime startDate,
      String? description,
      int repeats,
      Recurrence? recurrence,
      KhatmaShare? share,
      KhatmaTheme? theme,
      DateTime? endDate,
      DateTime? lastRead,
      List<KhatmaPart>? parts});

  @override
  $RecurrenceCopyWith<$Res>? get recurrence;
  @override
  $KhatmaShareCopyWith<$Res>? get share;
  @override
  $KhatmaThemeCopyWith<$Res>? get theme;
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
    Object? code = null,
    Object? name = null,
    Object? unit = null,
    Object? createDate = null,
    Object? startDate = null,
    Object? description = freezed,
    Object? repeats = null,
    Object? recurrence = freezed,
    Object? share = freezed,
    Object? theme = freezed,
    Object? endDate = freezed,
    Object? lastRead = freezed,
    Object? parts = freezed,
  }) {
    return _then(_$KhatmaImpl(
      id: freezed == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String?,
      code: null == code
          ? _value.code
          : code // ignore: cast_nullable_to_non_nullable
              as String,
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      unit: null == unit
          ? _value.unit
          : unit // ignore: cast_nullable_to_non_nullable
              as SplitUnit,
      createDate: null == createDate
          ? _value.createDate
          : createDate // ignore: cast_nullable_to_non_nullable
              as DateTime,
      startDate: null == startDate
          ? _value.startDate
          : startDate // ignore: cast_nullable_to_non_nullable
              as DateTime,
      description: freezed == description
          ? _value.description
          : description // ignore: cast_nullable_to_non_nullable
              as String?,
      repeats: null == repeats
          ? _value.repeats
          : repeats // ignore: cast_nullable_to_non_nullable
              as int,
      recurrence: freezed == recurrence
          ? _value.recurrence
          : recurrence // ignore: cast_nullable_to_non_nullable
              as Recurrence?,
      share: freezed == share
          ? _value.share
          : share // ignore: cast_nullable_to_non_nullable
              as KhatmaShare?,
      theme: freezed == theme
          ? _value.theme
          : theme // ignore: cast_nullable_to_non_nullable
              as KhatmaTheme?,
      endDate: freezed == endDate
          ? _value.endDate
          : endDate // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      lastRead: freezed == lastRead
          ? _value.lastRead
          : lastRead // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      parts: freezed == parts
          ? _value._parts
          : parts // ignore: cast_nullable_to_non_nullable
              as List<KhatmaPart>?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$KhatmaImpl implements _Khatma {
  const _$KhatmaImpl(
      {@JsonKey(includeFromJson: true, includeToJson: false) this.id,
      required this.code,
      required this.name,
      required this.unit,
      required this.createDate,
      required this.startDate,
      this.description,
      this.repeats = 0,
      this.recurrence,
      this.share,
      this.theme,
      this.endDate,
      this.lastRead,
      final List<KhatmaPart>? parts})
      : _parts = parts;

  factory _$KhatmaImpl.fromJson(Map<String, dynamic> json) =>
      _$$KhatmaImplFromJson(json);

  @override
  @JsonKey(includeFromJson: true, includeToJson: false)
  final String? id;
  @override
  final String code;
  @override
  final String name;
  @override
  final SplitUnit unit;
  @override
  final DateTime createDate;
  @override
  final DateTime startDate;
  @override
  final String? description;
  @override
  @JsonKey()
  final int repeats;
  @override
  final Recurrence? recurrence;
  @override
  final KhatmaShare? share;
  @override
  final KhatmaTheme? theme;
  @override
  final DateTime? endDate;
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
  String toString() {
    return 'Khatma(id: $id, code: $code, name: $name, unit: $unit, createDate: $createDate, startDate: $startDate, description: $description, repeats: $repeats, recurrence: $recurrence, share: $share, theme: $theme, endDate: $endDate, lastRead: $lastRead, parts: $parts)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$KhatmaImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.code, code) || other.code == code) &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.unit, unit) || other.unit == unit) &&
            (identical(other.createDate, createDate) ||
                other.createDate == createDate) &&
            (identical(other.startDate, startDate) ||
                other.startDate == startDate) &&
            (identical(other.description, description) ||
                other.description == description) &&
            (identical(other.repeats, repeats) || other.repeats == repeats) &&
            (identical(other.recurrence, recurrence) ||
                other.recurrence == recurrence) &&
            (identical(other.share, share) || other.share == share) &&
            (identical(other.theme, theme) || other.theme == theme) &&
            (identical(other.endDate, endDate) || other.endDate == endDate) &&
            (identical(other.lastRead, lastRead) ||
                other.lastRead == lastRead) &&
            const DeepCollectionEquality().equals(other._parts, _parts));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      id,
      code,
      name,
      unit,
      createDate,
      startDate,
      description,
      repeats,
      recurrence,
      share,
      theme,
      endDate,
      lastRead,
      const DeepCollectionEquality().hash(_parts));

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
      {@JsonKey(includeFromJson: true, includeToJson: false) final String? id,
      required final String code,
      required final String name,
      required final SplitUnit unit,
      required final DateTime createDate,
      required final DateTime startDate,
      final String? description,
      final int repeats,
      final Recurrence? recurrence,
      final KhatmaShare? share,
      final KhatmaTheme? theme,
      final DateTime? endDate,
      final DateTime? lastRead,
      final List<KhatmaPart>? parts}) = _$KhatmaImpl;

  factory _Khatma.fromJson(Map<String, dynamic> json) = _$KhatmaImpl.fromJson;

  @override
  @JsonKey(includeFromJson: true, includeToJson: false)
  String? get id;
  @override
  String get code;
  @override
  String get name;
  @override
  SplitUnit get unit;
  @override
  DateTime get createDate;
  @override
  DateTime get startDate;
  @override
  String? get description;
  @override
  int get repeats;
  @override
  Recurrence? get recurrence;
  @override
  KhatmaShare? get share;
  @override
  KhatmaTheme? get theme;
  @override
  DateTime? get endDate;
  @override
  DateTime? get lastRead;
  @override
  List<KhatmaPart>? get parts;
  @override
  @JsonKey(ignore: true)
  _$$KhatmaImplCopyWith<_$KhatmaImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

KhatmaTheme _$KhatmaThemeFromJson(Map<String, dynamic> json) {
  return _KhatmaTheme.fromJson(json);
}

/// @nodoc
mixin _$KhatmaTheme {
  String get color => throw _privateConstructorUsedError;
  String get icon => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $KhatmaThemeCopyWith<KhatmaTheme> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $KhatmaThemeCopyWith<$Res> {
  factory $KhatmaThemeCopyWith(
          KhatmaTheme value, $Res Function(KhatmaTheme) then) =
      _$KhatmaThemeCopyWithImpl<$Res, KhatmaTheme>;
  @useResult
  $Res call({String color, String icon});
}

/// @nodoc
class _$KhatmaThemeCopyWithImpl<$Res, $Val extends KhatmaTheme>
    implements $KhatmaThemeCopyWith<$Res> {
  _$KhatmaThemeCopyWithImpl(this._value, this._then);

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
abstract class _$$KhatmaThemeImplCopyWith<$Res>
    implements $KhatmaThemeCopyWith<$Res> {
  factory _$$KhatmaThemeImplCopyWith(
          _$KhatmaThemeImpl value, $Res Function(_$KhatmaThemeImpl) then) =
      __$$KhatmaThemeImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String color, String icon});
}

/// @nodoc
class __$$KhatmaThemeImplCopyWithImpl<$Res>
    extends _$KhatmaThemeCopyWithImpl<$Res, _$KhatmaThemeImpl>
    implements _$$KhatmaThemeImplCopyWith<$Res> {
  __$$KhatmaThemeImplCopyWithImpl(
      _$KhatmaThemeImpl _value, $Res Function(_$KhatmaThemeImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? color = null,
    Object? icon = null,
  }) {
    return _then(_$KhatmaThemeImpl(
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
class _$KhatmaThemeImpl implements _KhatmaTheme {
  const _$KhatmaThemeImpl({required this.color, required this.icon});

  factory _$KhatmaThemeImpl.fromJson(Map<String, dynamic> json) =>
      _$$KhatmaThemeImplFromJson(json);

  @override
  final String color;
  @override
  final String icon;

  @override
  String toString() {
    return 'KhatmaTheme(color: $color, icon: $icon)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$KhatmaThemeImpl &&
            (identical(other.color, color) || other.color == color) &&
            (identical(other.icon, icon) || other.icon == icon));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, color, icon);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$KhatmaThemeImplCopyWith<_$KhatmaThemeImpl> get copyWith =>
      __$$KhatmaThemeImplCopyWithImpl<_$KhatmaThemeImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$KhatmaThemeImplToJson(
      this,
    );
  }
}

abstract class _KhatmaTheme implements KhatmaTheme {
  const factory _KhatmaTheme(
      {required final String color,
      required final String icon}) = _$KhatmaThemeImpl;

  factory _KhatmaTheme.fromJson(Map<String, dynamic> json) =
      _$KhatmaThemeImpl.fromJson;

  @override
  String get color;
  @override
  String get icon;
  @override
  @JsonKey(ignore: true)
  _$$KhatmaThemeImplCopyWith<_$KhatmaThemeImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

Recurrence _$RecurrenceFromJson(Map<String, dynamic> json) {
  return _Recurrence.fromJson(json);
}

/// @nodoc
mixin _$Recurrence {
  RepeatInterval get unit => throw _privateConstructorUsedError;
  bool get repeat => throw _privateConstructorUsedError;
  DateTime? get startDate => throw _privateConstructorUsedError;
  DateTime? get endDate => throw _privateConstructorUsedError;
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
      {RepeatInterval unit,
      bool repeat,
      DateTime? startDate,
      DateTime? endDate,
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
    Object? unit = null,
    Object? repeat = null,
    Object? startDate = freezed,
    Object? endDate = freezed,
    Object? days = freezed,
    Object? frequency = freezed,
  }) {
    return _then(_value.copyWith(
      unit: null == unit
          ? _value.unit
          : unit // ignore: cast_nullable_to_non_nullable
              as RepeatInterval,
      repeat: null == repeat
          ? _value.repeat
          : repeat // ignore: cast_nullable_to_non_nullable
              as bool,
      startDate: freezed == startDate
          ? _value.startDate
          : startDate // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      endDate: freezed == endDate
          ? _value.endDate
          : endDate // ignore: cast_nullable_to_non_nullable
              as DateTime?,
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
      {RepeatInterval unit,
      bool repeat,
      DateTime? startDate,
      DateTime? endDate,
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
    Object? unit = null,
    Object? repeat = null,
    Object? startDate = freezed,
    Object? endDate = freezed,
    Object? days = freezed,
    Object? frequency = freezed,
  }) {
    return _then(_$RecurrenceImpl(
      unit: null == unit
          ? _value.unit
          : unit // ignore: cast_nullable_to_non_nullable
              as RepeatInterval,
      repeat: null == repeat
          ? _value.repeat
          : repeat // ignore: cast_nullable_to_non_nullable
              as bool,
      startDate: freezed == startDate
          ? _value.startDate
          : startDate // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      endDate: freezed == endDate
          ? _value.endDate
          : endDate // ignore: cast_nullable_to_non_nullable
              as DateTime?,
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
      {this.unit = RepeatInterval.auto,
      this.repeat = true,
      this.startDate,
      this.endDate,
      final List<int>? days,
      this.frequency})
      : _days = days;

  factory _$RecurrenceImpl.fromJson(Map<String, dynamic> json) =>
      _$$RecurrenceImplFromJson(json);

  @override
  @JsonKey()
  final RepeatInterval unit;
  @override
  @JsonKey()
  final bool repeat;
  @override
  final DateTime? startDate;
  @override
  final DateTime? endDate;
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
    return 'Recurrence(unit: $unit, repeat: $repeat, startDate: $startDate, endDate: $endDate, days: $days, frequency: $frequency)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$RecurrenceImpl &&
            (identical(other.unit, unit) || other.unit == unit) &&
            (identical(other.repeat, repeat) || other.repeat == repeat) &&
            (identical(other.startDate, startDate) ||
                other.startDate == startDate) &&
            (identical(other.endDate, endDate) || other.endDate == endDate) &&
            const DeepCollectionEquality().equals(other._days, _days) &&
            (identical(other.frequency, frequency) ||
                other.frequency == frequency));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, unit, repeat, startDate, endDate,
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
      {final RepeatInterval unit,
      final bool repeat,
      final DateTime? startDate,
      final DateTime? endDate,
      final List<int>? days,
      final int? frequency}) = _$RecurrenceImpl;

  factory _Recurrence.fromJson(Map<String, dynamic> json) =
      _$RecurrenceImpl.fromJson;

  @override
  RepeatInterval get unit;
  @override
  bool get repeat;
  @override
  DateTime? get startDate;
  @override
  DateTime? get endDate;
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
  DateTime? get startDate => throw _privateConstructorUsedError;
  DateTime? get endDate => throw _privateConstructorUsedError;
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
      DateTime? startDate,
      DateTime? endDate,
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
    Object? startDate = freezed,
    Object? endDate = freezed,
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
      startDate: freezed == startDate
          ? _value.startDate
          : startDate // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      endDate: freezed == endDate
          ? _value.endDate
          : endDate // ignore: cast_nullable_to_non_nullable
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
      DateTime? startDate,
      DateTime? endDate,
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
    Object? startDate = freezed,
    Object? endDate = freezed,
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
      startDate: freezed == startDate
          ? _value.startDate
          : startDate // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      endDate: freezed == endDate
          ? _value.endDate
          : endDate // ignore: cast_nullable_to_non_nullable
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
      this.startDate,
      this.endDate,
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
  final DateTime? startDate;
  @override
  final DateTime? endDate;
  @override
  final int? remindTimes;

  @override
  String toString() {
    return 'KhatmaPart(id: $id, userId: $userId, userName: $userName, startDate: $startDate, endDate: $endDate, remindTimes: $remindTimes)';
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
            (identical(other.startDate, startDate) ||
                other.startDate == startDate) &&
            (identical(other.endDate, endDate) || other.endDate == endDate) &&
            (identical(other.remindTimes, remindTimes) ||
                other.remindTimes == remindTimes));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType, id, userId, userName, startDate, endDate, remindTimes);

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
      final DateTime? startDate,
      final DateTime? endDate,
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
  DateTime? get startDate;
  @override
  DateTime? get endDate;
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
