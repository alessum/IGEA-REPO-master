import 'package:flutter/material.dart';
import 'package:igea_app/models/constants/constants_graphics.dart';
import 'package:igea_app/shared/constants.dart';
import 'package:igea_app/widgets/modal_bottom_sheets/registry_input_date.dart';
import 'package:intl/intl.dart';
import 'package:intl/date_symbol_data_local.dart';

///Text box che al click richiama una funzione specifica (per esempio mostrare una finestra modale).
///Il testo nella casella viene modificato in base al contenuto della funzione richiamata
class RegistryInputBirthdayClickAction extends StatefulWidget {
  RegistryInputBirthdayClickAction({
    Key key,
    @required this.setDateOfBirth,
    @required this.initialDate,
  }) : super(key: key);

  final Function(DateTime dateOfBirth) setDateOfBirth;
  final String initialDate;

  @override
  _RegistryInputBirthdayClickActionState createState() =>
      _RegistryInputBirthdayClickActionState();
}

class _RegistryInputBirthdayClickActionState
    extends State<RegistryInputBirthdayClickAction> {
  @override
  void initState() {
    super.initState();
    initializeDateFormatting();
  }

  @override
  Widget build(BuildContext context) {
    Size media = MediaQuery.of(context).size;
    return GestureDetector(
      onTap: () {
        _buildInputDateOfBirthBottomSheet(context);
      },
      child: Container(
        height: media.height < 700 ? media.height * 0.07 : media.height * 0.05,
        width: media.width,
        padding: const EdgeInsets.fromLTRB(10.0, 5.0, 10.0, 5.0),
        decoration: BoxDecoration(
            color: Color(0xFF5C88C1),
            borderRadius: BorderRadius.all(Radius.circular(25)),
            border: Border.all(
                style: BorderStyle.solid, color: Colors.white, width: 1.5)),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Text(
              widget.initialDate != null
                  ? widget.initialDate
                  : 'Data di nascita',
              textAlign: TextAlign.left,
              style: TextStyle(
                fontSize: media.width * 0.045,
                color: Colors.white,
                fontFamily: 'Light',
              ),
            ),
            Icon(
              Icons.edit,
              color: Colors.white,
              size: 20,
            )
          ],
        ),
      ),
    );
  }

  void _buildInputDateOfBirthBottomSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.black.withOpacity(0),
      builder: (context) => ModalBottomInputDate(
        setDate: (value) {
          this.widget.setDateOfBirth(value);
          Navigator.pop(context);
        },
        titleLabel: 'Seleziona la data di nascita',
        dateFormat: 'dd-MMM-yyyy',
        colorTheme: ConstantsGraphics.COLOR_ONBOARDING_BLUE,
        limitUpToday: true,
      ),
    ).then((value) => FocusScope.of(context).requestFocus(new FocusNode()));
  }
}
