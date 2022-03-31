import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:igea_app/blocs/situation_bloc.dart';
import 'package:igea_app/models/constants/constants.dart';
import 'package:igea_app/models/organ.dart';
import 'package:igea_app/models/reservable_test.dart';

class OrganDetail extends StatefulWidget {
  OrganDetail(
      {Key key,
      @required this.organ,
      @required this.organKey,
      @required this.expanded,
      @required this.value})
      : super(key: key);
  final Organ organ;
  final String organKey;
  final bool expanded;
  final double value;
  @override
  _OrganDetailState createState() => _OrganDetailState();
}

class _OrganDetailState extends State<OrganDetail> {
  SituationBloc situationBloc;
  @override
  void dispose() {
    super.dispose();
  }

  @override
  void didChangeDependencies() {
    // situationBloc = SituationBlocProvider.of(context);
    super.didChangeDependencies();
  }

  @override
  void initState() {
    super.initState();
  }

  List<ReservableTest> filterHeartRevervableTestList(
      List<ReservableTest> testList) {
    List<ReservableTest> heartRevervableTestList = [];
    testList.forEach((v) {
      if (Constants.HEART_TESTS.contains(v.type)) {
        heartRevervableTestList.add(v);
      }
    });
    return heartRevervableTestList;
  }

  List<ReservableTest> filterVesselsRevervableTestList(
      List<ReservableTest> testList) {
    List<ReservableTest> vesselsRevervableTestList = [];
    testList.forEach((v) {
      if (Constants.VESSELS_TESTS.contains(v.type)) {
        vesselsRevervableTestList.add(v);
      }
    });
    return vesselsRevervableTestList;
  }

  @override
  Widget build(BuildContext context) {
    double mediaHeight = MediaQuery.of(context).size.height;
    double mediaWidth = MediaQuery.of(context).size.width;

    List<ReservableTest> heartRevervableTestList =
        filterHeartRevervableTestList(widget.organ.reservableTestList);
    List<ReservableTest> vesselsRevervableTestList =
        filterVesselsRevervableTestList(widget.organ.reservableTestList);

    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: <Widget>[
        Container(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Padding(
                padding: const EdgeInsets.all(15),
                child: SvgPicture.asset(
                  '${widget.organ.imagePath}',
                  width: (() {
                    if (widget.organ.imagePath == 'assets/icons/utero.svg')
                      return mediaWidth * 0.24;
                    else if (widget.organ.imagePath == 'assets/icons/heart.svg')
                      return mediaWidth * 0.15;
                    else
                      return mediaWidth * 0.18;
                  }()),
                  color: widget.organ.imagePath.contains('vaccine')
                      ? Colors.white
                      : null,
                  // height: widget.organ.imagePath == 'assets/icons/utero.svg'
                  //     ? mediaHeight * 0.15
                  //     : widget.organ.imagePath == 'assets/icons/heart.svg'
                  //         ? mediaHeight * 0.18
                  //         : mediaHeight * 0.23,
                  fit: BoxFit.cover,
                ),
              ),
              Container(
                // height: mediaHeight * widget.value * 0.09,
                // width: mediaWidth * widget.value * 0.325,
                height: mediaHeight * 0.11,
                width: mediaWidth * 0.31,
                child: Padding(
                  padding: const EdgeInsets.all(4.0),
                  child: Text(
                    widget.organ.name,
                    textAlign: TextAlign.right,
                    style: TextStyle(
                        fontSize: widget.organ.imagePath == 'assets/icons/heart.svg'
                            ? mediaWidth * 0.035
                            : widget.organ.imagePath == 'assets/icons/utero.svg'
                                ? mediaWidth * 0.045
                                : mediaWidth * 0.05,
                        // fontSize: mediaWidth * widget.value * 0.055,
                        color: Colors.white,
                        fontFamily: 'Bold'),
                  ),
                ),
              ),
            ],
          ),
        ),
        ListTile(
          trailing: SvgPicture.asset(
            '${widget.organ.status.iconPath}',
            fit: BoxFit.cover,
            width: mediaWidth * 0.1,
          ),
          title: Text(
            widget.organ.status.message,
            textAlign: TextAlign.left,
            style: TextStyle(
                fontSize: mediaWidth * 0.05,
                fontFamily: 'Bold',
                color: Colors.white),
          ),
        )
      ],
    );
  }
}
