// GENERATED CODE - DO NOT MODIFY BY HAND

part of '../gamification/coupon.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Coupon _$CouponFromJson(Map<String, dynamic> json) {
  return Coupon()
    ..brand = json['brand'] as String
    ..title = json['title'] as String
    ..logoImage = json['logo_image'] as String
    ..code = json['code'] as String
    ..value = (json['value'] as num)?.toDouble()
    ..price = (json['price'] as num)?.toDouble();
}

Map<String, dynamic> _$CouponToJson(Coupon instance) => <String, dynamic>{
      'brand' : instance.brand,
      'title': instance.title,
      'logo_image' : instance.logoImage,
      'code': instance.code,
      'value': instance.value,
      'price': instance.price,
    };
