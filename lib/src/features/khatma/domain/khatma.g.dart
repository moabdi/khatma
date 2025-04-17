// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'khatma.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$KhatmaImpl _$$KhatmaImplFromJson(Map json) => _$KhatmaImpl(
      id: json['id'] as String?,
      code: json['code'] as String,
      name: json['name'] as String,
      unit: $enumDecode(_$SplitUnitEnumMap, json['unit']),
      createDate: DateTime.parse(json['createDate'] as String),
      startDate: DateTime.parse(json['startDate'] as String),
      description: json['description'] as String?,
      repeats: (json['repeats'] as num?)?.toInt(),
      recurrence: json['recurrence'] == null
          ? null
          : Recurrence.fromJson(
              Map<String, Object?>.from(json['recurrence'] as Map)),
      share: json['share'] == null
          ? null
          : KhatmaShare.fromJson(
              Map<String, Object?>.from(json['share'] as Map)),
      theme: json['theme'] == null
          ? null
          : KhatmaTheme.fromJson(
              Map<String, Object?>.from(json['theme'] as Map)),
      endDate: json['endDate'] == null
          ? null
          : DateTime.parse(json['endDate'] as String),
      lastRead: json['lastRead'] == null
          ? null
          : DateTime.parse(json['lastRead'] as String),
      readParts: (json['readParts'] as List<dynamic>?)
          ?.map((e) => KhatmaPart.fromJson(Map<String, Object?>.from(e as Map)))
          .toList(),
    );

Map<String, dynamic> _$$KhatmaImplToJson(_$KhatmaImpl instance) {
  final val = <String, dynamic>{
    'code': instance.code,
    'name': instance.name,
    'unit': _$SplitUnitEnumMap[instance.unit]!,
    'createDate': instance.createDate.toIso8601String(),
    'startDate': instance.startDate.toIso8601String(),
  };

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('description', instance.description);
  writeNotNull('repeats', instance.repeats);
  writeNotNull('recurrence', instance.recurrence?.toJson());
  writeNotNull('share', instance.share?.toJson());
  writeNotNull('theme', instance.theme?.toJson());
  writeNotNull('endDate', instance.endDate?.toIso8601String());
  writeNotNull('lastRead', instance.lastRead?.toIso8601String());
  writeNotNull(
      'readParts', instance.readParts?.map((e) => e.toJson()).toList());
  return val;
}

const _$SplitUnitEnumMap = {
  SplitUnit.sourat: 'sourat',
  SplitUnit.juzz: 'juzz',
  SplitUnit.hizb: 'hizb',
  SplitUnit.half: 'half',
  SplitUnit.rubue: 'rubue',
  SplitUnit.thumun: 'thumun',
};

_$KhatmaThemeImpl _$$KhatmaThemeImplFromJson(Map json) => _$KhatmaThemeImpl(
      color: json['color'] as String,
      icon: json['icon'] as String,
    );

Map<String, dynamic> _$$KhatmaThemeImplToJson(_$KhatmaThemeImpl instance) =>
    <String, dynamic>{
      'color': instance.color,
      'icon': instance.icon,
    };

_$RecurrenceImpl _$$RecurrenceImplFromJson(Map json) => _$RecurrenceImpl(
      unit: $enumDecodeNullable(_$RepeatIntervalEnumMap, json['unit']) ??
          RepeatInterval.auto,
      repeat: json['repeat'] as bool? ?? true,
      startDate: json['startDate'] == null
          ? null
          : DateTime.parse(json['startDate'] as String),
      endDate: json['endDate'] == null
          ? null
          : DateTime.parse(json['endDate'] as String),
      days: (json['days'] as List<dynamic>?)
          ?.map((e) => (e as num).toInt())
          .toList(),
      frequency: (json['frequency'] as num?)?.toInt(),
    );

Map<String, dynamic> _$$RecurrenceImplToJson(_$RecurrenceImpl instance) {
  final val = <String, dynamic>{
    'unit': _$RepeatIntervalEnumMap[instance.unit]!,
    'repeat': instance.repeat,
  };

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('startDate', instance.startDate?.toIso8601String());
  writeNotNull('endDate', instance.endDate?.toIso8601String());
  writeNotNull('days', instance.days);
  writeNotNull('frequency', instance.frequency);
  return val;
}

const _$RepeatIntervalEnumMap = {
  RepeatInterval.auto: 'auto',
  RepeatInterval.daily: 'daily',
  RepeatInterval.weekly: 'weekly',
  RepeatInterval.monthly: 'monthly',
};

_$KhatmaPartImpl _$$KhatmaPartImplFromJson(Map json) => _$KhatmaPartImpl(
      id: (json['id'] as num).toInt(),
      userId: json['userId'] as String?,
      userName: json['userName'] as String?,
      startDate: json['startDate'] == null
          ? null
          : DateTime.parse(json['startDate'] as String),
      endDate: json['endDate'] == null
          ? null
          : DateTime.parse(json['endDate'] as String),
      remindTimes: (json['remindTimes'] as num?)?.toInt(),
    );

Map<String, dynamic> _$$KhatmaPartImplToJson(_$KhatmaPartImpl instance) {
  final val = <String, dynamic>{
    'id': instance.id,
  };

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('userId', instance.userId);
  writeNotNull('userName', instance.userName);
  writeNotNull('startDate', instance.startDate?.toIso8601String());
  writeNotNull('endDate', instance.endDate?.toIso8601String());
  writeNotNull('remindTimes', instance.remindTimes);
  return val;
}

_$KhatmaShareImpl _$$KhatmaShareImplFromJson(Map json) => _$KhatmaShareImpl(
      visibility: $enumDecode(_$ShareVisibilityEnumMap, json['visibility']),
      maxPartToRead: (json['maxPartToRead'] as num?)?.toInt(),
      maxPartToReserve: (json['maxPartToReserve'] as num?)?.toInt(),
    );

Map<String, dynamic> _$$KhatmaShareImplToJson(_$KhatmaShareImpl instance) {
  final val = <String, dynamic>{
    'visibility': _$ShareVisibilityEnumMap[instance.visibility]!,
  };

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('maxPartToRead', instance.maxPartToRead);
  writeNotNull('maxPartToReserve', instance.maxPartToReserve);
  return val;
}

const _$ShareVisibilityEnumMap = {
  ShareVisibility.private: 'private',
  ShareVisibility.group: 'group',
  ShareVisibility.public: 'public',
};
