import 'package:flutter/material.dart';

class FormFieldTextRow extends StatefulWidget {
  FormFieldTextRow({
    Key key,
    @required this.label,
    @required this.hintText,
    @required this.setValue,
  }) : super(key: key);

  final Widget label;
  final String hintText;
  final Function(String value) setValue;

  @override
  _FormFieldTextRowState createState() => _FormFieldTextRowState();
}

class _FormFieldTextRowState extends State<FormFieldTextRow> {
  @override
  Widget build(BuildContext context) {
    Size media = MediaQuery.of(context).size;
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: <Widget>[
        Container(
          width: media.width * 0.55,
          child: widget.label,
          // child: Text(
          //   widget.label,
          //   style: TextStyle(
          //     fontSize: media.width * 0.035,
          //     fontFamily: 'Bold',
          //   ),
          // ),
        ),
        Stack(
          children: [
            Container(
              height: media.height < 700
                  ? media.height * 0.07
                  : media.height * 0.05,
              width: media.width * 0.25,
              padding: EdgeInsets.all(8),
              decoration: BoxDecoration(
                  color: Color(0xFFD8A31E),
                  borderRadius: BorderRadius.all(Radius.circular(25)),
                  border: Border.all(
                      style: BorderStyle.solid,
                      color: Colors.white,
                      width: 1.5)),
              child: Center(
                child: TextFormField(
                  style: TextStyle(
                      fontFamily: 'Book',
                      fontSize: media.width * 0.05,
                      color: Colors.white),
                  textAlign: TextAlign.center,
                  decoration: InputDecoration(
                    filled: false,
                    contentPadding: const EdgeInsets.fromLTRB(.0, .0, .0, 10.0),
                    errorMaxLines: 1,
                    hintText: widget.hintText,
                    hintStyle: TextStyle(
                        fontFamily: 'Book',
                        fontSize: media.width * 0.045,
                        color: Colors.white),
                    // suffixIcon: Icon(
                    //   Icons.edit,
                    //   color: Colors.white,
                    //   size: media.width * 0.05,
                    // ),
                    enabledBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: Colors.transparent),
                    ),
                    focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: Colors.transparent),
                    ),
                  ),
                  keyboardType: TextInputType.number,
                  onChanged: (val) {
                    widget.setValue(val);
                  },
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
