part of '../familiarity_tumor.dart';

FamiliarityTumor _$FamiliarityTumorFromJson(Map<dynamic, dynamic> json) {
  return FamiliarityTumor(
    _$parentTypeEnumDecode(_$ParentTypeEnumMap, json['parent_type']),
    _$tumorTypeEnumDecode(_$TumorTypeEnumMap, json['tumor_type']),
    json['label'] as String,
    json['tumor_count'] as int,
  );
}

Map<dynamic, dynamic> _$FamiliarityTumorToJson(FamiliarityTumor instance) =>
    <dynamic, dynamic>{
      'parent_type': instance.parentType,
      'tumor_type': instance.tumorType,
      'tumor_count': instance.tumorCount,
      'label': instance.label
    };

  T _$parentTypeEnumDecode<T>(
    Map<T, dynamic> enumValues,
    dynamic source, {
    T unknownValue,
  }) {
    if (source == null) {
      return null;
    } else {
      final value = ParentType.values[source];
      if (value == null && unknownValue == null) {
        throw ArgumentError('`$source` is not one of the supported values: '
            '${enumValues.values.join(', ')}');
      }
      return value ?? unknownValue;
    }
  }

  T _$tumorTypeEnumDecode<T>(
    Map<T, dynamic> enumValues,
    dynamic source, {
    T unknownValue,
  }) {
    if (source == null) {
      return null;
    } else {
      final value = TumorType.values[source];
      if (value == null && unknownValue == null) {
        throw ArgumentError('`$source` is not one of the supported values: '
            '${enumValues.values.join(', ')}');
      }
      return value ?? unknownValue;
    }
  }

  final _$ParentTypeEnumMap = {
    ParentType.MOTHER: ParentType.MOTHER.index,
    ParentType.FATHER: ParentType.FATHER.index,
    ParentType.BROTHER: ParentType.BROTHER.index,
    ParentType.SISTER: ParentType.SISTER.index,
    ParentType.UNCLE: ParentType.UNCLE.index,
    ParentType.AUNT: ParentType.AUNT.index,
    ParentType.GRANDMA: ParentType.GRANDMA.index,
    ParentType.GRANDPA: ParentType.GRANDPA.index
  };

  final _$TumorTypeEnumMap = {
    TumorType.BREAST: TumorType.BREAST.index,
    TumorType.PANCREAS: TumorType.PANCREAS.index,
    TumorType.PERITONEUM: TumorType.PERITONEUM.index,
    TumorType.OVERS: TumorType.OVERS.index
  };
