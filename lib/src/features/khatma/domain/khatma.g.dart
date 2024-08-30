// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'khatma.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$KhatmaImpl _$$KhatmaImplFromJson(Map json) => _$KhatmaImpl(
      id: json['id'] as String?,
      code: json['code'] as String,
      name: json['name'] as String,
      description: json['description'] as String?,
      createDate: DateTime.parse(json['createDate'] as String),
      endDate: json['endDate'] == null
          ? null
          : DateTime.parse(json['endDate'] as String),
      creator: json['creator'] as String?,
      style:
          KhatmaStyle.fromJson(Map<String, Object?>.from(json['style'] as Map)),
      lastRead: json['lastRead'] == null
          ? null
          : DateTime.parse(json['lastRead'] as String),
      parts: (json['parts'] as List<dynamic>?)
          ?.map((e) => KhatmaPart.fromJson(Map<String, Object?>.from(e as Map)))
          .toList(),
      recurrence: Recurrence.fromJson(
          Map<String, Object?>.from(json['recurrence'] as Map)),
      unit: $enumDecode(_$SplitUnitEnumMap, json['unit']),
      share:
          KhatmaShare.fromJson(Map<String, Object?>.from(json['share'] as Map)),
    );

Map<String, dynamic> _$$KhatmaImplToJson(_$KhatmaImpl instance) {
  final val = <String, dynamic>{
    'code': instance.code,
    'name': instance.name,
  };

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('description', instance.description);
  val['createDate'] = instance.createDate.toIso8601String();
  writeNotNull('endDate', instance.endDate?.toIso8601String());
  writeNotNull('creator', instance.creator);
  val['style'] = instance.style.toJson();
  writeNotNull('lastRead', instance.lastRead?.toIso8601String());
  writeNotNull('parts', instance.parts?.map((e) => e.toJson()).toList());
  val['recurrence'] = instance.recurrence.toJson();
  val['unit'] = _$SplitUnitEnumMap[instance.unit]!;
  val['share'] = instance.share.toJson();
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

_$KhatmaStyleImpl _$$KhatmaStyleImplFromJson(Map json) => _$KhatmaStyleImpl(
      color: json['color'] as String,
      icon: json['icon'] as String,
    );

Map<String, dynamic> _$$KhatmaStyleImplToJson(_$KhatmaStyleImpl instance) =>
    <String, dynamic>{
      'color': instance.color,
      'icon': instance.icon,
    };

_$RecurrenceImpl _$$RecurrenceImplFromJson(Map json) => _$RecurrenceImpl(
      repeat: json['repeat'] as bool? ?? false,
      startDate: DateTime.parse(json['startDate'] as String),
      endDate: DateTime.parse(json['endDate'] as String),
      unit: $enumDecodeNullable(_$RepeatIntervalEnumMap, json['unit']) ??
          RepeatInterval.auto,
      days: (json['days'] as List<dynamic>?)
          ?.map((e) => (e as num).toInt())
          .toList(),
      frequency: (json['frequency'] as num?)?.toInt(),
    );

Map<String, dynamic> _$$RecurrenceImplToJson(_$RecurrenceImpl instance) {
  final val = <String, dynamic>{
    'repeat': instance.repeat,
    'startDate': instance.startDate.toIso8601String(),
    'endDate': instance.endDate.toIso8601String(),
    'unit': _$RepeatIntervalEnumMap[instance.unit]!,
  };

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

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
      addedDate: json['addedDate'] == null
          ? null
          : DateTime.parse(json['addedDate'] as String),
      finishedDate: json['finishedDate'] == null
          ? null
          : DateTime.parse(json['finishedDate'] as String),
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
  writeNotNull('addedDate', instance.addedDate?.toIso8601String());
  writeNotNull('finishedDate', instance.finishedDate?.toIso8601String());
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
