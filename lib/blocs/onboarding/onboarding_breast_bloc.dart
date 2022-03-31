import 'dart:io';

import 'package:flutter/material.dart';
import 'package:igea_app/models/camera_file_manager.dart';
import 'package:igea_app/models/constants/constants.dart';
import 'package:igea_app/models/enums/test_type.dart';
import 'package:igea_app/models/outcome_screening.dart';
import 'package:igea_app/models/registry.dart';
import 'package:igea_app/models/reservable_test.dart';
import 'package:igea_app/models/reservation.dart';
import 'package:igea_app/models/test.dart';
import 'package:igea_app/models/user.dart';
import 'package:igea_app/screens/diary/modal_bottom_sheets/prevengo_modal_css.dart';
import 'package:igea_app/screens/welcome/ui_components/prevengo_onboarding_button.dart';
import 'package:igea_app/services/cloud_functions_service.dart';
import 'package:igea_app/services/cloud_storage_service.dart';
import 'package:igea_app/services/firestore_read.dart';
import 'package:igea_app/services/firestore_write.dart';
import 'package:igea_app/services/utilities.dart';
import 'package:rxdart/rxdart.dart';
import 'package:tuple/tuple.dart';

class OnboardingBreastBlocProvider extends InheritedWidget {
  final OnboardingBreastBloc bloc;

  OnboardingBreastBlocProvider({Key key, Widget child})
      : bloc = OnboardingBreastBloc(),
        super(key: key, child: child);

  @override
  bool updateShouldNotify(InheritedWidget oldWidget) {
    return true;
  }

  static OnboardingBreastBloc of(BuildContext context) {
    return context
        .dependOnInheritedWidgetOfExactType<OnboardingBreastBlocProvider>()
        .bloc;
  }
}

class OnboardingBreastBloc {
  final _firestoreWrite = FirestoreWrite.instance();
  final _firestoreRead = FirestoreRead.instance();
  final _cloudFunctionsService = CloudFunctionsService.instance();
  final _cloudStorageService = CloudStorageService.instance();

  //STREAM CONTROLLERS
  final _fetchRegistrySubject = PublishSubject<RegistryData>();
  final _showImageSubject = PublishSubject<File>();
  final _checkDadSubject = PublishSubject<bool>();
  final _checkMomSubject = PublishSubject<bool>();
  final _counterBrotherSubject = PublishSubject<int>();
  final _counterSisterSubject = PublishSubject<int>();
  final _counterAuntSubject = PublishSubject<int>();
  final _counterGrandPASubject = PublishSubject<int>();
  final _counterGrandMASubject = PublishSubject<int>();
  final _algorithmResultSubject = BehaviorSubject<Widget>();
  final _familiarityAlgorithmSubject = BehaviorSubject<Widget>();
  final _suggestedBooking = PublishSubject<String>();
  final _reservationSubject = PublishSubject<DateTime>();
  final _dontRememberReservationSubject = PublishSubject<bool>();
  final _checkNoFamiliaritySubject = PublishSubject<bool>();

  //SEND DATA TO UI
  Stream<bool> get getCheckDad => _checkDadSubject.stream;
  Stream<File> get getOutcomeImage => _showImageSubject.stream;
  Stream<bool> get getCheckMom => _checkMomSubject.stream;
  Stream<int> get getBrotherCounter => _counterBrotherSubject.stream;
  Stream<int> get getSisterCounter => _counterSisterSubject.stream;
  Stream<int> get getAuntCounter => _counterAuntSubject.stream;
  Stream<int> get getGrandPACounter => _counterGrandPASubject.stream;
  Stream<int> get getGrandMACounter => _counterGrandMASubject.stream;
  Stream<Widget> get getAlgorithmResult => _algorithmResultSubject.stream;
  Stream<Widget> get getfamiliarityAlgorithmResult =>
      _familiarityAlgorithmSubject.stream;
  Stream<String> get getSuggestedBooking => _suggestedBooking.stream;
  Stream<DateTime> get getReservation => _reservationSubject.stream;
  Stream<bool> get getCheckNoFamiliarity => _checkNoFamiliaritySubject.stream;
  Stream<bool> get getDontRememberReservation =>
      _dontRememberReservationSubject.stream;

