import 'package:igea_app/models/enums/breast_familiarity_type.dart';
import 'package:json_annotation/json_annotation.dart';

part 'mapping/breast_familiarity_risk.g.dart';

@JsonSerializable(
  fieldRename: FieldRename.snake,
)
class BreastFamiliarityRisk {
  const BreastFamiliarityRisk(
    this._title,
    this._iconPath,
    this._message,
    this._type,
  );

  final String _title;
  final String _iconPath;
  final String _message;
  final BreastFamiliarityType _type;

  String get title => _title;
  String get iconPath => _iconPath;
  String get message => _message;
  BreastFamiliarityType get type => _type;

  factory BreastFamiliarityRisk.fromJson(Map<dynamic, dynamic> json) => _$BreastFamiliarityRiskFromJson(json);
  Map<dynamic, dynamic> toJson() => _$BreastFamiliarityRiskToJson(this);
}
