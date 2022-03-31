import 'package:flutter/material.dart';
import 'package:igea_app/widgets/ui_components/form_circle_checkbox.dart';

class FormFieldRadioButtonRow extends StatefulWidget {
  FormFieldRadioButtonRow({Key key, @required this.label, @required this.setCheckValue})
      : super(key: key);

  final String label;
  final Function(bool checkedValue) setCheckValue;

  @override
  _FormFieldRadioButtonRowState createState() => _FormFieldRadioButtonRowState();
}

class _FormFieldRadioButtonRowState extends State<FormFieldRadioButtonRow> {
  bool _checkedNoValue = false;
  bool _checkedYesValue = false;
  bool _value; //valore risultante Yes = true - No = false

  @override
  Widget build(BuildContext context) {
    Size media = MediaQuery.of(context).size;

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: <Widget>[
        Container(
          width: media.width * 0.55,
          child: Text(
            widget.label,
            style: TextStyle(
              fontSize: media.width * 0.035,
              fontFamily: 'Bold',
            ),
          ),
        ),
        Text('Si',
            style: TextStyle(
              fontSize: media.width * 0.035,
              fontFamily: 'Book',
            )),
        GestureDetector(
          onTap: () {
            setState(() {
                _checkedYesValue = true;
                _checkedNoValue = false;
                _value = true;
                widget.setCheckValue(_value);
            });
            
          },
          child: FormCircleCheckbox(filledColor: _checkedYesValue ? Color(0xFFE8B21C) : Colors.white),
        ),
        Text('No',
            style: TextStyle(
              fontSize: media.width * 0.035,
              fontFamily: 'Book',
            )),
        GestureDetector(
          onTap: (){
            setState(() {
                _checkedNoValue = true;
                _checkedYesValue = false;
                _value = false;
              widget.setCheckValue(_value);
            });
            
          },
          child: FormCircleCheckbox(filledColor: _checkedNoValue ? Color(0xFFE8B21C) : Colors.white),
        ),
      ],
    );
  }
}
