// GENERATED CODE - DO NOT MODIFY BY HAND

part of '../heart.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Heart _$HeartFromJson(Map<dynamic, dynamic> json) {
  return Heart(
    json['name'] as String,
    json['status'] == null
        ? null
        : Status.fromJson(json['status'] as Map<dynamic, dynamic>),
    json['description'] as String,
    (json['tryglicerides'] as num)?.toDouble(),
    (json['cholesterol_tot'] as num)?.toDouble(),
    (json['cholesterol_hdl'] as num)?.toDouble(),
    (json['cholesterol_ldl'] as num)?.toDouble(),
    (json['systolic_pressure'] as num)?.toDouble(),
    (json['diastolic_pressure'] as num)?.toDouble(),
    json['smoker'] as bool,
    json['diabetic'] as bool,
    json['treatment_blood_pressure'] as bool,
    json['hypertension'] as bool,
  )
    ..imagePath = json['image_path'] as String
    ..reservableTestList = (json['reservable_test_list'] as List)
        ?.map((e) => e == null
            ? null
            : ReservableTest.fromJson(e as Map<dynamic, dynamic>))
        ?.toList()
    ..heartNextBloodTest = json['heart_next_blood_test'] == null
        ? null
        : DateTime.parse((json['heart_next_blood_test'] as Timestamp).toDate().toString())
    ..heartNextCardioExamTest = json['heart_next_blood_test'] == null
        ? null
        : DateTime.parse((json['heart_next_cardio_exam_test'] as Timestamp).toDate().toString())
    ..vesselNextEcoTsaTest = json['vessel_next_eco_tsa_test'] == null
        ? null
        : DateTime.parse((json['vessel_next_eco_tsa_test'] as Timestamp).toDate().toString())
    ..vesselNextBloodTest = json['vessel_next_blood_test'] == null
        ? null
        : DateTime.parse((json['vessel_next_blood_test'] as Timestamp).toDate().toString())
    ..heartLastBloodTest = json['heart_last_blood_test'] == null
        ? null
        : DateTime.parse((json['heart_last_blood_test'] as Timestamp).toDate().toString())
    ..heartLastCardioExamTest = json['heart_last_cardio_exam_test'] == null
        ? null
        : DateTime.parse((json['heart_last_cardio_exam_test'] as Timestamp).toDate().toString())
    ..vesselLastBloodTest = json['vessel_last_blood_test'] == null
        ? null
        : DateTime.parse((json['vessel_last_blood_test'] as Timestamp).toDate().toString())
    ..vesselLastEcoTsaTest = json['vessel_last_eco_tsa_test'] == null
        ? null
        : DateTime.parse((json['vessel_last_eco_tsa_test'] as Timestamp).toDate().toString());
}

Map<String, dynamic> _$HeartToJson(Heart instance) => <String, dynamic>{
      'name': instance.name,
      'status': instance.status?.toJson(),
      'image_path': instance.imagePath,
      'description': instance.description,
      'reservable_test_list': instance.reservableTestList?.map((e) => e?.toJson())?.toList(),
      'smoker': instance.smoker,
      'diabetic': instance.diabetic,
      'treatment_blood_pressure': instance.treatedBloodPressure,
      'tryglicerides': instance.tryglicerides,
      'cholesterol_tot': instance.cholesterolTot,
      'cholesterol_hdl': instance.cholesterolHDL,
      'cholesterol_ldl': instance.cholesterolLDL,
      'systolic_pressure': instance.systolicPressure,
      'diastolic_pressure': instance.diastolicPressure,
      'hypertension': instance.hypertension,
      'heart_next_blood_test': instance.heartNextBloodTest?.toUtc(),
      'heart_next_cardio_exam_test':
          instance.heartNextCardioExamTest?.toUtc(),
      'vessel_next_eco_tsa_test': instance.vesselNextEcoTsaTest?.toUtc(),
      'vessel_next_blood_test': instance.vesselNextBloodTest?.toUtc(),
      'heartL_last_blood_test': instance.heartLastBloodTest?.toUtc(),
      'heart_last_cardio_exam_test':
          instance.heartLastCardioExamTest?.toUtc(),
      'vessel_last_blood_test': instance.vesselLastBloodTest?.toUtc(),
      'vessel_last_eco_tsa_test': instance.vesselLastEcoTsaTest?.toUtc(),
    };
