import 'package:flutter/material.dart';
import 'package:igea_app/models/constants/gamification_constants.dart';
import 'package:igea_app/models/gamification/weekly_quiz.dart';
import 'package:igea_app/resources/gaming_repository.dart';
import 'package:rxdart/rxdart.dart';

class QuizBlocProvider extends InheritedWidget {
  final QuizBloc bloc;

  QuizBlocProvider({
    Key key,
    Widget child,
  })  : bloc = QuizBloc(),
        super(key: key, child: child);

  @override
  bool updateShouldNotify(covariant InheritedWidget oldWidget) {
    return true;
  }

  static QuizBloc of(BuildContext context) {
    return context.dependOnInheritedWidgetOfExactType<QuizBlocProvider>().bloc;
  }
}

class QuizBloc {
  GamingRepository _repository = GamingRepository.instance();

  //read stream
  final _fetchWeeklyQuizFromUser = PublishSubject<Map<String, WeeklyQuiz>>();

  Stream<Map<String, WeeklyQuiz>> get weeklyQuiz =>
      _fetchWeeklyQuizFromUser.stream;

  //write stream
  final _sendWeeklyQuizUserUpdate = PublishSubject<Map<String, dynamic>>();

  Sink<Map<String, dynamic>> get inWeeklyQuizUserUpdate =>
      _sendWeeklyQuizUserUpdate.sink;

  QuizBloc() {
    _sendWeeklyQuizUserUpdate.stream.listen((input) {
      Map<String, dynamic> jsonData =
          (input[GamificationConstants.WEEKLY_QUIZ_KEY] as WeeklyQuiz).toJson();
      jsonData.addAll({
        GamificationConstants.FIRESTORE_DOCUMENT_KEY:
            input[GamificationConstants.FIRESTORE_DOCUMENT_KEY]
      });
      print('[JSON DATA] ' + jsonData.toString());
      _repository.updateWeeklyQuizUser(jsonData);
    });
  }

  Future<void> fetchWeeklyQuizFromUser() async {
    await _repository.fetchWeeklyQuizFromUser().then((weeklyQuiz) {
      _fetchWeeklyQuizFromUser.sink.add(Map.fromIterable(
        weeklyQuiz.keys,
        key: (item) => item.toString(),
        value: (item) => WeeklyQuiz.fromJson(weeklyQuiz[item]),
      ));
    });
  }

  void dispose() async {
    _fetchWeeklyQuizFromUser.close();
    _sendWeeklyQuizUserUpdate.close();
  }
}
