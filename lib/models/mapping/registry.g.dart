// GENERATED CODE - DO NOT MODIFY BY HAND

part of '../registry.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

RegistryData _$RegistryFromJson(Map<dynamic, dynamic> json) {
  return RegistryData(
    json['username'] as String,
    json['name'] as String,
    json['surname'] as String,
    json['date_of_birth'] == null
        ? null
        : DateTime.parse(
            (json['date_of_birth'] as Timestamp).toDate().toString()),
    json['domicile'] as String,
    json['fiscal_code'] as String,
    _$enumDecodeNullable(_$GenderEnumMap, json['gender']),
  );
}

Map<dynamic, dynamic> _$RegistryToJson(RegistryData instance) => <String, dynamic>{
      'username': instance.username,
      'name': instance.name,
      'surname': instance.surname,
      'date_of_birth': instance.dateOfBirth?.toUtc(),
      'domicile': instance.domicile,
      'fiscal_code': instance.fiscalCode,
      'gender': _$GenderEnumMap[instance.gender],
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

  final value = Gender.values[source];

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

final _$GenderEnumMap = {
  Gender.MALE: Gender.MALE.index,
  Gender.FEMALE: Gender.FEMALE.index,
};
