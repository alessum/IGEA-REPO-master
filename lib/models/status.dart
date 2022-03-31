import 'package:json_annotation/json_annotation.dart';

import 'enums/status_type.dart';

part 'mapping/status.g.dart';

@JsonSerializable()
class Status {
  // const Status(String name, String color, String iconPath, String message, StatusType statusType) {
  //   this._name = name;
  //   this._color = color;
  //   this._iconPath = iconPath;
  //   this._message = message;
  //   this._statusType = statusType;
  // }
  const Status(this._name, this._color, this._iconPath, this._message, this._statusType);

  @JsonKey(name: 'title')
  final String _name;
  @JsonKey(name: 'color')
  final String _color;
  @JsonKey(name: 'icon')
  final String _iconPath;
  @JsonKey(name: 'message')
  final String _message;
  @JsonKey(name: 'status_type')
  final StatusType _statusType;

  //getter
  String get name => _name;
  String get color => _color;
  String get iconPath => _iconPath;
  String get message => _message;
  StatusType get statusType => _statusType;

  factory Status.fromJson(Map<dynamic, dynamic> json) => _$StatusFromJson(json);
  Map<dynamic, dynamic> toJson() => _$StatusToJson(this);
}
