// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'khatma_history.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$KhatmaHistoryImpl _$$KhatmaHistoryImplFromJson(Map json) =>
    _$KhatmaHistoryImpl(
      khatmaId: json['khatmaId'] as String?,
      startDate: const DateConverter().fromJson(json['startDate'] as String),
      endDate: const DateConverter().fromJson(json['endDate'] as String),
    );

Map<String, dynamic> _$$KhatmaHistoryImplToJson(_$KhatmaHistoryImpl instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('khatmaId', instance.khatmaId);
  val['startDate'] = const DateConverter().toJson(instance.startDate);
  val['endDate'] = const DateConverter().toJson(instance.endDate);
  return val;
}
