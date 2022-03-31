import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:igea_app/models/constants/gamification_constants.dart';
import 'package:igea_app/models/gamification/gamification_data.dart';
import 'package:igea_app/models/gamification/weekly_quiz.dart';
import 'package:igea_app/resources/gaming_repository.dart';
import 'package:rxdart/rxdart.dart';

class GamificationBlocProvider extends InheritedWidget {
  final GamificationBloc bloc;

  GamificationBlocProvider({
    Key key,
    Widget child,
  })  : bloc = GamificationBloc(),
        super(key: key, child: child);

  @override
  bool updateShouldNotify(covariant InheritedWidget oldWidget) {
    return true;
  }

  static GamificationBloc of(BuildContext context) {
    return context
        .dependOnInheritedWidgetOfExactType<GamificationBlocProvider>()
        .bloc;
  }
}

class GamificationBloc {
  GamingRepository _repository = GamingRepository.instance();

  //read stream
  final _fetchLeaderboard = PublishSubject<Map<String, GamificationData>>();
  final _fetchWeeklyQuiz = PublishSubject<Map<String, WeeklyQuiz>>();

  Stream<Map<String, GamificationData>> get leaderboard =>
      _fetchLeaderboard.stream;
  Stream<Map<String, WeeklyQuiz>> get weeklyQuiz => _fetchWeeklyQuiz.stream;

  //write stream
  final _sendWeeklyQuizToUser = PublishSubject<Map<String, dynamic>>();
  Sink<Map<String, dynamic>> get inNewWeeklyQuizToUser =>
      _sendWeeklyQuizToUser.sink;

  GamificationBloc() {
    _sendWeeklyQuizToUser.stream.listen((input) {
      Map<String, dynamic> jsonData =
          (input[GamificationConstants.WEEKLY_QUIZ_KEY] as WeeklyQuiz).toJson();
      jsonData.addAll({
        GamificationConstants.FIRESTORE_DOCUMENT_KEY:
            input[GamificationConstants.FIRESTORE_DOCUMENT_KEY],
      });
      _repository.sendNewWeeklyQuiz(jsonData);
    });
  }

  Future<void> fetchLeaderboard() async {
    await _repository.fetchLeaderboard().then((gamificationData) {
      _fetchLeaderboard.sink.add(gamificationData);
    });
  }

  Future<void> fetchWeeklyQuiz() async {
    Map<String,WeeklyQuiz> wee = Map();
    await _repository.fetchWeeklyQuiz().then((weeklyQuiz) {
      weeklyQuiz.docs.forEach((element) { 
        wee.addAll({
          element.id : WeeklyQuiz.fromJson(element.data())
        });
      });
      _fetchWeeklyQuiz.sink.add(wee);
    });
  }

  void dispose() async {
    _fetchLeaderboard.close();
    _fetchWeeklyQuiz.close();
    _sendWeeklyQuizToUser.close();
  }
}
