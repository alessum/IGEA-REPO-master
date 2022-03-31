import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:igea_app/models/constants/constants.dart';
import 'package:igea_app/models/constants/gamification_constants.dart';
import 'package:igea_app/services/firestore.dart';
import 'package:tuple/tuple.dart';

class FirestoreWrite {
  String _userid;
  set userid(_userid) => _userid = _userid;

  static final FirestoreWrite _firestoreWrite = FirestoreWrite._internal();
  FirestoreWrite._internal();

  factory FirestoreWrite.instance() {
    return _firestoreWrite;
  }

  factory FirestoreWrite(_userid) {
    _firestoreWrite._userid = _userid;
    return _firestoreWrite;
  }

  FirebaseFirestore _firestore = FirebaseFirestore.instance;

  sendNewOutcome(Map<dynamic, dynamic> outcomeData) {
    //collection ref
    String _collection =
        'userData/$_userid/test_list/${outcomeData[Constants.TEST_ID_KEY]}';

    //remove useless data
    outcomeData.remove(Constants.TEST_ID_KEY);

    //start transaction to update
    var _testRef = _firestore.doc(_collection);
    _firestore.runTransaction((transaction) {
      return transaction.get(_testRef).then((_) {
        transaction
            .update(_testRef, {'has_outcome': true, 'outcome': outcomeData});
      });
    });
  }

  Future<String> createTest(Map<dynamic, dynamic> jsonTest) {
    String _collection = 'userData/$_userid/test_list';
    return _firestore
        .collection(_collection)
        .add(jsonTest)
        .then((value) => value.id);
  }

  sendOnboardingNewTest(Map<dynamic, dynamic> jsonTest) {
    var batch = _firestore.batch();
    String collection = 'userData/$_userid/test_list';
    String organKey = jsonTest[Constants.ORGAN_KEY];

    _firestore
        .collection(collection)
        .where(Constants.ORGAN_KEY, isEqualTo: organKey)
        .get()
        .then((snapshots) {
      snapshots.docs.forEach((element) {
        batch.delete(element.reference);
      });

      DocumentReference newTestRef = _firestore.collection(collection).doc();
      batch.set(newTestRef, jsonTest);

      batch.commit();
    });
  }

  sendNewReservation(Map<dynamic, dynamic> jsonReservation) {
    //collection ref
    String _collection =
        'userData/$_userid/test_list/${jsonReservation[Constants.TEST_ID_KEY]}';

    //remove useless data
    jsonReservation.remove(Constants.TEST_ID_KEY);

    //start transaction to update
    var _testRef = _firestore.doc(_collection);
    _firestore.runTransaction((transaction) {
      return transaction.get(_testRef).then((_) {
        transaction.update(_testRef, {'reservation': jsonReservation});
      });
    });
  }

  void setOrgan(Map<dynamic, dynamic> jsonOrganData) {
    //collection ref
    String _collection =
        'userData/$_userid/organ_list/${jsonOrganData[Constants.ORGAN_KEY]}';

    //remove useless data
    jsonOrganData.remove(Constants.ORGAN_KEY);

    //start transaction to update
    var _organRef = _firestore.doc(_collection);
    _firestore.runTransaction((transaction) {
      return transaction.get(_organRef).then((_) {
        transaction.set(_organRef, jsonOrganData);
      });
    });
  }

  /// # Update Organ
  /// Metodo per l'aggiornamento di un singolo attributo dell'organo. L'input viene considerato nel modo seguente:
  /// #### Tuple2< chiave_organo , Tuple2< chiave_attributo  ,valore_attributo > >
  void updateOrgan(Tuple2<String, Tuple2<String, dynamic>> input) {
    //collection ref
    String _collection = 'userData/$_userid/organ_list/${input.item1}';

    //start transaction to update
    var _organRef = _firestore.doc(_collection);
    _firestore.runTransaction((transaction) {
      return transaction.get(_organRef).then((_) {
        transaction.update(_organRef, {
          input.item2.item1: input.item2.item2,
        });
      });
    });
  }

  ///## DEPRECATO
  void sendNewStatus(jsonStatus) {
    //collection ref
    String _collection =
        'userData/$_userid/organ_list${jsonStatus[Constants.ORGAN_KEY]}';

    //remove useless data
    jsonStatus.remove(Constants.ORGAN_KEY);

    //start transaction to update
    var _organRef = _firestore.doc(_collection);
    _firestore.runTransaction((transaction) {
      return transaction.get(_organRef).then((_) {
        transaction.update(_organRef, {'status': jsonStatus});
      });
    });
  }

