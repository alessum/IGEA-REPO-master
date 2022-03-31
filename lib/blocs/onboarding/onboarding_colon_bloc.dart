import 'dart:io';

import 'package:flutter/material.dart';
import 'package:igea_app/models/camera_file_manager.dart';
import 'package:igea_app/models/constants/constants.dart';
import 'package:igea_app/models/enums/test_type.dart';
import 'package:igea_app/models/outcome_screening.dart';
import 'package:igea_app/models/reservable_test.dart';
import 'package:igea_app/models/reservation.dart';
import 'package:igea_app/models/test.dart';
import 'package:igea_app/models/user.dart';
import 'package:igea_app/screens/diary/modal_bottom_sheets/prevengo_modal_css.dart';
import 'package:igea_app/services/cloud_functions_service.dart';
import 'package:igea_app/services/cloud_storage_service.dart';
import 'package:igea_app/services/firestore_read.dart';
import 'package:igea_app/services/firestore_write.dart';
import 'package:igea_app/services/utilities.dart';
import 'package:rxdart/rxdart.dart';
import 'package:tuple/tuple.dart';

class OnboardingColonBlocProvider extends InheritedWidget {
  final OnboardingColonBloc bloc;

  OnboardingColonBlocProvider({Key key, Widget child})
      : bloc = OnboardingColonBloc(),
        super(key: key, child: child);

  @override
  bool updateShouldNotify(InheritedWidget oldWidget) {
    return true;
  }

  static OnboardingColonBloc of(BuildContext context) {
    return context
        .dependOnInheritedWidgetOfExactType<OnboardingColonBlocProvider>()
        .bloc;
  }
}

class OnboardingColonBloc {
  final _firestoreWrite = FirestoreWrite.instance();
  final _firestoreRead = FirestoreRead.instance();
  final _cloudFunctionsService = CloudFunctionsService.instance();
  final _cloudStorageService = CloudStorageService.instance();

  //STREAM CONTROLLERS
  final _showImageSubject = PublishSubject<File>();
  final _checkDadSubject = PublishSubject<bool>();
  final _checkMomSubject = PublishSubject<bool>();
  final _algorithmResultSubject = BehaviorSubject<Widget>();
  final _familiarityAlgorithmSubject = BehaviorSubject<Widget>();
  final _suggestedBooking = PublishSubject<String>();
  final _reservationSubject = PublishSubject<DateTime>();
  final _dontRememberReservationSubject = PublishSubject<bool>();
  final _parentAgeSubject = PublishSubject<int>();
  final _parentCounterSubject = PublishSubject<int>();
  final _checkSyndromsSubject = PublishSubject<bool>();
  final _checkNoFamiliaritySubject = PublishSubject<bool>();

  //SEND DATA TO UI
  Stream<File> get getOutcomeImage => _showImageSubject.stream;
  Stream<bool> get getCheckDad => _checkDadSubject.stream;
  Stream<bool> get getCheckMom => _checkMomSubject.stream;
  Stream<Widget> get getAlgorithmResult => _algorithmResultSubject.stream;
  Stream<Widget> get getFamiliarityAlgorithmResult =>
      _familiarityAlgorithmSubject.stream;
  Stream<String> get getSuggestedBooking => _suggestedBooking.stream;
  Stream<DateTime> get getReservation => _reservationSubject.stream;
  Stream<int> get getParentAge => _parentAgeSubject.stream;
  Stream<int> get getparentCounter => _parentCounterSubject.stream;
  // Stream<bool> get getCheckSyndromsSubject => _checkSyndromsSubject.stream;
  Stream<bool> get getCheckNoFamiliarity => _checkNoFamiliaritySubject.stream;
  Stream<bool> get getDontRememberReservation =>
      _dontRememberReservationSubject.stream;

  //GET DATA FROM UI
  Sink<bool> get setCheckDad => _checkDadSubject.sink;
  Sink<bool> get setCheckMom => _checkMomSubject.sink;
  Sink<DateTime> get updateReservation => _reservationSubject.sink;
  Sink<int> get setParentAge => _parentAgeSubject.sink;
  Sink<bool> get setCheckSyndromsSubject => _checkSyndromsSubject.sink;
  Sink<bool> get setCheckNoFamiliarity => _checkNoFamiliaritySubject.sink;
  Sink<bool> get updateDontRemenberReservation =>
      _dontRememberReservationSubject.sink;

