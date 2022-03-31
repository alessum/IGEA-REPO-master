import 'package:flutter/material.dart';
import 'package:igea_app/models/constants/constants_graphics.dart';
import 'package:igea_app/shared/constants.dart';

class RegitryInputFiscalCode extends StatefulWidget {
  RegitryInputFiscalCode({
    Key key,
    @required this.hintText,
    @required this.initialValue,
    //@required this.focusScopeNode,
    @required this.setInputValue,
    @required this.autocomputeFiscalCode,
  }) : super(key: key);

  final String hintText;
  final String initialValue;
  //final FocusScopeNode focusScopeNode;
  final Function(String inputValue) setInputValue;
  final bool autocomputeFiscalCode;

  @override
  _RegitryInputFiscalCodeState createState() => _RegitryInputFiscalCodeState();
}

class _RegitryInputFiscalCodeState extends State<RegitryInputFiscalCode> {
  //Color _borderColor = ConstantsGraphics.COLOR_ONBOARDING_YELLOW;
  TextEditingController _controller = TextEditingController();

  @override
  void initState() {
    super.initState();
    _controller.text = widget.initialValue;
  }

  @override
  Widget build(BuildContext context) {
    Size media = MediaQuery.of(context).size;

    if(widget.autocomputeFiscalCode){
      _controller.text = widget.initialValue;
    }

    return Container(
      height: media.height < 600 ? 30 : 40.0,
      child: TextFormField(
        controller: _controller,
        textInputAction: TextInputAction.next,
        //onEditingComplete: widget.focusScopeNode.nextFocus,
        style: TextStyle(color: Colors.white, fontFamily: 'Book'),
        decoration: textInputDecorationRegistryScreen.copyWith(
            hintText: widget.hintText,
            focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(
                  color: ConstantsGraphics.COLOR_ONBOARDING_YELLOW, width: 3),
              borderRadius: BorderRadius.all(Radius.circular(25)),
            ),
            suffixIcon: _controller.text.isEmpty
                ? Icon(
                    Icons.edit,
                    color: Colors.white,
                    size: 20,
                  )
                : GestureDetector(
                    onTap: () {
                      _controller.text = '';
                      widget.setInputValue(_controller.text);
                    },
                    child: Icon(
                      Icons.close,
                      color: Colors.white,
                      size: 20,
                    ),
                  )),
        //initialValue: widget.initialValue,
        onChanged: (val) {
          widget.setInputValue(val);
        },
      ),
    );
  }
}
