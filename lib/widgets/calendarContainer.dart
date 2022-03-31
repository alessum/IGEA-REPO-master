import 'package:igea_app/blocs/bloc_calendar.dart';
import 'package:flutter/material.dart';
import '../screens/calendar/calendar_content.dart';

class CalendarContainer extends StatefulWidget {
  @override
  _CalendarContainerState createState() => _CalendarContainerState();
}

class _CalendarContainerState extends State<CalendarContainer> {
  @override
  Widget build(BuildContext context) {
    return Container(
        height: MediaQuery.of(context).size.height * 0.87,
        decoration: BoxDecoration(
          color: Colors.transparent,
          borderRadius: new BorderRadius.all(const Radius.circular(25.0)),
        ),
        padding: EdgeInsets.only(
          bottom: MediaQuery.of(context).viewInsets.bottom + 10,
        ),
        child: CalendarBlocProvider(child: CalendarContent()));
  }
}
