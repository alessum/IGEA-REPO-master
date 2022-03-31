import 'package:flutter/material.dart';
import 'package:igea_app/models/user.dart';
import 'package:igea_app/resources/gaming_repository.dart';
import 'package:igea_app/services/auth.dart';
import 'package:igea_app/services/cloud_functions_service.dart';
import 'package:igea_app/services/cloud_storage_service.dart';
import 'package:igea_app/services/firestore_read.dart';
import 'package:igea_app/services/firestore_write.dart';
import 'package:rxdart/rxdart.dart';

class WrapperBlocProvider extends InheritedWidget {
  final WrapperBloc bloc;

  WrapperBlocProvider({Key key, Widget child})
      : bloc = WrapperBloc(),
        super(key: key, child: child);

  @override
  bool updateShouldNotify(InheritedWidget oldWidget) {
    return true;
  }

  static WrapperBloc of(BuildContext context) {
    return context
        .dependOnInheritedWidgetOfExactType<WrapperBlocProvider>()
        .bloc;
  }
}

class WrapperBloc {
  FirebaseAuthService _firebaseAuthService = FirebaseAuthService();

  final _fetchUser = PublishSubject<PrevengoUser>();

  Stream<PrevengoUser> get user => _fetchUser.stream;

  WrapperBloc() {
    _firebaseAuthService.user.listen((firebaseUser) {
      if (firebaseUser == null) {
        print('L\'utente attualmente è disconnesso');
      } else {
        print('Utente connesso ${firebaseUser.uid}');
        //String uidTest = '3mUNS4LzAdezvTnxl60wUFJvfQA3';
        new FirestoreRead(firebaseUser.uid);
        new FirestoreWrite(firebaseUser.uid);
        new GamingRepository(firebaseUser.uid);
        new CloudStorageService(firebaseUser.uid);
        new CloudFunctionsService(firebaseUser.uid);
        final firestoreRead = FirestoreRead.instance();
        firestoreRead.fetchUser().then((value) {
          print(value.data());
          _fetchUser.sink.add(PrevengoUser.fromJson(value.data()));
        });
      }
    });
  }

  void dispose() async {
    _fetchUser.close();
  }
}
