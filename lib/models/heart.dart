import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:igea_app/models/reservable_test.dart';
import 'package:json_annotation/json_annotation.dart';

import 'enums/ethnicity.dart';
import 'status.dart';
import 'organ.dart';


part 'mapping/heart.g.dart';

@JsonSerializable()
class Heart extends Organ {
  Heart(
    String name,
    Status status,
    String description,
    double tryglicerides,
    double cholesterolTot,
    double cholesterolHDL,
    double cholesterolLDL,
    double systolicPressure,
    double diastolicPressure,
    bool smoker,
    bool diabetic,
    bool treatedBloodPressure,
    bool hypertension,
  ) : super(name, status, description){
    this._tryglicerides = tryglicerides;
    this._cholesterolHDL = cholesterolHDL;
    this._cholesterolLDL = cholesterolLDL;
    this._cholesterolTot = cholesterolTot;
    this._systolicPressure = systolicPressure;
    this._diastolicPressure = diastolicPressure;
    this._smoker = smoker;
    this._diabetic = diabetic;
    this._treatedBloodPressure = treatedBloodPressure;
    this._hypertension = hypertension;
  }


  Ethnicity _ethnicity;
  bool _familiarity;
  bool _irc; // insufficenza renale cronica
  double _height;
  double _weight;
  double _bmi;
  int _rcv; // rischio cardio-vascolare
  bool _treatedBloodPressure;
  bool _smoker;
  bool _diabetic;
  double _tryglicerides;
  double _cholesterolTot;
  double _cholesterolHDL;
  double _cholesterolLDL;
  double _systolicPressure;
  double _diastolicPressure;
  bool _hypertension;

  DateTime _heartNextBloodTest;
  DateTime _heartNextCardioExamTest;
  DateTime _vesselNextEcoTsaTest;
  DateTime _vesselNextBloodTest;

  DateTime _heartLastBloodTest;
  DateTime _heartLastCardioExamTest;
  DateTime _vesselLastEcoTsaTest;
  DateTime _vesselLastBloodTest;

  //getter
  Ethnicity get ethnicity => _ethnicity;
  bool get familiarity => _familiarity;
  bool get irc => _irc;
  double get height => _height;
  double get weight => _weight;
  double get bmi => _bmi;
  int get rcv => _rcv;
  bool get smoker => _smoker;
  bool get diabetic => _diabetic;
  bool get treatedBloodPressure => _treatedBloodPressure;
  double get tryglicerides => _tryglicerides;
  double get cholesterolTot => _cholesterolTot;
  double get cholesterolHDL => _cholesterolHDL;
  double get cholesterolLDL => _cholesterolLDL;
  double get systolicPressure => _systolicPressure;
  double get diastolicPressure => _diastolicPressure;
  bool get hypertension => _hypertension;
  
  DateTime get heartNextBloodTest => _heartNextBloodTest;
  DateTime get heartNextCardioExamTest => _heartNextCardioExamTest;
  DateTime get vesselNextEcoTsaTest => _vesselNextEcoTsaTest;
  DateTime get vesselNextBloodTest => _vesselNextBloodTest;
  DateTime get heartLastBloodTest => _heartLastBloodTest;
  DateTime get heartLastCardioExamTest => _heartLastCardioExamTest;
  DateTime get vesselLastBloodTest => _vesselLastBloodTest;
  DateTime get vesselLastEcoTsaTest => _vesselLastEcoTsaTest;
  
  //setter
  set smoker(_smoker) => this._smoker = _smoker;
  set diabetic(_diabetic) => this._diabetic = _diabetic;
  set treatedBloodPressure(_treatedBloodPressure) => this._treatedBloodPressure = _treatedBloodPressure;
  set tryglicerides(_tryglicerides) => this._tryglicerides = _tryglicerides;
  set cholesterolTot(_cholesterolTot) => this._cholesterolTot = _cholesterolTot;
  set cholesterolLDL(_cholesterolLDL) => this._cholesterolLDL = _cholesterolLDL;
  set systolicPressure(_systolicPressure) =>
      this._systolicPressure = _systolicPressure;
  set diastolicPressure(_diastolicPressure) => this._diastolicPressure = _diastolicPressure;
  set hypertension(_hypertension) => this._hypertension = _hypertension;
  set heartNextBloodTest(_heartNextBloodTest) => this._heartNextBloodTest = _heartNextBloodTest;
  set heartNextCardioExamTest(_heartNextCardioExamTest) => this._heartNextCardioExamTest = _heartNextCardioExamTest;
  set vesselNextEcoTsaTest(_vesselNextEcoTsaTest) => this._vesselNextEcoTsaTest = _vesselNextEcoTsaTest;
  set vesselNextBloodTest(_vesselNextBloodTest) => this._vesselNextBloodTest = _vesselNextBloodTest;

  set heartLastBloodTest(_heartLastBloodTest) => this._heartLastBloodTest = _heartLastBloodTest;
  set heartLastCardioExamTest(_heartLastCardioExamTest) => this._heartLastCardioExamTest = _heartLastCardioExamTest;
  set vesselLastEcoTsaTest(_vesselLastEcoTsaTest) => this._vesselLastEcoTsaTest = _vesselLastEcoTsaTest;
  set vesselLastBloodTest(_vesselLastBloodTest) => this._vesselLastBloodTest = _vesselLastBloodTest;


  factory Heart.fromJson(Map<dynamic, dynamic> json) => _$HeartFromJson(json);
  Map<dynamic,dynamic> toJson() => _$HeartToJson(this);
  
}