  OnboardingColonBloc() {
    CameraFileManager.getFileImage.listen((event) {
      CacheManager.saveKV(
        CacheManager.uterusOutcomeFileKey,
        event,
      );
      _showImageSubject.sink.add(event);
    });

    _checkDadSubject.stream.listen((event) {
      int counter =
          CacheManager.getValue(CacheManager.colonParentCounterKey) ?? 0;

      if (event && counter < 2) {
        counter++;
        _checkNoFamiliaritySubject.sink.add(false);
      } else if (counter > 0) counter--;

      _parentCounterSubject.sink.add(counter);

      CacheManager.saveMultipleKV({
        CacheManager.colonParentCounterKey: counter,
        CacheManager.colonCheckDadKey: event,
      });
    });

    _checkMomSubject.stream.listen((event) {
      int counter =
          CacheManager.getValue(CacheManager.colonParentCounterKey) ?? 0;

      if (event && counter < 2) {
        counter++;
        _checkNoFamiliaritySubject.sink.add(false);
      } else if (counter > 0) counter--;

      _parentCounterSubject.sink.add(counter);

      CacheManager.saveMultipleKV({
        CacheManager.colonParentCounterKey: counter,
        CacheManager.colonCheckMomKey: event,
      });
    });

    _checkNoFamiliaritySubject.stream.listen((event) {
      if (event) {
        CacheManager.saveMultipleKV({
          CacheManager.colonParentCounterKey: 0,
          CacheManager.colonCheckMomKey: false,
          CacheManager.colonCheckDadKey: false,
        });
        _checkDadSubject.sink.add(false);
        _checkMomSubject.sink.add(false);
      }
      CacheManager.saveKV(CacheManager.colonCheckNoFamiliarityKey, event);
    });

    _checkSyndromsSubject.stream.listen((event) {
      int syndromCounter =
          CacheManager.getValue(CacheManager.colonCountSyndromsKey) ?? 0;
      if (event) {
        syndromCounter++;
      } else {
        syndromCounter--;
      }
      print('$syndromCounter');
      CacheManager.saveKV(
        CacheManager.colonCountSyndromsKey,
        syndromCounter,
      );
    });

    _parentAgeSubject.stream.listen((event) {
      CacheManager.saveKV(CacheManager.colonParentAgeKey, event);
    });

    CameraFileManager.getFileImage.listen((event) {
      CacheManager.saveKV(
        CacheManager.colonOutcomeFileKey,
        event,
      );
      //_showImageSubject.sink.add(event);
    });

    _reservationSubject.stream.listen((event) {
      if (event != null) {
        Reservation reservation = Reservation(
          event,
          'Primo esame inserito',
          null,
          'Non specificato',
        );
        _dontRememberReservationSubject.sink.add(false);

        CacheManager.saveMultipleKV({
          CacheManager.colonReservationKey: reservation,
          CacheManager.colonDontRememberReservationKey: false,
        });
      }
    });

    _dontRememberReservationSubject.stream.listen((event) {
      if (event == true) {
        _reservationSubject.sink.add(null);
        CacheManager.saveKV(
          CacheManager.colonReservationKey,
          null,
        );
      }

      CacheManager.saveKV(
        CacheManager.colonDontRememberReservationKey,
        event,
      );
    });
  }

  bool isfamiliarityInputValid() {
    int totCounter =
        CacheManager.getValue(CacheManager.colonParentCounterKey) ?? 0;
    bool checkNoFamiliarity =
        CacheManager.getValue(CacheManager.colonCheckNoFamiliarityKey) ?? false;
    int checkSyndrom =
        CacheManager.getValue(CacheManager.colonCountSyndromsKey) ?? 0;

    return totCounter > 0 || checkNoFamiliarity || checkSyndrom > 0;
  }

