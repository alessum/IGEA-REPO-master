import 'package:igea_app/models/outcome.dart';
import 'package:igea_app/models/outcome_blood_test.dart';
import 'package:igea_app/models/outcome_factory.dart';
import 'package:igea_app/models/outcome_screening.dart';
import 'package:igea_app/models/reservation.dart';
import 'enums/test_type.dart';
import 'package:json_annotation/json_annotation.dart';

part 'mapping/test.g.dart';

@JsonSerializable(
  fieldRename: FieldRename.snake,
  explicitToJson: true,
)
class Test {
  Test(name, organKey, type, descritpion) {
    this._name = name;
    this._organKey = organKey;
    this._type = type;
    this._descritpion = descritpion;
  }

  @JsonKey(name: 'name')
  String _name;
  @JsonKey(name: 'organ_key')
  String _organKey;
  @JsonKey(name: 'type')
  TestType _type;
  @JsonKey(name: 'descritpion')
  String _descritpion;
  @JsonKey(name: 'reservation')
  Reservation _reservation;
  @JsonKey(name: 'outcome')
  Outcome _outcome;

  // Getter
  String get name => _name;
  String get organKey => _organKey;
  TestType get type => _type;
  String get descritpion => _descritpion;
  Reservation get reservation => _reservation;
  Outcome get outcome => _outcome;

  // Setter
  set reservation(_reservation) => this._reservation = _reservation;
  set outcome(_outcome) => this._outcome = _outcome;

  factory Test.fromJson(Map<dynamic, dynamic> json) => _$TestFromJson(json);
  Map<dynamic, dynamic> toJson() => _$TestToJson(this);

  void createReservation(Map<String, dynamic> reservationData) {
    //TODO check sui dati in input
    reservation = Reservation.fromJson(reservationData);
  }

  @override
  Outcome createOutcomeFromJson(Map<String, dynamic> json) {
    switch (this._type) {
      case TestType.PAP_TEST:
        return OutcomeScreening.fromJson(
            json['outcome'] as Map<dynamic, dynamic>);
        break;
      case TestType.HPV_DNA:
        return OutcomeScreening.fromJson(
            json['outcome'] as Map<dynamic, dynamic>);
        break;
      case TestType.MAMMOGRAPHY:
        return OutcomeScreening.fromJson(
            json['outcome'] as Map<dynamic, dynamic>);
        break;
      case TestType.SOF:
        return OutcomeScreening.fromJson(
            json['outcome'] as Map<dynamic, dynamic>);
        break;
      // case TestType.BLOOD_TEST:
      //   return OutcomeBloodTest.fromJson(
      //       json['outcome'] as Map<dynamic, dynamic>);
      //   break;
      default:
        return null;
        break;
    }
  }
}
