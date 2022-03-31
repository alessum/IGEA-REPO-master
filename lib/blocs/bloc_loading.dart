import 'package:flutter/material.dart';
import 'package:igea_app/models/user.dart';
import 'package:igea_app/resources/prevention_repository.dart';
import 'package:igea_app/services/firestore_read.dart';
import 'package:rxdart/rxdart.dart';

class LoadingBlocProvider extends InheritedWidget {
  final LoadingBloc bloc;

  LoadingBlocProvider({Key key, Widget child})
      : bloc = LoadingBloc(),
        super(key: key, child: child);

  @override
  bool updateShouldNotify(InheritedWidget oldWidget) {
    return true;
  }

  static LoadingBloc of(BuildContext context) {
    return context
        .dependOnInheritedWidgetOfExactType<LoadingBlocProvider>()
        .bloc;
  }
}

class LoadingBloc {
  PreventionRepository _repository = PreventionRepository.instance();
  FirestoreRead _firestoreRead = FirestoreRead.instance();
  final _fetchUser = PublishSubject<PrevengoUser>();

  Stream<PrevengoUser> get user => _fetchUser.stream;

  Future<void> fetchUser() async {
    await _firestoreRead.fetchUser().then((userData) {
      print('[USER DATA] ' + userData.toString());
      _fetchUser.sink.add(PrevengoUser.fromJson(userData.data()));
    });
  }

  void dispose() async {
    _fetchUser.close();
  }
}
