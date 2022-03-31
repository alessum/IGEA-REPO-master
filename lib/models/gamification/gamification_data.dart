
import 'package:json_annotation/json_annotation.dart';

part '../mapping/gamification_data.g.dart';

@JsonSerializable(
  fieldRename: FieldRename.snake,
  // explicitToJson: true,
)
class GamificationData{

  GamificationData();

  int _dailyScore;
  int _monthlyScore;

  //getter
  int get dailyQuizScore => _dailyScore;
  int get monthlyQuizScore => _monthlyScore;


  //setter
  set dailyQuizScore(dailyQuizScore) => _dailyScore = dailyQuizScore;
  set monthlyQuizScore(monthlyQuizScore) => _monthlyScore = monthlyQuizScore;

  factory GamificationData.fromJson(Map<dynamic, dynamic> json) => _$GamificationDataFromJson(json);
  Map<dynamic, dynamic> toJson() => _$GamificationDataToJson(this);

}