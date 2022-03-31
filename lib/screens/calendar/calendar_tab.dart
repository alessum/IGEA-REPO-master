import 'dart:collection';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:igea_app/blocs/bloc_calendar.dart';
import 'package:igea_app/models/constants/constants.dart';
import 'package:igea_app/models/test.dart';
import 'package:igea_app/widgets/customExpansionTileCalendar.dart';
import 'package:igea_app/widgets/ui_components/close_line_top_modal.dart';
import 'package:intl/intl.dart';
import 'package:tuple/tuple.dart';

class CalendarTab extends StatefulWidget {
  CalendarTab({
    Key key,
    @required this.reservedTestList,
    @required this.deleteTest,
    @required this.updateTest,
  }) : super(key: key);

  final Map<String, Test> reservedTestList;
  final Function(String key) deleteTest;
  final Function(String testKey, Test test, Map<String, dynamic> values)
      updateTest;

  @override
  _CalendarTabState createState() => _CalendarTabState();
}

class _CalendarTabState extends State<CalendarTab> {
  int _calendarYearShown = DateTime.now().year;

  List<MonthsAndReservations> monthsAndReservations = [
    new MonthsAndReservations('Gennaio'),
    new MonthsAndReservations('Febbraio'),
    new MonthsAndReservations('Marzo'),
    new MonthsAndReservations('Aprile'),
    new MonthsAndReservations('Maggio'),
    new MonthsAndReservations('Giugno'),
    new MonthsAndReservations('Luglio'),
    new MonthsAndReservations('Agosto'),
    new MonthsAndReservations('Settembre'),
    new MonthsAndReservations('Ottobre'),
    new MonthsAndReservations('Novembre'),
    new MonthsAndReservations('Dicembre'),
  ];

  void sortReservations(Map<String, Test> allTests) {
    var sortedKeys = allTests.keys.toList(growable: false)
      ..sort((k1, k2) => allTests[k1]
          .reservation
          .date
          .year
          .compareTo(allTests[k2].reservation.date.year));
    LinkedHashMap<String, Test> sortedMap = new LinkedHashMap.fromIterable(
        sortedKeys,
        key: (k) => k,
        value: (k) => allTests[k]);

    _fillMonthsAndReservations(sortedMap);
  }

  void _fillMonthsAndReservations(LinkedHashMap<String, Test> testList) {
    monthsAndReservations.forEach((month) {
      month.tests.clear();
    });
    for (int j = 0; j < monthsAndReservations.length; j++) {
      testList.forEach((k, v) {
        if ((v.reservation != null) &&
            (v.reservation.date.year == _calendarYearShown) &
                (v.reservation.date.month == j + 1)) {
          monthsAndReservations[j].tests.putIfAbsent(k, () => v);
        }
      });
    }
  }