  void initFamiliarityPage() {
    _checkDadSubject.sink.add(
      CacheManager.getValue(CacheManager.colonCheckDadKey),
    );
    _checkMomSubject.sink.add(
      CacheManager.getValue(CacheManager.colonCheckMomKey),
    );
    _checkSyndromsSubject.sink.add(
      CacheManager.getValue(CacheManager.colonCountSyndromsKey),
    );
    _checkNoFamiliaritySubject.sink.add(
      CacheManager.getValue(CacheManager.colonCheckNoFamiliarityKey),
    );
    if (CacheManager.getValue(CacheManager.dateOfBirthKey) == null) {
      _firestoreRead.userInfoListener().listen((event) {
        PrevengoUser user = PrevengoUser.fromJson(event.data());
        CacheManager.saveKV(
            CacheManager.dateOfBirthKey, user.registryData.dateOfBirth);
      });
    }
  }

  void initInputExamPage() {
    _reservationSubject.sink.add(
      CacheManager.getValue(CacheManager.uterusReservationKey),
    );
    _dontRememberReservationSubject.sink.add(
      CacheManager.getValue(CacheManager.uterusDontRememberReservationKey),
    );
  }

  void checkFamiliarityAlgorithm() {
    int syndromCounter =
        CacheManager.getValue(CacheManager.colonCountSyndromsKey) ?? 0;
    int parentCounter =
        CacheManager.getValue(CacheManager.colonParentCounterKey) ?? 0;
    int parentAge = CacheManager.getValue(CacheManager.colonParentAgeKey) ?? 0;

    print('Parent age $parentAge');

    DateTime userDateOfBirth =
        CacheManager.getValue(CacheManager.dateOfBirthKey);
    int userAge = DateTime.now().year - userDateOfBirth.year;

    print('User age $userAge');

    if (syndromCounter > 0) {
      _familiarityAlgorithmSubject.sink.add(
        PrevengoDiaryModalCSS(
          title: 'Rischio familiarità',
          iconPath: 'assets/avatars/arold_in_circle.svg',
          message:
              'Ti consiglio di parlare con il tuo medico di base ed eventualmente prenotare una visita presso una clinica del rischio eredo-familiare',
          colorTheme: Color(0xFFE8B21C),
          isAlert: true,
          chatbotInfoData: Tuple2<String, String>(
            'A cosa serve la familiarità?',
            'A cosa serve la familiarità?',
          ),
        ),
      );

      // aggiornamento familiarità organo
      _firestoreWrite.updateOrgan(Tuple2<String, Tuple2<String, dynamic>>(
        '002',
        Tuple2<String, dynamic>(
          'familiarity_risk',
          Constants.COLON_FAMILIARITY_SYNDROM.toJson(),
        ),
      ));
    } else if (parentCounter > 1) {
      if (userAge < 40) {
        _familiarityAlgorithmSubject.sink.add(
          PrevengoDiaryModalCSS(
            title: 'Rischio familiarità alto',
            iconPath: 'assets/avatars/arold_in_circle.svg',
            message:
                'Secondo le linee guida ministeriali, le persone della tua età dovrebbero fare un esame SOF ogni 3 anni a partire da 10 anni prima della data di diagnosi del carcinoma al tuo parente. Inoltre consiglio una colonscopia ogni 5-10 anni',
            colorTheme: Color(0xFFEB6D7B),
            isAlert: true,
            chatbotInfoData: Tuple2<String, String>(
              'A cosa serve la familiarità?',
              'A cosa serve la familiarità?',
            ),
          ),
        );

        // aggiornamento familiarità organo
        _firestoreWrite.updateOrgan(Tuple2<String, Tuple2<String, dynamic>>(
          '002',
          Tuple2<String, dynamic>(
            'familiarity_risk',
            Constants.COLON_FAMILIARITY_HIGH_UNDER_40.toJson(),
          ),
        ));
      } else {
        _familiarityAlgorithmSubject.sink.add(
          PrevengoDiaryModalCSS(
            title: 'Rischio familiarità alto',
            iconPath: 'assets/avatars/arold_in_circle.svg',
            message:
                'Secondo le linee guida ministeriali, le persone della tua età dovrebbero fare un esame SOF ogni 3 anni. Inoltre consiglio una colonscopia ogni 5-10 anni',
            colorTheme: Color(0xFFEB6D7B),
            isAlert: true,
            chatbotInfoData: Tuple2<String, String>(
              'A cosa serve la familiarità?',
              'A cosa serve la familiarità?',
            ),
          ),
        );

        // aggiornamento familiarità organo
        _firestoreWrite.updateOrgan(Tuple2<String, Tuple2<String, dynamic>>(
          '002',
          Tuple2<String, dynamic>(
            'familiarity_risk',
            Constants.COLON_FAMILIARITY_HIGH_OVER_40.toJson(),
          ),
        ));
      }
    } else if (parentCounter == 1) {
      if (parentAge < 60) {
        if (userAge < 40) {
          _familiarityAlgorithmSubject.sink.add(
            PrevengoDiaryModalCSS(
              title: 'Rishio familiarità alto',
              iconPath: 'assets/avatars/arold_in_circle.svg',
              message:
                  'Secondo le linee guida ministeriali, le persone della tua età dovrebbero fare un esame SOF ogni 3 anni a partire da 10 anni prima della data di diagnosi del carcinoma al tuo parente. Inoltre consiglio una colonscopia ogni 5-10 anni',
              colorTheme: Color(0xFFEB6D7B),
              isAlert: true,
              chatbotInfoData: Tuple2<String, String>(
                'A cosa serve la familiarità?',
                'A cosa serve la familiarità?',
              ),
            ),
          );

          // aggiornamento familiarità organo
          _firestoreWrite.updateOrgan(Tuple2<String, Tuple2<String, dynamic>>(
            '002',
            Tuple2<String, dynamic>(
              'familiarity_risk',
              Constants.COLON_FAMILIARITY_HIGH_UNDER_40.toJson(),
            ),
          ));
        } else {
          _familiarityAlgorithmSubject.sink.add(
            PrevengoDiaryModalCSS(
              title: 'Rishio familiarità alto',
              iconPath: 'assets/avatars/arold_in_circle.svg',
              message:
                  'Secondo le linee guida ministeriali, le persone della tua età dovrebbero fare un esame SOF ogni 3 anni. Inoltre consiglio una colonscopia ogni 5-10 anni',
              colorTheme: Color(0xFFEB6D7B),
              isAlert: true,
              chatbotInfoData: Tuple2<String, String>(
                'A cosa serve la familiarità?',
                'A cosa serve la familiarità?',
              ),
            ),
          );
          // aggiornamento familiarità organo
          _firestoreWrite.updateOrgan(Tuple2<String, Tuple2<String, dynamic>>(
            '002',
            Tuple2<String, dynamic>(
              'familiarity_risk',
              Constants.COLON_FAMILIARITY_HIGH_OVER_40.toJson(),
            ),
          ));
        }
      } else {
        _familiarityAlgorithmSubject.sink.add(
          PrevengoDiaryModalCSS(
            title: 'Rishio familiarità medio',
            iconPath: 'assets/avatars/arold_in_circle.svg',
            message:
                'Ti consiglio di fare un esame SOF ogni 3 anni e una sigmoidoscopia ogni 5 anni',
            colorTheme: Color(0xFFFAC297),
            isAlert: true,
            chatbotInfoData: Tuple2<String, String>(
              'A cosa serve la familiarità?',
              'A cosa serve la familiarità?',
            ),
          ),
        );
        // aggiornamento familiarità organo
        _firestoreWrite.updateOrgan(Tuple2<String, Tuple2<String, dynamic>>(
          '002',
          Tuple2<String, dynamic>(
            'familiarity_risk',
            Constants.COLON_FAMILIARITY_MEDIUM.toJson(),
          ),
        ));
      }
    } else {
      //no familiarità
      _familiarityAlgorithmSubject.sink.add(
        PrevengoDiaryModalCSS(
          title: 'Bene!',
          iconPath: 'assets/avatars/arold_in_circle.svg',
          message: 'Non è stato riscontrato alcun rischio di familiarità',
          colorTheme: Color(0xFF8AC165),
          isAlert: true,
          chatbotInfoData: Tuple2<String, String>(
            'A cosa serve la familiarità?',
            'A cosa serve la familiarità?',
          ),
        ),
      );
      // aggiornamento familiarità organo
      _firestoreWrite.updateOrgan(Tuple2<String, Tuple2<String, dynamic>>(
        '002',
        Tuple2<String, dynamic>(
          'familiarity_risk',
          Constants.COLON_FAMILIARITY_NULL.toJson(),
        ),
      ));
    }
  }

