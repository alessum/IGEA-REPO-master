import 'package:flutter/material.dart';
import 'package:igea_app/blocs/bloc_calendar_new_reminder.dart';
import 'package:igea_app/models/constants/constants.dart';
import 'package:igea_app/models/constants/constants_graphics.dart';
import 'package:igea_app/models/reservable_test.dart';
import 'package:igea_app/models/test.dart';
import 'package:igea_app/screens/calendar/modalBottomSheets/reservable_test_selection.dart';
import 'package:igea_app/screens/diary/modal_bottom_sheets/prevengo_modal_css.dart';
import 'package:igea_app/widgets/modal_bottom_sheets/input_time_spinner.dart';
import 'package:igea_app/widgets/modal_bottom_sheets/prevengo_modal_confirmation.dart';
import 'package:igea_app/widgets/modal_bottom_sheets/registry_input_date.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:intl/intl.dart';
import 'package:tuple/tuple.dart';

class InputReservationForm extends StatefulWidget {
  InputReservationForm({
    Key key,
    @required this.suggestedTest,
  }) : super(key: key);

  final Tuple2<String, Test> suggestedTest;

  @override
  _InputReservationFormState createState() => _InputReservationFormState();
}

class _InputReservationFormState extends State<InputReservationForm> {
  CalendarNewReminderBloc bloc;