  _showModalBottomReservationList(
      BuildContext context, Map<String, Test> testList) {
    Size media = MediaQuery.of(context).size;
    showModalBottomSheet(
      context: context,
      builder: (context) => CalendarBlocProvider(
        child: Container(
          height: media.height * 0.6,
          margin: EdgeInsets.all(8),
          padding: EdgeInsets.all(10),
          decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.all(Radius.circular(25))),
          child: Column(
            children: [
              CloseLineTopModal(),
              Container(
                height: media.height * 0.5,
                margin: EdgeInsets.symmetric(horizontal: 5, vertical: 10),
                child: ListView.separated(
                  separatorBuilder: (BuildContext context, int index) {
                    return SizedBox(
                      height: 10,
                    );
                  },
                  itemCount: testList.length,
                  itemBuilder: (ctx, index) {
                    String key = testList.keys.elementAt(index);
                    return CustomExpansionTileCalendar(
                      testData: Tuple2<String, Test>(
                        key,
                        testList[key],
                      ),
                      onModify: () => Navigator.pop(context),
                    );
                  },
                ),
              )
            ],
          ),
        ),
      ),
      backgroundColor: Colors.black.withOpacity(0),
      isScrollControlled: true,
    );
  }

  @override
  Widget build(BuildContext context) {
    Size media = MediaQuery.of(context).size;
    sortReservations(widget.reservedTestList);
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        Container(
          height: media.height * 0.055,
          width: media.width * 0.8,
          margin: EdgeInsets.symmetric(horizontal: media.width * 0.03),
          child: Card(
            elevation: .0,
            color: Color(0xff7ccddb),
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(25.0)),
            child: Padding(
              padding: const EdgeInsets.only(left: 3.0, right: 3.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  GestureDetector(
                      onTap: () {
                        setState(() {
                          _calendarYearShown = _calendarYearShown - 1;
                          _fillMonthsAndReservations(widget.reservedTestList);
                        });
                      },
                      child: Padding(
                        padding: const EdgeInsets.only(left: 3.0, right: 3.0),
                        child: CircleAvatar(
                          backgroundColor: Colors.white,
                          radius: media.width * .035,
                          child: Transform.rotate(
                            angle: pi / 2,
                            child: Icon(Icons.expand_more,
                                color: Color(0xff7ccddb),
                                size: media.width * .075),
                          ),
                        ),
                      )),
                  Text(
                    '$_calendarYearShown',
                    style: TextStyle(
                      fontSize: media.width * 0.05,
                      fontFamily: 'Gotham',
                      color: Colors.white,
                    ),
                  ),
                  GestureDetector(
                      onTap: () {
                        setState(() {
                          _calendarYearShown = _calendarYearShown + 1;
                          _fillMonthsAndReservations(widget.reservedTestList);
                        });
                      },
                      child: Padding(
                        padding: const EdgeInsets.only(left: 3.0, right: 3.0),
                        child: CircleAvatar(
                          backgroundColor: Colors.white,
                          radius: media.width * .035,
                          child: Transform.rotate(
                            angle: -pi / 2,
                            child: Icon(Icons.expand_more,
                                color: Color(0xff7ccddb),
                                size: media.width * .075),
                          ),
                        ),
                      )),
                ],
              ),
            ),
          ),
        ),
        Expanded(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: GridView.builder(
              gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
                  maxCrossAxisExtent: media.width * 0.4,
                  childAspectRatio: 4 / 3,
                  crossAxisSpacing: media.width * 0.03,
                  mainAxisSpacing: media.height * 0.03),
              itemCount: monthsAndReservations.length,
              itemBuilder: (context, index) {
                return Container(
                  height: media.height * 0.1,
                  width: media.width * 0.25,
                  padding: EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(25)),
                    color: Colors.white,
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Text(
                        monthsAndReservations[index].name.substring(0, 3),
                        style: TextStyle(
                          fontFamily: 'Bold',
                          fontSize: media.width * 0.05,
                        ),
                      ),
                      monthsAndReservations[index].tests.length > 0
                          ? GestureDetector(
                              onTap: () {
                                _showModalBottomReservationList(context,
                                    monthsAndReservations[index].tests);
                              },
                              child: Container(
                                padding: EdgeInsets.all(5),
                                decoration: BoxDecoration(
                                    color: Color(0xff7ccddb),
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(25))),
                                child: Center(
                                  child: Text(
                                    (() {
                                      String text =
                                          '${monthsAndReservations[index].tests.length} ';
                                      text += monthsAndReservations[index]
                                                  .tests
                                                  .length >
                                              1
                                          ? 'Esami'
                                          : 'Esame';
                                      return text;
                                    }()),
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontFamily: 'Bold',
                                      fontSize: media.width * 0.04,
                                    ),
                                  ),
                                ),
                              ),
                            )
                          : Container()
                    ],
                  ),
                );
              },
            ),
          ),
        ),
      ],
    );
  }
}

class MonthsAndReservations {
  MonthsAndReservations(this._name) {
    this._tests = Map();
  }

  String _name;
  Map<String, Test> _tests;

  // Getter
  String get name => _name;
  Map<String, Test> get tests => _tests;
}
