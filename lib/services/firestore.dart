import 'package:flutter/material.dart';

abstract class FirestoreService {
  FirestoreService({@required this.userid});
  final String userid;
}