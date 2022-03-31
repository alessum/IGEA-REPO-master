import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:igea_app/models/gamification/coupon.dart';
import 'package:igea_app/models/gamification/gamification_data.dart';
import 'package:igea_app/models/user.dart';
import 'package:igea_app/services/firestore_read.dart';
import 'package:rxdart/rxdart.dart';

class LeaderboardBlocProvider extends InheritedWidget {
  final LeaderboardBloc bloc;

  LeaderboardBlocProvider({
    Key key,
    Widget child,
  })  : bloc = LeaderboardBloc(),
        super(key: key, child: child);

  @override
  bool updateShouldNotify(covariant InheritedWidget oldWidget) {
    return true;
  }

  static LeaderboardBloc of(BuildContext context) {
    return context
        .dependOnInheritedWidgetOfExactType<LeaderboardBlocProvider>()
        .bloc;
  }
}

class LeaderboardBloc {

  final _firestoreRead = FirestoreRead.instance();

  //Stream controllers
  final _leaderboardSubject = BehaviorSubject<int>();

  //Send data to UI
  Stream<int> get getLeaderboardPosition => _leaderboardSubject.stream;

  LeaderboardBloc() {

    //listen for user leaderboard
    _firestoreRead.leaderboardListener().listen((event) {
      
    });

  }

  void dispose() async { 
    _leaderboardSubject.close();
  }
}
