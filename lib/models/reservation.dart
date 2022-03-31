
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:json_annotation/json_annotation.dart';

part 'mapping/reservation.g.dart';

@JsonSerializable()
class Reservation {
  Reservation(this._date, this._description, this._location, this._locationName);
  Reservation.onlyDate(this._date);

  @JsonKey(name: 'date')
  DateTime _date;
  @JsonKey(name: 'description')
  String _description;
  @JsonKey(name: 'location')
  GeoPoint _location;
  @JsonKey(name: 'location_name')
  String _locationName;

  //getter
  DateTime get date => _date;
  String get description => _description;
  GeoPoint get location => _location;
  String get locationName => _locationName;


  //setter
  set date(date) => this._date = date;
  set description(date) => this._description = description;
  set location(location) => this._location = location;
  set locationName(locationName) => this._locationName = locationName;

  factory Reservation.fromJson(Map<String, dynamic> json) =>
      _$ReservationFromJson(json);
  Map<String, dynamic> toJson() => _$ReservationToJson(this);
}