  void startFromZero() {
    _algorithmResultSubject.sink.add(
      PrevengoDiaryModalCSS(
        title: 'Ops! Sei in ritardo!',
        iconPath: 'assets/avatars/arold_in_circle.svg',
        message:
            'Partiamo da zero! Ti consiglio di prenotare il prossimo esame',
        suggestedBooking: 'Quest\'anno',
        colorTheme: Color(0xFFEB6D7B),
        isAlert: false,
      ),
    );
    _firestoreWrite.updateOrganStatus(Tuple2<String, Map<String, dynamic>>(
      '002',
      Constants.ORGAN_STATUS_LATETORESERVE.toJson(),
    ));
    _firestoreWrite.updateOrgan(Tuple2<String, Tuple2<String, dynamic>>(
      '002',
      Tuple2<String, dynamic>(
        'next_test_date',
        DateTime.now(),
      ),
    ));
    CacheManager.saveKV(CacheManager.checkQuestionaryColonKey, true);
  }

  void updateOrgan() async {
    print('update organ');
    ReservableTest reservableTest = Constants.allReservableTestList
        .firstWhere((element) => element.type == TestType.SOF);
    Reservation reservation =
        CacheManager.getValue(CacheManager.colonReservationKey);
    bool dontRememberReservation =
        CacheManager.getValue(CacheManager.colonDontRememberReservationKey);
    // Test creation
    Test test;
    if (reservation != null) {
      test = Test(
        reservableTest.name,
        reservableTest.organKey,
        reservableTest.type,
        reservableTest.description,
      );
      test.reservation = reservation;
      test.outcome = OutcomeScreening('Descrizione');

      test.outcome = OutcomeScreening('Descrizione');
      _firestoreWrite.createTest(test.toJson()).then((value) {
        File outcomeFile =
            CacheManager.getValue(CacheManager.colonOutcomeFileKey);
        if (outcomeFile != null) {
          _cloudStorageService.uploadFile(
              imageToUpload: outcomeFile, testKey: value);
        }
      });

      //calcolo data consigliata prossimo esame (cloud functions)
      _calcNextExamDateAlgorithm(test);
      CacheManager.saveKV(CacheManager.checkQuestionaryColonKey, true);
    } else if (dontRememberReservation == null ||
        dontRememberReservation == false) {
      //errore selezionare tipo esame ed inserire anno oppure cliccare su "non me lo ricordo"
      _algorithmResultSubject.sink.add(
        PrevengoDiaryModalCSS(
          title: 'Attenzione!',
          iconPath: 'assets/avatars/arold_in_circle.svg',
          message:
              'Selezionare il tipo di esame ed inserire l\'anno oppure cliccare su "non me lo ricordo"',
          colorTheme: Color(0xFFE8B21C),
          isAlert: true,
        ),
      );
    } else {
      //ok partiamo da zero!
      _algorithmResultSubject.sink.add(
        PrevengoDiaryModalCSS(
          title: 'Ops! Sei in ritardo!',
          iconPath: 'assets/avatars/arold_in_circle.svg',
          message:
              'Partiamo da zero. Ti consiglio di prenotare il prossimo esame',
          suggestedBooking: 'Quest\'anno',
          colorTheme: Color(0xFFEB6D7B),
          isAlert: false,
        ),
      );

      CacheManager.saveKV(CacheManager.checkQuestionaryColonKey, true);

      _firestoreWrite.updateOrganStatus(Tuple2<String, Map<String, dynamic>>(
        '002',
        Constants.ORGAN_STATUS_LATETORESERVE.toJson(),
      ));
      _firestoreWrite.updateOrgan(Tuple2<String, Tuple2<String, dynamic>>(
        '002',
        Tuple2<String, dynamic>(
          'next_test_date',
          DateTime.now(),
        ),
      ));
    }
  }

