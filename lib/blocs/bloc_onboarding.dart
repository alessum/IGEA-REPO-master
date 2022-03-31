import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:igea_app/models/breast.dart';
import 'package:igea_app/models/camera_file_manager.dart';
import 'package:igea_app/models/colon.dart';
import 'package:igea_app/models/constants/constants.dart';
import 'package:igea_app/models/enums/gender.dart';
import 'package:igea_app/models/enums/status_type.dart';
import 'package:igea_app/models/enums/test_type.dart';
import 'package:igea_app/models/heart.dart';
import 'package:igea_app/models/organ.dart';
import 'package:igea_app/models/registry.dart';
import 'package:igea_app/models/reservable_test.dart';
import 'package:igea_app/models/reservation.dart';
import 'package:igea_app/models/status.dart';
import 'package:igea_app/models/test.dart';
import 'package:igea_app/models/test_screening.dart';
import 'package:igea_app/models/uterus.dart';
import 'package:igea_app/resources/prevention_repository.dart';
import 'package:igea_app/screens/diary/modal_bottom_sheets/prevengo_modal_css.dart';
import 'package:igea_app/services/cloud_functions_service.dart';
import 'package:igea_app/services/firestore_write.dart';
import 'package:igea_app/services/utilities.dart';
import 'package:rxdart/rxdart.dart';
import 'package:intl/intl.dart';
import 'package:tuple/tuple.dart';

class OnboardingBlocProvider extends InheritedWidget {
  final OnboardingBloc bloc;

  OnboardingBlocProvider({Key key, Widget child})
      : bloc = OnboardingBloc(),
        super(key: key, child: child);

  @override
  bool updateShouldNotify(InheritedWidget oldWidget) {
    return true;
  }

  static OnboardingBloc of(BuildContext context) {
    return context
        .dependOnInheritedWidgetOfExactType<OnboardingBlocProvider>()
        .bloc;
  }
}

class OnboardingBloc {
  final _repository = PreventionRepository.instance();
  final _cloudFunctionsService = CloudFunctionsService.instance();
  final _firestoreWrite = FirestoreWrite.instance();

  String careGiverKey;
  String assistedUserKey;

  //read
  final _registryFetcher = PublishSubject<RegistryData>();

  //write
  final _sendRegistry = PublishSubject<Map<dynamic, dynamic>>();
  final _updateCardiovascularData = PublishSubject<Map<dynamic, dynamic>>();
  final _calcNextTestDate = PublishSubject<Map<dynamic, dynamic>>();
  final _updateFirstAccess = PublishSubject<bool>();

  final _updateHeartData = PublishSubject<Map<dynamic, dynamic>>();
  final _sendNewTest = PublishSubject<Map<dynamic, dynamic>>();

  final _updateOrganData = PublishSubject<Map<dynamic, dynamic>>();
  final _removeAllTestPerOrgan = PublishSubject<String>();

  final _updateHpvVaccineSubject = PublishSubject<bool>();
  final _updateCervixFirstTestSubject = PublishSubject<TestType>();
  final _updateCervixTestReservationSubject = PublishSubject<String>();

  final _cervixExamYearSubject = PublishSubject<String>();

  final _showImageSubject = PublishSubject<File>();

  final _algorithmResultSubject = PublishSubject<Widget>();

  // final _setTextContentBreastOutput = PublishSubject<Map<dynamic,dynamic>>();

  Stream<RegistryData> get registry => _registryFetcher.stream;
  Stream<String> get getCervixExamYear => _cervixExamYearSubject.stream;
  Stream<Widget> get getAlgorithmResult => _algorithmResultSubject.stream;

  Sink<Map<dynamic, dynamic>> get inRegistryData => _sendRegistry.sink;
  //Sink<Map<dynamic, dynamic>> get inCardiovascularData =>
  //_updateCardiovascularData.sink;
  Sink<Map<dynamic, dynamic>> get inCalcNextDateData => _calcNextTestDate.sink;
  Sink<bool> get inUpdateFirstAccess => _updateFirstAccess.sink;

