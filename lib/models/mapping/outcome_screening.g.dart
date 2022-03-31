// GENERATED CODE - DO NOT MODIFY BY HAND

part of '../outcome_screening.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

OutcomeScreening _$OutcomeScreeningTestFromJson(Map<String, dynamic> json) {
  return OutcomeScreening(json['description'] as String)
    ..outcomeFilePath = json['outcome_file_path'] as String;
}

Map<String, dynamic> _$OutcomeScreeningTestToJson(OutcomeScreening instance) =>
    <String, dynamic>{
      'outcome_file_path': instance?.outcomeFilePath,
      'description': instance?._description,
    };
