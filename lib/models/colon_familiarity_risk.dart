import 'package:igea_app/models/enums/colon_familiarity_type.dart';
import 'package:json_annotation/json_annotation.dart';

part 'mapping/colon_familiarity_risk.g.dart';

@JsonSerializable(
  fieldRename: FieldRename.snake,
)
class ColonFamiliarityRisk {
  const ColonFamiliarityRisk(
    this._title,
    this._iconPath,
    this._message,
    this._type,
  );

  final String _title;
  final String _iconPath;
  final String _message;
  final ColonFamiliarityType _type;

  String get title => _title;
  String get iconPath => _iconPath;
  String get message => _message;
  ColonFamiliarityType get type => _type;

  factory ColonFamiliarityRisk.fromJson(Map<dynamic, dynamic> json) => _$ColonFamiliarityRiskFromJson(json);
  Map<dynamic, dynamic> toJson() => _$ColonFamiliarityRiskToJson(this);
}