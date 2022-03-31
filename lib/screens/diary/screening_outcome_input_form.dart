import 'dart:io';

import 'package:flutter/material.dart';
import 'package:igea_app/blocs/diary/bloc_new_outcome.dart';
import 'package:igea_app/models/camera_file_manager.dart';
import 'package:igea_app/models/constants/constants_graphics.dart';
import 'package:igea_app/models/enums/screening_outcome_value.dart';
import 'package:igea_app/models/reservable_test.dart';
import 'package:igea_app/screens/camera/camera_screen.dart';
import 'package:igea_app/screens/diary/modal_bottom_sheets/prevengo_modal_css.dart';
import 'package:igea_app/screens/diary/modal_bottom_sheets/prevengo_modal_insert_date.dart';
import 'package:igea_app/screens/diary/modal_bottom_sheets/prevengo_modal_new_test_selection.dart';
import 'package:igea_app/screens/diary/modal_bottom_sheets/prevengo_modal_screeening_outcome_input.dart';
import 'package:igea_app/widgets/input_widgets/prevengo_single_radio_label.dart';
import 'package:igea_app/widgets/modal_bottom_sheets/registry_input_date.dart';
import 'package:igea_app/widgets/ui_components/button_radio_text_container.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:intl/intl.dart';

import '../../models/enums/test_type.dart';
import '../../models/reservation.dart';

class ScreeningOutcomeInputForm extends StatefulWidget {
  ScreeningOutcomeInputForm({
    Key key,
    @required this.reservableTest,
  }) : super(key: key);

  final ReservableTest reservableTest;

  @override
  _ScreeningOutcomeInputFormState createState() =>
      _ScreeningOutcomeInputFormState();
}

class _ScreeningOutcomeInputFormState extends State<ScreeningOutcomeInputForm> {
  NewOutcomeBloc bloc;

  TestType _testType;
  String _newTestName;

