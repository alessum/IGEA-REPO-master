import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:json_annotation/json_annotation.dart';
import 'organ.dart';
import 'reservable_test.dart';
import 'status.dart';
import 'familiarity_tumor.dart';
import 'breast_familiarity_risk.dart';

part 'mapping/breast.g.dart';

@JsonSerializable(explicitToJson: true, fieldRename: FieldRename.snake)
class Breast extends Organ {
  BreastFamiliarityRisk _familiarityRisk;

  Breast(String name, Status status, String description)
      : super(name, status, description);

  factory Breast.fromJson(Map<dynamic, dynamic> json) => _$BreastFromJson(json);
  Map<dynamic, dynamic> toJson() => _$BreastToJson(this);

  //get
  BreastFamiliarityRisk get familiarityRisk => _familiarityRisk;
  //set
  set familiarityRisk(familiarityRisk) => _familiarityRisk = familiarityRisk;
}