  //item1: String chiave organo
  //tiem 2: Map nuovo stato organo
  void updateOrganStatus(Tuple2<String, Map<String, dynamic>> input) {
    //collection ref
    String _collection = 'userData/$_userid/organ_list/${input.item1}';

    //start transaction to update
    var _organRef = _firestore.doc(_collection);
    _firestore.runTransaction((transaction) {
      return transaction.get(_organRef).then((_) {
        transaction.update(_organRef, {'status': input.item2});
      });
    });
  }

  Future<DocumentReference> createAssistedUser(String careGiverKey) {
    String _collection = 'userData';
    return _firestore.collection(_collection).add({'care_giver': careGiverKey});
  }

  void updateRegistry(jsonRegistry) {
    //collection ref
    String _collection = 'userData/$_userid/';
    //start transaction to update
    var _userRef = _firestore.doc(_collection);
    _firestore.runTransaction((transaction) {
      return transaction.get(_userRef).then((_) {
        transaction.update(_userRef, {'registry_data': jsonRegistry});
      });
    });
  }

  void updateFirstAccess(bool firstAccess) {
    //collection ref
    String _collection = 'userData/$_userid/';
    //start transaction to update
    var _userRef = _firestore.doc(_collection);
    _firestore.runTransaction((transaction) {
      return transaction.get(_userRef).then((_) {
        transaction.update(_userRef, {'first_access': firstAccess});
      });
    });
  }

  void initOrgans(Map<String, dynamic> organList) {
    var batch = _firestore.batch();
    organList.forEach((key, value) {
      var organRef = _firestore
          .collection('userData')
          .doc('$_userid')
          .collection('organ_list')
          .doc('$key');
      print('[ORGAN LIST TYPE] ' + organList[key].runtimeType.toString());
      print('[ORGAN LIST] ' + organList[key].toString());
      batch.set(organRef, organList[key]);
    });
    batch.commit().catchError((onError) {
      print('[FIRESTORE ERROR] ' + onError);
    }).then((value) => print('[COMMITTATO]'));
  }

  void updateMultiOrgan(
      Map<dynamic, Map<dynamic, dynamic>> jsonMultiScreeningData) {
    var batch = _firestore.batch();
    jsonMultiScreeningData.forEach((k, v) {
      var _organRef = _firestore
          .collection('userData')
          .doc('$_userid')
          .collection('organ_list')
          .doc('$k');
      batch.set(_organRef, v.cast<String, dynamic>());
    });
    batch.commit().catchError((onError) {
      print('[FIRESTORE ERROR] ' + onError);
    });

    // String collection = 'userData/$_userid/organ_list/${jsonMultiScreeningData['key']}';
    // jsonMultiScreeningData.remove('key');
    // DocumentReference organRef = _firestore.doc(collection);
    // _firestore.runTransaction((transaction) {
    //   return transaction.get(organRef).then((_) => {
    //     transaction.set(organRef, jsonMultiScreeningData.cast<String,dynamic>())
    //   });
    // });
  }

  void updateCardiovascularOrgan(jsonCardiovascularData) {
    //collection ref
    String _collection = 'userData/$_userid/organ_list/${Constants.HEART_KEY}';
    print('[ZZZ] ' + _collection);

    //start transaction to update
    var _userRef = _firestore.doc(_collection);
    _firestore.runTransaction((transaction) {
      return transaction.get(_userRef).then((_) {
        print('[fff] ' + jsonCardiovascularData.toString());
        transaction.update(
            _userRef, jsonCardiovascularData[Constants.HEART_KEY]);
      });
    });
  }

  void insertAssistedUserKey(String assistedUserKey) {
    String collection = 'userData/$_userid';
    var _userRef = _firestore.doc(collection);
    _firestore.runTransaction((transaction) {
      return transaction.get(_userRef).then((_) {
        transaction.update(_userRef, {
          'assisted_user_list': [assistedUserKey]
        });
      });
    });
  }

  void updateTestHasOutcome(Map<dynamic, dynamic> input) {
    //collection ref
    String _collection =
        'userData/$_userid/test_list/${input[Constants.TEST_ID_KEY]}';

    input.remove(input[Constants.TEST_ID_KEY]);

    //start transaction to update
    var _testRef = _firestore.doc(_collection);
    _firestore.runTransaction((transaction) {
      return transaction.get(_testRef).then((_) {
        transaction.update(_testRef, input);
      });
    });
  }

  deleteOutcome(String input) {
    //collection ref
    String _collection = 'userData/$_userid/test_list/$input';
    //start transaction to update
    var _testRef = _firestore.doc(_collection);
    _firestore.runTransaction((transaction) {
      return transaction.get(_testRef).then((_) {
        transaction.update(_testRef, {
          'outcome': null,
          'has_outcome': false,
        });
      });
    });
  }

