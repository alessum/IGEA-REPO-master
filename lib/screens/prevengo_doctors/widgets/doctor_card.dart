import 'package:flutter/material.dart';
import 'package:igea_app/models/doctor.dart';

class DoctorCard extends StatelessWidget {
  const DoctorCard({
    Key key,
    @required this.doctor,
    @required this.ontap,
  }) : super(key: key);

  final Doctor doctor;
  final Function(dynamic value) ontap;

  @override
  Widget build(BuildContext context) {
    Size media = MediaQuery.of(context).size;
    return Container(
      padding: EdgeInsets.all(13),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(15)),
        color: Colors.blueGrey[50],
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Container(
            height: media.height * .2,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  width: media.width * .32,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      Container(
                        height: 120,
                        width: 120,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.all(Radius.circular(15)),
                            color: Colors.orange[200]),
                      ),
                      Container(
                        height: 25,
                        width: media.width * .35,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Container(
                              width: media.width * .24,
                              child: ListView.builder(
                                scrollDirection: Axis.horizontal,
                                itemBuilder: (context, _) => Icon(
                                  Icons.star_rate_rounded,
                                  color: Colors.black87,
                                  size: 18,
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
                    ],
                  ),
                ),
                Container(
                  width: media.width * .5,
                  height: media.height * .16,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      Text(
                        doctor.name,
                        style: TextStyle(
                          fontSize: media.width * .06,
                          fontFamily: 'Book',
                        ),
                      ),
                      Text(
                        doctor.specialization,
                        style: TextStyle(
                          fontSize: media.width * .04,
                          fontFamily: 'Book',
                        ),
                      ),
                      Text(
                        doctor.address,
                        style: TextStyle(
                          fontSize: media.width * .04,
                          fontFamily: 'Book',
                        ),
                      ),
                      SizedBox(height: 5),
                      Container(
                        width: media.width * .5,
                        height: media.height * .05,
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius:
                                BorderRadius.all(Radius.circular(15))),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Container(
                              padding: EdgeInsets.all(4),
                              child: Image.network(
                                'https://i.dlpng.com/static/png/6532785_preview.png',
                                fit: BoxFit.scaleDown,
                              ),
                            ),
                            Container(
                              width: media.width * .27,
                              child: Text(doctor.clinicName),
                            )
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          Container(
            height: media.height * .05,
            decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.all(Radius.circular(25))),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  // width: media.width * .5,
                  height: media.height * .05,
                  decoration: BoxDecoration(
                      color: Colors.lightBlue[100],
                      borderRadius: BorderRadius.all(
                        Radius.circular(25),
                      )),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        height: media.height * .05,
                        width: media.width * .13,
                        margin: EdgeInsets.all(2),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(25),
                            bottomLeft: Radius.circular(25),
                            topRight: Radius.circular(10),
                            bottomRight: Radius.circular(10),
                          ),
                        ),
                        child: Center(
                          child: Icon(
                            Icons.healing_outlined,
                            size: media.width * .05,
                          ),
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.only(right: 15, left: 10),
                        child: Text(
                          doctor.medicalServices[0].name,
                          style: TextStyle(
                              fontSize: media.width * .035,
                              fontFamily: 'Book',
                              fontWeight: FontWeight.bold),
                        ),
                      )
                    ],
                  ),
                ),
                Container(
                  height: media.height * .05,
                  padding: EdgeInsets.symmetric(horizontal: 14),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(25)),
                    color: Colors.grey[300],
                  ),
                  child: Center(
                      child: Text(
                    '€ ${doctor.medicalServices[0].price.truncate()}',
                    style: TextStyle(
                        fontFamily: 'Book', fontWeight: FontWeight.bold),
                  )),
                )
              ],
            ),
          ),
          SizedBox(height: 10),
          Align(
            alignment: Alignment.centerRight,
            child: GestureDetector(
              onTap: () => ontap(dynamic),
              child: Container(
                height: media.height * .05,
                width: media.width * .4,
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.all(Radius.circular(25))),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Text(
                      'Maggiori info',
                      style: TextStyle(fontFamily: 'Book'),
                    ),
                    Icon(Icons.arrow_forward_ios_rounded)
                  ],
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
