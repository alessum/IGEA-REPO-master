// import 'package:igea_app/models/outcome.dart';
// import 'package:json_annotation/json_annotation.dart';


// part 'mapping/outcome_blood_test.g.dart';

// @JsonSerializable()
// class OutcomeBloodTest extends Outcome {
//   OutcomeBloodTest(tryglicerides, cholesterolTot, cholesterolHDL, cholesterolLDL, systolicPressure, hypertension) {
//       this._tryglicerides = tryglicerides;
//       this._cholesterolTot = cholesterolTot;
//       this._cholesterolHDL = cholesterolHDL;
//       this._cholesterolLDL = cholesterolLDL;
//       this._systolicPressure = systolicPressure;
//       this._hypertension = hypertension;
//   }
//   @JsonKey(name: 'tryglicerides')
//   double _tryglicerides;
//   @JsonKey(name: 'cholesterol_tot')
//   double _cholesterolTot;
//   @JsonKey(name: 'cholesterol_hdl')
//   double _cholesterolHDL;
//   @JsonKey(name: 'cholesterol_ldl')
//   double _cholesterolLDL;

//   //TODO vedere se rimuovere dall'esito
//   @JsonKey(name: 'systolic_pressure')
//   double _systolicPressure;
//   @JsonKey(name: 'hypertension')
//   bool _hypertension;

//   //getter
//   double get tryglicerides => _tryglicerides;
//   double get cholesterolTot => _cholesterolTot;
//   double get cholesterolHDL => _cholesterolHDL;
//   double get cholesterolLDL => _cholesterolLDL;
//   double get systolicPressure => _systolicPressure;
//   bool get hypertension => _hypertension;

//   factory OutcomeBloodTest.fromJson(Map<dynamic, dynamic> json) =>
//       _$OutcomeBloodTestFromJson(json);
//   Map<dynamic, dynamic> toJson() => _$OutcomeBloodTestToJson(this);
// }
