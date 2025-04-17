// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'khatma_history.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$CompletionHistoryImpl _$$CompletionHistoryImplFromJson(Map json) =>
    _$CompletionHistoryImpl(
      khatmaId: json['khatmaId'] as String?,
      startDate: const DateConverter().fromJson(json['startDate'] as String),
      endDate: const DateConverter().fromJson(json['endDate'] as String),
      completionMode: (json['completionMode'] as num?)?.toInt(),
      completion: json['completion'] as String?,
    );

Map<String, dynamic> _$$CompletionHistoryImplToJson(
    _$CompletionHistoryImpl instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('khatmaId', instance.khatmaId);
  val['startDate'] = const DateConverter().toJson(instance.startDate);
  val['endDate'] = const DateConverter().toJson(instance.endDate);
  writeNotNull('completionMode', instance.completionMode);
  writeNotNull('completion', instance.completion);
  return val;
}
