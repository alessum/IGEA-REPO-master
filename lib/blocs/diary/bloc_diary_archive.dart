import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:igea_app/models/constants/constants.dart';
import 'package:igea_app/models/enums/test_type.dart';
import 'package:igea_app/models/reservable_test.dart';
import 'package:igea_app/models/test.dart';
import 'package:igea_app/services/cloud_functions_service.dart';
import 'package:igea_app/services/firestore_read.dart';
import 'package:igea_app/services/firestore_write.dart';
import 'package:rxdart/rxdart.dart';
import 'package:tuple/tuple.dart';

class DiaryArchiveBlocProvider extends InheritedWidget {
  final DiaryArchiveBloc bloc;

  DiaryArchiveBlocProvider({Key key, Widget child})
      : bloc = DiaryArchiveBloc(),
        super(key: key, child: child);

  @override
  bool updateShouldNotify(InheritedWidget oldWidget) {
    return true;
  }

  static DiaryArchiveBloc of(BuildContext context) {
    return context
        .dependOnInheritedWidgetOfExactType<DiaryArchiveBlocProvider>()
        .bloc;
  }
}

class DiaryArchiveBloc {
  FirestoreRead _firestoreRead = FirestoreRead.instance();
  FirestoreWrite _firestoreWrite = FirestoreWrite.instance();
  CloudFunctionsService _cloudFunctionsService =
      CloudFunctionsService.instance();

  final _testsFetcher = PublishSubject<Map<String, Test>>(); // lista di test

  final _testTypeFilterSubject = PublishSubject<ReservableTest>();
  final _testStartDateFilterSubject = PublishSubject<int>();
  final _testEndDateFilterSubject = PublishSubject<int>();

  final _calcNextTestDate = PublishSubject<Map<String, dynamic>>();
  final _sendOutcomeSubject = PublishSubject<Tuple2<String, Test>>();
  final _deleteOutcomeSubject = PublishSubject<String>();

  Map<String, Test> testList;
  TestType testType;
  DateTime startDate, endDate;

  // send data to UI
  Stream<Map<String, Test>> get allTests => _testsFetcher.stream;
  Stream<ReservableTest> get getFilterTestType => _testTypeFilterSubject.stream;
  Stream<int> get getFilterStartDate => _testStartDateFilterSubject.stream;
  Stream<int> get getFilterEndDate => _testEndDateFilterSubject.stream;

  // get data from UI
  Sink<Tuple2<String, Test>> get inNewOutcome => _sendOutcomeSubject.sink;
  Sink<String> get inDeleteOutcome => _deleteOutcomeSubject.sink;
  Sink<Map<String, dynamic>> get inCalcNextDateData => _calcNextTestDate.sink;

  DiaryArchiveBloc() {
    _deleteOutcomeSubject.stream.listen((input) {
      _firestoreWrite.deleteOutcome(input);
    });

    _firestoreRead.testListener().listen((input) {
      testList = Map.fromIterable(
        input.docs
            .where((element) => Test.fromJson(element.data()).outcome != null),
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
  }

  void updateTestTypeFilter(ReservableTest input) {
    testType = input.type;
    _testTypeFilterSubject.sink.add(input);
  }

  void updateTestStartDateFilter(DateTime input) {
    startDate = input;
    _testStartDateFilterSubject.sink.add(input.year);
  }

  void updateTestEndDateFilter(DateTime input) {
    endDate = input;
    _testEndDateFilterSubject.sink.add(input.year);
  }

  void resetFilter() {
    testType = null;
    startDate = null;
    endDate = null;
    _testTypeFilterSubject.sink.add(null);
    _testStartDateFilterSubject.sink.add(null);
    _testEndDateFilterSubject.sink.add(null);
    _testsFetcher.sink.add(testList);
  }

  void filterTest() {
    Map<String, Test> filteredTestList = Map();
    testList.forEach((key, value) {
      if (testType == null) {
        if (startDate == null) {
          if (endDate == null) {
            filteredTestList.addAll({key: value});
          } else if (value.reservation.date.isBefore(endDate)) {
            filteredTestList.addAll({key: value});
          }
        } else if (value.reservation.date.isAfter(startDate)) {
          if (endDate == null) {
            filteredTestList.addAll({key: value});
          } else if (value.reservation.date.isBefore(endDate)) {
            filteredTestList.addAll({key: value});
          }
        }
      } else if (value.type == testType) {
        if (startDate == null) {
          if (endDate == null) {
            filteredTestList.addAll({key: value});
          } else if (value.reservation.date.isBefore(endDate)) {
            filteredTestList.addAll({key: value});
          }
        } else if (value.reservation.date.isAfter(startDate)) {
          if (endDate == null) {
            filteredTestList.addAll({key: value});
          } else if (value.reservation.date.isBefore(endDate)) {
            filteredTestList.addAll({key: value});
          }
        }
      }
    });
    _testsFetcher.sink.add(filteredTestList);
  }

  dispose() {
    _testsFetcher.close();
    _sendOutcomeSubject.close();
    _deleteOutcomeSubject.close();
    _calcNextTestDate.close();
    _testTypeFilterSubject.close();
    _testStartDateFilterSubject.close();
    _testEndDateFilterSubject.close();
  }
}
