import 'package:flutter/material.dart';

class DoctorHeader extends StatelessWidget {
  const DoctorHeader({
    Key key,
    @required this.doctorName,
    @required this.doctorSpecialization,
  }) : super(key: key);

  final String doctorName;
  final String doctorSpecialization;

  @override
  Widget build(BuildContext context) {
    Size media = MediaQuery.of(context).size;
    return Align(
      alignment: Alignment.topLeft,
      child: Container(
        width: media.width * .9,
        height: media.height * .15,
        decoration: BoxDecoration(
          color: Colors.orange[200],
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(media.width * .2),
            bottomRight: Radius.circular(25),
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Container(
              child: Image.asset(
                'assets/icons/doctor.png',
                width: media.width * .2,
              ),
            ),
            Container(
              padding: EdgeInsets.symmetric(vertical: 13),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    doctorName,
                    style: TextStyle(
                      fontSize: media.width * .06,
                      fontFamily: 'Book',
                    ),
                  ),
                  Container(
                    height: 25,
                    width: media.width * .38,
                    // padding: EdgeInsets.only(left: 5),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Container(
                          width: media.width * .27,
                          child: ListView.builder(
                            scrollDirection: Axis.horizontal,
                            itemBuilder: (context, _) => Icon(
                              Icons.star_rate_rounded,
                              color: Colors.black87,
                              size: media.width * .055,
                            ),
                            physics: NeverScrollableScrollPhysics(),
                            itemCount: 5,
                          ),
                        ),
                        Container(
                          child: Text(
                            '(21)',
                            style: TextStyle(
                              fontFamily: 'Bold',
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 15),
                  Text(
                    doctorSpecialization,
                    style: TextStyle(
                      fontSize: media.width * .04,
                      fontFamily: 'Book',
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
