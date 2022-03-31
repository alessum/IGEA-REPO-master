// import 'package:igea_app/models/reservation.dart';

// import 'enums/test_type.dart';
// import 'outcome_screening_test.dart';
// import 'test.dart';
// import 'package:json_annotation/json_annotation.dart';

// part 'mapping/test_screening.g.dart';

// @JsonSerializable(explicitToJson: true)
// class ScreeningTest extends Test{
//   ScreeningTest(String name, String organKey, TestType type, String descritpion) : super(name, organKey, type, descritpion){
//     // this.hasOutcome = false;
//   }

//   @JsonKey(name: 'outcome')
//   OutcomeScreening _outcome;

//     //getter
//   OutcomeScreening get outcome => _outcome;

//   //setter
//   set outcome(_outcome) => this._outcome = _outcome;

//   factory ScreeningTest.fromJson(Map<dynamic, dynamic> json) => _$ScreeningTestFromJson(json);
//   Map<dynamic,dynamic> toJson() => _$ScreeningTestToJson(this);
  
//   @override
//   void createOutcome(Map<String, Object> outcomeData) {
//     outcome = outcomeData;
//   }
// }