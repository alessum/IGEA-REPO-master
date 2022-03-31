import 'dart:io';

import 'package:flutter/material.dart';
import 'package:igea_app/models/camera_file_manager.dart';
import 'package:igea_app/models/constants/constants.dart';
import 'package:igea_app/models/enums/gender.dart';
import 'package:igea_app/models/enums/test_type.dart';
import 'package:igea_app/models/outcome_screening.dart';
import 'package:igea_app/models/registry.dart';
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

class OnboardingUterusBlocProvider extends InheritedWidget {
  final OnboardingUterusBloc bloc;

  OnboardingUterusBlocProvider({Key key, Widget child})
      : bloc = OnboardingUterusBloc(),
        super(key: key, child: child);

  @override
  bool updateShouldNotify(InheritedWidget oldWidget) {
    return true;
  }

  static OnboardingUterusBloc of(BuildContext context) {
    return context
        .dependOnInheritedWidgetOfExactType<OnboardingUterusBlocProvider>()
        .bloc;
  }
}

class OnboardingUterusBloc {
  final _firestoreWrite = FirestoreWrite.instance();
  final _firestoreRead = FirestoreRead.instance();
  final _cloudFunctionsService = CloudFunctionsService.instance();
  final _cloudStorageService = CloudStorageService.instance();

  RegistryData _registryData;
  bool _antiHpvVaccination;
  bool _inScreeningProgram;
  ReservableTest _reservableTest;
  Reservation _reservation;
  File _outcomeFile;

  //STREAM CONTROLLERS
  final _fetchRegistrySubject = PublishSubject<RegistryData>();
  final _hpvVaccinationSubject = PublishSubject<bool>();
  final _reservableTestSubject = PublishSubject<TestType>();
  final _reservationSubject = PublishSubject<DateTime>();
  final _suggestedBooking = PublishSubject<String>();
  final _showImageSubject = PublishSubject<File>();
  final _algorithmResultSubject = BehaviorSubject<Widget>();
  final _dontRememberReservationSubject = PublishSubject<bool>();

  //SEND DATA TO UI
  Stream<RegistryData> get getRegistryData => _fetchRegistrySubject.stream;
  Stream<String> get getSuggestedBooking => _suggestedBooking.stream;
  Stream<Widget> get getAlgorithmResult => _algorithmResultSubject.stream;
  Stream<bool> get isHpvVaccinated => _hpvVaccinationSubject.stream;
  Stream<TestType> get getReservableTestType => _reservableTestSubject.stream;
  Stream<File> get getOutcomeImage => _showImageSubject.stream;
  Stream<bool> get getDontRememberReservation =>
      _dontRememberReservationSubject.stream;
  Stream<DateTime> get getReservation => _reservationSubject.stream;

  //GET DATA FROM UI
  Sink<bool> get updateHpvVaccine => _hpvVaccinationSubject.sink;
  Sink<TestType> get updateReservableTest => _reservableTestSubject.sink;
  Sink<DateTime> get updateReservation => _reservationSubject.sink;
  Sink<bool> get updateDontRemenberReservation =>
      _dontRememberReservationSubject.sink;

  RegistryData get registryData => _registryData;

  OnboardingUterusBloc() {
    _firestoreRead.userInfoListener().listen((event) {
      _registryData = PrevengoUser.fromJson(event.data()).registryData;
      _fetchRegistrySubject.sink.add(_registryData);
    });

    CameraFileManager.getFileImage.listen((event) {
      CacheManager.saveKV(
        CacheManager.uterusOutcomeFileKey,
        event,
      );
      _showImageSubject.sink.add(event);
    });

    _hpvVaccinationSubject.stream.listen((event) {
      _antiHpvVaccination = event;
      CacheManager.saveKV(
        CacheManager.uterusAntiHpvVaccinationKey,
        event,
      );
    });

    _reservableTestSubject.stream.listen((event) {
      _reservableTest = Constants.allReservableTestList
          .firstWhere((element) => element.type == event);
      CacheManager.saveKV(
        CacheManager.uterusReservableTestKey,
        _reservableTest,
      );
    });

    _reservationSubject.stream.listen((event) {
      if (event != null) {
        _reservation = Reservation(
          event,
          'Primo esame inserito',
          null,
          'Non specificato',
        );
        _dontRememberReservationSubject.sink.add(false);

        CacheManager.saveMultipleKV({
          CacheManager.uterusReservationKey: _reservation,
          CacheManager.uterusDontRememberReservationKey: false,
        });
      }
    });

    _dontRememberReservationSubject.stream.listen((event) {
      if (event == true) {
        _reservationSubject.sink.add(null);
        CacheManager.saveKV(
          CacheManager.uterusReservationKey,
          null,
        );
      }

      CacheManager.saveKV(
        CacheManager.uterusDontRememberReservationKey,
        event,
      );
    });

    _algorithmResultSubject.stream.listen((event) {});
  }

