import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:json_annotation/json_annotation.dart';
import 'enums/gender.dart';

part 'mapping/registry.g.dart';

@JsonSerializable(fieldRename: FieldRename.snake)
class RegistryData {
  String _username;
  String _name;
  String _surname;
  DateTime _dateOfBirth;
  String _domicile;
  String _fiscalCode;
  Gender _gender;

  RegistryData(String username, String name, String surname, DateTime dateOfBirth,
      String domicile, String fiscalCode, Gender gender) {
    this._username = username;
    this._name = name;
    this._surname = surname;
    this._dateOfBirth = dateOfBirth;
    this._domicile = domicile;
    this._fiscalCode = fiscalCode;
    this._gender = gender;
  }

  String get username => _username;
  String get name => _name;
  String get surname => _surname;
  DateTime get dateOfBirth => _dateOfBirth;
  String get domicile => _domicile;
  String get fiscalCode => _fiscalCode;
  Gender get gender => _gender;

  set username(username) => _username = username;
  set name(name) => _name = name;
  set surname(surname) => _surname = surname;
  set dateOfBirth(dateOfBirth) => _dateOfBirth = dateOfBirth;
  set domicile(domicile) => _domicile = domicile;
  set fiscalCode(fiscalCode) => _fiscalCode = fiscalCode;
  set gender(gender) => _gender = gender;

  factory RegistryData.fromJson(Map<dynamic, dynamic> json) =>
      _$RegistryFromJson(json);
  Map<dynamic, dynamic> toJson() => _$RegistryToJson(this);
}
