import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:igea_app/models/gamification/coupon.dart';
import 'package:igea_app/models/gamification/gamification_data.dart';
import 'package:igea_app/models/gamification/weekly_quiz.dart';
import 'package:igea_app/services/firestore_read.dart';
import 'package:igea_app/services/firestore_write.dart';

class GamingRepository {
  FirestoreRead _firestoreRead;
  FirestoreWrite _firestoreWrite;
  String _userID;

  static final GamingRepository _gamingRepository =
      GamingRepository._internal();

  GamingRepository._internal();

  factory GamingRepository.instance() {
    return _gamingRepository;
  }

  factory GamingRepository(userID) {
    _gamingRepository._userID = userID;
    _gamingRepository._firestoreRead = FirestoreRead.instance();
    _gamingRepository._firestoreWrite = FirestoreWrite.instance();
    // _gamingRepository._firestoreRead =
    //     FirestoreRead(userid: _gamingRepository._userID);
    // _gamingRepository._firestoreWrite =
    //     FirestoreWrite(userid: _gamingRepository._userID);
    return _gamingRepository;
  }

  String get userID => _userID;
  set userID(_userID) => this._userID = _userID;

  Future<Map<String, GamificationData>> fetchLeaderboard() async {
    return await _firestoreRead.fetchLeaderboard().then((snapshot) {
      Map<String, GamificationData> leaderboard = Map();
      snapshot.docs.forEach((userData) {
        leaderboard.addAll({
          userData.id: GamificationData.fromJson(userData.data()),
        });
      });
      return leaderboard;
    });
  }

  Future<Map<String, Coupon>> fetchOwnedCoupons() async {
    return await _firestoreRead.fetchOwnedCoupons().then((snapshot) {
      Map<String, Coupon> couponList = Map();
      snapshot.docs.forEach((coupon) {
        couponList.addAll({
          coupon.id: Coupon.fromJson(coupon.data()),
        });
      });
      return couponList;
    });
  }

  Future<Map<String, Coupon>> fetchPurchasableCoupons() async {
    return await _firestoreRead.fetchPurchasableCoupons().then((snapshot) {
      Map<String, Coupon> couponList = Map();
      snapshot.docs.forEach((coupon) {
        couponList.addAll({
          coupon.id: Coupon.fromJson(coupon.data()),
        });
      });
      return couponList;
    });
  }


  ///Da un QuerySnapshot crea una Map<String,dynamic> con key = documentID e value = Map<String,dynamic>
  Future<QuerySnapshot> fetchWeeklyQuiz() async {
    return await _firestoreRead.fetchWeeklyQuiz();
  }

  void sendNewWeeklyQuiz(Map<String, dynamic> jsonData) {
    _firestoreWrite.sendNewWeeklyQuiz(jsonData);
  }

  Future<Map<String, dynamic>> fetchWeeklyQuizFromUser() async {
    return await _firestoreRead.fetchWeeklyQuizFromUser().then((snapshot) {
      Map<String, dynamic> weeklyQuizMap = {
        snapshot.docs.single.id: snapshot.docs.single.data,
      };
      return weeklyQuizMap;
    });
  }

  void updateWeeklyQuizUser(Map<String,dynamic> json) {
    _firestoreWrite.updateWeeklyQuizUser(json);
  }
}
