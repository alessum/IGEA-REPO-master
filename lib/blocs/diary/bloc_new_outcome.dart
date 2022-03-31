import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:igea_app/models/camera_file_manager.dart';
import 'package:igea_app/models/constants/constants.dart';
import 'package:igea_app/models/constants/constants_graphics.dart';
import 'package:igea_app/models/enums/screening_outcome_value.dart';
import 'package:igea_app/models/outcome.dart';
import 'package:igea_app/models/outcome_screening.dart';
import 'package:igea_app/models/reservable_test.dart';
import 'package:igea_app/models/reservation.dart';
import 'package:igea_app/models/test.dart';
import 'package:igea_app/screens/diary/modal_bottom_sheets/prevengo_modal_css.dart';
import 'package:igea_app/services/cloud_functions_service.dart';
import 'package:igea_app/services/cloud_storage_service.dart';
import 'package:igea_app/services/firestore_read.dart';
import 'package:igea_app/services/firestore_write.dart';
import 'package:rxdart/rxdart.dart';
import 'package:tuple/tuple.dart';

import '../../models/enums/test_type.dart';

class NewOutcomeBlocProvider extends InheritedWidget {
  final NewOutcomeBloc bloc;

  NewOutcomeBlocProvider({Key key, Widget child})
      : bloc = NewOutcomeBloc(),
        super(key: key, child: child);

  @override
  bool updateShouldNotify(InheritedWidget oldWidget) {
    return true;
  }

  static NewOutcomeBloc of(BuildContext context) {
    return context
        .dependOnInheritedWidgetOfExactType<NewOutcomeBlocProvider>()
        .bloc;
  }
}

class NewOutcomeBloc {
  final _firestoreRead = FirestoreRead.instance();
  final _firestoreWrite = FirestoreWrite.instance();
  final _cloudFunctionsService = CloudFunctionsService.instance();
  final _cloudStorageService = CloudStorageService.instance();

  ReservableTest _oldReservableTest;
  ReservableTest _newReservableTest;
  Reservation _oldReservation;
  Reservation _newReservation;
  File _outcomeFile;
  bool _isStandardScreeningProtocol = false;

  String _genericTestName;
  String _genericDescription;
  DateTime _genericDate;

  //Data Access Layer I/O streams
  final _testsFetcher = PublishSubject<Map<String, Test>>();
  final _calcNextTestDate = PublishSubject<Map<String, dynamic>>();
  final _sendOutcomeSubject = PublishSubject<Tuple2<String, Test>>();
  final _newTestWithOutcomeSubject =
      PublishSubject<Tuple3<ReservableTest, ScreeningOutcomeValue, DateTime>>();

  //Presentation layer I/O streams
  final _showImageSubject = PublishSubject<File>();
  final _checkScreeningProtocolSubject = PublishSubject<bool>();
  final _oldReservableTestSubject = PublishSubject<ReservableTest>();
  final _newReservableTestSubject = PublishSubject<ReservableTest>();
  final _oldReservationSubject = PublishSubject<Reservation>();
  final _newReservationSubject = PublishSubject<Reservation>();
  final _algorithmResultSubject = BehaviorSubject<Widget>();

  final _genericTestNameSubject = PublishSubject<String>();
  final _genericDescriptionSubject = PublishSubject<String>();
  final _genericDateSubject = PublishSubject<DateTime>();

  // send data to UI
  Stream<Map<String, Test>> get allTests => _testsFetcher.stream;
  Stream<File> get imageFile => _showImageSubject.stream;
  Stream<Reservation> get getOldReservation => _oldReservationSubject.stream;
  Stream<Reservation> get getNewReservation => _newReservationSubject.stream;
  Stream<bool> get getCheckScreeningProtocol =>
      _checkScreeningProtocolSubject.stream;
  Stream<ReservableTest> get getOldReservableTest =>
      _oldReservableTestSubject.stream;
  Stream<ReservableTest> get getNewReservableTest =>
      _newReservableTestSubject.stream;
  Stream<Widget> get getAlgorithmResult => _algorithmResultSubject.stream;
  Stream<DateTime> get getGenericDate => _genericDateSubject.stream;

