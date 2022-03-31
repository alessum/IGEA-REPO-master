import 'medical_service.dart';
import 'package:json_annotation/json_annotation.dart';

part 'mapping/doctor.g.dart';

@JsonSerializable(explicitToJson: true, fieldRename: FieldRename.snake)
class Doctor {
  String _name;
  String _address;
  String _clinicName;
  String _cvPath;
  String _email;
  String _phoneNumber;
  String _specialization;
  List<MedicalService> _medicalServices;

  Doctor(
    this._name,
    this._address,
    this._clinicName,
    this._cvPath,
    this._email,
    this._phoneNumber,
    this._specialization,
    this._medicalServices,
  );

  String get name => _name;
  String get address => _address;
  String get clinicName => _clinicName;
  String get cvPath => _cvPath;
  String get email => _email;
  String get phoneNumber => _phoneNumber;
  String get specialization => _specialization;
  List<MedicalService> get medicalServices => _medicalServices;

  factory Doctor.fromJson(Map<dynamic, dynamic> json) => _$DoctorFromJson(json);
  Map<dynamic, dynamic> toJson() => _$DoctorToJson(this);
}
