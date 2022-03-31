// GENERATED CODE - DO NOT MODIFY BY HAND

part of '../user.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PrevengoUser _$UserFromJson(Map<String, dynamic> json) {
  return PrevengoUser()
    ..firstAccess = json['first_access'] as bool
    ..registryData = json['registry_data'] == null
        ? null
        : RegistryData.fromJson(json['registry_data'] as Map<String, dynamic>)
    ..wallet = json['wallet'] == null
        ? null
        : Wallet.fromJson(json['wallet'] as Map<String, dynamic>)
    ..gamificationData = GamificationData.fromJson(
        json['gamification_data'] as Map<String, dynamic>);
}

Map<String, dynamic> _$UserToJson(PrevengoUser instance) => <String, dynamic>{
      'first_access': instance.firstAccess,
      'registry_data': instance.registryData?.toJson(),
      'wallet': instance.wallet?.toJson(),
      'gamification_data': instance.gamificationData?.toJson(),
    };
