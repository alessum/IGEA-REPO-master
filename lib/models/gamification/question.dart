import 'package:igea_app/models/gamification/answer.dart';
import 'package:json_annotation/json_annotation.dart';

part '../mapping/question.g.dart';

@JsonSerializable(
  fieldRename: FieldRename.snake,
  explicitToJson: true,
)
class Question {
  
  Question();

  String _text;
  String _curiosity;
  List<Answer> _answerList;
  bool _isCorrect;

  //getter
  String get text => _text;
  String get curiosity => _curiosity;
  List<Answer> get answerList => _answerList;
  bool get isCorrect => _isCorrect;

  //setter
  set text(text) => _text = text;
  set curiosity(curiosity) => _curiosity = curiosity;
  set answerList(answerList) => _answerList = answerList;
  set isCorrect(isCorrect) => _isCorrect = isCorrect;

  factory Question.fromJson(Map<dynamic, dynamic> json) =>
      _$QuestionFromJson(json);
  Map<dynamic, dynamic> toJson() => _$QuestionToJson(this);
}
