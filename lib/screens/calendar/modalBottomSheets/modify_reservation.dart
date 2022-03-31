import 'package:flutter/material.dart';
import 'package:igea_app/models/constants/constants.dart';
import 'package:igea_app/models/constants/constants_graphics.dart';
import 'package:igea_app/models/test.dart';
import 'package:igea_app/widgets/modal_bottom_sheets/input_time_spinner.dart';
import 'package:igea_app/widgets/modal_bottom_sheets/registry_input_date.dart';
import 'package:igea_app/widgets/ui_components/close_line_top_modal.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:intl/intl.dart';
import 'package:tuple/tuple.dart';

class ModalBottomModifyReservation extends StatefulWidget {
  ModalBottomModifyReservation({
    Key key,
    @required this.test,
    @required this.setReservationValues,
  }) : super(key: key);

  ///__Elements in tuple3__
  ///1. Reservation date
  ///2. Place
  ///3. Notes
  final Function(Tuple3<DateTime, String, String> reservationValues)
      setReservationValues;
  final Test test;

  @override
  _ModalBottomModifyReservationState createState() =>
      _ModalBottomModifyReservationState();
}

class _ModalBottomModifyReservationState
    extends State<ModalBottomModifyReservation> {
  TimeOfDay _reservationTime;
  DateTime _reservationDate;
  String _reservationPlace;
  String _reservationNotes;
  Map<String, dynamic> _reservationValues = Map();

  TextEditingController _placeTextController;
  TextEditingController _notesTextController;

  @override
  void initState() {
    super.initState();
    _placeTextController =
        TextEditingController(text: widget.test.reservation.locationName);
    _notesTextController =
        TextEditingController(text: widget.test.reservation.description);
    _reservationDate = widget.test.reservation.date;
    _reservationTime = TimeOfDay.fromDateTime(_reservationDate);
    _reservationPlace = widget.test.reservation.locationName;

    print(_reservationDate.toIso8601String());
    initializeDateFormatting();
  }

  @override
  Widget build(BuildContext context) {
    Size media = MediaQuery.of(context).size;
    return Padding(
      padding: EdgeInsets.only(
          bottom: MediaQuery.of(context).viewInsets.bottom * 0.05),
      child: Container(
        margin: EdgeInsets.all(8),
        padding:
            EdgeInsets.symmetric(vertical: 15, horizontal: media.width * 0.05),
        decoration: BoxDecoration(
            color: Colors.grey[200],
            borderRadius: BorderRadius.all(Radius.circular(25))),
        child: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              CloseLineTopModal(
                color: Colors.grey[500],
              ),
              SizedBox(height: media.height * 0.02),
              Row(
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
                            //FIXME PARTE SEMPRE DA 00:00 PROBLEMI DI FORMATO?
                            initialTime: widget.test.reservation.date,
                            setTime: (value) {
                              setState(() {
                                _reservationTime = value;
                              });
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
                      child: Text(
                        _reservationTime != null
                            ? formatTimeOfDayInHHMM(_reservationTime)
                            : DateFormat('hh:mm')
                                .format(widget.test.reservation.date),
                        style: TextStyle(
                          fontSize: media.width * 0.04,
                          fontFamily: 'Book',
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: media.height * 0.02),
              Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Text('Data: ',
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
                              setState(() {
                                _reservationDate = value;
                              });
                              Navigator.pop(context);
                            },
                            initialDate: widget.test.reservation.date,
                            titleLabel:
                                'Inserisci il giorno della prenotazione',
                            dateFormat: 'dd-MMM-yyyy',
                            colorTheme: ConstantsGraphics.COLOR_ONBOARDING_CYAN,
                            limitUpToday: false,
                          ),
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
                        child: Text(
                          _reservationDate != null
                              ? DateFormat('yMMMd', 'it')
                                  .format(_reservationDate)
                              : DateFormat('yMMMd', 'it')
                                  .format(widget.test.reservation.date),
                          style: TextStyle(
                            fontSize: media.width * 0.04,
                            fontFamily: 'Book',
                          ),
                        ),
                      ),
                    ),
                  ]),
              SizedBox(height: media.height * 0.02),
              Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Text('Luogo: ',
                        style: TextStyle(
                            fontFamily: 'Book',
                            fontSize: media.width * 0.045,
                            color: Colors.grey[900])),
                    SizedBox(
                      width: media.width * 0.5,
                      height: media.height * 0.12,
                      child: Stack(
                        children: <Widget>[
                          Container(
                              width: media.width * 0.5,
                              height: media.height * 0.12,
                              child: Card(
                                elevation: 0.0,
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(25.0)),
                              )),
                          TextField(
                            controller: _placeTextController,
                            onChanged: (text) {
                              setState(() {
                                _reservationPlace = text;
                              });
                            },
                            keyboardType: TextInputType.multiline,
                            maxLines: null,
                            decoration: const InputDecoration(
                                hintText: 'Inserire luogo',
                                border: InputBorder.none,
                                focusedBorder: InputBorder.none,
                                enabledBorder: InputBorder.none,
                                errorBorder: InputBorder.none,
                                disabledBorder: InputBorder.none,
                                contentPadding: EdgeInsets.only(
                                    left: 15, bottom: 11, top: 11, right: 15)),
                          ),
                        ],
                      ),
                    ),
                  ]),
              SizedBox(height: media.height * 0.02),
              Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Text('Note: ',
                        style: TextStyle(
                            fontFamily: 'Book',
                            fontSize: media.width * 0.045,
                            color: Colors.grey[900])),
                    SizedBox(
                      width: media.width * 0.5,
                      height: media.height * 0.12,
                      child: Stack(
                        children: <Widget>[
                          Container(
                              height: media.height * 0.12,
                              width: media.width * 0.5,
                              child: Card(
                                elevation: 0.0,
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(25.0)),
                              )),
                          TextField(
                            controller: _notesTextController,
                            onChanged: (text) {
                              setState(() {
                                _reservationNotes = text;
                              });
                            },
                            keyboardType: TextInputType.multiline,
                            maxLines: null,
                            decoration: const InputDecoration(
                                hintText: '- note personali',
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
                  ]),
              SizedBox(height: media.height * 0.02),
              GestureDetector(
                onTap: () {
                  DateTime newDate = DateTime(
                    _reservationDate.year,
                    _reservationDate.month,
                    _reservationDate.day,
                    _reservationTime.hour,
                    _reservationTime.minute,
                  );

                  _reservationValues.addAll({
                    Constants.RESERVATION_DATE_KEY: newDate,
                    Constants.RESERVATION_LOCATION_NAME_KEY: _reservationPlace,
                    Constants.RESERVATION_DESCRIPTION_KEY: _reservationNotes,
                  });
                  widget.setReservationValues(
                    Tuple3<DateTime, String, String>(
                      newDate,
                      _reservationPlace,
                      _reservationNotes,
                    ),
                  );
                },
                child: Container(
                  padding: EdgeInsets.all(media.width * 0.03),
                  width: media.width,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(30.0)),
                    color: Color(0xff7ccddb),
                  ),
                  child: Text(
                    'Conferma',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        fontSize: media.width * 0.06,
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
}
