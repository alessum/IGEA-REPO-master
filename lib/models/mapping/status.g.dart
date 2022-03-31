// GENERATED CODE - DO NOT MODIFY BY HAND

part of '../status.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Status _$StatusFromJson(Map<dynamic, dynamic> json) {
  return Status(
    json['name'] as String,
    json['color'] as String,
    json['icon'] as String,
    json['message'] as String,
    _$enumDecodeNullable(_$StatusTypeEnumMap, json['status_type']),
  );
}

T _$enumDecode<T>(
  Map<T, dynamic> enumValues,
  dynamic source, {
  T unknownValue,
}) {
  if (source == null) {
    throw ArgumentError('A value must be provided. Supported values: '
        '${enumValues.values.join(', ')}');
  }

  final value = StatusType.values[source];

  if (value == null && unknownValue == null) {
    throw ArgumentError('`$source` is not one of the supported values: '
        '${enumValues.values.join(', ')}');
  }
  return value ?? unknownValue;
}


T _$enumDecodeNullable<T>(
  Map<T, dynamic> enumValues,
  dynamic source, {
  T unknownValue,
}) {
  if (source == null) {
    return null;
  }
  return _$enumDecode<T>(enumValues, source, unknownValue: unknownValue);
}

final _$StatusTypeEnumMap = {
  StatusType.GOOD: StatusType.GOOD.index,
  StatusType.INACTIVE: StatusType.INACTIVE.index,
  StatusType.IS_IN_LATE: StatusType.IS_IN_LATE.index,
  StatusType.IS_TIME_TO_RESERVE: StatusType.IS_TIME_TO_RESERVE.index,
  StatusType.RESERVED: StatusType.RESERVED.index
};


Map<String, dynamic> _$StatusToJson(Status instance) => <String, dynamic>{
      'name': instance.name,
      'color': instance.color,
      'icon': instance.iconPath,
      'message': instance.message,
      'status_type': instance.statusType.index
    };