  Sink<Map<dynamic, dynamic>> get inHeartData => _updateHeartData.sink;

  Sink<Map<dynamic, dynamic>> get inUpdateOrganData => _updateOrganData.sink;
  Sink<Map<dynamic, dynamic>> get inNewTestData => _sendNewTest.sink;
  Sink<String> get inRemoveAllTestPerOrgan => _removeAllTestPerOrgan.sink;

  Sink<bool> get updateHpvVaccine => _updateHpvVaccineSubject.sink;
  Sink<TestType> get updateCervixFirstTest =>
      _updateCervixFirstTestSubject.sink;
  Sink<String> get updateCervixTestReservation =>
      _updateCervixTestReservationSubject.sink;

  Organ breast;
  Organ colon;
  Organ uterus;

  //CERVICE UTERINA
  bool _antiHPVVaccine;
  ReservableTest _cervixFirstTest;
  Reservation _cervixReservation;

  //MAMMELLA
  bool _breastFamiliarity;
  ReservableTest _breastFirstTest;

  //COLON
  bool _colonFamiliarity;
  ReservableTest _colonFirstTest;

  //REFERTO
  File _outcomeFile;

  OnboardingBloc() {
    _sendRegistry.stream.listen((input) {
      Map<dynamic, dynamic> _jsonRegistry;
      _jsonRegistry = RegistryData(
        input[Constants.REGISTRY_USERNAME_KEY],
        input[Constants.REGISTRY_NAME_KEY],
        input[Constants.REGISTRY_SURNAME_KEY],
        input[Constants.REGISTRY_DATE_OF_BIRTH_KEY],
        // input[Constants.REGISTRY_DOMICILE_KEY],
        '', //FIXME SISTEMARE DOMICILIO, CI VUOLE COME INPUT O LO TOLGO O LO PREVEDIAMO PER IL FUTURO?
        input[Constants.REGISTRY_FISCAL_CODE_KEY],
        input[Constants.REGISTRY_GENDER_KEY],
      ).toJson();

      Map<String, dynamic> jsonOrganList =
          _initOrganData(input[Constants.REGISTRY_GENDER_KEY]);
      _firestoreWrite.updateRegistry(_jsonRegistry);
      // print('[INIT ORGANS]');
      // print(jsonOrganList.toString());
      _firestoreWrite.initOrgans(jsonOrganList);
    });

    _updateOrganData.stream.listen((input) {
      //capire di quale key si tratta

      switch (input[Constants.ORGAN_KEY]) {
        case Constants.BREAST_KEY:
          breast.lastTestDate = input[Constants.LAST_TEST_DATE_KEY];
          // (breast as Breast).breastFamiliarity =
          //     input[Constants.ORGAN_BREAST_FAMILIARITY_KEY];

          break;
        case Constants.COLON_KEY:
          break;
        case Constants.UTERUS_KEY:
          break;
        default:
          return null;
      }

      _repository.updateOrgan(input);
    });

    CameraFileManager.getFileImage.listen((event) {
      _outcomeFile = event;
      //_showImageSubject.sink.add(event);
    });

    _updateHpvVaccineSubject.stream.listen((input) {
      _antiHPVVaccine = input;
      print('HPV VACCINE: $input');
    });

    _updateCervixFirstTestSubject.stream.listen((input) {
      _cervixFirstTest = Constants.allReservableTestList
          .firstWhere((element) => element.type == input);
    });

    _updateCervixTestReservationSubject.stream.listen((input) {
      if (input.length == 4) {
        DateTime date = DateTime(int.parse(input));
        _cervixReservation = Reservation(
          date,
          'Primo esame inserito',
          null,
          'Non specificato',
        );
        print('Date time: $date');
      }
    });

    //TODO IMPLEMENTARE ANCHE PER CARDIOVASCULAR DATA
    _sendNewTest.stream.listen((input) {
      Map<String, dynamic> jsonTest;

      //FIXME GESTIRE SCREENING TEST
      // ScreeningTest test = ScreeningTest(
      //   input[Constants.TEST_NAME_KEY],
      //   input[Constants.ORGAN_KEY],
      //   input[Constants.TEST_TYPE_KEY],
      //   input[Constants.TEST_DESCRIPTION_KEY],
      // );
      // test.reservation = Reservation(input[Constants.RESERVATION_DATE_KEY],
      //     'Primo esame inserito', null, null);
      // jsonTest = test.toJson();
      // _repository.sendOnboardingNewTest(jsonTest);
    });

    _removeAllTestPerOrgan.stream.listen((input) {
      print('REMOVE ALL TESTS');
      _repository.removeAllTestPerOrgan(input);
    });

    // _updateCardiovascularData.stream.listen((input) {
    //   print('[DEBUG CARDIO] ' + input.toString());
    //   Map<dynamic, Map<dynamic, dynamic>> jsonCardiovascularData;
    //   jsonCardiovascularData = {
    //     '004': {
    //       Constants.ORGAN_HEART_SMOKE_KEY:
    //           input[Constants.ORGAN_HEART_SMOKE_KEY],
    //       Constants.ORGAN_HEART_DIABETES_KEY:
    //           input[Constants.ORGAN_HEART_DIABETES_KEY],
    //       Constants.ORGAN_HEART_TRYGLIC_KEY:
    //           input[Constants.ORGAN_HEART_TRYGLIC_KEY],
    //       Constants.ORGAN_HEART_CHOL_TOT_KEY:
    //           input[Constants.ORGAN_HEART_CHOL_TOT_KEY],
    //       Constants.ORGAN_HEART_CHOL_HDL_KEY:
    //           input[Constants.ORGAN_HEART_CHOL_HDL_KEY],
    //       Constants.ORGAN_HEART_CHOL_LDL_KEY:
    //           input[Constants.ORGAN_HEART_CHOL_LDL_KEY],
    //       Constants.ORGAN_HEART_SYST_PRESS_KEY:
    //           input[Constants.ORGAN_HEART_SYST_PRESS_KEY],
    //       Constants.ORGAN_ACTIVE_KEY: true,
    //       Constants.ORGAN_DESCRIPTION_KEY: "Descrizione",
    //       Constants.ORGAN_HEART_IMAGE_PATH: 'assets/icons/heart.svg',
    //       Constants.ORGAN_NAME_KEY: 'Sistema Cardiovascolare',
    //       Constants.ORGAN_RESERVABLE_TEST_LIST_KEY: [
    //         {
    //           'description': 'descrizione',
    //           'name': 'Eco dop',
    //           'test_type': TestType.ECO_TSA.index,
    //           'video_path': 'videoPath'
    //         }
    //       ],
    //       Constants.ORGAN_STATUS_KEY: {
    //         Constants.STATUS_COLOR_KEY: '0xFFEB6D7B',
    //         Constants.STATUS_ICON_KEY: 'assets/icons/crossed_circle.svg',
    //         Constants.STATUS_MESSAGE_KEY: 'Sei in ritardo!',
    //         Constants.STATUS_TYPE_KEY: StatusType.IS_IN_LATE.index
    //       }
    //     },
    //   };
    //   _repository.updateCardiovascularOrgan(jsonCardiovascularData);
    // });

    _calcNextTestDate.stream.listen((input) {
      if (input[Constants.LAST_TEST_DATE_KEY] != null) {
        input[Constants.LAST_TEST_DATE_KEY] =
            _formatDate(input[Constants.LAST_TEST_DATE_KEY]);
      }

      print('[INPUT DATA] ' + input.toString());
      switch (input[Constants.ORGAN_KEY]) {
        case '001':
          _cloudFunctionsService.calcNextMammographyDate(input);
          break;
        case '002':
          _cloudFunctionsService.calcNextColonScreening(input);
          break;
        case '003':
          _cloudFunctionsService.calcNextUterusScreening(input);
          break;
      }
    });

    //FIXME PROVVISORIO CHIAMATO ALLA FINE DELL'INSERIMENTO DEI DATI
    //TODO SE ESCE DALLA FASE DI ONBOARDING FARE IN MODO CHE DEVE COMPIALRE I QUESTIONARI SEPARATAMENTE

    _updateFirstAccess.stream.listen((input) {
      _repository.updateFirstAccess(input);
    });
  }

