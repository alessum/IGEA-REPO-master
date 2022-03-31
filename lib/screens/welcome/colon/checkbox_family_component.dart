import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class CheckboxFamilyComponent extends StatelessWidget {
  const CheckboxFamilyComponent({
    Key key,
    @required this.name,
    @required this.isChecked,
    @required this.updateForm,
  }) : super(key: key);

  final String name;
  final bool isChecked;
  final Function() updateForm;

  final Color _checkedColor = const Color(0xFFD8A31E);
  final Color _nonCheckedColor = const Color(0xFFEEE7D0);

  @override
  Widget build(BuildContext context) {
    Size media = MediaQuery.of(context).size;
    return GestureDetector(
      onTap: () {
        updateForm();
      },
          child: Container(
          width: media.width * 0.4,
          child: Stack(
            children: <Widget>[
              Align(
                alignment: Alignment.bottomCenter,
                child: Container(
                  padding: EdgeInsets.only(top: 12, left: 15),
                  height: 55,
                  decoration: BoxDecoration(
                      color: isChecked ? _checkedColor : _nonCheckedColor,
                      borderRadius: BorderRadius.all(Radius.circular(15))),
                  child: Align(
                    alignment: Alignment.bottomLeft,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: <Widget>[
                        Container(
                            width: 15,
                            child: CircleAvatar(
                              backgroundColor: Color(0xFF5C88C1),
                            )),
                        SizedBox(width: 10),
                        Text(
                          name,
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: media.width * 0.045),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              Positioned(
                bottom: 25,
                right: 20,
                child: name == 'Papà'
                    ? SvgPicture.asset(
                        'assets/avatars/Papa.svg',
                        height: media.height * 0.045,
                      )
                    : SvgPicture.asset(
                        'assets/' + name + '.svg',
                        height: media.height * 0.045,
                      ),
              )
            ],
          )),
    );
  }
}
