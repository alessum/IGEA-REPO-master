import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:igea_app/blocs/bloc_calendar_new_reminder.dart';
import 'package:igea_app/models/test.dart';
import 'package:igea_app/screens/calendar/input_reservation_form.dart';
import 'package:intl/intl.dart';
import 'package:tuple/tuple.dart';

class CalendarAddExamScreen extends StatefulWidget {
  CalendarAddExamScreen({
    Key key,
  }) : super(key: key);

  @override
  _CalendarAddExamScreenState createState() => _CalendarAddExamScreenState();
}

class _CalendarAddExamScreenState extends State<CalendarAddExamScreen> {
  CalendarNewReminderBloc bloc;
  Tuple2<String, Test> suggestedTest;

  @override
  Widget build(BuildContext context) {
    bloc = CalendarNewReminderBlocProvider.of(context);
    Size media = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Colors.white,
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
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  width: media.width * 0.8,
                  padding: EdgeInsets.all(media.width * 0.04),
                  child: Text(
                    'Qui puoi inserire un nuovo promemoria nel calendario per un esame che hai prenotato.\n',
                    style: TextStyle(
                        fontSize: media.width * 0.05, fontFamily: 'Bold'),
                  ),
                ),
                Container(
                  child: SvgPicture.asset(
                    'assets/avatars/arold_lateral.svg',
                    height: media.width * 0.3,
                  ),
                ),
              ],
            ),
            Padding(
              padding: EdgeInsets.only(
                  bottom: MediaQuery.of(context).viewInsets.bottom),
              child: InputReservationForm(
                suggestedTest: suggestedTest,
              ),
            ),
            // Expanded(
            //   child: StreamBuilder<Map<String, Test>>(
            //     stream: bloc.getTestList,
            //     builder: (context, snapshot) => snapshot.hasData
            //         ? snapshot.data.length == 0
            //             ? Container(
            //                 child: Center(
            //                   child: Text('Nessun esame pronato con ATS'),
            //                 ),
            //               )
            //             : Column(
            //                 mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            //                 children: [
            //                   // Row(
            //                   //   mainAxisAlignment:
            //                   //       MainAxisAlignment.spaceBetween,
            //                   //   children: [
            //                   //     Container(
            //                   //       width: media.width * 0.8,
            //                   //       padding: EdgeInsets.all(10),
            //                   //       child: Text(
            //                   //         'Ciao! Puoi cliccare su un esame che vedi nella lista qui sotto per salvare il promemoria, oppure eliminalo se non ti interessa',
            //                   //         style: TextStyle(
            //                   //             fontSize: media.width * 0.045,
            //                   //             fontFamily: 'Book'),
            //                   //       ),
            //                   //     ),
            //                   //     Container(
            //                   //       child: SvgPicture.asset(
            //                   //         'assets/avatars/arold_lateral.svg',
            //                   //         height: media.width * 0.3,
            //                   //       ),
            //                   //     ),
            //                   //   ],
            //                   // ),

            //                   // Expanded(
            //                   //   child: ListView.separated(
            //                   //       itemBuilder: (context, index) {
            //                   //         String key =
            //                   //             snapshot.data.keys.elementAt(index);
            //                   //         return Container(
            //                   //           width: media.width * 0.8,
            //                   //           padding: const EdgeInsets.all(8),
            //                   //           decoration: BoxDecoration(
            //                   //             borderRadius: BorderRadius.all(
            //                   //                 Radius.circular(30)),
            //                   //             color: ConstantsGraphics
            //                   //                 .COLOR_CALENDAR_CYAN,
            //                   //           ),
            //                   //           child: Text(
            //                   //             snapshot.data[key].name.toUpperCase(),
            //                   //             style: TextStyle(
            //                   //               color: Colors.white,
            //                   //               fontSize: media.width * 0.05,
            //                   //               fontFamily: 'Gotham',
            //                   //             ),
            //                   //           ),
            //                   //         );
            //                   //       },
            //                   //       separatorBuilder: (context, _) =>
            //                   //           SizedBox(height: media.height * 0.01),
            //                   //       itemCount: snapshot.data.length),
            //                   // )
            //                 ],
            //               )
            //         : Center(
            //             child: CircularProgressIndicator(),
            //           ),
            //   ),
            // ),
          ],
        ),
      ),
    );
  }

  String formatTimeOfDay(TimeOfDay tod) {
    final now = new DateTime.now();
    final dt = DateTime(now.year, now.month, now.day, tod.hour, tod.minute);
    final format = DateFormat.jm();
    return format.format(dt);
  }

  String formatTimeOfDayInHHMM(TimeOfDay tod) {
    final now = new DateTime.now();
    final dt = DateTime(now.year, now.month, now.day, tod.hour, tod.minute);
    final format = DateFormat('HH:mm');
    return format.format(dt);
  }

  // void showNonReservedTests(BuildContext ctx) {
  //   Size media = MediaQuery.of(ctx).size;
  //   showModalBottomSheet(
  //     context: ctx,
  //     builder: (_) => Container(
  //       margin: EdgeInsets.only(bottom: 8, left: 8, right: 8),
  //       padding: EdgeInsets.only(bottom: 10),
  //       decoration: BoxDecoration(
  //           borderRadius: BorderRadius.vertical(
  //               top: Radius.circular(25), bottom: Radius.circular(25)),
  //           color: Colors.white),
  //       height: media.height * 0.3,
  //       child: Container(
  //         padding: EdgeInsets.all(15),
  //         child: Column(
  //           mainAxisAlignment: MainAxisAlignment.spaceBetween,
  //           children: <Widget>[
  //             Row(
  //               mainAxisAlignment: MainAxisAlignment.spaceBetween,
  //               children: <Widget>[
  //                 Flexible(
  //                   flex: 2,
  //                   child: SvgPicture.asset(
  //                     'assets/avatars/arold_in_circle.svg',
  //                     fit: BoxFit.cover,
  //                     height: media.height * 0.1,
  //                   ),
  //                 ),
  //                 Flexible(
  //                   flex: 5,
  //                   child: Text(
  //                     'Mi risulta che hai cercato di prenotare l\'esame "${widget.nonReservedTestList.values.toList()[0].name}". Vuoi salvarlo nel calendario?',
  //                     style: TextStyle(fontSize: 20),
  //                   ),
  //                 )
  //               ],
  //             ),
  //             Row(
  //               mainAxisAlignment: MainAxisAlignment.spaceEvenly,
  //               children: <Widget>[
  //                 GestureDetector(
  //                   onTap: () => setState(() {
  //                     testKey = widget.nonReservedTestList.keys.toList()[0];
  //                     selectedTest =
  //                         widget.nonReservedTestList.values.toList()[0];
  //                     nonReservedTestSelected = true;
  //                     print('HO CONFERMATO');

  //                     Navigator.pop(context);
  //                   }),
  //                   child: Container(
  //                     width: 120,
  //                     decoration: BoxDecoration(
  //                       color: Color(0xff7ccddb),
  //                       borderRadius: BorderRadius.circular(20.0),
  //                     ),
  //                     padding: const EdgeInsets.only(
  //                         top: 5.0, bottom: 5.0, left: 15.0, right: 15.0),
  //                     child: Text(
  //                       'Conferma',
  //                       style: TextStyle(
  //                           fontSize: 18,
  //                           color: Colors.white,
  //                           fontWeight: FontWeight.w300,
  //                           fontFamily: 'FilsonSoft'),
  //                     ),
  //                   ),
  //                 ),
  //                 GestureDetector(
  //                   onTap: () => setState(() {
  //                     //testKey = widget.nonReservedTestList.keys.toList()[0];
  //                     //TODO ELIMINARE TEST DAL DATABASE CON BLOC
  //                     Navigator.pop(context);
  //                   }),
  //                   child: Container(
  //                     width: 120,
  //                     decoration: BoxDecoration(
  //                       color: Color(0xff7ccddb),
  //                       borderRadius: BorderRadius.circular(20.0),
  //                     ),
  //                     padding: const EdgeInsets.only(
  //                         top: 5.0, bottom: 5.0, left: 15.0, right: 15.0),
  //                     child: Text(
  //                       'Elimina',
  //                       textAlign: TextAlign.center,
  //                       style: TextStyle(
  //                           fontSize: 18,
  //                           color: Colors.white,
  //                           fontWeight: FontWeight.w300,
  //                           fontFamily: 'FilsonSoft'),
  //                     ),
  //                   ),
  //                 )
  //               ],
  //             )
  //           ],
  //         ),
  //       ),
  //     ),
  //     backgroundColor: Colors.black.withOpacity(0),
  //     isScrollControlled: true,
  //   );
  // }
}
