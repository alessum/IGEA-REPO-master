// GENERATED CODE - DO NOT MODIFY BY HAND

part of '../reservable_test.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ReservableTest _$ReservableTestFromJson(Map<dynamic, dynamic> json) {
  return ReservableTest(
    json['description'] as String,
    json['name'] as String,
    _$enumDecodeNullable(_$TestTypeEnumMap, json['type']),
    json['organ_key'] as String,
    json['video_path'] as String,
    json['in_depth_test_list'] as List<String>,
  );
}

Map<dynamic, dynamic> _$ReservableTestToJson(ReservableTest instance) =>
    <dynamic, dynamic>{
      'description': instance.description,
      'name': instance.name,
      'type': instance.type.index,
      'organ_key': instance.organKey,
      'video_path': instance.videoPath,
    };

T _$enumDecode<T>(
  Map<T, dynamic> enumValues,
  dynamic source, {
  T unknownValue,
}) {
  if (source == null) {
    throw ArgumentError('A value must be provided. Supported values: '
        '${enumValues.values.join(', ')}');
  }

  final value = TestType.values[source];

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

final _$TestTypeEnumMap = {
  TestType.PAP_TEST: TestType.PAP_TEST.index,
  TestType.HPV_DNA: TestType.HPV_DNA.index,
  TestType.MAMMOGRAPHY: TestType.MAMMOGRAPHY.index,
  TestType.SOF: TestType.SOF.index,
  TestType.BLOOD_TEST: TestType.BLOOD_TEST.index,
};
