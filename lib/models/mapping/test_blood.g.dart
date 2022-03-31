// // GENERATED CODE - DO NOT MODIFY BY HAND
// part of 'test_blood.dart';

// // **************************************************************************
// // JsonSerializableGenerator
// // **************************************************************************



// BloodTest _$BloodTestFromJson(Map<dynamic, dynamic> json) {
//   return BloodTest(
//     json['name'] as String,
//     json['organ_key'] as String,
//     _$enumDecodeNullable(_$TestTypeEnumMap, json['type']),
//     json['descritpion'] as String,
//   )
//     ..reservation = json['reservation'] == null
//         ? null
//         : Reservation.fromJson(json['reservation'] as Map<dynamic, dynamic>)
//     ..outcome = json['outcome'] == null
//         ? null
//         : OutcomeBloodTest.fromJson(json['outcome'] as Map<dynamic, dynamic>);
//     // ..hasOutcome = json['has_outcome'] as bool;
// }

// Map<dynamic, dynamic> _$BloodTestToJson(BloodTest instance) => <dynamic, dynamic>{
//       'name': instance.name,
//       'organ_key': instance.organKey,
//       'type': _$TestTypeEnumMap[instance.type],
//       'descritpion': instance.descritpion,
//       'reservation': instance.reservation?.toJson(),
//       'outcome': instance.outcome?.toJson(),
//       // 'has_outcome' : instance.hasOutcome,
//     };

// T _$enumDecode<T>(
//   Map<T, dynamic> enumValues,
//   dynamic source, {
//   T unknownValue,
// }) {
//   if (source == null) {
//     throw ArgumentError('A value must be provided. Supported values: '
//         '${enumValues.values.join(', ')}');
//   }

//   final value = TestType.values[source];

//   if (value == null && unknownValue == null) {
//     throw ArgumentError('`$source` is not one of the supported values: '
//         '${enumValues.values.join(', ')}');
//   }
//   return value ?? unknownValue;
// }

// T _$enumDecodeNullable<T>(
//   Map<T, dynamic> enumValues,
//   dynamic source, {
//   T unknownValue,
// }) {
//   if (source == null) {
//     return null;
//   }
//   return _$enumDecode<T>(enumValues, source, unknownValue: unknownValue);
// }

// final _$TestTypeEnumMap = {
//   TestType.PAP_TEST: TestType.PAP_TEST.index,
//   TestType.HPV_DNA: TestType.HPV_DNA.index,
//   TestType.MAMMOGRAPHY: TestType.MAMMOGRAPHY.index,
//   TestType.SOF: TestType.SOF.index,
//   TestType.BLOOD_TEST: TestType.BLOOD_TEST.index,
//   TestType.CARDIO_TEST: TestType.CARDIO_TEST.index,
//   TestType.ECO_TSA: TestType.ECO_TSA.index,
// };
