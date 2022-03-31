// GENERATED CODE - DO NOT MODIFY BY HAND

part of '../gamification/answer.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Answer _$AnswerFromJson(Map<String, dynamic> json) {
  return Answer()
    ..isCorrect = json['is_correct']
    ..text = json['text'];
}

Map<String, dynamic> _$AnswerToJson(Answer instance) => <String, dynamic>{
      'is_correct': instance.isCorrect,
      'text': instance.text,
    };
