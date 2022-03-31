import 'package:igea_app/models/enums/screening_outcome_value.dart';
import 'package:igea_app/models/outcome.dart';
import 'package:json_annotation/json_annotation.dart';

part 'mapping/outcome_screening.g.dart';

@JsonSerializable()
class OutcomeScreening extends Outcome {
  OutcomeScreening(this._description);
  String _description;

  String get description => _description;
  set description(description) => _description = description;

  factory OutcomeScreening.fromJson(Map<String, dynamic> json) =>
      _$OutcomeScreeningTestFromJson(json);
  Map<String, dynamic> toJson() => _$OutcomeScreeningTestToJson(this);
}