  @override
  Widget build(BuildContext context) {
    initializeDateFormatting();
    bloc = CalendarNewReminderBlocProvider.of(context);

    Size media = MediaQuery.of(context).size;
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 10),
      height: media.height * 0.5,
      decoration: BoxDecoration(
          color: ConstantsGraphics.COLOR_CALENDAR_B_GREY,
          borderRadius: BorderRadius.all(Radius.circular(25))),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 15.0),
        child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Text('Tipologia: ',
                        style: TextStyle(
                            fontFamily: 'Book',
                            fontSize: media.width * 0.045,
                            color: Colors.grey[900])),
                    GestureDetector(
                      onTap: () => _showModalReservableTest(context),
                      child: Container(
                        width: media.width * 0.5,
                        padding: EdgeInsets.all(10),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.all(Radius.circular(25)),
                            color: Colors.white),
                        child: StreamBuilder<ReservableTest>(
                            stream: bloc.getReservableTest,
                            builder: (context, snapshot) {
                              return Text(
                                snapshot.hasData
                                    ? snapshot.data.name
                                    : 'Inserisci la tipologia',
                                style: TextStyle(
                                  fontSize: media.width * 0.04,
                                  fontFamily: 'Book',
                                ),
                              );
                            }),
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Text('Ora: ',
                        style: TextStyle(
                            fontFamily: 'Book',
                            fontSize: media.width * 0.045,
                            color: Colors.grey[900])),
                    GestureDetector(
                      onTap: () {
                        showModalBottomSheet(
                          context: context,
                          builder: (_) => ModalBottomInputTimeSpinner(
                              setTime: (value) {
                                bloc.setTime.add(value);
                                Navigator.pop(context);
                              },
                              titleLabel: 'Inserisci l\'ora della prenotazione',
                              colorTheme:
                                  ConstantsGraphics.COLOR_ONBOARDING_CYAN),
                          backgroundColor: Colors.black.withOpacity(0),
                          isScrollControlled: true,
                        );
                      },
                      child: Container(
                        width: media.width * 0.5,
                        padding: EdgeInsets.all(10),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.all(Radius.circular(25)),
                            color: Colors.white),
                        child: StreamBuilder<TimeOfDay>(
                            stream: bloc.getTime,
                            builder: (context, snapshot) {
                              return Text(
                                snapshot.hasData
                                    ? formatTimeOfDayInHHMM(snapshot.data)
                                    : 'Inserisci l\'ora',
                                style: TextStyle(
                                  fontSize: media.width * 0.04,
                                  fontFamily: 'Book',
                                ),
                              );
                            }),
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15.0),
                child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Text('Data:',
                          style: TextStyle(
                              fontFamily: 'Book',
                              fontSize: media.width * 0.045,
                              color: Colors.grey[900])),
                      GestureDetector(
                        onTap: () {
                          showModalBottomSheet(
                            context: context,
                            builder: (_) => ModalBottomInputDate(
                              setDate: (value) {
                                bloc.setDate.add(value);
                                Navigator.pop(context);
                              },
                              titleLabel:
                                  'Inserisci il giorno della prenotazione',
                              dateFormat: 'dd-MMM-yyyy',
                              colorTheme:
                                  ConstantsGraphics.COLOR_ONBOARDING_CYAN,
                              limitUpToday: false,
                              initialDate: DateTime.now(),
                            ),
                            backgroundColor: Colors.black.withOpacity(0),
                            isScrollControlled: true,
                          );
                        },
                        child: Container(
                          width: media.width * 0.5,
                          padding: EdgeInsets.all(10),
                          decoration: BoxDecoration(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(25)),
                              color: Colors.white),
                          child: StreamBuilder<DateTime>(
                              stream: bloc.getDate,
                              builder: (context, snapshot) {
                                return Text(
                                  snapshot.hasData
                                      ? DateFormat('yMMMd', 'it')
                                          .format(snapshot.data)
                                      : 'Inserisci il giorno',
                                  style: TextStyle(
                                    fontSize: media.width * 0.04,
                                    fontFamily: 'Book',
                                  ),
                                );
                              }),
                        ),
                      ),
                    ]),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15.0),
                child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Text('Luogo: ',
                          style: TextStyle(
                              fontFamily: 'Book',
                              fontSize: media.width * 0.045,
                              color: Colors.grey[900])),
                      SizedBox(
                        width: 200.0,
                        child: Stack(
                          children: <Widget>[
                            Container(
                                height: 50.0,
                                width: 200.0,
                                child: Card(
                                  elevation: 0.0,
                                  shape: RoundedRectangleBorder(
                                      borderRadius:
                                          BorderRadius.circular(25.0)),
                                )),
                            StreamBuilder<String>(
                                stream: bloc.getPlace,
                                builder: (context, snapshot) {
                                  return TextField(
                                    onChanged: (text) {
                                      bloc.setPlace.add(text);
                                    },
                                    decoration: const InputDecoration(
                                        hintText: 'inserisci luogo',
                                        border: InputBorder.none,
                                        focusedBorder: InputBorder.none,
                                        enabledBorder: InputBorder.none,
                                        errorBorder: InputBorder.none,
                                        disabledBorder: InputBorder.none,
                                        contentPadding: EdgeInsets.only(
                                            left: 15,
                                            bottom: 11,
                                            top: 11,
                                            right: 15)),
                                    readOnly: false,
                                  );
                                }),
                          ],
                        ),
                      ),
                    ]),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Text('Note: ',
                        style: TextStyle(
                            fontFamily: 'Book',
                            fontSize: media.width * 0.045,
                            color: Colors.grey[900])),
                    SizedBox(
                      width: 200.0,
                      child: Stack(
                        children: <Widget>[
                          Container(
                              height: 50.0,
                              width: 200.0,
                              child: Card(
                                elevation: 0.0,
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(25.0)),
                              )),
                          TextField(
                            onChanged: (text) {
                              bloc.setNotes.add(text);
                            },
                            decoration: const InputDecoration(
                                hintText: 'Inserisci note',
                                border: InputBorder.none,
                                focusedBorder: InputBorder.none,
                                enabledBorder: InputBorder.none,
                                errorBorder: InputBorder.none,
                                disabledBorder: InputBorder.none,
                                contentPadding: EdgeInsets.only(
                                    left: 15, bottom: 11, top: 11, right: 15)),
                            readOnly: false,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              //SizedBox(height: media.height * 0.01),
              Align(
                alignment: Alignment.centerLeft,
                child: Container(
                  padding: EdgeInsets.only(left: media.width * .05),
                  width: media.width * .8,
                  child: Text(
                    'I campi Tipologia, Ora e Data sono obbligatori',
                    style: TextStyle(
                      fontSize: media.width * .04,
                      fontFamily: 'Bold',
                    ),
                  ),
                ),
              ),
              GestureDetector(
                onTap: () {
                  if (bloc.isInputDataValid()) {
                    bloc.createNewReminder();
                    showModalBottomSheet(
                      context: context,
                      builder: (context) => StreamBuilder<Widget>(
                        stream: bloc.getNewReminderResult,
                        builder: (context, snapshot) {
                          if (snapshot.hasData) {
                            return snapshot.data;
                          } else {
                            return Container(
                              height: 200,
                              width: 200,
                              child: Center(
                                child: CircularProgressIndicator(),
                              ),
                            );
                          }
                        },
                      ),
                      backgroundColor: Colors.black.withOpacity(0),
                      isScrollControlled: true,
                    );
                  } else {
                    showModalBottomSheet(
                      context: context,
                      builder: (context) => PrevengoDiaryModalCSS(
                        colorTheme: Colors.grey[400],
                        title: 'C\'è un problema',
                        message:
                            'Ho bisono di alcune informazioni per creare il promemoria',
                        iconPath: 'assets/avatars/arold_in_circle.svg',
                        isAlert: true,
                      ),
                      backgroundColor: Colors.black.withOpacity(0),
                      isScrollControlled: true,
                    );
                  }
                },
                child: Container(
                  padding: EdgeInsets.all(media.width * 0.03),
                  width: media.width * 0.9,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(30.0)),
                    color: Color(0xff7ccddb),
                  ),
                  child: Text(
                    'Conferma',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        fontSize: media.width * .05,
                        color: Colors.white,
                        fontWeight: FontWeight.w300,
                        fontFamily: 'Gotham'),
                  ),
                  // child: Row(
                  //   children: <Widget>[
                  //     Text('Conferma',
                  //         style: TextStyle(
                  //             fontSize: 18,
                  //             color: Colors.white,
                  //             fontWeight: FontWeight.w300,
                  //             fontFamily: 'FilsonSoft')),
                  //     SizedBox(width: 10.0),
                  //     CircleAvatar(
                  //       backgroundColor: Colors.white,
                  //       radius: 15.0,
                  //       child: Icon(Icons.check,
                  //           color: Color(0xff7ccddb), size: 25),
                  //     )
                  //   ],
                  // ),
                ),
              ),
            ]),
      ),
    );
  }

  String formatTimeOfDayInHHMM(TimeOfDay tod) {
    final now = new DateTime.now();
    final dt = DateTime(now.year, now.month, now.day, tod.hour, tod.minute);
    final format = DateFormat('HH:mm');
    return format.format(dt);
  }

  _showModalReservableTest(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (context) => ModalBottomReservableTestSelection(
        colorTheme: ConstantsGraphics.COLOR_CALENDAR_CYAN,
        reservableTestSelection: (reservableTest) {
          bloc.setReservableTest.add(reservableTest);
        },
      ),
      backgroundColor: Colors.black.withOpacity(0),
      isScrollControlled: true,
    );
  }
}
