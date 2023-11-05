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
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

/// @nodoc
mixin _$Khatma {
  String? get id => throw _privateConstructorUsedError;
  String? get description => throw _privateConstructorUsedError;
  DateTime? get endDate => throw _privateConstructorUsedError;
  String? get creator => throw _privateConstructorUsedError;
  KhatmaStyle get style => throw _privateConstructorUsedError;
  DateTime? get lastRead => throw _privateConstructorUsedError;
  List<int>? get completedParts => throw _privateConstructorUsedError;
  List<KhatmaPart>? get parts => throw _privateConstructorUsedError;
  String get name => throw _privateConstructorUsedError;
  DateTime get createDate => throw _privateConstructorUsedError;
  Recurrence get recurrence => throw _privateConstructorUsedError;
  SplitUnit get unit => throw _privateConstructorUsedError;
  KhatmaShareType get share => throw _privateConstructorUsedError;

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
      String? description,
      DateTime? endDate,
      String? creator,
      KhatmaStyle style,
      DateTime? lastRead,
      List<int>? completedParts,
      List<KhatmaPart>? parts,
      String name,
      DateTime createDate,
      Recurrence recurrence,
      SplitUnit unit,
      KhatmaShareType share});

  $KhatmaStyleCopyWith<$Res> get style;
  $RecurrenceCopyWith<$Res> get recurrence;
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
    Object? description = freezed,
    Object? endDate = freezed,
    Object? creator = freezed,
    Object? style = null,
    Object? lastRead = freezed,
    Object? completedParts = freezed,
    Object? parts = freezed,
    Object? name = null,
    Object? createDate = null,
    Object? recurrence = null,
    Object? unit = null,
    Object? share = null,
  }) {
    return _then(_value.copyWith(
      id: freezed == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String?,
      description: freezed == description
          ? _value.description
          : description // ignore: cast_nullable_to_non_nullable
              as String?,
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
      completedParts: freezed == completedParts
          ? _value.completedParts
          : completedParts // ignore: cast_nullable_to_non_nullable
              as List<int>?,
      parts: freezed == parts
          ? _value.parts
          : parts // ignore: cast_nullable_to_non_nullable
              as List<KhatmaPart>?,
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      createDate: null == createDate
          ? _value.createDate
          : createDate // ignore: cast_nullable_to_non_nullable
              as DateTime,
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
              as KhatmaShareType,
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
      String? description,
      DateTime? endDate,
      String? creator,
      KhatmaStyle style,
      DateTime? lastRead,
      List<int>? completedParts,
      List<KhatmaPart>? parts,
      String name,
      DateTime createDate,
      Recurrence recurrence,
      SplitUnit unit,
      KhatmaShareType share});

  @override
  $KhatmaStyleCopyWith<$Res> get style;
  @override
  $RecurrenceCopyWith<$Res> get recurrence;
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
    Object? description = freezed,
    Object? endDate = freezed,
    Object? creator = freezed,
    Object? style = null,
    Object? lastRead = freezed,
    Object? completedParts = freezed,
    Object? parts = freezed,
    Object? name = null,
    Object? createDate = null,
    Object? recurrence = null,
    Object? unit = null,
    Object? share = null,
  }) {
    return _then(_$KhatmaImpl(
      id: freezed == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String?,
      description: freezed == description
          ? _value.description
          : description // ignore: cast_nullable_to_non_nullable
              as String?,
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
      completedParts: freezed == completedParts
          ? _value._completedParts
          : completedParts // ignore: cast_nullable_to_non_nullable
              as List<int>?,
      parts: freezed == parts
          ? _value._parts
          : parts // ignore: cast_nullable_to_non_nullable
              as List<KhatmaPart>?,
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      createDate: null == createDate
          ? _value.createDate
          : createDate // ignore: cast_nullable_to_non_nullable
              as DateTime,
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
              as KhatmaShareType,
    ));
  }
}

/// @nodoc

class _$KhatmaImpl implements _Khatma {
  const _$KhatmaImpl(
      {this.id,
      this.description,
      this.endDate,
      this.creator,
      required this.style,
      this.lastRead,
      final List<int>? completedParts,
      final List<KhatmaPart>? parts,
      required this.name,
      required this.createDate,
      required this.recurrence,
      required this.unit,
      required this.share})
      : _completedParts = completedParts,
        _parts = parts;