  void _calcNextExamDateAlgorithm(Test test) async {
    print('[CLOUD FUNCTION CALL]');

    Map<String, String> result;
    result = await _cloudFunctionsService.calcNextTestDate(
      test.toJson(),
    );

    String nextTestDate = result['next_test_date'];
    int nextTestYear = DateTime.parse(nextTestDate).year;

    if (DateTime.now().year < nextTestYear) {
      int yearDiff = nextTestYear - DateTime.now().year;
      _algorithmResultSubject.sink.add(
        PrevengoDiaryModalCSS(
          title: 'Ben Fatto!',
          iconPath: 'assets/avatars/arold_in_circle.svg',
          message:
              'Ho inserito il tuo esito. Ti ricorederò io quando dovrai prenotare il prossimo esame tra',
          suggestedBooking: yearDiff == 1 ? '$yearDiff anno' : '$yearDiff anni',
          colorTheme: Color(0xFF8AC165),
          isAlert: false,
        ),
      );
    } else if (DateTime.now().year > nextTestYear) {
      _algorithmResultSubject.sink.add(
        PrevengoDiaryModalCSS(
          title: 'Ops! Sei in ritardo!',
          iconPath: 'assets/avatars/arold_in_circle.svg',
          message:
              'Ho inserito il tuo esito. Ti consiglio di prenotare il prossimo esame',
          suggestedBooking: 'Quest\'anno',
          colorTheme: Color(0xFFEB6D7B),
          isAlert: false,
        ),
      );
    } else {
      _algorithmResultSubject.sink.add(
        PrevengoDiaryModalCSS(
          title: 'Bene! E\' ora di prenotare!',
          iconPath: 'assets/avatars/arold_in_circle.svg',
          message:
              'Ho inserito il tuo esito. Ti consiglio di prenotare il prossimo esame',
          suggestedBooking: 'Quest\'anno',
          colorTheme: Color(0xFFFAC297),
          isAlert: false,
        ),
      );
    }
  }

