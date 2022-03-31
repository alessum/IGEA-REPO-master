// GENERATED CODE - DO NOT MODIFY BY HAND

part of '../gamification/gamification_data.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

GamificationData _$GamificationDataFromJson(Map<String, dynamic> json) {
  return GamificationData()
    ..dailyQuizScore = json['daily_score'] as int
    ..monthlyQuizScore = json['monthly_score'] as int;
}

Map<String, dynamic> _$GamificationDataToJson(GamificationData instance) =>
    <String, dynamic>{
      'daily_score': instance.dailyQuizScore,
      'monthly_score': instance.monthlyQuizScore,
    };
