import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_holo_date_picker/date_picker.dart';
import 'package:flutter_holo_date_picker/date_picker_theme.dart';
import 'package:flutter_holo_date_picker/widget/date_picker_widget.dart';
import 'package:flutter_time_picker_spinner/flutter_time_picker_spinner.dart';
import 'package:igea_app/widgets/ui_components/close_line_top_modal.dart';

import '../../../models/constants/constants_graphics.dart';
import '../../../models/reservation.dart';
import '../ui_components/prevengo_dropdown.dart';

class PrevengoDiaryModalInsertDate extends StatefulWidget {
  const PrevengoDiaryModalInsertDate({
    Key key,
    @required this.onDateChange,
  }) : super(key: key);

  final Function(Reservation reservation) onDateChange;

  @override
  _PrevengoDiaryModalInsertDateState createState() =>
      _PrevengoDiaryModalInsertDateState();
}

class _PrevengoDiaryModalInsertDateState
    extends State<PrevengoDiaryModalInsertDate> {
  // final List<String> _inputTypes = [
  //   'Data precisa',
  //   'Numero di mesi',
  //   'Numero di anni',
  // ];

  String inputType;
  int addedTime;
  DateTime _selectedDate;
  TimeOfDay _timeOfDay;
  String _place;
  String _notes;

  @override
  Widget build(BuildContext context) {
    Size media = MediaQuery.of(context).size;

    List<DropdownMenuItem<String>> _dropDownMenuItems = [
      DropdownMenuItem(
        value: 'Data precisa',
        child: Text(
          'Data precisa',
          style: TextStyle(
            fontSize: media.width * 0.04,
            fontFamily: 'Book',
          ),
        ),
      ),
      DropdownMenuItem(
        value: 'Numero di mesi',
        child: Text(
          'Numero di mesi',
          style: TextStyle(
            fontSize: media.width * 0.04,
            fontFamily: 'Book',
          ),
        ),
      ),
      DropdownMenuItem(
        value: 'Numero di anni',
        child: Text(
          'Numero di anni',
          style: TextStyle(
            fontSize: media.width * 0.04,
            fontFamily: 'Book',
          ),
        ),
      ),
    ];
    return Padding(
      padding:
          EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
      child: Container(
        // height: media.height * 0.5,
        padding: const EdgeInsets.fromLTRB(15, 8, 15, 8),
        margin: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(25),
          color: Colors.white,
        ),
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              CloseLineTopModal(),
              SizedBox(height: media.height * 0.02),
              Container(
                child: Text(
                  'Inserisci quando dovrai fare il prossimo esame',
                  style: TextStyle(
                    fontSize: media.width * 0.05,
                    fontFamily: 'Bold',
                  ),
                ),
              ),
              SizedBox(height: media.height * 0.02),
              CustomDropdown(
                dropdownMenuItemList: _dropDownMenuItems,
                onChanged: (type) {
                  setState(() {
                    inputType = type;
                    print(inputType);
                  });
                },
                value: inputType,
                isEnabled: true,
              ),
              SizedBox(height: media.height * 0.02),
              _getContent(media),
              SizedBox(height: media.height * 0.04),
              GestureDetector(
                onTap: () {
                  Reservation reservation = Reservation(
                    DateTime(
                      _selectedDate?.year,
                      _selectedDate?.month,
                      _selectedDate?.day,
                      _timeOfDay?.hour ?? 0,
                      _timeOfDay?.minute ?? 0,
                    ),
                    _notes,
                    null,
                    _place,
                  );
                  widget.onDateChange(reservation);
                  Navigator.pop(context);
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
        ),
      ),
    );
  }

  Widget _getContent(Size media) {
    if (inputType != null) {
      if (inputType == 'Numero di mesi' || inputType == 'Numero di anni') {
        return Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              inputType == 'Numero di mesi' ? 'Quanti mesi?' : 'Quanti anni?',
              style: TextStyle(
                fontSize: media.width * 0.05,
                fontFamily: 'Book',
              ),
            ),
            Container(
              width: media.width * 0.3,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(25)),
                border: Border.all(width: 1),
              ),
              child: TextField(
                onChanged: (text) {
                  setState(() {
                    print('sono qui');
                    addedTime = int.parse(text);
                    DateTime now = DateTime.now();
                    if (inputType == 'Numero di mesi') {
                      if (now.month + addedTime > 12) {
                        _selectedDate = DateTime(
                          now.year + (now.month / 12).floor(),
                          addedTime -
                              (12 * ((now.month / 12).floor()) - now.month),
                          now.day,
                        );
                      } else {
                        _selectedDate = DateTime(
                          now.year,
                          now.month + addedTime,
                          now.day,
                        );
                      }
                    } else {
                      _selectedDate = DateTime(
                        now.year + addedTime,
                        now.month,
                        now.day,
                      );
                    }
                  });
                },
                keyboardType: TextInputType.number,
                inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                decoration: InputDecoration(
                  hintText: inputType == 'Numero di mesi' ? 'Mesi' : 'Anni',
                  border: InputBorder.none,
                  focusedBorder: InputBorder.none,
                  enabledBorder: InputBorder.none,
                  errorBorder: InputBorder.none,
                  disabledBorder: InputBorder.none,
                  contentPadding: EdgeInsets.only(
                    left: 15,
                    bottom: 11,
                    top: 11,
                    right: 15,
                  ),
                ),
                readOnly: false,
              ),
            ),
          ],
        );
      } else if (inputType == 'Data precisa') {
        return Column(
          children: [
            DatePickerWidget(
              looping: false, // default is not looping
              firstDate: DateTime(DateTime.now().year - 50),
              lastDate: DateTime(DateTime.now().year + 10),
              initialDate: DateTime.now(),
              dateFormat: 'dd-MMM-yyyy',
              locale: DatePicker.localeFromString('it'),
              onChange: (DateTime newDate, _) {
                setState(() {
                  _selectedDate = newDate;
                });
              },
              pickerTheme: DateTimePickerTheme(
                itemTextStyle: TextStyle(
                  color: Colors.black,
                  fontSize: 23,
                ),
                dividerColor: ConstantsGraphics.COLOR_DIARY_BLUE,
              ),
            ),
            Container(
              child: Text(
                'Puoi inserire anche l\'orario, il luogo e le note, così ti salverò un promemoria in calendario',
                style: TextStyle(
                  fontSize: media.width * 0.045,
                  fontFamily: 'Book',
                ),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  width: media.width * 0.25,
                  child: Center(
                    child: Text(
                      'Ore',
                      style: TextStyle(
                        fontFamily: 'Bold',
                        fontSize: media.width * 0.06,
                      ),
                    ),
                  ),
                ),
                Container(
                  width: media.width * 0.3,
                  child: TimePickerSpinner(
                    is24HourMode: true,
                    time: DateTime.now(),
                    normalTextStyle: TextStyle(
                        fontFamily: 'Book',
                        fontSize: media.width * 0.05,
                        color: Colors.black),
                    highlightedTextStyle: TextStyle(
                        fontFamily: 'Bold',
                        fontSize: media.width * 0.05,
                        color: ConstantsGraphics.COLOR_DIARY_BLUE),
                    spacing: 10,
                    itemHeight: 40,
                    isForce2Digits: true,
                    minutesInterval: 1,
                    alignment: Alignment.center,
                    onTimeChange: (time) {
                      setState(() {
                        _timeOfDay =
                            TimeOfDay(hour: time.hour, minute: time.minute);
                      });
                    },
                  ),
                ),
                Container(
                  width: media.width * 0.25,
                  child: Center(
                    child: Text(
                      'Minuti',
                      style: TextStyle(
                        fontFamily: 'Bold',
                        fontSize: media.width * 0.06,
                      ),
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: media.height * 0.02),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Luogo',
                  style: TextStyle(
                    fontSize: media.width * 0.05,
                    fontFamily: 'Book',
                  ),
                ),
                Container(
                  width: media.width * 0.4,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(25)),
                    border: Border.all(width: 1),
                  ),
                  child: TextField(
                    controller: TextEditingController(),
                    onChanged: (text) {
                      setState(() {
                        addedTime = int.parse(text);
                      });
                    },
                    keyboardType: TextInputType.multiline,
                    maxLines: null,
                    decoration: InputDecoration(
                      hintText: 'Inserisci luogo',
                      border: InputBorder.none,
                      focusedBorder: InputBorder.none,
                      enabledBorder: InputBorder.none,
                      errorBorder: InputBorder.none,
                      disabledBorder: InputBorder.none,
                      contentPadding: EdgeInsets.only(
                        left: 15,
                        bottom: 11,
                        top: 11,
                        right: 15,
                      ),
                    ),
                    readOnly: false,
                  ),
                ),
              ],
            ),
            SizedBox(height: media.height * 0.02),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Note',
                  style: TextStyle(
                    fontSize: media.width * 0.05,
                    fontFamily: 'Book',
                  ),
                ),
                Container(
                  width: media.width * 0.4,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(25)),
                    border: Border.all(width: 1),
                  ),
                  child: TextField(
                    controller: TextEditingController(),
                    onChanged: (text) {
                      setState(() {
                        addedTime = int.parse(text);
                      });
                    },
                    keyboardType: TextInputType.multiline,
                    maxLines: null,
                    decoration: InputDecoration(
                      hintText: 'Inserisci note',
                      border: InputBorder.none,
                      focusedBorder: InputBorder.none,
                      enabledBorder: InputBorder.none,
                      errorBorder: InputBorder.none,
                      disabledBorder: InputBorder.none,
                      contentPadding: EdgeInsets.only(
                        left: 15,
                        bottom: 11,
                        top: 11,
                        right: 15,
                      ),
                    ),
                    readOnly: false,
                  ),
                ),
              ],
            ),
          ],
        );
      } else
        return Container();
    } else
      return Container();
  }
}
