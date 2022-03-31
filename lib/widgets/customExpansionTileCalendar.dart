import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:igea_app/blocs/bloc_calendar.dart';
import 'package:igea_app/models/constants/constants_graphics.dart';
import 'package:igea_app/models/test.dart';
import 'package:igea_app/screens/calendar/modalBottomSheets/modify_reservation.dart';
import 'package:igea_app/widgets/modal_bottom_sheets/confirmation_alert.dart';
import 'package:intl/intl.dart';
import 'package:tuple/tuple.dart';

import 'modal_bottom_sheets/prevengo_modal_confirmation.dart';

class CustomExpansionTileCalendar extends StatefulWidget {
  CustomExpansionTileCalendar({
    @required this.testData,
    this.onModify,
  });

  final Tuple2<String, Test> testData;
  final Function() onModify;

  @override
  _CustomExpansionTileCalendarState createState() =>
      _CustomExpansionTileCalendarState();
}

class _CustomExpansionTileCalendarState
    extends State<CustomExpansionTileCalendar>
    with SingleTickerProviderStateMixin {
  AnimationController _controller;
  Animation<double> _expandAnimation;
  Animation<double> _rotateAnimation;
  bool _expand = true;

  @override
  void initState() {
    super.initState();
    prepareAnimations();
    //_runExpandCheck();
  }

  ///Setting up the animation
  void prepareAnimations() {
    _controller =
        AnimationController(vsync: this, duration: Duration(milliseconds: 200));
    Animation curve = CurvedAnimation(
      parent: _controller,
      curve: Curves.ease,
    );
    _expandAnimation = Tween(begin: 0.0, end: 1.0).animate(curve)
      ..addListener(() {
        setState(() {});
      });
    _rotateAnimation = Tween(begin: 0.0, end: pi / 2).animate(curve)
      ..addListener(() {
        setState(() {});
      });
  }

  void _runExpandCheck() {
    if (_expand) {
      _controller.forward();
    } else {
      _controller.reverse();
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  CalendarBloc bloc;

  @override
  Widget build(BuildContext context) {
    Size media = MediaQuery.of(context).size;

    bloc = CalendarBlocProvider.of(context);

    return Container(
      child: Stack(
        alignment: Alignment.topCenter,
        children: <Widget>[
          Padding(
            padding: EdgeInsets.fromLTRB(
                .0,
                media.height * 0.02 + widget.testData.item2.name.length,
                0.0,
                0.0),
            child: SizeTransition(
              axisAlignment: 1.0,
              sizeFactor: _expandAnimation,
              child: Container(
                height: media.height * 0.3,
                width: double.maxFinite,
                child: Card(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.only(
                        bottomRight: Radius.circular(22),
                        bottomLeft: Radius.circular(22)),
                  ),
                  elevation: 0,
                  color: Color.alphaBlend(
                      Colors.white60, ConstantsGraphics.COLOR_CALENDAR_CYAN),
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(18.0, 40.0, 10.0, 10.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        CalendarDetailRowItem(
                          iconPath: ConstantsGraphics.CALENDAR_TIME_ICON,
                          textContent: DateFormat.Hm()
                              .format(widget.testData.item2.reservation.date),
                        ),
                        CalendarDetailRowItem(
                          iconPath: ConstantsGraphics.CALENDAR_LOCATION_ICON,
                          textContent:
                              widget.testData.item2.reservation.locationName ??
                                  'Nessun luogo specificato',
                        ),
                        CalendarDetailRowItem(
                          iconPath: ConstantsGraphics.CALENDAR_NOTES_ICON,
                          textContent:
                              widget.testData.item2.reservation.description ??
                                  'Nessuna nota',
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            GestureDetector(
                              onTap: () => _showModifyReservation(
                                  context, widget.testData.item2),
                              child: Container(
                                width: media.width * 0.3,
                                decoration: BoxDecoration(
                                    color:
                                        ConstantsGraphics.COLOR_ONBOARDING_CYAN,
                                    borderRadius: BorderRadius.all(
                                      Radius.circular(25),
                                    )),
                                padding: EdgeInsets.all(10),
                                child: Center(
                                  child: Text(
                                    'Modifica',
                                    style: TextStyle(
                                        fontSize: media.width * 0.05,
                                        fontFamily: 'Bold',
                                        color: Colors.white),
                                  ),
                                ),
                              ),
                            ),
                            GestureDetector(
                              onTap: () =>
                                  _showDeleteReservationConfirmation(context),
                              child: Container(
                                width: media.width * 0.3,
                                decoration: BoxDecoration(
                                    color:
                                        ConstantsGraphics.COLOR_ONBOARDING_CYAN,
                                    borderRadius: BorderRadius.all(
                                      Radius.circular(25),
                                    )),
                                padding: EdgeInsets.all(10),
                                child: Center(
                                  child: Text(
                                    'Elimina',
                                    style: TextStyle(
                                        fontSize: media.width * 0.05,
                                        fontFamily: 'Bold',
                                        color: Colors.white),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
          GestureDetector(
            onTap: () {
              setState(() {
                _expand = !_expand;
              });
              _runExpandCheck();
            },
            child: Container(
              padding: EdgeInsets.all(12),
              width: double.maxFinite,
              decoration: BoxDecoration(
                color: ConstantsGraphics.COLOR_CALENDAR_CYAN,
                borderRadius: BorderRadius.all(Radius.circular(25)),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Container(
                    width: media.width * 0.38,
                    child: Text(
                      widget.testData.item2.name.toUpperCase(),
                      style: TextStyle(
                        fontSize: media.width * 0.04,
                        fontFamily: 'Gotham',
                        color: Colors.white,
                      ),
                    ),
                  ),
                  Row(
                    children: <Widget>[
                      FittedBox(
                        fit: BoxFit.fitWidth,
                        child: Text(
                          DateFormat('d/M/y')
                              .format(widget.testData.item2.reservation.date),
                          style: TextStyle(
                            fontSize: media.width * 0.045,
                            fontFamily: 'Book',
                            color: Colors.white,
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 5.0, right: 10.0),
                        child: Container(
                          decoration: BoxDecoration(
                              shape: BoxShape.circle, color: Colors.white),
                          child: Transform.rotate(
                              angle: _rotateAnimation.value,
                              child: Icon(Icons.expand_more,
                                  color: Color(0xff7ccddb))),
                        ),
                      )
                    ],
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }

  _showModifyReservation(BuildContext context, Test test) {
    showModalBottomSheet(
      context: context,
      builder: (context) => ModalBottomModifyReservation(
        test: test,
        setReservationValues: (reservationValues) {
          test.reservation.date = reservationValues.item1;
          test.reservation.locationName = reservationValues.item2;
          test.reservation.description = reservationValues.item3;
          bloc.updateTest.add(
            Tuple2<String, Test>(
              widget.testData.item1,
              test,
            ),
          );
          Navigator.pop(context);
          showModalBottomSheet(
            context: context,
            builder: (context) => PrevengoModalConfirmation(
              title: 'Promemoria modificato!',
              iconPath: 'assets/avatars/arold_in_circle.svg',
              message: 'Ho modificato il promemoria dal calenadario',
              colorTheme: ConstantsGraphics.COLOR_CALENDAR_CYAN,
              popScreensNumber: 1,
            ),
            backgroundColor: Colors.black.withOpacity(0),
            isScrollControlled: true,
          ).then((_) => widget.onModify());
        },
      ),
      backgroundColor: Colors.black.withOpacity(0),
      isScrollControlled: true,
    );
  }

  _showDeleteReservationConfirmation(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (context) => ModalBottomConfirmation(
          confirmationLabel:
              'Sei sicuro di voler eliminare il promemoria del senguente esame: ${widget.testData.item2.name}',
          onPress: (isYes) {
            if (isYes) {
              bloc.inDeleteTest.add(widget.testData);
              Navigator.pop(context);
              showModalBottomSheet(
                context: context,
                builder: (context) => StreamBuilder<Widget>(
                  stream: bloc.getAlgorithmResult,
                  builder: (context, snapshot) => snapshot.hasData
                      ? snapshot.data
                      : Container(
                          child: Center(
                            child: CircularProgressIndicator(),
                          ),
                        ),
                ),
                backgroundColor: Colors.black.withOpacity(0),
                isScrollControlled: true,
              ).then((_) => widget.onModify());
            } else {
              Navigator.pop(context);
            }
          }),
      backgroundColor: Colors.black.withOpacity(0),
      isScrollControlled: true,
    );
  }
}

class CalendarDetailRowItem extends StatelessWidget {
  const CalendarDetailRowItem({
    Key key,
    @required this.iconPath,
    @required this.textContent,
  }) : super(key: key);
  final String iconPath;
  final String textContent;

  @override
  Widget build(BuildContext context) {
    Size media = MediaQuery.of(context).size;
    return Row(mainAxisAlignment: MainAxisAlignment.start, children: <Widget>[
      SvgPicture.asset(
        iconPath,
        width: media.width * 0.045,
      ),
      SizedBox(width: media.width * 0.03),
      Expanded(
        child: Text(
          textContent,
          style: TextStyle(
            fontSize: media.width * 0.04,
            fontFamily: 'Book',
            color: Colors.black,
          ),
        ),
      )
    ]);
  }
}
