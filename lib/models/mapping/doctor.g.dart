part of '../doctor.dart';

Doctor _$DoctorFromJson(Map<dynamic, dynamic> json) {
  return Doctor(
    json['name'] as String,
    json['address'] as String,
    json['clinic_name'] as String,
    json['cv_path'] as String,
    json['email'] as String,
    json['phone_number'] as String,
    json['specialization'] as String,
    (json['medical_services'] as List)
        ?.map(
          (e) => e == null
              ? null
              : MedicalService.fromJson(e as Map<String, dynamic>),
        )
        ?.toList(),
  );
}

Map<dynamic, dynamic> _$DoctorToJson(Doctor instance) => <dynamic, dynamic>{
      'name': instance.name,
      'address': instance.address,
      'clinic_name': instance.clinicName,
      'cv_path': instance.cvPath,
      'email': instance.email,
      'phone_number': instance.phoneNumber,
      'specialization': instance.specialization,
      'medical_services':
          instance.medicalServices?.map((e) => e?.toJson())?.toList(),
    };