  @override
  final String? id;
  @override
  final String? description;
  @override
  final DateTime? endDate;
  @override
  final String? creator;
  @override
  final KhatmaStyle style;
  @override
  final DateTime? lastRead;
  final List<int>? _completedParts;
  @override
  List<int>? get completedParts {
    final value = _completedParts;
    if (value == null) return null;
    if (_completedParts is EqualUnmodifiableListView) return _completedParts;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(value);
  }

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
  final String name;
  @override
  final DateTime createDate;
  @override
  final Recurrence recurrence;
  @override
  final SplitUnit unit;
  @override
  final KhatmaShareType share;

  @override
  String toString() {
    return 'Khatma(id: $id, description: $description, endDate: $endDate, creator: $creator, style: $style, lastRead: $lastRead, completedParts: $completedParts, parts: $parts, name: $name, createDate: $createDate, recurrence: $recurrence, unit: $unit, share: $share)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$KhatmaImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.description, description) ||
                other.description == description) &&
            (identical(other.endDate, endDate) || other.endDate == endDate) &&
            (identical(other.creator, creator) || other.creator == creator) &&
            (identical(other.style, style) || other.style == style) &&
            (identical(other.lastRead, lastRead) ||
                other.lastRead == lastRead) &&
            const DeepCollectionEquality()
                .equals(other._completedParts, _completedParts) &&
            const DeepCollectionEquality().equals(other._parts, _parts) &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.createDate, createDate) ||
                other.createDate == createDate) &&
            (identical(other.recurrence, recurrence) ||
                other.recurrence == recurrence) &&
            (identical(other.unit, unit) || other.unit == unit) &&
            (identical(other.share, share) || other.share == share));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      id,
      description,
      endDate,
      creator,
      style,
      lastRead,
      const DeepCollectionEquality().hash(_completedParts),
      const DeepCollectionEquality().hash(_parts),
      name,
      createDate,
      recurrence,
      unit,
      share);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$KhatmaImplCopyWith<_$KhatmaImpl> get copyWith =>
      __$$KhatmaImplCopyWithImpl<_$KhatmaImpl>(this, _$identity);
}

abstract class _Khatma implements Khatma {
  const factory _Khatma(
      {final String? id,
      final String? description,
      final DateTime? endDate,
      final String? creator,
      required final KhatmaStyle style,
      final DateTime? lastRead,
      final List<int>? completedParts,
      final List<KhatmaPart>? parts,
      required final String name,
      required final DateTime createDate,
      required final Recurrence recurrence,
      required final SplitUnit unit,
      required final KhatmaShareType share}) = _$KhatmaImpl;

  @override
  String? get id;
  @override
  String? get description;
  @override
  DateTime? get endDate;
  @override
  String? get creator;
  @override
  KhatmaStyle get style;
  @override
  DateTime? get lastRead;
  @override
  List<int>? get completedParts;
  @override
  List<KhatmaPart>? get parts;
  @override
  String get name;
  @override
  DateTime get createDate;
  @override
  Recurrence get recurrence;
  @override
  SplitUnit get unit;
  @override
  KhatmaShareType get share;
  @override
  @JsonKey(ignore: true)
  _$$KhatmaImplCopyWith<_$KhatmaImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
mixin _$KhatmaStyle {
  String get color => throw _privateConstructorUsedError;
  String get icon => throw _privateConstructorUsedError;

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

class _$KhatmaStyleImpl implements _KhatmaStyle {
  const _$KhatmaStyleImpl({required this.color, required this.icon});

  @override
  final String color;
  @override
  final String icon;

  @override
  String toString() {
    return 'KhatmaStyle(color: $color, icon: $icon)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$KhatmaStyleImpl &&
            (identical(other.color, color) || other.color == color) &&
            (identical(other.icon, icon) || other.icon == icon));
  }

  @override
  int get hashCode => Object.hash(runtimeType, color, icon);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$KhatmaStyleImplCopyWith<_$KhatmaStyleImpl> get copyWith =>
      __$$KhatmaStyleImplCopyWithImpl<_$KhatmaStyleImpl>(this, _$identity);
}

abstract class _KhatmaStyle implements KhatmaStyle {
  const factory _KhatmaStyle(
      {required final String color,
      required final String icon}) = _$KhatmaStyleImpl;

