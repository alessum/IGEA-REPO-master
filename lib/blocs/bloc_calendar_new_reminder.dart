import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:igea_app/models/constants/constants.dart';
import 'package:igea_app/models/constants/constants_graphics.dart';
import 'package:igea_app/models/enums/test_type.dart';
import 'package:igea_app/models/reservable_test.dart';
import 'package:igea_app/models/reservation.dart';
import 'package:igea_app/models/test.dart';
import 'package:igea_app/services/firestore_read.dart';
import 'package:igea_app/services/firestore_write.dart';
import 'package:igea_app/widgets/modal_bottom_sheets/prevengo_modal_confirmation.dart';
import 'package:rxdart/rxdart.dart';
import 'package:tuple/tuple.dart';

class CalendarNewReminderBlocProvider extends InheritedWidget {
  final CalendarNewReminderBloc bloc;

  CalendarNewReminderBlocProvider({Key key, Widget child})
      : bloc = CalendarNewReminderBloc(),
        super(key: key, child: child);

  @override
  bool updateShouldNotify(InheritedWidget oldWidget) {
    return true;
  }

  static CalendarNewReminderBloc of(BuildContext context) {
    return context
        .dependOnInheritedWidgetOfExactType<CalendarNewReminderBlocProvider>()
        .bloc;
  }
}

class CalendarNewReminderBloc {
  final _firestoreWrite = FirestoreWrite.instance();
  final _firestoreRead = FirestoreRead.instance();

  // Streams
  final _fetchTestNoReservationSubject = BehaviorSubject<Map<String, Test>>();
  final _newReminderResultSubject = BehaviorSubject<Widget>();
  final _sendReservationSubject = PublishSubject<dynamic>();
  final _reservableTestSubject = PublishSubject<ReservableTest>();
  final _timeSubject = PublishSubject<TimeOfDay>();
  final _dateSubject = PublishSubject<DateTime>();
  final _placeSubject = PublishSubject<String>();
  final _notesSubject = PublishSubject<String>();

  // Send data to UI
  Stream<ReservableTest> get getReservableTest => _reservableTestSubject.stream;
  Stream<Widget> get getNewReminderResult => _newReminderResultSubject.stream;
  Stream<TimeOfDay> get getTime => _timeSubject.stream;
  Stream<DateTime> get getDate => _dateSubject.stream;
  Stream<String> get getPlace => _placeSubject.stream;
  Stream<String> get getNotes => _notesSubject.stream;
  Stream<Map<String, Test>> get getTestList =>
      _fetchTestNoReservationSubject.stream;

  // Get Data from UI
  Function(dynamic) get inNewReservation => _sendReservationSubject.sink.add;
  Sink<ReservableTest> get setReservableTest => _reservableTestSubject.sink;
  Sink<TimeOfDay> get setTime => _timeSubject.sink;
  Sink<DateTime> get setDate => _dateSubject.sink;
  Sink<String> get setPlace => _placeSubject.sink;
  Sink<String> get setNotes => _notesSubject.sink;

  // Runtime variables
  ReservableTest _reservableTest;
  TimeOfDay _time;
  DateTime _date;
  String _place;
  String _notes;

  CalendarNewReminderBloc() {
    _firestoreRead.testNoReservationListner().listen((input) {
      Map<String, Test> testList = Map.fromIterable(
        input.docs,
        key: (element) => (element as DocumentSnapshot).id,
        value: (element) => Test.fromJson((element as DocumentSnapshot).data()),
      );
      _fetchTestNoReservationSubject.sink.add(testList);
    });

    _reservableTestSubject.stream.listen((event) => _reservableTest = event);
    _timeSubject.stream.listen((event) => _time = event);
    _dateSubject.stream.listen((event) => _date = event);
    _placeSubject.stream.listen((event) => _place = event);
    _notesSubject.stream.listen((event) => _notes = event);

    _sendReservationSubject.stream.listen((input) {
      if (input is Tuple2) {
        // update test, insert reservation
        _firestoreWrite.updateTest(
          Tuple2(
            input.item1,
            (input.item2 as Test).toJson(),
          ),
        );

        // update organ status to reserved
        _firestoreWrite.updateOrgan(
          Tuple2(
            input.item1,
            Tuple2(
              Constants.ORGAN_STATUS_KEY,
              Constants.ORGAN_STATUS_RESERVED.toJson(),
            ),
          ),
        );
      } else if (input is Tuple4) {
        ReservableTest rst = input.item1;
        Test t = Test(
          rst.name,
          rst.organKey,
          rst.type,
          rst.description,
        );
        t.reservation = Reservation(
          input.item2, //date
          input.item3, //place label
          null, //geolocation null
          input.item4, //notes
        );

        // create test with reservation
        _firestoreWrite.createTest(t.toJson());

        if (rst.type != TestType.GENERIC_TEST) {
          // update organ status to reserved
          _firestoreWrite.updateOrgan(
            Tuple2(
              rst.organKey,
              Tuple2(
                Constants.ORGAN_STATUS_KEY,
                Constants.ORGAN_STATUS_RESERVED.toJson(),
              ),
            ),
          );
        }
      }
    });

    _newReminderResultSubject.sink.add(
      PrevengoModalConfirmation(
        title: 'Promemoria creato!',
        iconPath: 'assets/avatars/arold_in_circle.svg',
        message: 'Ho creato un promemoria per l\'esame: ',
        colorTheme: ConstantsGraphics.COLOR_CALENDAR_CYAN,
        popScreensNumber: 2,
      ),
    );
  }

  bool isInputDataValid() {
    print('reservable test: $_reservableTest');
    print('time $_time');
    print('date $_date');
    return _reservableTest != null && _time != null && _date != null;
  }

  void createNewReminder() {
    Test t = Test(
      _reservableTest.name,
      _reservableTest.organKey,
      _reservableTest.type,
      _reservableTest.description,
    );
    t.reservation = Reservation(
      DateTime(
        _date.year,
        _date.month,
        _date.day,
        _time.hour,
        _time.minute,
      ),
      _notes ?? '',
      null,
      _place ?? '',
    );
    _firestoreWrite.createTest(t.toJson());
    if (_reservableTest.type != TestType.GENERIC_TEST &&
        _reservableTest.type != TestType.IN_DEPTH_TEST) {
      _firestoreWrite.updateOrganStatus(Tuple2<String, Map<String, dynamic>>(
        _reservableTest.organKey,
        Constants.ORGAN_STATUS_RESERVED.toJson(),
      ));
    }
  }

  dispose() {
    _fetchTestNoReservationSubject.close();
    _sendReservationSubject.close();
    _placeSubject.close();
    _reservableTestSubject.close();
    _timeSubject.close();
    _dateSubject.close();
    _notesSubject.close();
    _newReminderResultSubject.close();
  }
}
