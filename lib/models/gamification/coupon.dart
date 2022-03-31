

import 'package:json_annotation/json_annotation.dart';

part '../mapping/coupon.g.dart';

@JsonSerializable(fieldRename: FieldRename.snake)
class Coupon{

  Coupon();

  String _brand;
  String _title;
  String _logoImage;
  String _code;
  double _value;
  double _price;

  //getter
  String get brand => _brand;
  String get title => _title;
  String get logoImage => _logoImage;
  String get code => _code;
  double get value => _value;
  double get price => _price;


  //setter
  set brand(brand) => _brand = brand;
  set title(title) => _title = title;
  set logoImage(logoImage) => _logoImage = logoImage;
  set code(code) => _code = code;
  set value(value) => _value = value;
  set price(price) => _price = price;

  factory Coupon.fromJson(Map<dynamic, dynamic> json) => _$CouponFromJson(json);
  Map<dynamic, dynamic> toJson() => _$CouponToJson(this);


}