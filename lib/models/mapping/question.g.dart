// GENERATED CODE - DO NOT MODIFY BY HAND

part of '../gamification/question.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Question _$QuestionFromJson(Map<String, dynamic> json) {
  return Question()
    ..text = json['text'] as String
    ..curiosity = json['curiosity'] as String
    ..isCorrect = json['is_correct'] as bool
    ..answerList = (json['answer_list'] as List)
        ?.map((e) =>
            e == null ? null : Answer.fromJson(e as Map<String, dynamic>))
        ?.toList();
}

Map<String, dynamic> _$QuestionToJson(Question instance) => <String, dynamic>{
      'text': instance.text,
      'curiosity': instance.curiosity,
      'answer_list': instance.answerList?.map((e) => e?.toJson())?.toList(),
      'is_correct': instance.isCorrect,
    };