  void initHpvRequestPage() {
    _hpvVaccinationSubject.sink.add(
      CacheManager.getValue(CacheManager.uterusAntiHpvVaccinationKey),
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
    _reservableTestSubject.sink.add(
      (CacheManager.getValue(CacheManager.uterusReservableTestKey)
              as ReservableTest)
          .type,
    );
    _reservationSubject.sink.add(
      CacheManager.getValue(CacheManager.uterusReservationKey),
    );
    _dontRememberReservationSubject.sink.add(
      CacheManager.getValue(CacheManager.uterusDontRememberReservationKey),
    );
  }

  bool isHpvVaccineInputValid() {
    bool checkHpvVaccine =
        CacheManager.getValue(CacheManager.uterusAntiHpvVaccinationKey);
    return checkHpvVaccine != null;
  }

  void updateOrgan() async {
    ReservableTest reservableTest =
        CacheManager.getValue(CacheManager.uterusReservableTestKey);
    Reservation reservation =
        CacheManager.getValue(CacheManager.uterusReservationKey);
    bool dontRememberReservation =
        CacheManager.getValue(CacheManager.uterusDontRememberReservationKey);
    bool antiHpvVaccination =
        CacheManager.getValue(CacheManager.uterusAntiHpvVaccinationKey);
    // Test creation
    Test test;
    if (reservableTest != null && reservation != null) {
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
            CacheManager.getValue(CacheManager.uterusOutcomeFileKey);
        if (outcomeFile != null) {
          _cloudStorageService.uploadFile(
              imageToUpload: outcomeFile, testKey: value);
        }
      });

      //calcolo data consigliata prossimo esame (cloud functions)
      _calcNextExamDateAlgorithm(test);

      CacheManager.saveKV(CacheManager.checkQuestionaryUterusKey, true);
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
              'Ho inserito il tuo esito. Ti consiglio di prenotare il prossimo esame',
          suggestedBooking: 'Quest\'anno',
          colorTheme: Color(0xFFEB6D7B),
          isAlert: false,
        ),
      );

      CacheManager.saveKV(CacheManager.checkQuestionaryUterusKey, true);

      _firestoreWrite.updateOrganStatus(Tuple2<String, Map<String, dynamic>>(
        '003',
        Constants.ORGAN_STATUS_LATETORESERVE.toJson(),
      ));
      _firestoreWrite.updateOrgan(Tuple2<String, Tuple2<String, dynamic>>(
        '003',
        Tuple2<String, dynamic>(
          'next_test_date',
          DateTime.now(),
        ),
      ));
    }

    //organ update
    _firestoreWrite.updateOrgan(
      Tuple2(
        '003',
        Tuple2<String, dynamic>(
          Constants.ORGAN_HPV_VACCINE_KEY,
          antiHpvVaccination,
        ),
      ),
    );
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
      '003',
      Constants.ORGAN_STATUS_LATETORESERVE.toJson(),
    ));
    _firestoreWrite.updateOrgan(Tuple2<String, Tuple2<String, dynamic>>(
      '003',
      Tuple2<String, dynamic>(
        'next_test_date',
        DateTime.now(),
      ),
    ));
    CacheManager.saveKV(CacheManager.checkQuestionaryUterusKey, true);
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
    DateTime userYearOfBirth =
        CacheManager.getValue(CacheManager.dateOfBirthKey);
    int userAge = DateTime.now().year - userYearOfBirth.year;

    if (userAge > 24 && userAge < 66) {
      _suggestedBooking.sink.add('3 anni');
    }
  }

  void updateVaccination() {
    bool antiHpvVaccination =
        CacheManager.getValue(CacheManager.uterusAntiHpvVaccinationKey);
    _firestoreWrite.updateOrgan(
      Tuple2(
        '003',
        Tuple2<String, dynamic>(
          Constants.ORGAN_HPV_VACCINE_KEY,
          antiHpvVaccination,
        ),
      ),
    );
  }

  bool isTooSoonForScreening() {
    DateTime userYearOfBirth =
        CacheManager.getValue(CacheManager.dateOfBirthKey);
    int userAge = DateTime.now().year - userYearOfBirth.year;
    return userAge < 25;
  }

  bool isTooLateForScreening() {
    DateTime userYearOfBirth =
        CacheManager.getValue(CacheManager.dateOfBirthKey);
    int userAge = DateTime.now().year - userYearOfBirth.year;
    return userAge > 65;
  }

  void setTooSoonForScreeningStatus() {
    DateTime userYearOfBirth =
        CacheManager.getValue(CacheManager.dateOfBirthKey);
    int userAge = DateTime.now().year - userYearOfBirth.year;
    DateTime nextTestDate = DateTime(DateTime.now().year + (25 - userAge));

    _firestoreWrite.updateOrganStatus(Tuple2<String, Map<String, dynamic>>(
      '003',
      Constants.ORGAN_STATUS_GOOD.toJson(),
    ));

    _firestoreWrite.updateOrgan(Tuple2<String, Tuple2<String, dynamic>>(
      '003',
      Tuple2<String, dynamic>(
        'next_test_date',
        nextTestDate,
      ),
    ));
    CacheManager.saveKV(CacheManager.checkQuestionaryUterusKey, true);
  }

  void setTooLateForScreeningStatus() {
    _firestoreWrite.updateOrganStatus(Tuple2<String, Map<String, dynamic>>(
      '003',
      Constants.ORGAN_STATUS_OUTOFAGE.toJson(),
    ));
    CacheManager.saveKV(CacheManager.checkQuestionaryUterusKey, true);
  }

  void dispose() {
    _fetchRegistrySubject.close();
    _hpvVaccinationSubject.close();
    _reservableTestSubject.close();
    _reservationSubject.close();
    _suggestedBooking.close();
    _showImageSubject.close();
    _algorithmResultSubject.close();
    _dontRememberReservationSubject.close();
  }
}
