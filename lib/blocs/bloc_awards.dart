import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:igea_app/models/gamification/coupon.dart';
import 'package:igea_app/models/gamification/gamification_data.dart';
import 'package:igea_app/models/user.dart';
import 'package:igea_app/resources/gaming_repository.dart';
import 'package:igea_app/services/firestore_read.dart';
import 'package:rxdart/rxdart.dart';

class AwardsBlocProvider extends InheritedWidget {
  final AwardsBloc bloc;

  AwardsBlocProvider({
    Key key,
    Widget child,
  })  : bloc = AwardsBloc(),
        super(key: key, child: child);

  @override
  bool updateShouldNotify(covariant InheritedWidget oldWidget) {
    return true;
  }

  static AwardsBloc of(BuildContext context) {
    return context
        .dependOnInheritedWidgetOfExactType<AwardsBlocProvider>()
        .bloc;
  }
}

class AwardsBloc {
  GamingRepository _repository = GamingRepository.instance();
  final _firestoreRead = FirestoreRead.instance();

  //Stream controllers
  final _gamificationDataSubject = BehaviorSubject<GamificationData>();
  final _leaderboardPositionSubject = BehaviorSubject<int>();
  final _ownedCouponsSubject = BehaviorSubject<Map<String, Coupon>>();

  //Send data to UI
  Stream<GamificationData> get getGamificationData =>
      _gamificationDataSubject.stream;
  Stream<int> get getLeaderboardPosition => _leaderboardPositionSubject.stream;
  Stream<Map<String, Coupon>> get getOwnedCoupons => _ownedCouponsSubject.stream;

  AwardsBloc() {
    //listen for user score
    _firestoreRead.userInfoListener().listen((event) {
      _gamificationDataSubject.sink
          .add(PrevengoUser.fromJson(event.data()).gamificationData);
    });

    //listen for user leaderboard position
    _firestoreRead.leaderboardListener().listen((event) {
      int position = event.docs
              .indexWhere((element) => element.id == _firestoreRead.userid) +
          1;
      _leaderboardPositionSubject.sink.add(position);
    });

    //listen for user coupons
    _firestoreRead.ownedCouponsListener().listen((event) {
      Map<String, Coupon> couponList = Map.fromIterable(
        event.docs,
        key: (element) => (element as DocumentSnapshot).id,
        value: (element) => Coupon.fromJson((element as DocumentSnapshot).data()),
      );
      _ownedCouponsSubject.sink.add(couponList);
    });
  }

  void dispose() async {
    _ownedCouponsSubject.close();
    _gamificationDataSubject.close();
    _leaderboardPositionSubject.close();
  }
}
