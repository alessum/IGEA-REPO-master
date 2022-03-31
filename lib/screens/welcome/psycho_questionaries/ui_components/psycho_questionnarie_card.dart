import 'package:flutter/material.dart';

class PsychoQuestionnarieCard extends StatelessWidget {
  final String title;
  final String description;
  final Function() onStart;

  const PsychoQuestionnarieCard({
    Key key,
    @required this.title,
    @required this.description,
    @required this.onStart,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size media = MediaQuery.of(context).size;
    return Container(
      // height: media.height * 0.022,
      margin: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      padding: EdgeInsets.symmetric(horizontal: 15, vertical: 15),
      decoration: BoxDecoration(
          color: Color(0x22000000),
          borderRadius: BorderRadius.all(Radius.circular(25))),
      child: Column(
        children: [
          Row(
            children: [
              Text(
                title,
                style: TextStyle(
                    fontFamily: 'Gotham',
                    color: Colors.white,
                    fontSize: media.height * 0.025),
              ),
              SizedBox(
                width: 10,
              )
            ],
          ),
          SizedBox(
            height: media.height * 0.01,
          ),
          Text(
            description,
            style: TextStyle(
                fontFamily: 'Book',
                color: Colors.white,
                height: media.height * 0.0015,
                fontSize: media.height * 0.02),
          ),
          SizedBox(
            height: media.height * 0.02,
          ),
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              // _check
              //     ? SvgPicture.asset(
              //         'assets/icons/check_in_circle.svg',
              //         width: 30.0,
              //         height: 30.0,
              //       )
              //     : Container(
              //         width: 30.0,
              //         height: 30.0,
              //         decoration: new BoxDecoration(
              //           color: Colors.transparent,
              //           shape: BoxShape.circle,
              //         ),
              //       ),
              SizedBox(
                width: media.width * 0.3,
              ),
              GestureDetector(
                onTap: () => onStart(),
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 20, vertical: 5),
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.all(Radius.circular(25))),
                  child: Text(
                    'Avvia',
                    style: TextStyle(
                        fontFamily: 'Gotham',
                        color: Color(0xff6DAEBF),
                        height: media.height * 0.0015,
                        fontSize: media.height * 0.025),
                  ),
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}