  @override
  Widget build(BuildContext context) {
    Size media = MediaQuery.of(context).size;
    bloc = NewOutcomeBlocProvider.of(context);
    initializeDateFormatting();

    return Container(
      padding: EdgeInsets.all(media.width * 0.07),
      decoration: BoxDecoration(
          color: Colors.grey[200],
          borderRadius: BorderRadius.all(Radius.circular(25))),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        mainAxisSize: MainAxisSize.max,
        children: [
          Container(
            alignment: Alignment.topLeft,
            child: Text(
              'Vuoi inserire una foto dell\'esito?',
              style: TextStyle(
                fontSize: media.width * 0.05,
                fontFamily: 'Gotham',
              ),
            ),
          ),
          SizedBox(height: media.height * 0.02),
          GestureDetector(
            onTap: () => Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => CameraScreen(),
              ),
            ),
            child: Container(
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.all(Radius.circular(25))),
              child: Center(
                child: Text('Scatta la foto',
                    style: TextStyle(
                      fontSize: media.width * 0.05,
                      fontFamily: 'Book',
                    )),
              ),
            ),
          ),
          StreamBuilder<File>(
            stream: bloc.imageFile,
            builder: (context, snapshot) => snapshot.hasData
                ? Column(
                    children: [
                      Container(
                        margin: EdgeInsets.symmetric(vertical: 10),
                        child: Image.file(
                          snapshot.data,
                          height: media.height * 0.4,
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          GestureDetector(
                            onTap: () => Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => CameraScreen(),
                              ),
                            ),
                            child: Container(
                              width: media.width * 0.4,
                              padding: const EdgeInsets.all(10),
                              decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(25))),
                              child: Center(
                                child: Text('Modifica',
                                    style: TextStyle(
                                      fontSize: media.width * 0.05,
                                      fontFamily: 'Book',
                                    )),
                              ),
                            ),
                          ),
                          GestureDetector(
                            onTap: () => CameraFileManager.addFileImage(null),
                            child: Container(
                              width: media.width * 0.4,
                              padding: const EdgeInsets.all(10),
                              decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(25))),
                              child: Center(
                                child: Text('Elimina',
                                    style: TextStyle(
                                      fontSize: media.width * 0.05,
                                      fontFamily: 'Book',
                                    )),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  )
                : Container(),
          ),
          SizedBox(height: media.height * 0.04),
          Container(
            alignment: Alignment.topLeft,
            child: Text(
              ' Quando hai fatto l\'esame?',
              style: TextStyle(
                fontSize: media.width * 0.05,
                fontFamily: 'Gotham',
              ),
            ),
          ),
          SizedBox(height: media.height * 0.02),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Text('Data: ',
                    style: TextStyle(
                        fontSize: media.width * 0.05,
                        fontFamily: 'Book',
                        color: Colors.grey[900])),
                GestureDetector(
                  onTap: () {
                    showModalBottomSheet(
                      context: context,
                      builder: (_) => ModalBottomInputDate(
                        setDate: (value) {
                          bloc.updateOldReservation.add(
                            Reservation(
                              value,
                              null,
                              null,
                              null,
                            ),
                          );
                          Navigator.pop(context);
                        },
                        titleLabel: 'Inserisci la data dell\'esame ',
                        dateFormat: 'dd-MMM-yyyy',
                        colorTheme: ConstantsGraphics.COLOR_DIARY_BLUE,
                        limitUpToday: true,
                      ),
                      backgroundColor: Colors.black.withOpacity(0),
                      isScrollControlled: true,
                    );
                  },
                  child: Container(
                    width: media.width * 0.4,
                    padding: EdgeInsets.all(10),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(25)),
                        color: Colors.white),
                    child: StreamBuilder<Reservation>(
                        stream: bloc.getOldReservation,
                        builder: (context, snapshot) {
                          return Text(
                            snapshot.hasData
                                ? DateFormat('yMMMd', 'it')
                                    .format(snapshot.data.date)
                                : 'Inserisci il giorno',
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
          SizedBox(height: media.height * 0.04),
          Container(
            alignment: Alignment.topLeft,
            child: Text(
              'Quale sarà il prossimo esame da prenotare?',
              style: TextStyle(
                fontSize: media.width * 0.05,
                fontFamily: 'Gotham',
              ),
            ),
          ),
          SizedBox(height: media.height * 0.02),
          StreamBuilder<Object>(
              stream: bloc.getCheckScreeningProtocol,
              builder: (context, snapshot) {
                return PrevengoSingleRadioLabel(
                    onTap: (value) {
                      bloc.updateCheckScreeningProtocol.add(value);
                      setState(() {
                        _newTestName = widget.reservableTest.name;
                      });
                    },
                    isCheck: snapshot.data ?? false,
                    label: 'Protocollo screening standard');
              }),
          SizedBox(height: media.height * 0.02),
          StreamBuilder<bool>(
            stream: bloc.getCheckScreeningProtocol,
            builder: (context, snapshot) {
              return GestureDetector(
                onTap: () {
                  if (!snapshot.hasData || !snapshot.data) {
                    showModalBottomSheet(
                      context: context,
                      builder: (_) => PrevengoDiaryModalNewTestSelection(
                        reservableTest: widget.reservableTest,
                        onTestSelected: (reservableTest) {
                          bloc.updateNewReservableTest.add(reservableTest);
                        },
                      ),
                      backgroundColor: Colors.black.withOpacity(0),
                      isScrollControlled: true,
                    );
                  }
                },
                child: Container(
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.all(
                      Radius.circular(25),
                    ),
                  ),
                  child: Center(
                    child: StreamBuilder<ReservableTest>(
                        stream: bloc.getNewReservableTest,
                        builder: (context, reservableTestSnap) {
                          return Text(
                            reservableTestSnap.hasData
                                ? reservableTestSnap.data.name
                                : 'Scegli il test',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                fontSize: media.width * 0.05,
                                fontFamily: 'Book',
                                color: snapshot.hasData
                                    ? !snapshot.data
                                        ? Colors.black
                                        : Colors.grey[500]
                                    : Colors.black),
                          );
                        }),
                  ),
                ),
              );
            },
          ),
          SizedBox(height: media.height * 0.02),
          Container(
            alignment: Alignment.topLeft,
            child: Text(
              'Quando sarà il prossimo esame?',
              style: TextStyle(
                fontSize: media.width * 0.05,
                fontFamily: 'Gotham',
              ),
            ),
          ),
          SizedBox(height: media.height * 0.02),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Text('Data: ',
                    style: TextStyle(
                        fontSize: media.width * 0.05,
                        fontFamily: 'Book',
                        color: Colors.grey[900])),
                StreamBuilder<bool>(
                  stream: bloc.getCheckScreeningProtocol,
                  builder: (context, checkSnap) {
                    return GestureDetector(
                      onTap: () {
                        if (!checkSnap.hasData || !checkSnap.data) {
                          showModalBottomSheet(
                            context: context,
                            builder: (_) => PrevengoDiaryModalInsertDate(
                              onDateChange: (reservation) {
                                bloc.updateNewReservation.add(reservation);
                              },
                            ),
                            backgroundColor: Colors.black.withOpacity(0),
                            isScrollControlled: true,
                          );
                        }
                      },
                      child: Container(
                        width: media.width * 0.4,
                        padding: EdgeInsets.all(10),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.all(Radius.circular(25)),
                            color: Colors.white),
                        child: StreamBuilder<Reservation>(
                          stream: bloc.getNewReservation,
                          builder: (context, snapshot) {
                            return Text(
                              snapshot.hasData
                                  ? DateFormat('yMMMd', 'it')
                                      .format(snapshot.data.date)
                                  : 'Inserisci data',
                              style: TextStyle(
                                  fontSize: media.width * 0.04,
                                  fontFamily: 'Book',
                                  color: checkSnap.hasData
                                      ? !checkSnap.data
                                          ? Colors.black
                                          : Colors.grey[500]
                                      : Colors.black),
                            );
                          },
                        ),
                      ),
                    );
                  },
                ),
              ],
            ),
          ),
          SizedBox(height: media.height * 0.04),
          GestureDetector(
            onTap: () {
              bloc.insertNewScreeningOutcome();
              showModalBottomSheet(
                context: context,
                builder: (context) => StreamBuilder<Widget>(
                  stream: bloc.getAlgorithmResult,
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
            },
            child: Container(
              alignment: Alignment.center,
              padding: EdgeInsets.all(8),
              decoration: BoxDecoration(
                  color: Color(0xff4768b7),
                  borderRadius: BorderRadius.all(Radius.circular(25))),
              child: Center(
                child: Text(
                  'Conferma',
                  style: TextStyle(
                      fontSize: media.width * 0.05,
                      fontFamily: 'Bold',
                      color: Colors.white),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
