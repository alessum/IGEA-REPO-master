import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:igea_app/models/camera_file_manager.dart';
import 'package:igea_app/services/firestore.dart';

class FirestoreRead {
  String _userid;
  FirebaseFirestore _firestore;

  String get userid => _userid;
  set userid(userid) => _userid = userid;

  static final FirestoreRead _firestoreRead = FirestoreRead._internal();
  FirestoreRead._internal();

  factory FirestoreRead.instance() {
    return _firestoreRead;
  }

  factory FirestoreRead(userid) {
    _firestoreRead._userid = userid;
    _firestoreRead._firestore = FirebaseFirestore.instance;
    return _firestoreRead;
  }

  Stream<DocumentSnapshot> userInfoListener() =>
      _firestore.collection('userData').doc(_userid).snapshots();

  //listener for user's organs real time data changes
  Stream<QuerySnapshot> allOrgansListener() =>
      _firestore.collection('userData/$_userid/organ_list').snapshots();

  Stream<DocumentSnapshot> organListener(String organKey) => _firestore
      .collection('userData/$_userid/organ_list')
      .doc(organKey)
      .snapshots();

  Stream<QuerySnapshot> testListener() =>
      _firestore.collection('userData/$_userid/test_list').snapshots();

  Stream<QuerySnapshot> testNoReservationListner() => _firestore
      .collection('userData/$_userid/test_list')
      .where('reservation', isNull: true)
      .snapshots();

  Stream<QuerySnapshot> testRecentOutcomesListener() => _firestore
      .collection('userData/$_userid/test_list')
      .limit(10)
      .where('outcome', isNotEqualTo: null)
      .orderBy('reservation.date', descending: true)
      .snapshots();

  Stream<QuerySnapshot> testNoOutcomeListener() => _firestore
      .collection('userData/$_userid/test_list')
      .where('outcome', isNull: true)
      .where('reservation.date', isLessThanOrEqualTo: DateTime.now())
      .snapshots();

  Stream<QuerySnapshot> leaderboardListener() => _firestore
      .collection('leaderboard')
      .orderBy('monthly_score', descending: true)
      .snapshots();

  Stream<QuerySnapshot> ownedCouponsListener() => _firestore
      .collection('userData/$_userid/owned_coupon_list')
      .orderBy('value')
      .snapshots();

  Stream<QuerySnapshot> doctorsByDistanceListener() =>
      _firestore.collection('doctors/').snapshots();

  Stream<DocumentSnapshot> doctorListener(String doctorKey) =>
      _firestore.doc('doctors/$doctorKey').snapshots();

  Stream<QuerySnapshot> doctorReviewsListener(String doctorKey) =>
      _firestore.collection('doctors/$doctorKey/reviews').snapshots();

  Future<QuerySnapshot> getLastScreeningTest(Map<dynamic, dynamic> jsonTest) {
    return _firestore
        .collection('userData/$_userid/test_list/')
        .limit(1)
        .orderBy('reservation.date', descending: true)
        .where('type', isEqualTo: jsonTest['type'])
        .where('outcome', isNotEqualTo: null)
        .where(
          'reservation.date',
          isGreaterThan: jsonTest['reservation']['date'],
        )
        .get();
  }

  Future<QuerySnapshot> getOrgans() async {
    return _firestore
        .collection('userData/$_userid/organ_list')
        .get()
        .then((snapshot) {
      return snapshot;
    }).catchError((onError) {
      print('[ERROR]' + onError);
    });
  }

  Future<QuerySnapshot> fetchLeaderboard() async {
    return _firestore.collection('leaderboard').get().then((snapshot) {
      return snapshot;
    }).catchError((onError) {
      print('[ERROR]' + onError);
    });
  }

  Future<QuerySnapshot> getTests() async {
    return _firestore
        .collection('userData/$_userid/test_list')
        .get()
        .then((snapshot) {
      snapshot.docs.forEach((docSnap) {
        print(docSnap.data.toString());
      });
      return snapshot;
    });
  }

  Future<QuerySnapshot> getTestsWithReservation() async {
    return _firestore
        .collection('userData/$_userid/test_list')
        .get()
        .then((snapshot) {
      return snapshot;
    }).catchError((onError) {
      print('[EEE]' + onError);
    }).whenComplete(() {
      print('completo!');
    });
  }

  // Future<QuerySnapshot> fetchAllReservableTests() async {
  //   return _firestore
  //       .collection('reservable_test_list')
  //       .get()
  //       .then((snapshot) {
  //     return snapshot;
  //   }).catchError((onError) {
  //     print('[FIRESTORE ERROR] ' + onError);
  //   });
  // }

  Future<DocumentSnapshot> fetchUser() async {
    return _firestore
        .collection('userData')
        .doc(_userid)
        .get()
        .then((snapshot) {
      return snapshot;
    }).catchError((onError) {
      print('[FIRESTORE ERROR] ' + onError);
    });
  }

  Future<QuerySnapshot> fetchInfoBoard() async {
    return _firestore.collection('info_board').get().then((snapshot) {
      return snapshot;
    }).catchError((onError) {
      print('[FIRESTORE ERROR] ' + onError);
    });
  }

  Future<QuerySnapshot> fetchLeaderBoard() async {
    return _firestore.collection('leaderboard').get().then((snapshot) {
      return snapshot;
    }).catchError((onError) {
      print('[FIRESTORE ERROR] ' + onError);
    });
  }

  Future<QuerySnapshot> fetchWeeklyQuiz() async {
    return _firestore
        .collection('weekly_quiz')
        .orderBy('start_game_date')
        .limit(1)
        .get()
        .then((snapshot) {
      return snapshot;
    });
  }

  Future<QuerySnapshot> fetchQuizDuello() async {
    return _firestore
        .collection('quiz_duello')
        .orderBy('in_progress', descending: true)
        .get()
        .then((snapshot) {
      return snapshot;
    });
  }

  Future<QuerySnapshot> fetchWeeklyQuizFromUser() async {
    return _firestore
        .collection('userData/$_userid/quiz_list')
        .where('in_progress', isEqualTo: true)
        .limit(1)
        .get()
        .then((snapshot) {
      return snapshot;
    });
  }

  Future<QuerySnapshot> fetchOwnedCoupons() async {
    return _firestore
        .collection('userData/$_userid/owned_coupon_list/')
        .get()
        .then((snapshot) {
      return snapshot;
    });
  }

  Future<QuerySnapshot> fetchPurchasableCoupons() async {
    return _firestore.collection('coupon_list').get().then((snapshot) {
      return snapshot;
    });
  }
}
