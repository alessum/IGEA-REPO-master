// GENERATED CODE - DO NOT MODIFY BY HAND

part of '../gamification/weekly_quiz.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

WeeklyQuiz _$WeeklyQuizFromJson(Map<dynamic, dynamic> json) {
  return WeeklyQuiz()
    ..inProgress = json['in_progress'] as bool
    ..startQuizDate = json['start_quiz_date'] == null
        ? null
        : DateTime.parse(json['start_quiz_date'] as String)
    ..questionList = (json['question_list'] as List)
        ?.map((e) =>
            e == null ? null : Question.fromJson(e as Map<String, dynamic>))
        ?.toList()
    ..correctAnswersCount = json['correct_answers_count'] as int;
}

Map<String, dynamic> _$WeeklyQuizToJson(WeeklyQuiz instance) =>
    <String, dynamic>{
      'in_progress': instance.inProgress,
      'start_quiz_date': instance.startQuizDate?.toIso8601String(),
      'question_list': instance.questionList?.map((e) => e?.toJson())?.toList(),
      'correct_answers_count': instance.correctAnswersCount,
    };