  @override
  String get color;
  @override
  String get icon;
  @override
  @JsonKey(ignore: true)
  _$$KhatmaStyleImplCopyWith<_$KhatmaStyleImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
mixin _$Recurrence {
  KhatmaScheduler get scheduler => throw _privateConstructorUsedError;
  DateTime get startDate => throw _privateConstructorUsedError;
  DateTime get endDate => throw _privateConstructorUsedError;
  RecurrenceUnit? get unit => throw _privateConstructorUsedError;
  int? get occurrence => throw _privateConstructorUsedError;

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
      {KhatmaScheduler scheduler,
      DateTime startDate,
      DateTime endDate,
      RecurrenceUnit? unit,
      int? occurrence});
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
    Object? scheduler = null,
    Object? startDate = null,
    Object? endDate = null,
    Object? unit = freezed,
    Object? occurrence = freezed,
  }) {
    return _then(_value.copyWith(
      scheduler: null == scheduler
          ? _value.scheduler
          : scheduler // ignore: cast_nullable_to_non_nullable
              as KhatmaScheduler,
      startDate: null == startDate
          ? _value.startDate
          : startDate // ignore: cast_nullable_to_non_nullable
              as DateTime,
      endDate: null == endDate
          ? _value.endDate
          : endDate // ignore: cast_nullable_to_non_nullable
              as DateTime,
      unit: freezed == unit
          ? _value.unit
          : unit // ignore: cast_nullable_to_non_nullable
              as RecurrenceUnit?,
      occurrence: freezed == occurrence
          ? _value.occurrence
          : occurrence // ignore: cast_nullable_to_non_nullable
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
      {KhatmaScheduler scheduler,
      DateTime startDate,
      DateTime endDate,
      RecurrenceUnit? unit,
      int? occurrence});
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
    Object? scheduler = null,
    Object? startDate = null,
    Object? endDate = null,
    Object? unit = freezed,
    Object? occurrence = freezed,
  }) {
    return _then(_$RecurrenceImpl(
      scheduler: null == scheduler
          ? _value.scheduler
          : scheduler // ignore: cast_nullable_to_non_nullable
              as KhatmaScheduler,
      startDate: null == startDate
          ? _value.startDate
          : startDate // ignore: cast_nullable_to_non_nullable
              as DateTime,
      endDate: null == endDate
          ? _value.endDate
          : endDate // ignore: cast_nullable_to_non_nullable
              as DateTime,
      unit: freezed == unit
          ? _value.unit
          : unit // ignore: cast_nullable_to_non_nullable
              as RecurrenceUnit?,
      occurrence: freezed == occurrence
          ? _value.occurrence
          : occurrence // ignore: cast_nullable_to_non_nullable
              as int?,
    ));
  }
}

/// @nodoc

class _$RecurrenceImpl implements _Recurrence {
  const _$RecurrenceImpl(
      {required this.scheduler,
      required this.startDate,
      required this.endDate,
      this.unit,
      this.occurrence});

  @override
  final KhatmaScheduler scheduler;
  @override
  final DateTime startDate;
  @override
  final DateTime endDate;
  @override
  final RecurrenceUnit? unit;
  @override
  final int? occurrence;

  @override
  String toString() {
    return 'Recurrence(scheduler: $scheduler, startDate: $startDate, endDate: $endDate, unit: $unit, occurrence: $occurrence)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$RecurrenceImpl &&
            (identical(other.scheduler, scheduler) ||
                other.scheduler == scheduler) &&
            (identical(other.startDate, startDate) ||
                other.startDate == startDate) &&
            (identical(other.endDate, endDate) || other.endDate == endDate) &&
            (identical(other.unit, unit) || other.unit == unit) &&
            (identical(other.occurrence, occurrence) ||
                other.occurrence == occurrence));
  }

  @override
  int get hashCode =>
      Object.hash(runtimeType, scheduler, startDate, endDate, unit, occurrence);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$RecurrenceImplCopyWith<_$RecurrenceImpl> get copyWith =>
      __$$RecurrenceImplCopyWithImpl<_$RecurrenceImpl>(this, _$identity);
}

abstract class _Recurrence implements Recurrence {
  const factory _Recurrence(
      {required final KhatmaScheduler scheduler,
      required final DateTime startDate,
      required final DateTime endDate,
      final RecurrenceUnit? unit,
      final int? occurrence}) = _$RecurrenceImpl;

