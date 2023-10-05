// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'khatma.dart';

// **************************************************************************
// CopyWithGenerator
// **************************************************************************

abstract class _$KhatmaCWProxy {
  Khatma id(String? id);

  Khatma name(String name);

  Khatma description(String? description);

  Khatma createDate(DateTime createDate);

  Khatma endDate(DateTime? endDate);

  Khatma creator(String? creator);

  Khatma recurrence(Recurrence recurrence);

  Khatma unit(SplitUnit unit);

  Khatma lastRead(DateTime? lastRead);

  Khatma completedParts(List<int>? completedParts);

  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `Khatma(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// Khatma(...).copyWith(id: 12, name: "My name")
  /// ````
  Khatma call({
    String? id,
    String? name,
    String? description,
    DateTime? createDate,
    DateTime? endDate,
    String? creator,
    Recurrence? recurrence,
    SplitUnit? unit,
    DateTime? lastRead,
    List<int>? completedParts,
  });
}

/// Proxy class for `copyWith` functionality. This is a callable class and can be used as follows: `instanceOfKhatma.copyWith(...)`. Additionally contains functions for specific fields e.g. `instanceOfKhatma.copyWith.fieldName(...)`
class _$KhatmaCWProxyImpl implements _$KhatmaCWProxy {
  const _$KhatmaCWProxyImpl(this._value);

  final Khatma _value;

  @override
  Khatma id(String? id) => this(id: id);

  @override
  Khatma name(String name) => this(name: name);

  @override
  Khatma description(String? description) => this(description: description);

  @override
  Khatma createDate(DateTime createDate) => this(createDate: createDate);

  @override
  Khatma endDate(DateTime? endDate) => this(endDate: endDate);

  @override
  Khatma creator(String? creator) => this(creator: creator);

  @override
  Khatma recurrence(Recurrence recurrence) => this(recurrence: recurrence);

  @override
  Khatma unit(SplitUnit unit) => this(unit: unit);

  @override
  Khatma lastRead(DateTime? lastRead) => this(lastRead: lastRead);

  @override
  Khatma completedParts(List<int>? completedParts) =>
      this(completedParts: completedParts);

  @override

  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `Khatma(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// Khatma(...).copyWith(id: 12, name: "My name")
  /// ````
  Khatma call({
    Object? id = const $CopyWithPlaceholder(),
    Object? name = const $CopyWithPlaceholder(),
    Object? description = const $CopyWithPlaceholder(),
    Object? createDate = const $CopyWithPlaceholder(),
    Object? endDate = const $CopyWithPlaceholder(),
    Object? creator = const $CopyWithPlaceholder(),
    Object? recurrence = const $CopyWithPlaceholder(),
    Object? unit = const $CopyWithPlaceholder(),
    Object? lastRead = const $CopyWithPlaceholder(),
    Object? completedParts = const $CopyWithPlaceholder(),
  }) {
    return Khatma(
      id: id == const $CopyWithPlaceholder()
          ? _value.id
          // ignore: cast_nullable_to_non_nullable
          : id as String?,
      name: name == const $CopyWithPlaceholder() || name == null
          ? _value.name
          // ignore: cast_nullable_to_non_nullable
          : name as String,
      description: description == const $CopyWithPlaceholder()
          ? _value.description
          // ignore: cast_nullable_to_non_nullable
          : description as String?,
      createDate:
          createDate == const $CopyWithPlaceholder() || createDate == null
              ? _value.createDate
              // ignore: cast_nullable_to_non_nullable
              : createDate as DateTime,
      endDate: endDate == const $CopyWithPlaceholder()
          ? _value.endDate
          // ignore: cast_nullable_to_non_nullable
          : endDate as DateTime?,
      creator: creator == const $CopyWithPlaceholder()
          ? _value.creator
          // ignore: cast_nullable_to_non_nullable
          : creator as String?,
      recurrence:
          recurrence == const $CopyWithPlaceholder() || recurrence == null
              ? _value.recurrence
              // ignore: cast_nullable_to_non_nullable
              : recurrence as Recurrence,
      unit: unit == const $CopyWithPlaceholder() || unit == null
          ? _value.unit
          // ignore: cast_nullable_to_non_nullable
          : unit as SplitUnit,
      lastRead: lastRead == const $CopyWithPlaceholder()
          ? _value.lastRead
          // ignore: cast_nullable_to_non_nullable
          : lastRead as DateTime?,
      completedParts: completedParts == const $CopyWithPlaceholder()
          ? _value.completedParts
          // ignore: cast_nullable_to_non_nullable
          : completedParts as List<int>?,
    );
  }
}

extension $KhatmaCopyWith on Khatma {
  /// Returns a callable class that can be used as follows: `instanceOfKhatma.copyWith(...)` or like so:`instanceOfKhatma.copyWith.fieldName(...)`.
  // ignore: library_private_types_in_public_api
  _$KhatmaCWProxy get copyWith => _$KhatmaCWProxyImpl(this);
}
