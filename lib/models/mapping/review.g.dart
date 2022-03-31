part of '../review.dart';

Review _$ReviewFromJson(Map<dynamic, dynamic> json) {
  return Review(
    json['rating'] as int,
    json['title'] as String,
    json['message'] as String,
    json['username'] as String,
  );
}

Map<dynamic, dynamic> _$ReviewToJson(Review instance) => <dynamic, dynamic>{
      'rating': instance.rating,
      'message': instance.message,
      'username': instance.username,
    };
