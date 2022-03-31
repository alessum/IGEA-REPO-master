import 'package:flutter/material.dart';
import 'package:flutter_time_picker_spinner/flutter_time_picker_spinner.dart';
import 'package:igea_app/widgets/ui_components/button_rounded_confirmation.dart';

class ModalBottomInputTimeSpinner extends StatefulWidget {
  ModalBottomInputTimeSpinner({
    Key key,
    @required this.colorTheme,
    @required this.setTime,
    @required this.titleLabel,
    this.initialTime,
  }) : super(key: key);


  final DateTime initialTime;
  final String titleLabel;
  final Color colorTheme;
  final Function(TimeOfDay timeOfDay) setTime;

  @override
  _ModalBottomInputTimeSpinnerState createState() =>
      _ModalBottomInputTimeSpinnerState();
}

class _ModalBottomInputTimeSpinnerState
    extends State<ModalBottomInputTimeSpinner> {
  TimeOfDay _timeOfDay;

  @override
  Widget build(BuildContext context) {
    Size media = MediaQuery.of(context).size;
    return Container(
      height: media.height * 0.4,
      padding: EdgeInsets.fromLTRB(15, 8, 15, 8),
      margin: EdgeInsets.all(8),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(25),
        color: Colors.white,
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            height: 3,
            width: media.width * 0.25,
            decoration: BoxDecoration(
              color: Colors.grey[600],
              borderRadius: BorderRadius.circular(25),
            ),
          ),
          SizedBox(
            height: media.height * 0.02,
          ),
          Container(
            child: Text(
              widget.titleLabel,
              style: TextStyle(
                fontSize: media.width * 0.05,
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
                  time: widget.initialTime ?? DateTime.now(),
                  normalTextStyle: TextStyle(
                      fontFamily: 'Book',
                      fontSize: media.width * 0.05,
                      color: Colors.black),
                  highlightedTextStyle: TextStyle(
                    fontFamily: 'Bold',
                    fontSize: media.width * 0.05,
                    color: widget.colorTheme,
                  ),
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
          GestureDetector(
            onTap: () {
              widget.setTime(_timeOfDay);
            },
            child: ButtonRoundedConfirmation(
              label: 'Conferma',
              buttonColor: widget.colorTheme,
            ),
          )
        ],
      ),
    );
  }
}