  //GET DATA FROM UI
  Sink<bool> get setCheckDad => _checkDadSubject.sink;
  Sink<bool> get setCheckMom => _checkMomSubject.sink;
  Sink<int> get setBrotherCounter => _counterBrotherSubject.sink;
  Sink<int> get setSisterCounter => _counterSisterSubject.sink;
  Sink<int> get setAuntCounter => _counterAuntSubject.sink;
  Sink<int> get setGrandPACounter => _counterGrandPASubject.sink;
  Sink<int> get setGrandMACounter => _counterGrandMASubject.sink;
  Sink<DateTime> get updateReservation => _reservationSubject.sink;
  Sink<bool> get setCheckNoFamiliarity => _checkNoFamiliaritySubject.sink;
  Sink<bool> get updateDontRemenberReservation =>
      _dontRememberReservationSubject.sink;

  OnboardingBreastBloc() {
    CameraFileManager.getFileImage.listen((event) {
      CacheManager.saveKV(
        CacheManager.uterusOutcomeFileKey,
        event,
      );
      _showImageSubject.sink.add(event);
    });

    _checkDadSubject.stream.listen((event) {
      int counter =
          CacheManager.getValue(CacheManager.breastParentCounterKey) ?? 0;
      if (event)
        counter++;
      else if (counter > 0) counter--;

      CacheManager.saveMultipleKV({
        CacheManager.breastParentCounterKey: counter,
        CacheManager.breastCheckDadKey: event,
      });

      if (event) {
        _checkNoFamiliaritySubject.sink.add(false);
      }
    });

    _checkMomSubject.stream.listen((event) {
      int counter =
          CacheManager.getValue(CacheManager.breastParentCounterKey) ?? 0;
      if (event)
        counter++;
      else if (counter > 0) counter--;

      CacheManager.saveMultipleKV({
        CacheManager.breastParentCounterKey: counter,
        CacheManager.breastCheckMomKey: event,
      });

      if (event) {
        _checkNoFamiliaritySubject.sink.add(false);
      }
    });

    _counterBrotherSubject.stream.listen((event) {
      int totCounter =
          CacheManager.getValue(CacheManager.breastParentCounterKey) ?? 0;
      int counter =
          CacheManager.getValue(CacheManager.breastCounterBrotherKey) ?? 0;

      if (counter < event) {
        totCounter++;
      } else if (counter > event) {
        totCounter--;
      }

      if (totCounter != 0) {
        _checkNoFamiliaritySubject.sink.add(false);
      }

      CacheManager.saveMultipleKV({
        CacheManager.breastParentCounterKey: totCounter,
        CacheManager.breastCounterBrotherKey: event,
      });

      print('TOTAL COUNTER: $totCounter');
    });

    _counterSisterSubject.stream.listen((event) {
      int totCounter =
          CacheManager.getValue(CacheManager.breastParentCounterKey) ?? 0;
      int counter =
          CacheManager.getValue(CacheManager.breastCounterSisterKey) ?? 0;

      if (counter < event) {
        totCounter++;
      } else if (counter > event) {
        totCounter--;
      }

      if (totCounter != 0) {
        _checkNoFamiliaritySubject.sink.add(false);
      }

      CacheManager.saveMultipleKV({
        CacheManager.breastParentCounterKey: totCounter,
        CacheManager.breastCounterSisterKey: event,
      });

      print('TOTAL COUNTER: $totCounter');
    });

    _counterAuntSubject.stream.listen((event) {
      int totCounter =
          CacheManager.getValue(CacheManager.breastParentCounterKey) ?? 0;
      int counter =
          CacheManager.getValue(CacheManager.breastCounterAuntKey) ?? 0;

      if (counter < event) {
        totCounter++;
      } else if (counter > event) {
        totCounter--;
      }

      if (totCounter != 0) {
        _checkNoFamiliaritySubject.sink.add(false);
      }

      CacheManager.saveMultipleKV({
        CacheManager.breastParentCounterKey: totCounter,
        CacheManager.breastCounterAuntKey: event,
      });

      print('TOTAL COUNTER: $totCounter');
    });

    _counterGrandPASubject.stream.listen((event) {
      int totCounter =
          CacheManager.getValue(CacheManager.breastParentCounterKey) ?? 0;
      int counter =
          CacheManager.getValue(CacheManager.breastCounterGrandPAKey) ?? 0;

      if (counter < event) {
        totCounter++;
      } else if (counter > event) {
        totCounter--;
      }

      if (totCounter != 0) {
        _checkNoFamiliaritySubject.sink.add(false);
      }

      CacheManager.saveMultipleKV({
        CacheManager.breastParentCounterKey: totCounter,
        CacheManager.breastCounterGrandPAKey: event,
      });

      print('TOTAL COUNTER: $totCounter');
    });

    _counterGrandMASubject.stream.listen((event) {
      int totCounter =
          CacheManager.getValue(CacheManager.breastParentCounterKey) ?? 0;
      int counter =
          CacheManager.getValue(CacheManager.breastCounterGrandMAKey) ?? 0;

      if (counter < event) {
        totCounter++;
      } else if (counter > event) {
        totCounter--;
      }

      if (totCounter != 0) {
        _checkNoFamiliaritySubject.sink.add(false);
      }

      CacheManager.saveMultipleKV({
        CacheManager.breastParentCounterKey: totCounter,
        CacheManager.breastCounterGrandMAKey: event,
      });

      print('TOTAL COUNTER: $totCounter');
    });

    _checkNoFamiliaritySubject.stream.listen((event) {
      if (event) {
        CacheManager.saveMultipleKV({
          CacheManager.breastParentCounterKey: 0,
          CacheManager.breastCounterBrotherKey: 0,
          CacheManager.breastCounterSisterKey: 0,
          CacheManager.breastCounterAuntKey: 0,
          CacheManager.breastCounterGrandPAKey: 0,
          CacheManager.breastCounterGrandMAKey: 0,
        });
        _checkMomSubject.sink.add(false);
        _checkDadSubject.sink.add(false);
        _counterBrotherSubject.sink.add(0);
        _counterSisterSubject.sink.add(0);
        _counterAuntSubject.sink.add(0);
        _counterGrandPASubject.sink.add(0);
        _counterGrandMASubject.sink.add(0);
      }
      CacheManager.saveKV(
        CacheManager.breastCheckNoFamiliarityKey,
        event,
      );
    });

    CameraFileManager.getFileImage.listen((event) {
      CacheManager.saveKV(
        CacheManager.breastOutcomeFileKey,
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
          CacheManager.breastReservationKey: reservation,
          CacheManager.breastDontRememberReservationKey: false,
        });
      }
    });

    _dontRememberReservationSubject.stream.listen((event) {
      if (event == true) {
        _reservationSubject.sink.add(null);
        CacheManager.saveKV(
          CacheManager.breastReservationKey,
          null,
        );
      }

      CacheManager.saveKV(
        CacheManager.breastDontRememberReservationKey,
        event,
      );
    });
  }

  void initFamiliarityPage() {
    _checkDadSubject.sink.add(
      CacheManager.getValue(CacheManager.breastCheckDadKey),
    );
    _checkMomSubject.sink.add(
      CacheManager.getValue(CacheManager.breastCheckMomKey),
    );
    _counterBrotherSubject.sink.add(
      CacheManager.getValue(CacheManager.breastCounterBrotherKey),
    );
    _counterSisterSubject.sink.add(
      CacheManager.getValue(CacheManager.breastCounterSisterKey),
    );
    _counterAuntSubject.sink.add(
      CacheManager.getValue(CacheManager.breastCounterAuntKey),
    );
    _counterGrandPASubject.sink.add(
      CacheManager.getValue(CacheManager.breastCounterGrandPAKey),
    );
    _counterGrandMASubject.sink.add(
      CacheManager.getValue(CacheManager.breastCounterGrandMAKey),
    );
    _checkNoFamiliaritySubject.sink.add(
      CacheManager.getValue(CacheManager.breastCheckNoFamiliarityKey),
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

  bool isfamiliarityInputValid() {
    int totCounter =
        CacheManager.getValue(CacheManager.breastParentCounterKey) ?? 0;
    bool checkNoFamiliarity =
        CacheManager.getValue(CacheManager.breastCheckNoFamiliarityKey) ??
            false;

    return totCounter > 0 || checkNoFamiliarity;
  }

  void checkFamiliarityAlgorithm() {
    int totCounter =
        CacheManager.getValue(CacheManager.breastParentCounterKey) ?? 0;

    print('total counter $totCounter');
    if (totCounter >= 3) {
      _familiarityAlgorithmSubject.sink.add(
        PrevengoDiaryModalCSS(
          title: 'Rischio familiarità alto',
          iconPath: 'assets/avatars/arold_in_circle.svg',
          message:
              'Ti consiglio di rivolgerti al tuo medico di base o ad un ambulatorio del rischio eredo-familiare',
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
        '001',
        Tuple2<String, dynamic>(
          'familiarity_risk',
          Constants.BREAST_FAMILIARITY_HIGH.toJson(),
        ),
      ));
    } else if (totCounter == 2) {
      _familiarityAlgorithmSubject.sink.add(
        PrevengoDiaryModalCSS(
          title: 'Rischio familiarità moderato',
          iconPath: 'assets/avatars/arold_in_circle.svg',
          message: 'Ti consiglio di parlarne con il tuo medico di base',
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
        '001',
        Tuple2<String, dynamic>(
          'familiarity_risk',
          Constants.BREAST_FAMILIARITY_MODERATE.toJson(),
        ),
      ));
    } else if (totCounter == 1) {
      _familiarityAlgorithmSubject.sink.add(
        PrevengoDiaryModalCSS(
          title: 'Rischio familiarità basso',
          iconPath: 'assets/avatars/arold_in_circle.svg',
          message:
              'Ti consiglio di parlarne con il tuo medico di base nel caso in cui il tumore fosse stato diagnosticato entro i 50 anni del tuo parente',
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
        '001',
        Tuple2<String, dynamic>(
          'familiarity_risk',
          Constants.BREAST_FAMILIARITY_LOW.toJson(),
        ),
      ));
    } else {
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
        '001',
        Tuple2<String, dynamic>(
          'familiarity_risk',
          Constants.BREAST_FAMILIARITY_NULL.toJson(),
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
            'Partiamo da zero! Ti consiglio di prenotare il prossimo esame.',
        suggestedBooking: 'Quest\'anno',
        colorTheme: Color(0xFFEB6D7B),
        isAlert: false,
      ),
    );
    _firestoreWrite.updateOrganStatus(Tuple2<String, Map<String, dynamic>>(
      '001',
      Constants.ORGAN_STATUS_LATETORESERVE.toJson(),
    ));
    _firestoreWrite.updateOrgan(Tuple2<String, Tuple2<String, dynamic>>(
      '001',
      Tuple2<String, dynamic>(
        'next_test_date',
        DateTime.now(),
      ),
    ));
    CacheManager.saveKV(CacheManager.checkQuestionaryBreastKey, true);
  }

  void updateOrgan() async {
    ReservableTest reservableTest = Constants.allReservableTestList
        .firstWhere((element) => element.type == TestType.MAMMOGRAPHY);
    Reservation reservation =
        CacheManager.getValue(CacheManager.breastReservationKey);
    bool dontRememberReservation =
        CacheManager.getValue(CacheManager.breastDontRememberReservationKey);
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
      _firestoreWrite.createTest(test.toJson()).then((value) {
        File outcomeFile =
            CacheManager.getValue(CacheManager.breastOutcomeFileKey);
        if (outcomeFile != null) {
          _cloudStorageService.uploadFile(
              imageToUpload: outcomeFile, testKey: value);
        }
      });

      //calcolo data consigliata prossimo esame (cloud functions)
      _calcNextExamDateAlgorithm(test);
      CacheManager.saveKV(CacheManager.checkQuestionaryBreastKey, true);
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

      CacheManager.saveKV(CacheManager.checkQuestionaryBreastKey, true);

      _firestoreWrite.updateOrganStatus(Tuple2<String, Map<String, dynamic>>(
        '001',
        Constants.ORGAN_STATUS_LATETORESERVE.toJson(),
      ));
      _firestoreWrite.updateOrgan(Tuple2<String, Tuple2<String, dynamic>>(
        '001',
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
    DateTime userDateOfBirth =
        CacheManager.getValue(CacheManager.dateOfBirthKey);
    int age = DateTime.now().year - userDateOfBirth.year;

    //ALGORITMO MINISTERIALE
    if (age >= 50 && age <= 74) {
      _suggestedBooking.sink.add('2 anni');
    }

    // ALGORTIMO FERRARI
    // if (age > 39 && age < 46) {
    //   _suggestedBooking.sink.add('Anno');
    // } else if (age > 45 && age < 75) {
    //   _suggestedBooking.sink.add('2 anni');
    // }
  }

  bool isTooSoonForScreening() {
    DateTime userYearOfBirth =
        CacheManager.getValue(CacheManager.dateOfBirthKey);
    int userAge = DateTime.now().year - userYearOfBirth.year;
    return userAge < 50;
  }

  bool isTooLateForScreening() {
    DateTime userYearOfBirth =
        CacheManager.getValue(CacheManager.dateOfBirthKey);
    int userAge = DateTime.now().year - userYearOfBirth.year;
    return userAge > 74;
  }

  void setTooSoonForScreeningStatus() {
    DateTime userYearOfBirth =
        CacheManager.getValue(CacheManager.dateOfBirthKey);
    int userAge = DateTime.now().year - userYearOfBirth.year;
    DateTime nextTestDate = DateTime(DateTime.now().year + (50 - userAge));

    _firestoreWrite.updateOrganStatus(Tuple2<String, Map<String, dynamic>>(
      '001',
      Constants.ORGAN_STATUS_GOOD.toJson(),
    ));

    _firestoreWrite.updateOrgan(Tuple2<String, Tuple2<String, dynamic>>(
      '001',
      Tuple2<String, dynamic>(
        'next_test_date',
        nextTestDate,
      ),
    ));
    CacheManager.saveKV(CacheManager.checkQuestionaryBreastKey, true);
  }

  void setTooLateForScreeningStatus() {
    _firestoreWrite.updateOrganStatus(Tuple2<String, Map<String, dynamic>>(
      '001',
      Constants.ORGAN_STATUS_OUTOFAGE.toJson(),
    ));
    CacheManager.saveKV(CacheManager.checkQuestionaryBreastKey, true);
  }

  void dispose() {
    _fetchRegistrySubject.close();
    _checkDadSubject.close();
    _checkMomSubject.close();
    _counterBrotherSubject.close();
    _counterSisterSubject.close();
    _counterAuntSubject.close();
    _counterGrandPASubject.close();
    _counterGrandMASubject.close();
    _algorithmResultSubject.close();
    _suggestedBooking.close();
    _reservationSubject.close();
    _dontRememberReservationSubject.close();
  }
}
