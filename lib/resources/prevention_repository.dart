import 'package:igea_app/models/breast.dart';
import 'package:igea_app/models/colon.dart';
import 'package:igea_app/models/enums/test_type.dart';
import 'package:igea_app/models/heart.dart';
import 'package:igea_app/models/organ.dart';
import 'package:igea_app/models/registry.dart';
import 'package:igea_app/models/reservable_test.dart';
import 'package:igea_app/models/test.dart';
import 'package:igea_app/models/uterus.dart';
import 'package:igea_app/services/firestore_read.dart';
import 'package:igea_app/services/firestore_write.dart';
import 'package:igea_app/services/cloud_storage_service.dart';
import 'package:igea_app/models/constants/constants.dart';
import 'package:igea_app/models/user.dart';
import 'package:rxdart/rxdart.dart';

class PreventionRepository {
  FirestoreRead _firestoreRead;
  FirestoreWrite _firestoreWrite;
  CloudStorageService _storageService;
  String _userID;

  static final PreventionRepository _preventionRepository =
      PreventionRepository._internal();

  PreventionRepository._internal();

  factory PreventionRepository.instance() {
    return _preventionRepository;
  }

  factory PreventionRepository(userID) {
    _preventionRepository._userID = userID;
    // _preventionRepository._firestoreRead =
    //     FirestoreRead(userid: _preventionRepository._userID);
    // _preventionRepository._firestoreWrite =
    //     FirestoreWrite(userid: _preventionRepository._userID);
    // _preventionRepository._storageService =
    //     CloudStorageService(userid: _preventionRepository._userID);
    return _preventionRepository;
  }

  String get userID => _userID;
  set userID(_userID) => this._userID = _userID;

  Future<Map<String, Test>> fetchAllTests() async {
    return await _firestoreRead.getTests().then((snapshot) {
      Map<String, Test> testList = Map();
      snapshot.docs.forEach((test) {
        testList.putIfAbsent(test.id, () {
          return Test.fromJson(test.data());
        });
      });
      return testList;
    });
  }

  Future<Map<String, Test>> fetchAllTestsWithReservation() async {
    return await _firestoreRead.getTestsWithReservation().then((snapshot) {
      Map<String, Test> testList = Map();
      snapshot.docs.forEach((test) {
        testList.putIfAbsent(test.id, () {
          return Test.fromJson(test.data());
        });
      });
      return testList;
    });
  }

  PublishSubject _organfetcher = PublishSubject<Map<String,Organ>>();
  void close(){
    _organfetcher.close();
  }


  ///
  /// SCRITTURA
  ///
  void sendNewTest(Map<dynamic, dynamic> jsonTest) {
    _firestoreWrite.createTest(jsonTest);
  }

  void sendOnboardingNewTest(Map<dynamic, dynamic> jsonTest) {
    _firestoreWrite.sendOnboardingNewTest(jsonTest);
  }

  void sendNewOutcome(Map<dynamic, dynamic> jsonOutcome) {
    _firestoreWrite.sendNewOutcome(jsonOutcome);
  }

  void sendNewReservation(Map<dynamic, dynamic> jsonReservation) {
    _firestoreWrite.sendNewReservation(jsonReservation);
  }

  void sendNewOrgan(Map<dynamic, dynamic> jsonOrgan) {
    _firestoreWrite.setOrgan(jsonOrgan);
  }

  void sendNewStatus(Map<dynamic, dynamic> jsonStatus) {
    _firestoreWrite.sendNewStatus(jsonStatus);
  }

  void updateRegistry(Map<dynamic, dynamic> jsonRegistry) {
    print('[MODIFICO INFO UTENTE]' + jsonRegistry.toString());
    _firestoreWrite.updateRegistry(jsonRegistry);
  }

  void updateStatus(Map<dynamic, dynamic> jsonStatus) {
    // _firestoreWrite.updateOrgan(jsonStatus);
  }

  void updateAllScreeningOrgans(
      Map<dynamic, Map<dynamic, dynamic>> jsonMultiScreeningData) {
    //_firestoreWrite.updateOrgan(jsonMultiScreeningData);
    // jsonMultiScreeningData.forEach((k,v) {
    //   //inserisco nella mappa/valore della mappa generale (vedi Map<dynamic,Map<dynamic,dynamic>>)
    //   //anche la chiave dell'organo di modo che sia reperibile per l'update del singolo organo
    //     v.addAll({Constants.ORGAN_KEY : k});
    //     print('[REPO] ' + v.toString());
    //    _firestoreWrite.updateOrgan(v);
    // });
  }

  void updateOrgan(Map<String, dynamic> jsonOrganData) {
    // _firestoreWrite.updateOrgan(jsonOrganData);
  }

  void updateCardiovascularOrgan(Map<dynamic, dynamic> jsonCardiovascularData) {
    _firestoreWrite.updateCardiovascularOrgan(jsonCardiovascularData);
  }

  Future<void> insertAssistedUserKey(String assistedUserKey) async {
    _firestoreWrite.insertAssistedUserKey(assistedUserKey);
  }

  Future<String> createAssistedUser(String careGiverKey) async {
    return await _firestoreWrite
        .createAssistedUser(careGiverKey)
        .then((docRef) {
      return docRef.id;
    });
  }

  // Future<String> uploadOutcomeImage(Map<dynamic, dynamic> input) async {
  //   String testTypeString =
  //       (input[Constants.TEST_TYPE_KEY] as TestType).toString();
  //   testTypeString = testTypeString.substring(testTypeString.indexOf('.') + 1);
  //   return await _storageService.uploadFile(
  //       imageToUpload: input[Constants.CAMERA_FILE_KEY],
  //       title: testTypeString,
  //       testKey: input[Constants.TEST_ID_KEY]);
  // }

  fetchOutcomeImage() {}

  void updateTestHasOutcome(Map<dynamic, dynamic> input) {
    _firestoreWrite.updateTestHasOutcome(input);
  }

  void deleteOutcome(String input) => _firestoreWrite.deleteOutcome(input);
  void deleteTest(String input) => _firestoreWrite.deleteTest(input);

  void updateFirstAccess(bool input) =>
      _firestoreWrite.updateFirstAccess(input);

  void removeAllTestPerOrgan(String organKey) =>
      _firestoreWrite.removeAllTestForOrgan(organKey);

  void updateTest(Map<String,dynamic> input) {
    //_firestoreWrite.updateTest(input);
  }

  void initOrgans(Map<String,dynamic> jsonOrganList) {
    _firestoreWrite.initOrgans(jsonOrganList);
  }
}

// then((snapshot) {
//       print('[DEBUG]'+snapshot.documents.length.toString());
//       snapshot.documents.forEach((document) {
//         organList.putIfAbsent(document.documentID, () {
//           switch (document.documentID) {
//             case '001':
//               return Breast.fromJson(document.data);
//             case '002':
//               return Colon.fromJson(document.data);
//             case '003':
//               return Uterus.fromJson(document.data);
//             default:
//               return null;
//           }
//         });
//       });
//     });
