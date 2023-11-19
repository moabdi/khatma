// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'khatma.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$KhatmaImpl _$$KhatmaImplFromJson(Map<String, dynamic> json) => _$KhatmaImpl(
      id: json['id'] as String?,
      name: json['name'] as String,
      description: json['description'] as String?,
      createDate: DateTime.parse(json['createDate'] as String),
      endDate: json['endDate'] == null
          ? null
          : DateTime.parse(json['endDate'] as String),
      creator: json['creator'] as String?,
      style: KhatmaStyle.fromJson(json['style'] as Map<String, dynamic>),
      lastRead: json['lastRead'] == null
          ? null
          : DateTime.parse(json['lastRead'] as String),
      completedParts: (json['completedParts'] as List<dynamic>?)
          ?.map((e) => e as int)
          .toList(),
      parts: (json['parts'] as List<dynamic>?)
          ?.map((e) => KhatmaPart.fromJson(e as Map<String, dynamic>))
          .toList(),
      recurrence:
          Recurrence.fromJson(json['recurrence'] as Map<String, dynamic>),
      unit: $enumDecode(_$SplitUnitEnumMap, json['unit']),
      share: KhatmaShare.fromJson(json['share'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$$KhatmaImplToJson(_$KhatmaImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'description': instance.description,
      'createDate': instance.createDate.toIso8601String(),
      'endDate': instance.endDate?.toIso8601String(),
      'creator': instance.creator,
      'style': instance.style,
      'lastRead': instance.lastRead?.toIso8601String(),
      'completedParts': instance.completedParts,
      'parts': instance.parts,
      'recurrence': instance.recurrence,
      'unit': _$SplitUnitEnumMap[instance.unit]!,
      'share': instance.share,
    };

const _$SplitUnitEnumMap = {
  SplitUnit.sourat: 'sourat',
  SplitUnit.juzz: 'juzz',
  SplitUnit.hizb: 'hizb',
  SplitUnit.half: 'half',
  SplitUnit.rubue: 'rubue',
  SplitUnit.thumun: 'thumun',
};

_$KhatmaStyleImpl _$$KhatmaStyleImplFromJson(Map<String, dynamic> json) =>
    _$KhatmaStyleImpl(
      color: json['color'] as String,
      icon: json['icon'] as String,
    );

Map<String, dynamic> _$$KhatmaStyleImplToJson(_$KhatmaStyleImpl instance) =>
    <String, dynamic>{
      'color': instance.color,
      'icon': instance.icon,
    };

_$RecurrenceImpl _$$RecurrenceImplFromJson(Map<String, dynamic> json) =>
    _$RecurrenceImpl(
      repeat: json['repeat'] as bool? ?? false,
      startDate: DateTime.parse(json['startDate'] as String),
      endDate: DateTime.parse(json['endDate'] as String),
      unit: $enumDecodeNullable(_$RepeatIntervalEnumMap, json['unit']) ??
          RepeatInterval.auto,
      days: (json['days'] as List<dynamic>?)?.map((e) => e as int).toList(),
      frequency: json['frequency'] as int?,
    );

Map<String, dynamic> _$$RecurrenceImplToJson(_$RecurrenceImpl instance) =>
    <String, dynamic>{
      'repeat': instance.repeat,
      'startDate': instance.startDate.toIso8601String(),
      'endDate': instance.endDate.toIso8601String(),
      'unit': _$RepeatIntervalEnumMap[instance.unit]!,
      'days': instance.days,
      'frequency': instance.frequency,
    };

const _$RepeatIntervalEnumMap = {
  RepeatInterval.auto: 'auto',
  RepeatInterval.daily: 'daily',
  RepeatInterval.weekly: 'weekly',
  RepeatInterval.monthly: 'monthly',
};

_$KhatmaPartImpl _$$KhatmaPartImplFromJson(Map<String, dynamic> json) =>
    _$KhatmaPartImpl(
      id: json['id'] as int,
      userId: json['userId'] as String?,
      userName: json['userName'] as String?,
      addedDate: json['addedDate'] == null
          ? null
          : DateTime.parse(json['addedDate'] as String),
      finishedDate: json['finishedDate'] == null
          ? null
          : DateTime.parse(json['finishedDate'] as String),
      remindTimes: json['remindTimes'] as int?,
    );

Map<String, dynamic> _$$KhatmaPartImplToJson(_$KhatmaPartImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'userId': instance.userId,
      'userName': instance.userName,
      'addedDate': instance.addedDate?.toIso8601String(),
      'finishedDate': instance.finishedDate?.toIso8601String(),
      'remindTimes': instance.remindTimes,
    };

_$KhatmaShareImpl _$$KhatmaShareImplFromJson(Map<String, dynamic> json) =>
    _$KhatmaShareImpl(
      visibility: $enumDecode(_$ShareVisibilityEnumMap, json['visibility']),
      maxPartToRead: json['maxPartToRead'] as int?,
      maxPartToReserve: json['maxPartToReserve'] as int?,
    );

Map<String, dynamic> _$$KhatmaShareImplToJson(_$KhatmaShareImpl instance) =>
    <String, dynamic>{
      'visibility': _$ShareVisibilityEnumMap[instance.visibility]!,
      'maxPartToRead': instance.maxPartToRead,
      'maxPartToReserve': instance.maxPartToReserve,
    };

const _$ShareVisibilityEnumMap = {
  ShareVisibility.private: 'private',
  ShareVisibility.group: 'group',
  ShareVisibility.public: 'public',
};