  void setFirstAccess() {
    _firestoreWrite.updateFirstAccess(false);
  }

  Map<String, dynamic> _initOrganData(Gender gender) {
    Map<String, dynamic> jsonScreeningData = Map();

    //COLON
    Organ colon = Colon(
      'Colon',
      Status(
        Constants.ORGAN_STATUS_INACTIVE_NAME,
        Constants.ORGAN_STATUS_INACTIVE_COLOR,
        Constants.ORGAN_STATUS_INACTIVE_ICON,
        Constants.ORGAN_STATUS_INACTIVE_MESSAGE,
        StatusType.INACTIVE,
      ),
      'Descrizione organo',
    );
    colon.active = false;
    colon.positive = false;
    colon.reservableTestList = <ReservableTest>[
      ReservableTest.fromJson(Constants.RESTEST_SOF),
    ];
    colon.imagePath = Constants.ORGAN_COLON_IMAGE_PATH;

    Organ uterus = Uterus(
      CacheManager.getValue(CacheManager.genderKey) == Gender.FEMALE
          ? 'Cervice Uterina'
          : 'Vaccino anti HPV',
      CacheManager.getValue(CacheManager.genderKey) == Gender.FEMALE
          ? Constants.ORGAN_STATUS_INACTIVE
          : Constants.ORGAN_STATUS_GOOD,
      'Descrizione organo',
    );
    uterus.active = false;
    uterus.positive = false;
    uterus.reservableTestList =
        CacheManager.getValue(CacheManager.genderKey) == Gender.FEMALE
            ? <ReservableTest>[
                ReservableTest.fromJson(Constants.RESTEST_HPV_DNA),
                ReservableTest.fromJson(Constants.RESTEST_PAP_TEST),
              ]
            : <ReservableTest>[];
    uterus.imagePath =
        CacheManager.getValue(CacheManager.genderKey) == Gender.FEMALE
            ? Constants.ORGAN_UTERUS_IMAGE_PATH
            : 'assets/icons/needle.svg';

    //TODO SBLOCCARE PER INSERIRE IL SISTEMA CARDIOVASCOLARE
    // Organ heart = Heart(
    //     'Cuore',
    //     Status(
    //       Constants.ORGAN_STATUS_INACTIVE_NAME,
    //       Constants.ORGAN_STATUS_INACTIVE_COLOR,
    //       Constants.ORGAN_STATUS_INACTIVE_ICON,
    //       Constants.ORGAN_STATUS_INACTIVE_MESSAGE,
    //       StatusType.INACTIVE,
    //     ),
    //     'Descrizione organo',
    //     null,
    //     null,
    //     null,
    //     null,
    //     null,
    //     null,
    //     null,
    //     null,
    //     null,
    //     null);
    // heart.reservableTestList = [
    //   ReservableTest.fromJson(Constants.RESTEST_CARDIO_TEST),
    //   ReservableTest.fromJson(Constants.RESTEST_BLOOD_TEST),
    // ];
    // heart.imagePath = Constants.ORGAN_HEART_IMAGE_PATH;

    jsonScreeningData.addAll({'002': (colon as Colon).toJson()});
    jsonScreeningData.addAll({'003': (uterus as Uterus).toJson()});
    // jsonScreeningData.addAll({'004': (heart as Heart).toJson()});

    if (gender == Gender.FEMALE) {
      //MAMMELLA
      Organ breast = Breast(
        'Mammella',
        Status(
          Constants.ORGAN_STATUS_INACTIVE_NAME,
          Constants.ORGAN_STATUS_INACTIVE_COLOR,
          Constants.ORGAN_STATUS_INACTIVE_ICON,
          Constants.ORGAN_STATUS_INACTIVE_MESSAGE,
          StatusType.INACTIVE,
        ),
        'Descrizione organo',
      );
      breast.active = false;
      breast.positive = false;
      breast.reservableTestList = <ReservableTest>[
        ReservableTest.fromJson(Constants.RESTEST_MAMMOGRAPHY)
      ];
      breast.imagePath = Constants.ORGAN_BREAST_IMAGE_PATH;
      jsonScreeningData.addAll({'001': (breast as Breast).toJson()});
    }

    return jsonScreeningData;
  }

