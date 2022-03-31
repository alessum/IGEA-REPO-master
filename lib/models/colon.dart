import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:igea_app/models/colon_familiarity_risk.dart';
import 'package:igea_app/models/reservable_test.dart';
import 'package:json_annotation/json_annotation.dart';
import 'constants/constants.dart';
import 'enums/test_type.dart';
import 'organ.dart';
import 'status.dart';

part 'mapping/colon.g.dart';

@JsonSerializable(explicitToJson: true)
class Colon extends Organ {
  @JsonKey(name: 'familiarity')
  ColonFamiliarityRisk _familiarityRisk;

  Colon(String name, Status status, String description)
      : super(name, status, description) {
    imagePath = Constants.ORGAN_COLON_IMAGE_PATH;

    reservableTestList = [
      ReservableTest(
        'description',
        'Sangue occulto feci',
        TestType.SOF,
        Constants.COLON_KEY,
        'videoPath',
        [
          'Colonscopia',
          'Sigmoidoscopia',
          'Clisma opaco',
        ],
      ),
    ];
  }

  factory Colon.fromJson(Map<dynamic, dynamic> json) => _$ColonFromJson(json);
  Map<dynamic, dynamic> toJson() => _$ColonToJson(this);

  //getter
  ColonFamiliarityRisk get familiarityRisk => _familiarityRisk;

  //setter
  set colonFamiliarity(_colonFamiliarity) =>
      this._familiarityRisk = _colonFamiliarity;
}
