// import 'package:igea_app/models/outcome.dart';
// import 'package:igea_app/models/outcome_blood_test.dart';
// import 'package:igea_app/models/reservation.dart';

// import 'enums/test_type.dart';
// import 'test.dart';
// import 'package:json_annotation/json_annotation.dart';

// part 'test_blood.g.dart';

// @JsonSerializable(explicitToJson: true)
// class BloodTest extends Test{
//   BloodTest(String name, String organKey, TestType type, String descritpion) : super(name, organKey, type, descritpion){
//     // this.hasOutcome = false;
//   }

//   @JsonKey(name: 'outcome')
//   OutcomeBloodTest _outcome;

//   //getter
//   OutcomeBloodTest get outcome => _outcome;

//   //setter
//   set outcome(_outcome) => this._outcome = _outcome;

//   factory BloodTest.fromJson(Map<dynamic, dynamic> json) => _$BloodTestFromJson(json);
//   Map<dynamic,dynamic> toJson() => _$BloodTestToJson(this);
// }