import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class OnboardingTextInputWidget extends StatelessWidget {
  const OnboardingTextInputWidget(
    this._inputTextLabel,
    this._infoMessage,
    this._inputTextValue,
    this._changeValue,
  );

  final String _inputTextValue;
  final String _inputTextLabel;
  final String _infoMessage;
  final Function(double val) _changeValue;

  void createInfoDialog(BuildContext context, String content) {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(content: Text(content), actions: <Widget>[
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
          child: Card(
              elevation: 0.0,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(60.0)),
              color: Colors.white,
              child: Align(
                  alignment: Alignment.centerRight,
                  child: GestureDetector(
                    onTap: () {
                      createInfoDialog(context, _infoMessage);
                    },
                    child: Text('i ',
                        style: TextStyle(
                            color: Color(0xfff9dbc1),
                            fontSize: 30,
                            fontFamily: 'MarckScript',
                            fontWeight: FontWeight.w900)),
                  )))),
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
                padding: EdgeInsets.symmetric(
                    vertical: media.height < 600 ? 5 : 10.0, horizontal: 10),
                child: Text(_inputTextLabel,
                    style: TextStyle(
                        fontSize: media.height < 600 ? 15 : 20.0,
                        color: Color(0xffb3ada6),
                        fontFamily: 'FilsonSoft'))),
          ),
        ),
        Positioned(
            top: media.height < 600 ? 7 : 13.0,
            right: 8,
            child: ConstrainedBox(
                constraints: BoxConstraints(
                    maxHeight: media.height < 600 ? 25 : 30, maxWidth: media.height < 600 ? 45 : 50),
                child: TextFormField(
                  onChanged: (val) => _changeValue,
                  initialValue: _inputTextValue,
                  decoration: InputDecoration(
                    contentPadding: EdgeInsets.fromLTRB(10.0, 7.0, 10.0, 5.0),
                    hintStyle: TextStyle(
                        color: Color(0xff83b6bc), fontFamily: 'FilsonSoft'),
                    enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(18.0)),
                        borderSide:
                            BorderSide(color: Colors.white, width: 3.0)),
                    focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(18.0)),
                        borderSide:
                            BorderSide(color: Colors.white, width: 3.0)),
                  ),
                  keyboardType: TextInputType.number,
                  inputFormatters: [
                    FilteringTextInputFormatter.deny(RegExp("[.]"))
                  ],
                )))
      ])
    ]);
  }
}