  Future<void> createAssistedUser() async {
    careGiverKey = _repository.userID;
    _repository.createAssistedUser(careGiverKey).then((key) {
      assistedUserKey = key;
      _repository.insertAssistedUserKey(assistedUserKey).then((_) {
        _repository.userID = assistedUserKey;
      });
    });
  }

  Map<String, dynamic> suggestedCityList = Map();
  Future<void> loadSuggestedCity() async {
    await rootBundle
        .loadString('assets/catasto_comuni.json')
        .then((jsonString) {
      suggestedCityList = json.decode(jsonString);
    });
  }

  // Future<void> fetchRegistry() async {
  //   await _repository.fetchRegistry().then((registry) {
  //     _registryFetcher.sink.add(registry);
  //   });
  // }

  // void createOutputRangeAgeWidget(int age) {
  //   Map<dynamic, dynamic> content;
  //   if (age < 40 || age >= 75) {
  //     content.addAll({
  //       'initial_text':
  //           'Per ora non preoccuparti , ti ricorderò io il momento giusto! Nel frattempo concentriamoci insieme su un corretto stile di vita!',
  //     });
  //   } else if (age >= 40 && age < 50) {
  //     content.addAll({
  //       'initial_text':
  //           'Secondo le linee guida ministeriali e secondo i dati che hai inserito dovresti fare una mammografia ogni',
  //       'year_text': 'anno'
  //     });
  //   } else if (age >= 50 && age < 75) {
  //     content.addAll({
  //       'initial_text':
  //           'Secondo le linee guida ministeriali e secondo i dati che hai inserito dovresti fare una mammografia ogni',
  //       'year_text': '2 anni'
  //     });
  //   }

