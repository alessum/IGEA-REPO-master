import 'package:flutter/material.dart';
import 'package:igea_app/blocs/bloc_calendar.dart';
import 'package:igea_app/blocs/bloc_calendar_new_reminder.dart';
import 'package:igea_app/models/constants/constants.dart';
import 'package:igea_app/models/constants/constants_graphics.dart';
import 'package:igea_app/models/test.dart';
import 'package:igea_app/screens/calendar/calendar_add_exam_screen.dart';
import 'package:igea_app/screens/calendar/calendar_tab.dart';
import 'package:igea_app/screens/calendar/event_list_tab.dart';
import 'package:igea_app/widgets/modal_bottom_sheets/confirmation_alert.dart';
import 'package:igea_app/widgets/modal_bottom_sheets/prevengo_modal_confirmation.dart';
import 'package:intl/intl.dart';
import 'package:tuple/tuple.dart';

class CalendarContent extends StatefulWidget {
  @override
  _CalendarContentState createState() => _CalendarContentState();
}

class _CalendarContentState extends State<CalendarContent>
    with TickerProviderStateMixin {
  List<Tab> _tabList = List();
  TabController _tabController;
  Color list_color =
      Colors.black; //TODO: quando sistemato il cambio colori mettere bianco qui
  Color calendar_color = Colors.black;
  CalendarBloc bloc;

  Map<String, Test> filterNonReservedTests(Map<String, Test> allTests) {
    Map<String, Test> filteredTests = Map<String, Test>();
    allTests.forEach((k, v) {
      if (v.reservation == null) {
        filteredTests.putIfAbsent(k, () => v);
      }
    });
    return filteredTests;
  }

  Map<String, Test> filterReservedTests(Map<String, Test> allTests) {
    Map<String, Test> filteredTests = Map<String, Test>();
    allTests.forEach((k, v) {
      if (v.reservation != null) {
        filteredTests.putIfAbsent(k, () => v);
      }
    });
    return filteredTests;
  }

  @override
  void initState() {
    super.initState();
    //Size media = MediaQuery.of(context).size;

    _tabList.add(Tab(
      child: Text(
        'Elenco',
        style: TextStyle(
          color: list_color,
          // color: Colors.black,
          //fontSize: media.width * 0.3,
          fontFamily: 'Bold',
        ),
      ),
    ));
    _tabList.add(Tab(
      child: Text(
        'Calendario',
        style: TextStyle(
          color: calendar_color,
          // color: Colors.black,
          //fontSize: media.width * 0.3,
          fontFamily: 'Bold',
        ),
      ),
    ));
    _tabController = TabController(vsync: this, length: _tabList.length);
  }

  @override
  Widget build(BuildContext context) {
    Size media = MediaQuery.of(context).size;
    bloc = CalendarBlocProvider.of(context);

    return StreamBuilder(
      stream: bloc.getTestList,
      builder: (context, AsyncSnapshot<Map<String, Test>> snapshot) {
        if (snapshot.hasData) {
          return Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            mainAxisSize: MainAxisSize.max,
            children: <Widget>[
              Container(
                padding: EdgeInsets.symmetric(horizontal: 20),
                margin: EdgeInsets.only(top: media.height * 0.01),
                child: TabBar(
                  controller: _tabController,
                  tabs: _tabList,
                  indicatorSize: TabBarIndicatorSize.tab,
                  indicator: BoxDecoration(
                    color: Color(0xff7ccddb),
                    borderRadius: BorderRadius.all(
                      Radius.circular(100),
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: media.height * 0.01,
              ),
              Expanded(
                child: Container(
                  margin: EdgeInsets.symmetric(horizontal: media.width * 0.05),
                  padding: EdgeInsets.symmetric(vertical: 10),
                  // height: media.height * 0.68,
                  decoration: BoxDecoration(
                      color: Color(0xFFEDEDED),
                      borderRadius:
                          new BorderRadius.all(const Radius.circular(25.0))),
                  child: TabBarView(
                    controller: _tabController,
                    children: <Widget>[
                      EventListTab(
                        reservedTestList: snapshot.data,
                        deleteTest: (key) {
                          _showAreYouSureAlertDelete(
                              context, key, snapshot.data[key]);
                        },
                      ),
                      CalendarTab(
                        reservedTestList: snapshot.data,
                        deleteTest: (key) {
                          _showAreYouSureAlertDelete(
                              context, key, snapshot.data[key]);
                        },
                        updateTest: (testKey, test, values) {
                          values.addAll({
                            Constants.TEST_ID_KEY: testKey,
                            testKey: test,
                          });
                          //bloc.updateTest.add(values);
                        },
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(
                height: media.height * 0.01,
              ),
              GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => CalendarNewReminderBlocProvider(
                        child: CalendarAddExamScreen(),
                      ),
                    ),
                  );
                  setState(() {
                    if (list_color == Colors.black) {
                      list_color = Colors.white;
                      calendar_color = Colors.black;
                    } else {
                      list_color = Colors.black;
                      calendar_color = Colors.white;
                    }
                  });
                },
                child: Container(
                  margin: EdgeInsets.symmetric(
                      horizontal: media.width * 0.08,
                      vertical: media.height * 0.01),
                  padding: EdgeInsets.all(media.width * 0.025),
                  decoration: BoxDecoration(
                      color: Color(0xff7ccddb),
                      borderRadius: BorderRadius.all(Radius.circular(25))),
                  child: Center(
                    child: Text(
                      'Aggiungi una prenotazione',
                      style: TextStyle(
                          color: Colors.white,
                          fontFamily: 'Bold',
                          fontSize: media.width * 0.05),
                    ),
                  ),
                ),
              ),
            ],
          );
        } else if (snapshot.hasError) {
          return Text(snapshot.error.toString());
        }
        return Center(child: CircularProgressIndicator());
      },
    );
  }

  _showAreYouSureAlertDelete(BuildContext context, String key, Test test) {
    showModalBottomSheet(
      context: context,
      builder: (context) => ModalBottomConfirmation(
        confirmationLabel:
            'Sei sicuro di voler eliminare il promemoria della prenotazione?',
        onPress: (isYesButtonPressed) {
          if (isYesButtonPressed) {
            bloc.inDeleteTest.add(Tuple2<String, Test>(
              key,
              test,
            ));
          }
          Navigator.pop(context);
          showModalBottomSheet(
            context: context,
            builder: (context) => StreamBuilder<Widget>(
              stream: bloc.getAlgorithmResult,
              builder: (context, snapshot) => snapshot.hasData
                  ? snapshot.data
                  : Container(
                      child: Center(
                        child: CircularProgressIndicator(),
                      ),
                    ),
            ),
            backgroundColor: Colors.black.withOpacity(0),
            isScrollControlled: true,
          );
        },
      ),
      backgroundColor: Colors.black.withOpacity(0),
      isScrollControlled: true,
    );
  }

  String formatTimeOfDay(TimeOfDay tod) {
    final now = new DateTime.now();
    final dt = DateTime(now.year, now.month, now.day, tod.hour, tod.minute);
    final format = DateFormat.jm(); //"6:00 AM"
    return format.format(dt);
  }
}