  @override
  KhatmaScheduler get scheduler;
  @override
  DateTime get startDate;
  @override
  DateTime get endDate;
  @override
  RecurrenceUnit? get unit;
  @override
  int? get occurrence;
  @override
  @JsonKey(ignore: true)
  _$$RecurrenceImplCopyWith<_$RecurrenceImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
mixin _$KhatmaPart {
  int get id => throw _privateConstructorUsedError;
  String? get readerId => throw _privateConstructorUsedError;
  String? get readerName => throw _privateConstructorUsedError;
  DateTime? get addedDate => throw _privateConstructorUsedError;
  DateTime? get finishedDate => throw _privateConstructorUsedError;
  int? get remind => throw _privateConstructorUsedError;

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
      String? readerId,
      String? readerName,
      DateTime? addedDate,
      DateTime? finishedDate,
      int? remind});
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
    Object? readerId = freezed,
    Object? readerName = freezed,
    Object? addedDate = freezed,
    Object? finishedDate = freezed,
    Object? remind = freezed,
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int,
      readerId: freezed == readerId
          ? _value.readerId
          : readerId // ignore: cast_nullable_to_non_nullable
              as String?,
      readerName: freezed == readerName
          ? _value.readerName
          : readerName // ignore: cast_nullable_to_non_nullable
              as String?,
      addedDate: freezed == addedDate
          ? _value.addedDate
          : addedDate // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      finishedDate: freezed == finishedDate
          ? _value.finishedDate
          : finishedDate // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      remind: freezed == remind
          ? _value.remind
          : remind // ignore: cast_nullable_to_non_nullable
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
      String? readerId,
      String? readerName,
      DateTime? addedDate,
      DateTime? finishedDate,
      int? remind});
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
    Object? readerId = freezed,
    Object? readerName = freezed,
    Object? addedDate = freezed,
    Object? finishedDate = freezed,
    Object? remind = freezed,
  }) {
    return _then(_$KhatmaPartImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int,
      readerId: freezed == readerId
          ? _value.readerId
          : readerId // ignore: cast_nullable_to_non_nullable
              as String?,
      readerName: freezed == readerName
          ? _value.readerName
          : readerName // ignore: cast_nullable_to_non_nullable
              as String?,
      addedDate: freezed == addedDate
          ? _value.addedDate
          : addedDate // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      finishedDate: freezed == finishedDate
          ? _value.finishedDate
          : finishedDate // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      remind: freezed == remind
          ? _value.remind
          : remind // ignore: cast_nullable_to_non_nullable
              as int?,
    ));
  }
}

/// @nodoc

class _$KhatmaPartImpl implements _KhatmaPart {
  const _$KhatmaPartImpl(
      {required this.id,
      this.readerId,
      this.readerName,
      this.addedDate,
      this.finishedDate,
      this.remind});

  @override
  final int id;
  @override
  final String? readerId;
  @override
  final String? readerName;
  @override
  final DateTime? addedDate;
  @override
  final DateTime? finishedDate;
  @override
  final int? remind;

  @override
  String toString() {
    return 'KhatmaPart(id: $id, readerId: $readerId, readerName: $readerName, addedDate: $addedDate, finishedDate: $finishedDate, remind: $remind)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$KhatmaPartImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.readerId, readerId) ||
                other.readerId == readerId) &&
            (identical(other.readerName, readerName) ||
                other.readerName == readerName) &&
            (identical(other.addedDate, addedDate) ||
                other.addedDate == addedDate) &&
            (identical(other.finishedDate, finishedDate) ||
                other.finishedDate == finishedDate) &&
            (identical(other.remind, remind) || other.remind == remind));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType, id, readerId, readerName, addedDate, finishedDate, remind);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$KhatmaPartImplCopyWith<_$KhatmaPartImpl> get copyWith =>
      __$$KhatmaPartImplCopyWithImpl<_$KhatmaPartImpl>(this, _$identity);
}

abstract class _KhatmaPart implements KhatmaPart {
  const factory _KhatmaPart(
      {required final int id,
      final String? readerId,
      final String? readerName,
      final DateTime? addedDate,
      final DateTime? finishedDate,
      final int? remind}) = _$KhatmaPartImpl;

  @override
  int get id;
  @override
  String? get readerId;
  @override
  String? get readerName;
  @override
  DateTime? get addedDate;
  @override
  DateTime? get finishedDate;
  @override
  int? get remind;
  @override
  @JsonKey(ignore: true)
  _$$KhatmaPartImplCopyWith<_$KhatmaPartImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
