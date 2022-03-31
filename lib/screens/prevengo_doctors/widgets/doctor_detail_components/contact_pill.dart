import 'package:flutter/material.dart';

class ContactPill extends StatelessWidget {
  const ContactPill({
    Key key,
    @required this.contact,
    @required this.contactIcon,
  }) : super(key: key);

  final String contact;
  final Icon contactIcon;

  @override
  Widget build(BuildContext context) {
    Size media = MediaQuery.of(context).size;
    return Align(
      alignment: Alignment.topLeft,
      child: Container(
          margin: EdgeInsets.only(left: media.width * .05),
          width: media.width * .5,
          padding: EdgeInsets.fromLTRB(15, 4, 2, 4),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.all(
                Radius.circular(25),
              ),
              color: Colors.white),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(contact,
                  style: TextStyle(
                      fontFamily: 'Book', fontSize: media.width * .04)),
              Container(
                padding: EdgeInsets.all(4),
                decoration: BoxDecoration(
                    shape: BoxShape.circle, color: Colors.lightBlue[100]),
                child: Center(
                  child: contactIcon
                ),
              )
            ],
          )),
    );
  }
}
