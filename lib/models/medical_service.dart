part 'mapping/medical_service.g.dart';

class MedicalService {
  String _name;
  double _price;

  MedicalService(this._name, this._price);

  String get name => _name;
  double get price => _price;

  factory MedicalService.fromJson(Map<dynamic, dynamic> json) =>
      _$MedicalServiceFromJson(json);
  Map<dynamic, dynamic> toJson() => _$MedicalServiceToJson(this);
}
