import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:igea_app/models/breast.dart';
import 'package:igea_app/models/colon.dart';
import 'package:igea_app/models/heart.dart';
import 'package:igea_app/models/organ.dart';
import 'package:igea_app/models/user.dart';
import 'package:igea_app/models/uterus.dart';
import 'package:igea_app/services/firestore_read.dart';
import 'package:rxdart/rxdart.dart';

class HomeBlocProvider extends InheritedWidget {
  final HomeBloc bloc;

  HomeBlocProvider({Key key, Widget child})
      : bloc = HomeBloc(),
        super(key: key, child: child);

  @override
  bool updateShouldNotify(_) => true;

  static HomeBloc of(BuildContext context) {
    return context.dependOnInheritedWidgetOfExactType<HomeBlocProvider>().bloc;
  }
}

class HomeBloc {
  FirestoreRead _firestoreRead = FirestoreRead.instance();

  final _fetchUser = PublishSubject<PrevengoUser>();
  final _changeUser = PublishSubject<String>();
  final _organsfetcher = BehaviorSubject<Map<String, Organ>>();

  // send data to UI
  Stream<Map<String, Organ>> get allOrgans => _organsfetcher.stream;
  Stream<PrevengoUser> get user => _fetchUser.stream;

  // get data from UI
  Sink<String> get inUserKey => _changeUser.sink;

  HomeBloc() {
    //TODO MODIFICARE PER CARE GIVER E CAMBIO UTENZA
    _changeUser.stream.listen((input) {
      print('CHANGE USER');
      _firestoreRead.userid = input;
    });

    _firestoreRead.userInfoListener().listen((snapshot) {
      _fetchUser.sink.add(PrevengoUser.fromJson(snapshot.data()));
    });

    _firestoreRead.allOrgansListener().listen((snapshot) {
      Map<String, Organ> organList = Map.fromIterable(snapshot.docs,
          key: (element) => (element as DocumentSnapshot).id,
          value: (element) {
            switch ((element as DocumentSnapshot).id) {
              case '001':
                return Breast.fromJson((element as DocumentSnapshot).data());
              case '002':
                return Colon.fromJson((element as DocumentSnapshot).data());
              case '003':
                return Uterus.fromJson((element as DocumentSnapshot).data());
              case '004':
                return Heart.fromJson((element as DocumentSnapshot).data());
              default:
                return null;
            }
          });
      _organsfetcher.sink.add(organList);
    });
  }

  void dispose() async {
    _changeUser.close();
    _organsfetcher.close();
    _fetchUser.close();
  }
}
