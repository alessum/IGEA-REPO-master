import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:igea_app/models/constants/constants.dart';
import 'package:igea_app/models/enums/test_type.dart';
import 'package:igea_app/models/test.dart';
import 'package:igea_app/screens/diary/modal_bottom_sheets/prevengo_modal_css.dart';
import 'package:igea_app/services/cloud_functions_service.dart';
import 'package:igea_app/services/firestore_read.dart';
import 'package:igea_app/services/firestore_write.dart';
import 'package:rxdart/rxdart.dart';
import 'package:tuple/tuple.dart';

class CalendarBlocProvider extends InheritedWidget {
  final CalendarBloc bloc;

  CalendarBlocProvider({Key key, Widget child})
      : bloc = CalendarBloc(),
        super(key: key, child: child);

  @override
  bool updateShouldNotify(InheritedWidget oldWidget) {
    return true;
  }

  static CalendarBloc of(BuildContext context) {
    return context
        .dependOnInheritedWidgetOfExactType<CalendarBlocProvider>()
        .bloc;
  }
}

class CalendarBloc {
  final _firestoreRead = FirestoreRead.instance();
  final _firestoreWrite = FirestoreWrite.instance();
  final _cloudFunctionsService = CloudFunctionsService.instance();

  final _fetchTestSubject = PublishSubject<Map<String, Test>>();
  final _deleteTestSubject = PublishSubject<Tuple2<String, Test>>();
  final _updateTestSubject = PublishSubject<Tuple2<String, Test>>();
  final _algorithmResultSubject = BehaviorSubject<Widget>();

  // send data to UI
  Stream<Map<String, Test>> get getTestList => _fetchTestSubject.stream;
  Stream<Widget> get getAlgorithmResult => _algorithmResultSubject.stream;

  // get data from UI
  Sink<Tuple2<String, Test>> get inDeleteTest => _deleteTestSubject.sink;
  Sink<Tuple2<String, Test>> get updateTest => _updateTestSubject.sink;

  CalendarBloc() {
    _firestoreRead.testListener().listen((input) {
      Map<String, Test> testList = Map.fromIterable(
        input.docs.where(
            (element) => Test.fromJson(element.data()).reservation != null),
        key: (element) => (element as DocumentSnapshot).id,
        value: (element) => Test.fromJson((element as DocumentSnapshot).data()),
      );
      _fetchTestSubject.sink.add(testList);
    });

    _deleteTestSubject.stream.listen((input) {
      String testKey = input.item1;
      Test test = input.item2;
      if (test.type != TestType.IN_DEPTH_TEST &&
          test.type != TestType.GENERIC_TEST) {
        _firestoreRead.getLastScreeningTest(test.toJson()).then((snapshot) {
          if (snapshot.docs.length > 0) {
            //esame più recente del tipo appena eliminato
            Test t = Test.fromJson(snapshot.docs[0].data());
            print('test date ${t.reservation.date}');
            _calcNextExamDateAlgorithm(Test.fromJson(snapshot.docs[0].data()))
                .then((_) => _firestoreWrite.deleteOutcome(testKey));
          } else {
            _startFromZero(test)
                .then((_) => _firestoreWrite.deleteOutcome(testKey));
          }
        });
      } else {
        _firestoreWrite.deleteOutcome(testKey);
        _algorithmResultSubject.sink.add(
          PrevengoDiaryModalCSS(
            title: 'Esito eliminato!',
            iconPath: 'assets/avatars/arold_in_circle.svg',
            message: 'Ho eliminato l\'esito dell\'esame: ${test.name}',
            suggestedBooking: 'Quest\'anno',
            colorTheme: Color(0xFFEB6D7B),
            isAlert: false,
          ),
        );
      }
    });

    _updateTestSubject.stream.listen((input) {
      _firestoreWrite.updateTest(
        Tuple2<String, Map<String, dynamic>>(
          input.item1,
          input.item2.toJson(),
        ),
      );
    });
  }

  Future<void> _startFromZero(Test test) async {
    _algorithmResultSubject.sink.add(
      PrevengoDiaryModalCSS(
        title: 'Esito eliminato!',
        iconPath: 'assets/avatars/arold_in_circle.svg',
        message:
            'Non ci sono altri esiti salvati. Partiamo da zero! Ti consiglio di prenotare il prossimo esame.',
        suggestedBooking: 'Quest\'anno',
        colorTheme: Color(0xFFEB6D7B),
        isAlert: false,
      ),
    );
    _firestoreWrite.updateOrganStatus(Tuple2<String, Map<String, dynamic>>(
      test.organKey,
      Constants.ORGAN_STATUS_LATETORESERVE.toJson(),
    ));
    _firestoreWrite.updateOrgan(Tuple2<String, Tuple2<String, dynamic>>(
      test.organKey,
      Tuple2<String, dynamic>(
        'next_test_date',
        DateTime.now(),
      ),
    ));
  }

  Future<void> _calcNextExamDateAlgorithm(Test test) async {
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
              'Ho eliminato il tuo esito e ricalcolato la data per l\'esame successivo. Ti ricorederò io quando dovrai prenotarlo tra',
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
              'Ho eliminato il tuo esito e ricalcolato la data per l\'esame successivo. Ti consiglio di prenotarlo',
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
              'Ho eliminato il tuo esito e ricalcolato la data per l\'esame successivo. Ti consiglio di prenotarlo',
          suggestedBooking: 'Quest\'anno',
          colorTheme: Color(0xFFFAC297),
          isAlert: false,
        ),
      );
    }
  }

  dispose() {
    _fetchTestSubject.close();
    _deleteTestSubject.close();
    _updateTestSubject.close();
    _algorithmResultSubject.close();
  }
}
