// GENERATED CODE - DO NOT MODIFY BY HAND

part of '../reservation.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Reservation _$ReservationFromJson(Map<String, dynamic> json) {
  return Reservation(
    json['date'] == null
        ? null
        : DateTime.parse((json['date'] as Timestamp).toDate().toString()),
    json['description'],
    json['location'] == null
        ? null
        : GeoPoint(
            (json['location'] as GeoPoint).latitude,
            (json['location'] as GeoPoint).longitude,
          ),
    json['location_name'],
  );
}

Map<String, dynamic> _$ReservationToJson(Reservation instance) =>
    <String, dynamic>{
      'date': Timestamp.fromDate(instance.date?.toUtc()),
      'description': instance.description,
      'location': instance.location,
      'location_name': instance.locationName,
    };
