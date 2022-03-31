import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:igea_app/models/reservable_test.dart';
import 'package:json_annotation/json_annotation.dart';
import 'constants/constants.dart';
import 'enums/test_type.dart';
import 'organ.dart';
import 'status.dart';

part 'mapping/uterus.g.dart';

@JsonSerializable(explicitToJson: true)
class Uterus extends Organ {
  @JsonKey(name: 'hpv_vaccine')
  bool _hpvVaccine;

  Uterus(String name, Status status, String description)
      : super(name, status, description) {
    imagePath = Constants.ORGAN_UTERUS_IMAGE_PATH;
    reservableTestList = [
      ReservableTest(
        'desc',
        'Pap-Test',
        TestType.PAP_TEST,
        Constants.UTERUS_KEY,
        'path//',
        ['Colposcopia'],
      ),
      ReservableTest(
        'desc',
        'Hpv-DNA Test',
        TestType.HPV_DNA,
        Constants.UTERUS_KEY,
        'path//',
        ['Colposcopia'],
      ),
    ];
  }

  factory Uterus.fromJson(Map<dynamic, dynamic> json) => _$UterusFromJson(json);
  Map<dynamic, dynamic> toJson() => _$UterusToJson(this);

  //getter
  bool get hpvVaccine => _hpvVaccine;

  //setter
  set hpvVaccine(_hpvVaccine) => this._hpvVaccine = _hpvVaccine;
}
