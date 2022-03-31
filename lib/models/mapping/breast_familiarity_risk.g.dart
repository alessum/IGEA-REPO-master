part of '../breast_familiarity_risk.dart';

BreastFamiliarityRisk _$BreastFamiliarityRiskFromJson(
    Map<dynamic, dynamic> json) {
  return BreastFamiliarityRisk(
    json['title'] as String,
    json['icon_path'] as String,
    json['message'] as String,
    _$enumDecodeNullable(_$BreastFamiliarityTypeEnumMap, json['type']),
  );
}

Map<dynamic, dynamic> _$BreastFamiliarityRiskToJson(
        BreastFamiliarityRisk instance) =>
    <dynamic, dynamic>{
      'title': instance.title,
      'icon_path': instance.iconPath,
      'message': instance.message,
      'type': _$BreastFamiliarityTypeEnumMap[instance.type],
    };

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

T _$enumDecode<T>(
  Map<T, dynamic> enumValues,
  dynamic source, {
  T unknownValue,
}) {
  if (source == null) {
    throw ArgumentError('A value must be provided. Supported values: '
        '${enumValues.values.join(', ')}');
  }

  final value = BreastFamiliarityType.values[source];

  if (value == null && unknownValue == null) {
    throw ArgumentError('`$source` is not one of the supported values: '
        '${enumValues.values.join(', ')}');
  }
  return value ?? unknownValue;
}

final _$BreastFamiliarityTypeEnumMap = {
  BreastFamiliarityType.HIGH: BreastFamiliarityType.HIGH.index,
  BreastFamiliarityType.MODERATE: BreastFamiliarityType.MODERATE.index,
  BreastFamiliarityType.LOW: BreastFamiliarityType.LOW.index,
  BreastFamiliarityType.NULL: BreastFamiliarityType.NULL.index,
};
