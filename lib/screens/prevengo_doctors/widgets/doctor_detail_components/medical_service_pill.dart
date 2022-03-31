import 'package:flutter/material.dart';
import 'package:igea_app/models/medical_service.dart';

class MedicalServicePill extends StatelessWidget {
  const MedicalServicePill({
    Key key,
    @required this.medicalService,
  }) : super(key: key);

  final MedicalService medicalService;

  @override
  Widget build(BuildContext context) {
    Size media = MediaQuery.of(context).size;
    return Container(
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.all(Radius.circular(25))),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            padding: EdgeInsets.only(left: 10),
            child: Text(
              medicalService.name,
              style: TextStyle(
                fontFamily: 'Book',
              ),
            ),
          ),
          SizedBox(width: 8),
          Container(
            padding: EdgeInsets.all(5),
            height: media.height * .05,
            margin: EdgeInsets.all(1),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(25)),
                color: Colors.grey[200]),
            child: Center(
                child: Text(
              '€ ${medicalService.price.truncate()}',
              style: TextStyle(
                fontFamily: 'Book',
                fontWeight: FontWeight.bold,
              ),
            )),
          )
        ],
      ),
    );
  }
}
