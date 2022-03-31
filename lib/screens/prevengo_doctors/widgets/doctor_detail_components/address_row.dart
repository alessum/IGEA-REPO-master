import 'package:flutter/material.dart';

class DoctorAddressRow extends StatelessWidget {
  const DoctorAddressRow({
    Key key,
    @required this.address,
  }) : super(key: key);

  final String address;

  @override
  Widget build(BuildContext context) {
    Size media = MediaQuery.of(context).size;
    return Container(
      padding: EdgeInsets.symmetric(horizontal: media.width * .06),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Container(
            width: media.width * .4,
            child: Text(
              address,
              style: TextStyle(
                fontSize: media.width * .04,
                fontFamily: 'Book',
              ),
            ),
          ),
          Container(
            height: media.height * .05,
            width: media.width * .3,
            decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.all(Radius.circular(25))),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 8.0),
                  child: Text(
                    'Apri in\nmappe ',
                    style: TextStyle(
                      fontSize: media.width * .03,
                      fontFamily: 'Book',
                    ),
                  ),
                ),
                Container(
                  padding: EdgeInsets.all(5),
                  height: media.height * .05,
                  decoration: BoxDecoration(
                      color: Colors.lightBlue[100],
                      borderRadius: BorderRadius.all(Radius.circular(25))),
                  child: Center(
                      child: Text(
                    '12 Km',
                    style: TextStyle(
                      fontFamily: 'Book',
                      fontWeight: FontWeight.bold,
                    ),
                  )),
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