  // get data from UI
  Sink<Tuple2<String, Test>> get inNewOutcome => _sendOutcomeSubject.sink;
  Sink<Map<String, dynamic>> get inCalcNextDateData => _calcNextTestDate.sink;
  Sink<Tuple3<ReservableTest, ScreeningOutcomeValue, DateTime>>
      get inNewTestWithOutcome => _newTestWithOutcomeSubject.sink;
  Sink<Reservation> get updateOldReservation => _oldReservationSubject.sink;
  Sink<Reservation> get updateNewReservation => _newReservationSubject.sink;
  Sink<bool> get updateCheckScreeningProtocol =>
      _checkScreeningProtocolSubject.sink;
  Sink<ReservableTest> get updateOldReservableTest =>
      _oldReservableTestSubject.sink;
  Sink<ReservableTest> get updateNewReservableTest =>
      _newReservableTestSubject.sink;

  Sink<String> get setGenericTestName => _genericTestNameSubject.sink;
  Sink<String> get setGenericDescription => _genericDescriptionSubject.sink;
  Sink<DateTime> get setGenericDate => _genericDateSubject.sink;

  NewOutcomeBloc() {
    _firestoreRead.testNoOutcomeListener().listen((input) {
      print('TestNoOutcomeListener');
      Map<String, Test> testList = Map.fromIterable(
        input.docs,
        key: (element) => (element as DocumentSnapshot).id,
        value: (element) => Test.fromJson((element as DocumentSnapshot).data()),
      );
      _testsFetcher.sink.add(testList);
    });

    _sendOutcomeSubject.stream.listen((input) {
      _firestoreWrite.updateTest(
        Tuple2<String, Map<String, dynamic>>(
          input.item1,
          input.item2.toJson(),
        ),
      );
    });

    _calcNextTestDate.stream.listen((input) {
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

    CameraFileManager.getFileImage.listen((event) {
      _outcomeFile = event;
      _showImageSubject.sink.add(event);
    });

    _oldReservableTestSubject.stream.listen((input) {
      _oldReservableTest = input;
      _newReservableTestSubject.sink.add(null);
    });

    _newReservableTestSubject.stream.listen((input) {
      _newReservableTest = input;
    });

    _checkScreeningProtocolSubject.stream.listen((input) {
      ReservableTest t = Constants.allReservableTestList.firstWhere(
        (element) => (element.organKey == _oldReservableTest.organKey &&
            element.type != TestType.IN_DEPTH_TEST),
      );
      _newReservableTestSubject.sink.add(input ? t : null);
      if (input) {
        _newReservationSubject.sink.add(null);
      }
      _isStandardScreeningProtocol = input;
    });

    _oldReservationSubject.stream.listen((event) => _oldReservation = event);
    _newReservationSubject.stream.listen((event) => _newReservation = event);
    _genericTestNameSubject.stream.listen((event) => _genericTestName = event);
    _genericDescriptionSubject.stream
        .listen((event) => _genericDescription = event);
    _genericDateSubject.stream.listen((event) => _genericDate = event);
  }

  void createNewGenericOutcome() {
    Test test = Test(
      _genericTestName,
      '000',
      TestType.GENERIC_TEST,
      'Test generico',
    );
    test.reservation = Reservation(
      _genericDate,
      'Nessuna nota',
      null,
      'Non specificato',
    );
    test.outcome = OutcomeScreening(_genericDescription);
    _firestoreWrite.createTest(test.toJson());

    _algorithmResultSubject.sink.add(PrevengoDiaryModalCSS(
      title: 'Esito inserito!',
      iconPath: 'assets/avatars/arold_in_circle.svg',
      message:
          'Ho aggiornato la tua lista degli esiti con quello appena inserito',
      suggestedBooking: '',
      colorTheme: ConstantsGraphics.COLOR_DIARY_BLUE,
      isAlert: false,
    ));
  }

  void insertNewScreeningOutcome() async {
    Test oldTest;
    if (_oldReservation != null) {
      oldTest = Test(
        _oldReservableTest.name,
        _oldReservableTest.organKey,
        _oldReservableTest.type,
        _oldReservableTest.description,
      );

      oldTest.createReservation(_oldReservation.toJson());
      String testKey = await _firestoreWrite.createTest(oldTest.toJson());
      String filePath;
      if (_outcomeFile != null) {
        filePath = await _cloudStorageService.uploadFile(
          imageToUpload: _outcomeFile,
          testKey: testKey,
        );
      }
      OutcomeScreening outcomeScreening = OutcomeScreening('Descrizione');
      outcomeScreening.outcomeFilePath = filePath;
      oldTest.outcome = outcomeScreening;
      _firestoreWrite.updateTest(Tuple2<String, Map<String, dynamic>>(
        testKey,
        oldTest.toJson(),
      ));

      //next exam date
      if (_newReservableTest == null) {
        _algorithmResultSubject.sink.add(PrevengoDiaryModalCSS(
          title: 'C\'è un problema!',
          iconPath: 'assets/avatars/arold_in_circle.svg',
          message:
              'Inserisci il prossimo esame che dovrai fare, oppure seleziona \'Protocollo di screening standard\' per il calcolo automatico della data del prossimo esame di screening',
          suggestedBooking: '',
          colorTheme: ConstantsGraphics.COLOR_DIARY_BLUE,
          isAlert: true,
        ));
      } else if (_isStandardScreeningProtocol) {
        _calcNextExamDateAlgorithm(oldTest);
      } else {
        //data inserita manualmente
        if (_newReservation != null) {
          DateTime now = DateTime.now();
          int yearDiff = _newReservation.date.year - now.year;
          Test newTest = Test(
            _newReservableTest.name,
            _newReservableTest.organKey,
            _newReservableTest.type,
            _newReservableTest.description,
          );
          newTest.createReservation(_newReservation.toJson());
          _firestoreWrite.createTest(newTest.toJson());

          //IN CASO DI ESAMI DI APPROFONDIMENTO
          if (_newReservableTest.type == TestType.IN_DEPTH_TEST) {
            //update organ
            _firestoreWrite.updateOrganStatus(
                Tuple2<String, Map<String, dynamic>>(
                    _newReservableTest.organKey,
                    Constants.ORGAN_STATUS_DEEPENING.toJson()));

            //return widget modal
            _algorithmResultSubject.sink.add(
              PrevengoDiaryModalCSS(
                title: 'Bene!',
                iconPath: 'assets/avatars/arold_in_circle.svg',
                message:
                    'E\' necessario approfondire con ulteriori visite, non preoccuparti! Ci risentiamo tra ',
                suggestedBooking: yearDiff == 0
                    ? '${_newReservation.date.month - now.month} mesi'
                    : yearDiff == 1
                        ? '${_newReservation.date.year - now.year} anno'
                        : '${_newReservation.date.year - now.year} anni',
                colorTheme: ConstantsGraphics.COLOR_DIARY_BLUE,
                isAlert: false,
              ),
            );
          } else {
            _firestoreWrite.updateOrganStatus(
                Tuple2<String, Map<String, dynamic>>(
                    _newReservableTest.organKey,
                    Constants.ORGAN_STATUS_RESERVED.toJson()));
            _algorithmResultSubject.sink.add(PrevengoDiaryModalCSS(
              title: 'Ben fatto!',
              iconPath: 'assets/avatars/arold_in_circle.svg',
              message:
                  'Ho inserito il tuo esito. Ho creato un promemoria in calendario per il prossimo esame',
              suggestedBooking: '',
              colorTheme: Color(0xFF9CD7F2),
              isAlert: false,
            ));
          }
        } else {
          //NESSUNA DATA PER IL PROSSIMO ESAME
          if (_newReservableTest.type == TestType.IN_DEPTH_TEST) {
            //update organ
            _firestoreWrite.updateOrganStatus(
                Tuple2<String, Map<String, dynamic>>(
                    _newReservableTest.organKey,
                    Constants.ORGAN_STATUS_DEEPENING.toJson()));
            _algorithmResultSubject.sink.add(
              PrevengoDiaryModalCSS(
                title: 'Bene!',
                iconPath: 'assets/avatars/arold_in_circle.svg',
                message:
                    'E\' necessario approfondire con ulteriori visite, non preoccuparti! Ci risentiamo tra ',
                suggestedBooking: '',
                colorTheme: ConstantsGraphics.COLOR_DIARY_BLUE,
                isAlert: false,
              ),
            );
          } else {
            _calcNextExamDateAlgorithm(oldTest);
          }
        }
      }
    } else {
      //ALERT NON è STATA INSERITA LA DATA DELL'ESAME SOSTENUTO
      _algorithmResultSubject.sink.add(PrevengoDiaryModalCSS(
        title: 'C\'è un problema!',
        iconPath: 'assets/avatars/arold_in_circle.svg',
        message:
            'Per inserire l\'esito è necessaria la data dell\'esame sostenuto',
        suggestedBooking: '',
        colorTheme: ConstantsGraphics.COLOR_DIARY_BLUE,
        isAlert: true,
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

  dispose() {
    _testsFetcher.close();
    _sendOutcomeSubject.close();
    _calcNextTestDate.close();
    _showImageSubject.close();
  }
}
