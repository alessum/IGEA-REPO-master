import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:igea_app/blocs/bloc_calendar.dart';
import 'package:igea_app/screens/calendar/calendar_content.dart';

class CalendarScreen extends StatefulWidget {
  CalendarScreen({Key key}) : super(key: key);

  @override
  _CalendarScreenState createState() => _CalendarScreenState();
}

class _CalendarScreenState extends State<CalendarScreen> {
  @override
  Widget build(BuildContext context) {
    Size media = MediaQuery.of(context).size;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leadingWidth: media.width * 0.1,
        leading: GestureDetector(
          onTap: () => Navigator.pop(context),
          child: Padding(
            padding: const EdgeInsets.only(left: 8.0),
            child: SvgPicture.asset(
              'assets/icons/circle_left.svg',
              color: Colors.black,
            ),
          ),
        ),
        title: Text('Calendario',
            textAlign: TextAlign.left,
            style: TextStyle(
                fontSize: media.width * 0.07,
                color: Colors.black,
                fontFamily: 'Gotham')),
      ),
      body: CalendarBlocProvider(
        child: CalendarContent(),
      ),
    );
  }
}
