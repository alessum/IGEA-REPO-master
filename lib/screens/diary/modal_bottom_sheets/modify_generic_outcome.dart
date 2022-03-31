import 'package:flutter/material.dart';
import 'package:igea_app/models/camera_file_manager.dart';
import 'package:igea_app/models/constants/constants_graphics.dart';
import 'package:igea_app/models/enums/screening_outcome_value.dart';
import 'package:igea_app/screens/camera/camera_screen.dart';
import 'package:igea_app/widgets/modal_bottom_sheets/registry_input_date.dart';
import 'package:igea_app/widgets/ui_components/close_line_top_modal.dart';
import 'package:intl/intl.dart';

class ModalBottomModifyGenericOutcome extends StatefulWidget {
  ModalBottomModifyGenericOutcome({
    Key key,
    @required this.onUpdateOutcome,
    @required this.initialDate,
  }) : super(key: key);

  final Function(DateTime reservationDate, String description) onUpdateOutcome;
  final String initialDate;

  @override
  _ModalBottomModifyGenericOutcomeState createState() =>
      _ModalBottomModifyGenericOutcomeState();
}

class _ModalBottomModifyGenericOutcomeState
    extends State<ModalBottomModifyGenericOutcome> {
  ScreeningOutcomeValue _outcomeValue;
  bool _isGoodOutcome;
  DateTime _reservationDate;
  String _description;

  @override
  Widget build(BuildContext context) {
    Size media = MediaQuery.of(context).size;
    return Padding(
      padding:
          EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
      child: Container(
        margin: EdgeInsets.all(8),
        padding: EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.all(Radius.circular(25)),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            CloseLineTopModal(color: Colors.grey[600]),
            SizedBox(height: media.height * .02),
            Row(
              children: [
                Container(
                  child: Text(
                    'Modifica Esito',
                    style: TextStyle(
                      fontSize: media.width * 0.07,
                      fontFamily: 'Bold',
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: media.height * .03),
            Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text('Descrizione: ',
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
                          decoration: BoxDecoration(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(25)),
                              color: Colors.grey[200]),
                        ),
                        TextField(
                          // controller: _placeTextController,
                          onChanged: (text) {
                            setState(() {
                              _description = text;
                            });
                          },
                          keyboardType: TextInputType.multiline,
                          maxLines: null,
                          decoration: const InputDecoration(
                              hintText: 'Inserire descrizione',
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
            SizedBox(height: media.height * .02),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Container(
                  width: media.width * 0.3,
                  child: Text('Data: ',
                      style: TextStyle(
                          fontFamily: 'Book',
                          fontSize: media.width * 0.05,
                          color: Color(0xFF757575))),
                ),
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
                        titleLabel: 'Inserisci la data dell\'esame ',
                        dateFormat: 'dd-MMM-yyyy',
                        colorTheme: ConstantsGraphics.COLOR_DIARY_BLUE,
                        initialDate: DateTime.now(),
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
                        color: Colors.grey[200]),
                    child: Text(
                      _reservationDate != null
                          ? DateFormat('yMMMd', 'it').format(_reservationDate)
                          : widget.initialDate,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: media.width * 0.04,
                        fontFamily: 'Book',
                      ),
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: media.height * .04),
            GestureDetector(
              onTap: () {
                widget.onUpdateOutcome(_reservationDate, _description);
              },
              child: Container(
                padding: EdgeInsets.all(15),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(25)),
                  color: ConstantsGraphics.COLOR_DIARY_BLUE,
                ),
                child: Center(
                  child: Text(
                    'Conferma',
                    style: TextStyle(
                      fontSize: media.width * 0.055,
                      fontFamily: 'Gotham',
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