  //   _setTextContentBreastOutput.sink.add(content);
  // }

  void updateCervix() async {
    // Test creation
    if (_cervixFirstTest != null) {
      Test t = Test(
        _cervixFirstTest.name,
        _cervixFirstTest.organKey,
        _cervixFirstTest.type,
        _cervixFirstTest.description,
      );
      if (_cervixReservation != null) {
        t.reservation = _cervixReservation;
      }
      _firestoreWrite.createTest(t.toJson());
    }

    //organ update
    _firestoreWrite.updateOrgan(
      Tuple2(
        '003',
        Tuple2<String, dynamic>(
          Constants.ORGAN_HPV_VACCINE_KEY,
          _antiHPVVaccine,
        ),
      ),
    );

    //cloud function
  }

  String _formatDate(DateTime date) {
    final DateFormat formatter = DateFormat('dd/MM/yyyy');
    final String formatted = formatter.format(date);
    return formatted;
  }

  //CALC EXAM YEAR FOR ORGANS
  void calcCervixExamYear() {
    int age = 32;
    if (age > 24 && age < 66) {
      _cervixExamYearSubject.sink.add('3 anni');
    }
  }

  void dispose() async {
    _sendRegistry.close();
    _updateCardiovascularData.close();
    _calcNextTestDate.close();
    _updateFirstAccess.close();
  }
}
