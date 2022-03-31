import 'package:flutter/material.dart';
import 'package:igea_app/models/enums/gender.dart';
import 'package:igea_app/widgets/modal_bottom_sheets/registry_input_gender.dart';

class RegistryInputGenderClickAction extends StatefulWidget {
  RegistryInputGenderClickAction({
    Key key,
    @required this.setGender,
    @required this.initalGenderValue,
  }) : super(key: key);

  final Function(Gender gender) setGender;
  final int initalGenderValue;

  @override
  _RegistryInputGenderClickActionState createState() =>
      _RegistryInputGenderClickActionState();
}

class _RegistryInputGenderClickActionState
    extends State<RegistryInputGenderClickAction> {
  @override
  Widget build(BuildContext context) {
    Size media = MediaQuery.of(context).size;
    return Container(
      height: media.height < 600 ? 30 : 40.0,
      child: GestureDetector(
        onTap: () {
          buildGenderInput();
        },
        child: Container(
          height:
              media.height < 700 ? media.height * 0.07 : media.height * 0.05,
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
                _convertGenderToString(),
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
      ),
    );
  }

  buildGenderInput() {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.black.withOpacity(0),
      builder: (_) => ModalBottomInputGender(
        setGender: (value) {
          this.widget.setGender(value);
        },
      ),
    ).then((value) => FocusScope.of(context).requestFocus(new FocusNode()));
  }

  String _convertGenderToString() {
    switch (widget.initalGenderValue) {
      case 0:
        print('Maschio');
        return 'Maschio';
        break;
      case 1:
        print('Femmina');
        return 'Femmina';
        break;
      default:
        return 'Sesso';
    }
  }
}
