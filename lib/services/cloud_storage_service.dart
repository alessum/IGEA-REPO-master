import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart';

class CloudStorageService {
  String _userid;
  final _storage = FirebaseStorage.instance;

  static final CloudStorageService _cloudStorageService =
      CloudStorageService._internal();
  CloudStorageService._internal();

  factory CloudStorageService.instance() {
    return _cloudStorageService;
  }

  factory CloudStorageService(userid) {
    _cloudStorageService._userid = userid;
    return _cloudStorageService;
  }

  Future<String> uploadFile({
    File imageToUpload,
    String testKey,
  }) async {
    var fileRef = 'userFiles/$_userid/outcome_files/$testKey';
    final Reference firebaseStorageRef = FirebaseStorage.instance.ref(fileRef);
    try {
      return firebaseStorageRef.putFile(imageToUpload).then((snap) {
        if (snap.state == TaskState.success) {
          return snap.ref.getDownloadURL();
        } else
          return null;
      });
    } on FirebaseException catch (e) {
      print(e);
      return null;
    }
  }

  Future<void> downloadList(String doctorKey) async {}
}
