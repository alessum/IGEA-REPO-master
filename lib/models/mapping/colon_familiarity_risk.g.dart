part of '../colon_familiarity_risk.dart';

ColonFamiliarityRisk _$ColonFamiliarityRiskFromJson(
    Map<dynamic, dynamic> json) {
  return ColonFamiliarityRisk(
    json['title'] as String,
    json['icon_path'] as String,
    json['message'] as String,
    _$enumDecodeNullable(_$ColonFamiliarityTypeEnumMap, json['type']),
  );
}

Map<dynamic, dynamic> _$ColonFamiliarityRiskToJson(
        ColonFamiliarityRisk instance) =>
    <dynamic, dynamic>{
      'title': instance.title,
      'icon_path': instance.iconPath,
      'message': instance.message,
      'type': _$ColonFamiliarityTypeEnumMap[instance.type],
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

  final value = ColonFamiliarityType.values[source];

  if (value == null && unknownValue == null) {
    throw ArgumentError('`$source` is not one of the supported values: '
        '${enumValues.values.join(', ')}');
  }
  return value ?? unknownValue;
}

final _$ColonFamiliarityTypeEnumMap = {
  ColonFamiliarityType.SYNDROM: ColonFamiliarityType.SYNDROM.index,
  ColonFamiliarityType.HIGH_OVER_40: ColonFamiliarityType.HIGH_OVER_40.index,
  ColonFamiliarityType.HIGH_UNDER_40: ColonFamiliarityType.HIGH_UNDER_40.index,
  ColonFamiliarityType.MEDIUM: ColonFamiliarityType.MEDIUM.index,
  ColonFamiliarityType.NULL: ColonFamiliarityType.NULL.index,
};
