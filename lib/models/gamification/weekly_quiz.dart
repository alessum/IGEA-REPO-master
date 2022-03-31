import 'package:igea_app/models/gamification/question.dart';
import 'package:json_annotation/json_annotation.dart';

part '../mapping/weekly_quiz.g.dart';

@JsonSerializable(
  fieldRename: FieldRename.snake,
  explicitToJson: true,
)
class WeeklyQuiz {
  WeeklyQuiz();

  bool _inProgress;
  DateTime _startQuizDate;
  List<Question> _questionList;
  int _correctAnswersCount;

  //getter
  bool get inProgress => _inProgress;
  DateTime get startQuizDate => _startQuizDate;
  List<Question> get questionList => _questionList;
  int get correctAnswersCount => _correctAnswersCount;

  //setter
  set inProgress(inProgress) => _inProgress = inProgress;
  set startQuizDate(startQuizDate) => _startQuizDate = startQuizDate;
  set questionList(questionList) => _questionList = questionList;
  set correctAnswersCount(correctAnswersCount) => _correctAnswersCount = correctAnswersCount;

  factory WeeklyQuiz.fromJson(Map<dynamic, dynamic> json) =>
      _$WeeklyQuizFromJson(json);
  Map<dynamic, dynamic> toJson() => _$WeeklyQuizToJson(this);
}
