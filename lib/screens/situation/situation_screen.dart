import 'package:flutter/material.dart';
import 'package:igea_app/models/organ.dart';
import 'package:igea_app/widgets/organ_list.dart';

class SituationModalBottomSheet extends StatelessWidget {
  SituationModalBottomSheet({
    Key key,
    this.organList,
    this.organKey,
  }) : super(key: key);

  final Map<String, Organ> organList;
  final String organKey;

  @override
  Widget build(BuildContext context) {
    var media = MediaQuery.of(context).size;
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.all(Radius.circular(25)),
      ),
      margin: EdgeInsets.all(8),
      padding: EdgeInsets.symmetric(vertical: 12),
      height: MediaQuery.of(context).size.height * 0.43,
      width: MediaQuery.of(context).size.width,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Padding(
            padding: EdgeInsets.all(20),
            child: Text(
              'Situazione',
              style: TextStyle(
                fontSize: media.width * 0.07,
                fontFamily: 'Gotham',
              ),
            ),
          ),
          Expanded(
            child: OrganList(
              initialPage: int.parse(organKey),
              organList: organList,
            ),
          )
        ],
      ),
    );
  }
}
