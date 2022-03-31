import 'package:circular_check_box/circular_check_box.dart';
import 'package:flutter/material.dart';

class OnboardingCheckBoxInputWidget extends StatelessWidget {
  const OnboardingCheckBoxInputWidget(
    this._inputTextLabel,
    this._infoMessage,
    this._checkValue,
    this._changeValue,
  );

  final bool _checkValue;
  final String _inputTextLabel;
  final String _infoMessage;
  final Function() _changeValue;

  void _createInfoDialog(BuildContext context, String content) {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
              //title: Text('Inserisci il Comune di nascita'),
              content: Text(content),
              actions: <Widget>[
                MaterialButton(
                  elevation: 5.0,
                  child: Text('Ho capito'),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                )
              ]);
        });
  }

  @override
  Widget build(BuildContext context) {
    Size media = MediaQuery.of(context).size;
    return Stack(overflow: Overflow.visible, children: <Widget>[
      Container(
        color: Colors.transparent,
        height: media.height < 600 ? 40 : 55.0,
        child: Padding(
          padding: EdgeInsets.symmetric(vertical: 0.0),
          child: Card(
            elevation: 0.0,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(60.0)),
            color: Colors.white,
            child: Align(
              alignment: Alignment.centerRight,
              child: GestureDetector(
                onTap: () {
                  _createInfoDialog(context, _infoMessage);
                },
                child: Text('i ',
                    style: TextStyle(
                        color: Color(0xfff9dbc1),
                        fontSize: 30,
                        fontFamily: 'MarckScript',
                        fontWeight: FontWeight.w900)),
              ),
            ),
          ),
        ),
      ),
      Stack(children: <Widget>[
        Container(
          color: Colors.transparent,
          height: media.height < 600 ? 40 : 55.0,
          width: media.height < 600 ? 200 : 250.0,
          child: Card(
            elevation: 0.0,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(30.0)),
            color: Color(0xfff9dbc1),
            child: Padding(
                padding: EdgeInsets.symmetric(vertical: media.height < 600 ? 5 : 10.0, horizontal: 10),
                child: Text('$_inputTextLabel',
                    style: TextStyle(
                        fontSize: media.height < 600 ? 15 : 20.0,
                        color: Color(0xffb3ada6),
                        fontFamily: 'FilsonSoft'))),
          ),
        ),
        Positioned(
          top: media.height < 600 ? 7 : 14.0,
          right: 20,
          child: ConstrainedBox(
            constraints: BoxConstraints(maxHeight: 26, maxWidth: 26),
            child: Container(
              decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(color: Colors.white, width: 3.0)),
              child: CircularCheckBox(
                  disabledColor: Color(0xfff9c397),
                  activeColor: Color(0xfff9c397),
                  inactiveColor: Colors.white,
                  value: _checkValue,
                  materialTapTargetSize: MaterialTapTargetSize.padded,
                  onChanged: (_) => _changeValue()),
            ),
          ),
        ),
      ]),
    ]);
  }
}
