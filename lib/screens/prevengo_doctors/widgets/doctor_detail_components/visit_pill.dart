import 'package:flutter/material.dart';

class VisitPill extends StatelessWidget {
  const VisitPill({ Key key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size media = MediaQuery.of(context).size;
    return Container(
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
                          'Visita cardiologica',
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
                    '€ 120',
                    style: TextStyle(
                        fontFamily: 'Book', fontWeight: FontWeight.bold),
                  )),
                )
              ],
            ),
          );
  }
}