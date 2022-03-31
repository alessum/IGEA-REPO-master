import 'package:flutter/material.dart';
import 'package:igea_app/widgets/ui_components/button_radio_text_container.dart';

class FormFieldRadioContainerRow extends StatefulWidget {
  FormFieldRadioContainerRow({
    Key key,
    @required this.label1,
    @required this.label2,
    @required this.setCheckedValue,
    this.buttonColor,
  }) : super(key: key);

  final String label1, label2;
  final Color buttonColor;

  /// **Descrizione**
  /// Setta entrambi i valori (quelli passati come parametro) del widget padre,
  /// con il nuovo valore modificato al click del pulsante.
  /// Pesanta per gestire soltato DUE scelte (per esempio etnia afro americana o altra etnia)
  final Function(bool value1, bool value2) setCheckedValue;

  @override
  _FormFieldRadioContainerRowState createState() =>
      _FormFieldRadioContainerRowState();
}

class _FormFieldRadioContainerRowState
    extends State<FormFieldRadioContainerRow> {
  bool chkValue1 = false;
  bool chkValue2 = false;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: <Widget>[
        GestureDetector(
          onTap: () => setState(() {
            chkValue1 = true;
            chkValue2 = false;
            widget.setCheckedValue(chkValue1, chkValue2);
          }),
          child: ButtonRadioTextContainer(
            label: widget.label1,
            checked: chkValue1,
            nonCheckedColor: widget.buttonColor,
          ),
        ),
        GestureDetector(
          onTap: () => setState(() {
            chkValue1 = false;
            chkValue2 = true;
            widget.setCheckedValue(chkValue1, chkValue2);
          }),
          child: ButtonRadioTextContainer(
            label: widget.label2,
            checked: chkValue2,
            nonCheckedColor: widget.buttonColor,
          ),
        )
      ],
    );
  }
}
