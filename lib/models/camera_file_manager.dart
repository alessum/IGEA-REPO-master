import 'dart:io';

import 'package:rxdart/rxdart.dart';

class CameraFileManager {

  static File _savedImage;

  static File get savedImage => _savedImage;
  static set savedImage(image) => _savedImage = image;

  static final _storeFileImageSubject = PublishSubject<File>();

  static Stream<File> get getFileImage => _storeFileImageSubject.stream;


  static addFileImage(File file){
    _storeFileImageSubject.sink.add(file);
  }

  static dispose(){
    _storeFileImageSubject.close();
  }

}