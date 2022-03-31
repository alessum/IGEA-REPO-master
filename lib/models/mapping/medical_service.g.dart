part of '../medical_service.dart';

MedicalService _$MedicalServiceFromJson(Map<String, dynamic> json) {
  return MedicalService(
    json['name'] as String,
    (json['price'] as num)?.toDouble(),
  );
}

Map<dynamic, dynamic> _$MedicalServiceToJson(MedicalService instance) =>
    <dynamic, dynamic>{
      'name': instance.name,
      'price': instance.price,
    };
