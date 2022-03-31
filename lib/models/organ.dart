import 'package:igea_app/models/reservable_test.dart';
import 'package:json_annotation/json_annotation.dart';
import 'status.dart';

abstract class Organ {
  Organ(this._name, this._status, this._description);

  @JsonKey(name: 'name')
  String _name;
  @JsonKey(name: 'status')
  Status _status;
  @JsonKey(name: 'image_path')
  String _imagePath;
  @JsonKey(name: 'description')
  String _description;
  @JsonKey(name: 'active')
  bool _active;
  @JsonKey(name: 'positive')
  bool _positive;
  @JsonKey(name: 'next_test_date')
  DateTime _nextExamDate;
  @JsonKey(name: 'last_test_date')
  DateTime _lastExamDate;

  @JsonKey(name: 'reservable_test_list')
  List<ReservableTest> _reservableTestList;

  //getter
  String get name => _name;
  Status get status => _status;
  String get imagePath => _imagePath;
  String get description => _description;
  bool get isPositive => _positive;
  bool get isactive => _active;
  DateTime get nextTestDate => _nextExamDate;
  DateTime get lastTestDate => _lastExamDate;
  List<ReservableTest> get reservableTestList => _reservableTestList;


  //setter
  set name(_name) => this._name = _name;
  set status(_status) => this._status = _status;
  set imagePath(_imagePath) => this._imagePath = _imagePath;
  set description(_description) => this._description = _description;
  set active(_active) => this._active = _active;
  set positive(_positive) => this._positive = _positive;
  set nextTestDate(_nextExamDate) => this._nextExamDate = _nextExamDate;
  set lastTestDate(_lastExamDate) => this._lastExamDate = _lastExamDate;
  set reservableTestList(_reservableTestList) =>
      this._reservableTestList = _reservableTestList;
}
