import 'package:flutter/material.dart';
import 'package:flutter_holo_date_picker/flutter_holo_date_picker.dart';
import 'package:flutter_holo_date_picker/widget/date_picker_widget.dart';
import 'package:igea_app/widgets/ui_components/button_rounded_confirmation.dart';

class ModalBottomInputDate extends StatefulWidget {
  ModalBottomInputDate({
    Key key,
    @required this.setDate,
    @required this.titleLabel,
    @required this.dateFormat,
    @required this.colorTheme,
    @required this.limitUpToday,
    this.initialDate,
  }) : super(key: key);

  final Function(DateTime dateOfBirth) setDate;
  final DateTime initialDate;
  final String titleLabel;
  final String dateFormat;
  final Color colorTheme;
  final bool limitUpToday;

  @override
  _ModalBottomInputDateState createState() => _ModalBottomInputDateState();
}

class _ModalBottomInputDateState extends State<ModalBottomInputDate> {
  DateTime _selectedDate;
  DateTime _dateUpLimit = DateTime(DateTime.now().year + 10);
  DateTime _dateDownLimit = DateTime(DateTime.now().year - 90);

  @override
  void initState() {
    super.initState();
    _selectedDate = widget.initialDate ??
        (widget.limitUpToday ? DateTime(1991, 10, 12) : DateTime.now());
  }

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
          DatePickerWidget(
            looping: false, // default is not looping
            firstDate: widget.limitUpToday ? _dateDownLimit : DateTime.now(),
            lastDate: widget.limitUpToday ? DateTime.now() : _dateUpLimit,
            initialDate: widget.initialDate ??
                (widget.limitUpToday ? DateTime(1991, 10, 12) : DateTime.now()),
            dateFormat: widget.dateFormat,
            locale: DatePicker.localeFromString('it'),
            onChange: (DateTime newDate, _) => _selectedDate = newDate,
            pickerTheme: DateTimePickerTheme(
              itemTextStyle: TextStyle(
                color: Colors.black,
                fontSize: 23,
              ),
              dividerColor: widget.colorTheme,
            ),
          ),
          GestureDetector(
            onTap: () {
              widget.setDate(_selectedDate);
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