  //CALC EXAM YEAR FOR ORGANS
  void calcSuggestedBooking() {
    // int age = 40;
    // if (age > 39 && age < 46) {
    //   _suggestedBooking.sink.add('Anno');
    // } else if (age > 45 && age < 75) {
    //   _suggestedBooking.sink.add('2 anni');
    // }
    _suggestedBooking.sink.add('3 anni');
  }

  bool isTooSoonForScreening() {
    DateTime userYearOfBirth =
        CacheManager.getValue(CacheManager.dateOfBirthKey);
    int userAge = DateTime.now().year - userYearOfBirth.year;
    return userAge <= 39;
  }

  bool isTooLateForScreening() {
    DateTime userYearOfBirth =
        CacheManager.getValue(CacheManager.dateOfBirthKey);
    int userAge = DateTime.now().year - userYearOfBirth.year;
    return userAge >= 75;
  }

  void setTooSoonForScreeningStatus() {
    DateTime userYearOfBirth =
        CacheManager.getValue(CacheManager.dateOfBirthKey);
    int userAge = DateTime.now().year - userYearOfBirth.year;
    DateTime nextTestDate = DateTime(DateTime.now().year + (40 - userAge));

    _firestoreWrite.updateOrganStatus(Tuple2<String, Map<String, dynamic>>(
      '002',
      Constants.ORGAN_STATUS_GOOD.toJson(),
    ));

    _firestoreWrite.updateOrgan(Tuple2<String, Tuple2<String, dynamic>>(
      '002',
      Tuple2<String, dynamic>(
        'next_test_date',
        nextTestDate,
      ),
    ));
    CacheManager.saveKV(CacheManager.checkQuestionaryColonKey, true);
  }

  void setTooLateForScreeningStatus() {
    _firestoreWrite.updateOrganStatus(Tuple2<String, Map<String, dynamic>>(
      '002',
      Constants.ORGAN_STATUS_OUTOFAGE.toJson(),
    ));
    CacheManager.saveKV(CacheManager.checkQuestionaryColonKey, true);
  }

  void dispose() {
    _checkDadSubject.close();
    _checkMomSubject.close();
    _algorithmResultSubject.close();
    _suggestedBooking.close();
    _reservationSubject.close();
    _dontRememberReservationSubject.close();
  }
}