  deleteTest(String input) {
    //collection ref
    String _collection = 'userData/$_userid/test_list/$input';
    //start transaction to update
    var _testRef = _firestore.doc(_collection);
    _firestore.runTransaction((transaction) {
      return transaction.get(_testRef).then((_) {
        transaction.delete(_testRef);
      });
    });
  }

  void updateLeaderBoard(Map<dynamic, dynamic> jsonLeaderBoard) {
    String collection = 'leaderBoard/$_userid';
    var leaderboardRef = _firestore.doc(collection);
    _firestore.runTransaction((transaction) {
      return transaction.get(leaderboardRef).then((_) {
        transaction.update(leaderboardRef, jsonLeaderBoard);
      });
    });
  }

  void updateWallet(Map<dynamic, dynamic> jsonWallet) {
    String collection = 'wallet/$_userid';
    var walletRef = _firestore.doc(collection);
    _firestore.runTransaction((transaction) {
      return transaction.get(walletRef).then((_) {
        transaction.update(walletRef, jsonWallet);
      });
    });
  }

  void updateGameQuizDuello(Map<dynamic, dynamic> jsonGame) {
    String quizDuelloId = jsonGame['quiz_duello_key'];

    // dynamic tmpJsonGame = {
    //   'score_player_1' : 'score_player_1',
    //   'score_player_2' : 'score_player_2',
    //   'turn_number' : 'numero del turno',
    //   'turn_player' : 'player_key',
    // };

    String collection = 'quiz_duello/$quizDuelloId';
    var quizDuelloRef = _firestore.doc(collection);
    _firestore.runTransaction((transaction) {
      return transaction.get(quizDuelloRef).then((_) {
        transaction.update(quizDuelloRef, jsonGame);
      });
    });
  }

  void updateTest(Tuple2<String, Map<String, dynamic>> input) {
    String coll = 'userData/$_userid/test_list/${input.item1}';

    var _testRef = _firestore.doc(coll);
    _firestore.runTransaction((transaction) {
      return transaction.get(_testRef).then((_) {
        transaction.update(_testRef, input.item2);
      });
    });
  }

  void updateOutcomeImageRef(Tuple2<String, String> input) {
    String ref = 'userData/$_userid/test_list/${input.item1}';
    var testRef = _firestore.doc(ref);
    _firestore.runTransaction((transaction) {
      return transaction.get(testRef).then((_) {
        transaction.update(testRef, {
          'outcome': {
            'outcome_image_path': input.item2,
          }
        });
      });
    });
  }

  //REMOVE ELEMENTS

  ///**ATTENZIONE**
  ///rimuove tutti i documenti della collection test_list
  void removeTestList() {
    String collection = 'userData/$_userid/test_list/';
    _firestore.collection(collection).get().then((snapshot) {
      for (DocumentSnapshot ds in snapshot.docs) {
        ds.reference.delete();
      }
    });
  }

  ///Rimuove tutti i documenti della collection test_list per cui è specificato l'organo di appartentenza
  void removeAllTestForOrgan(String organKey) {
    String collection = 'userData/$_userid/test_list/';
    _firestore.collection(collection).get().then((snapshot) {
      for (DocumentSnapshot ds in snapshot.docs) {
        if ((ds.data()[Constants.ORGAN_KEY] as String) == organKey) {
          ds.reference.delete();
        }
      }
    });
  }

  void sendNewWeeklyQuiz(Map<String, dynamic> jsonData) {
    String collection =
        'userData/$_userid/quiz_list/${jsonData[GamificationConstants.FIRESTORE_DOCUMENT_KEY]}';
    jsonData.remove(GamificationConstants.FIRESTORE_DOCUMENT_KEY);

    var _weeklyQuizRef = _firestore.doc(collection);
    _firestore.runTransaction((transaction) {
      return transaction.get(_weeklyQuizRef).then((_) {
        transaction.set(_weeklyQuizRef, jsonData);
      });
    });
  }

  void updateWeeklyQuizUser(Map<String, dynamic> json) {
    String collection =
        'userData/$_userid/quiz_list/${json[GamificationConstants.FIRESTORE_DOCUMENT_KEY]}';
    json.remove(GamificationConstants.FIRESTORE_DOCUMENT_KEY);
    var _usrWeeklyQuizRef = _firestore.doc(collection);
    _firestore.runTransaction((transaction) {
      return transaction.get(_usrWeeklyQuizRef).then((_) {
        transaction.update(_usrWeeklyQuizRef, json);
      });
    });
  }
}
