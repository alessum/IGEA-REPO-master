import 'package:json_annotation/json_annotation.dart';
import 'enums/test_type.dart';

part 'mapping/reservable_test.g.dart';

@JsonSerializable()
class ReservableTest {
  ReservableTest(String description, String name, TestType type,
      String organKey, String videoPath, List<String> inDepthTestList) {
    this._description = description;
    this._name = name;
    this._type = type;
    this._organKey = organKey;
    this._videoPath = videoPath;
    this._inDepthTestList = inDepthTestList;
  }

  @JsonKey(name: 'description')
  String _description;
  @JsonKey(name: 'title')
  String _name;
  @JsonKey(name: 'type')
  TestType _type;
  @JsonKey(name: 'organ_key')
  String _organKey;
  @JsonKey(name: 'video_path')
  String _videoPath;
  List<String> _inDepthTestList;

  //getter
  String get description => _description;
  String get name => _name;
  TestType get type => _type;
  String get organKey => _organKey;
  String get videoPath => _videoPath;
  List<String> get inDepthTestList => _inDepthTestList;

  set name(_name) => this._name = _name;

  factory ReservableTest.fromJson(Map<dynamic, dynamic> json) =>
      _$ReservableTestFromJson(json);
  Map<dynamic, dynamic> toJson() => _$ReservableTestToJson(this);
}
