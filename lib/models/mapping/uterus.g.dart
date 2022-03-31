// GENERATED CODE - DO NOT MODIFY BY HAND

part of '../uterus.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Uterus _$UterusFromJson(Map<String, dynamic> json) {
  return Uterus(
    json['name'] as String,
    json['status'] == null
        ? null
        : Status.fromJson(json['status'] as Map<String, dynamic>),
    json['description'] as String,
  )
    ..imagePath = json['image_path'] as String
    ..nextTestDate = json['next_test_date'] == null
        ? null
        : DateTime.parse((json['next_test_date'] as Timestamp).toDate().toString())
    ..lastTestDate = json['last_test_date'] == null
        ? null
        : DateTime.parse((json['last_test_date'] as Timestamp).toDate().toString())
    ..reservableTestList = (json['reservable_test_list'] as List)
        ?.map((e) => e == null
            ? null
            : ReservableTest.fromJson(e as Map<String, dynamic>))
        ?.toList()
    ..hpvVaccine = json['hpv_vaccine'] as bool;
}

Map<String, dynamic> _$UterusToJson(Uterus instance) => <String, dynamic>{
      'name': instance.name,
      'status': instance.status?.toJson(),
      'image_path': instance.imagePath,
      'description': instance.description,
      'next_test_date': instance.nextTestDate?.toIso8601String(),
      'last_test_date': instance.lastTestDate?.toIso8601String(),
      'reservable_test_list':
          instance.reservableTestList?.map((e) => e?.toJson())?.toList(),
      'hpv_vaccine': instance.hpvVaccine,
    };
