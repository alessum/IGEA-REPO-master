import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:igea_app/services/cloud_storage_service.dart';
import 'package:igea_app/services/firestore_write.dart';
import 'package:rxdart/rxdart.dart';
import 'package:tuple/tuple.dart';

class BlocCameraProvider extends InheritedWidget {
  final BlocCamera bloc;

  BlocCameraProvider({Key key, Widget child})
      : bloc = BlocCamera(),
        super(key: key, child: child);

  @override
  bool updateShouldNotify(InheritedWidget oldWidget) {
    return true;
  }

  static BlocCamera of(BuildContext context) {
    return context
        .dependOnInheritedWidgetOfExactType<BlocCameraProvider>()
        .bloc;
  }
}

class BlocCamera {
  CloudStorageService _cloudStorageService = CloudStorageService.instance();
  FirestoreWrite _firestoreWrite = FirestoreWrite.instance();
  final _uploadOutcomeImageSubject = PublishSubject<Tuple2<String, File>>();

  Sink<Tuple2<String, File>> get uploadOutcome =>
      _uploadOutcomeImageSubject.sink;

  BlocCamera() {
    _uploadOutcomeImageSubject.stream.listen((event) {
      _cloudStorageService
          .uploadFile(
        imageToUpload: event.item2,
        testKey: event.item1,
      )
          .then((value) {
        print('FIREBASE PATH $value');
        _firestoreWrite.updateOutcomeImageRef(
          Tuple2<String, String>(event.item1, value),
        );
      });
    });
  }

  void dispose() {
    _uploadOutcomeImageSubject.close();
  }
}
