import 'package:json_annotation/json_annotation.dart';

part '../mapping/answer.g.dart';

@JsonSerializable(fieldRename: FieldRename.snake)
class Answer {

  Answer();

  bool _isCorrect;
  String _text;

  //getter
  get isCorrect => _isCorrect;
  get text => _text;

  //setter
  set isCorrect(isCorrect) => _isCorrect = isCorrect;
  set text(text) => _text = text;

  factory Answer.fromJson(Map<dynamic, dynamic> json) => _$AnswerFromJson(json);
  Map<dynamic, dynamic> toJson() => _$AnswerToJson(this);
}
