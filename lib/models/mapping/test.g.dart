part of '../test.dart';

Test _$TestFromJson(Map<dynamic, dynamic> json) {
  return Test(
    json['name'] as String,
    json['organ_key'] as String,
    _$enumDecodeNullable(_$TestTypeEnumMap, json['type']),
    json['description'] as String,
  )
    ..reservation = json['reservation'] == null
        ? null
        : Reservation.fromJson(json['reservation'] as Map<dynamic, dynamic>)
    ..outcome =
        json['outcome'] == null ? null : getFromJsonOutcomeFromTestType(json);
}

Map<String, dynamic> _$TestToJson(Test instance) => <String, dynamic>{
      'name': instance.name,
      'organ_key': instance.organKey,
      'type': _$TestTypeEnumMap[instance.type],
      'description': instance.descritpion,
      'reservation': instance.reservation?.toJson(),
      'outcome': getToJsonOutcomeFromTestType(instance.outcome, instance.type),
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

Outcome getFromJsonOutcomeFromTestType(Map<dynamic, dynamic> json) {
  TestType type = _$enumDecodeNullable(_$TestTypeEnumMap, json['type']);
  if (type == TestType.PAP_TEST ||
      type == TestType.HPV_DNA ||
      type == TestType.MAMMOGRAPHY ||
      type == TestType.SOF ||
      type == TestType.GENERIC_TEST) {
    return OutcomeScreening.fromJson(json['outcome'] as Map<dynamic, dynamic>);
  }
  // else
  //   return OutcomeBloodTest.fromJson(json['outcome'] as Map<dynamic, dynamic>);
}

Map<String, dynamic> getToJsonOutcomeFromTestType(
    Outcome outcome, TestType type) {
  if (type == TestType.PAP_TEST ||
      type == TestType.HPV_DNA ||
      type == TestType.MAMMOGRAPHY ||
      type == TestType.SOF ||
      type == TestType.GENERIC_TEST) {
    return (outcome as OutcomeScreening)?.toJson();
  }
  // else
  //   return (outcome as OutcomeBloodTest)?.toJson();
}

final _$TestTypeEnumMap = {
  TestType.PAP_TEST: TestType.PAP_TEST.index,
  TestType.HPV_DNA: TestType.HPV_DNA.index,
  TestType.MAMMOGRAPHY: TestType.MAMMOGRAPHY.index,
  TestType.SOF: TestType.SOF.index,
  TestType.BLOOD_TEST: TestType.BLOOD_TEST.index,
  TestType.CARDIO_TEST: TestType.CARDIO_TEST.index,
  TestType.ECO_TSA: TestType.ECO_TSA.index,
  TestType.GENERIC_TEST: TestType.GENERIC_TEST.index,
};
