// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'khatma_history.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$PrivateKhatmaHistoryImpl _$$PrivateKhatmaHistoryImplFromJson(Map json) =>
    _$PrivateKhatmaHistoryImpl(
      id: json['id'] as String,
      unit: $enumDecode(_$SplitUnitEnumMap, json['unit']),
      startDate: const DateConverter().fromJson(json['startDate'] as String),
      endDate: const DateConverter().fromJson(json['endDate'] as String),
      userId: json['userId'] as String,
      parts: (json['parts'] as List<dynamic>)
          .map((e) =>
              KhatmaPartHistory.fromJson(Map<String, Object?>.from(e as Map)))
          .toList(),
      $type: json['runtimeType'] as String?,
    );

Map<String, dynamic> _$$PrivateKhatmaHistoryImplToJson(
        _$PrivateKhatmaHistoryImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'unit': _$SplitUnitEnumMap[instance.unit]!,
      'startDate': const DateConverter().toJson(instance.startDate),
      'endDate': const DateConverter().toJson(instance.endDate),
      'userId': instance.userId,
      'parts': instance.parts.map((e) => e.toJson()).toList(),
      'runtimeType': instance.$type,
    };

const _$SplitUnitEnumMap = {
  SplitUnit.sourat: 'sourat',
  SplitUnit.juzz: 'juzz',
  SplitUnit.hizb: 'hizb',
  SplitUnit.half: 'half',
  SplitUnit.rubue: 'rubue',
  SplitUnit.thumun: 'thumun',
};

_$SharedKhatmaHistoryImpl _$$SharedKhatmaHistoryImplFromJson(Map json) =>
    _$SharedKhatmaHistoryImpl(
      id: json['id'] as String,
      unit: $enumDecode(_$SplitUnitEnumMap, json['unit']),
      startDate: const DateConverter().fromJson(json['startDate'] as String),
      endDate: const DateConverter().fromJson(json['endDate'] as String),
      userId: json['userId'] as String,
      parts: (json['parts'] as Map).map(
        (k, e) => MapEntry(
            k as String,
            (e as List<dynamic>)
                .map((e) => KhatmaPartHistory.fromJson(
                    Map<String, Object?>.from(e as Map)))
                .toList()),
      ),
      $type: json['runtimeType'] as String?,
    );

Map<String, dynamic> _$$SharedKhatmaHistoryImplToJson(
        _$SharedKhatmaHistoryImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'unit': _$SplitUnitEnumMap[instance.unit]!,
      'startDate': const DateConverter().toJson(instance.startDate),
      'endDate': const DateConverter().toJson(instance.endDate),
      'userId': instance.userId,
      'parts': instance.parts
          .map((k, e) => MapEntry(k, e.map((e) => e.toJson()).toList())),
      'runtimeType': instance.$type,
    };

_$KhatmaPartHistoryImpl _$$KhatmaPartHistoryImplFromJson(Map json) =>
    _$KhatmaPartHistoryImpl(
      id: (json['id'] as num).toInt(),
      endDate: const DateConverter().fromJson(json['endDate'] as String),
    );

Map<String, dynamic> _$$KhatmaPartHistoryImplToJson(
        _$KhatmaPartHistoryImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'endDate': const DateConverter().toJson(instance.endDate),
    };
