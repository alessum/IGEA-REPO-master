import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:igea_app/models/camera_file_manager.dart';
import 'package:igea_app/models/constants/constants_graphics.dart';
import 'package:igea_app/models/outcome_screening.dart';
import 'package:igea_app/models/enums/screening_outcome_value.dart';
import 'package:igea_app/blocs/diary/diary_bloc.dart';
import 'package:igea_app/models/test.dart';
import 'package:igea_app/screens/camera/camera_screen.dart';
import 'package:igea_app/screens/diary/modal_bottom_sheets/modify_outcome.dart';
import 'package:igea_app/shared/constants.dart';
import 'package:igea_app/widgets/modal_bottom_sheets/prevengo_modal_confirmation.dart';
import 'package:igea_app/widgets/ui_components/close_line_top_modal.dart';
import 'package:intl/intl.dart';
import 'package:tuple/tuple.dart';

class TileScreeningOutcome extends StatefulWidget {
  final Tuple2<String, Test> testData;
  final Function(Map<String, dynamic> values) onUpdateOutcome;

  TileScreeningOutcome({
    @required this.testData,
    @required this.onUpdateOutcome,
  });

  @override
  _TileScreeningOutcomeState createState() => _TileScreeningOutcomeState();
}

class _TileScreeningOutcomeState extends State<TileScreeningOutcome>
    with SingleTickerProviderStateMixin {
  AnimationController _controller;
  AnimationController _expandNextTestDateController;
  Animation<double> _expandAnimation;
  bool _expand = false;

  ScreeningOutcomeValue value;
  bool isDoubt;

  Test test;

  @override
  void initState() {
    super.initState();
    prepareAnimations();
    test = widget.testData.item2;
    //_runExpandCheck();
    //print('[ARCHIVE D] ' + widget.outcome.outcomeValue.toString());

    // _expandNextTestDateController = AnimationController(
    //   vsync: this,
    //   duration: Duration(milliseconds: 200),
    // );
    // Animation curve = CurvedAnimation(
    //   parent: _controller,
    //   curve: Curves.ease,
    // );
    // _expandAnimation = Tween(begin: 0.0, end: 1.0).animate(curve);
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

  DateTime date;
  TextEditingController dateController = TextEditingController();

  DiaryBloc bloc;

  @override
  Widget build(BuildContext context) {
    Size media = MediaQuery.of(context).size;
    bloc = DiaryBlocProvider.of(context);

    return Container(
      child: Stack(
        children: <Widget>[
          SizeTransition(
            axisAlignment: 1.0,
            sizeFactor: _expandAnimation,
            child: Padding(
              padding: const EdgeInsets.fromLTRB(10.0, 30, 10, 0),
              child: Container(
                width: double.maxFinite,
                color: Colors.transparent,
                child: Container(
                  decoration: BoxDecoration(
                      color: Color(0xffebebeb),
                      borderRadius: BorderRadius.all(Radius.circular(20))),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 10.0),
                    child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          SizedBox(height: media.height * 0.07),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: <Widget>[
                              Container(
                                width: media.width * 0.2,
                                child: Text(
                                  'Referto: ',
                                  style: TextStyle(
                                      fontSize: media.width * 0.05,
                                      color: Colors.grey[900],
                                      fontFamily: 'Book'),
                                ),
                              ),
                              Container(
                                width: media.width * 0.4,
                                child: widget.testData.item2.outcome
                                            .outcomeFilePath !=
                                        null
                                    ? GestureDetector(
                                        onTap: () => showDialog(
                                          context: context,
                                          builder: (context) => Dialog(
                                            backgroundColor: Colors.transparent,
                                            insetPadding: EdgeInsets.symmetric(
                                                vertical: media.height * 0.05,
                                                horizontal: media.width * 0.05),
                                            child: Container(
                                              height: media.height * 0.8,
                                              width: media.width,
                                              decoration: BoxDecoration(
                                                color: Colors.grey[50],
                                                borderRadius: BorderRadius.all(
                                                  Radius.circular(25),
                                                ),
                                              ),
                                              child: Container(
                                                  padding: EdgeInsets.all(13),
                                                  child: Column(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceBetween,
                                                    children: [
                                                      Image.network(
                                                        widget
                                                            .testData
                                                            .item2
                                                            .outcome
                                                            .outcomeFilePath,
                                                        height:
                                                            media.height * 0.7,
                                                        loadingBuilder:
                                                            (BuildContext
                                                                    context,
                                                                Widget child,
                                                                ImageChunkEvent
                                                                    loadingProgress) {
                                                          if (loadingProgress ==
                                                              null)
                                                            return child;
                                                          return Center(
                                                            child:
                                                                CircularProgressIndicator(
                                                              value: loadingProgress
                                                                          .expectedTotalBytes !=
                                                                      null
                                                                  ? loadingProgress
                                                                          .cumulativeBytesLoaded /
                                                                      loadingProgress
                                                                          .expectedTotalBytes
                                                                  : null,
                                                            ),
                                                          );
                                                        },
                                                      ),
                                                      GestureDetector(
                                                        onTap: () =>
                                                            Navigator.pop(
                                                                context),
                                                        child: Container(
                                                          alignment:
                                                              Alignment.center,
                                                          width:
                                                              media.width * 0.4,
                                                          padding:
                                                              EdgeInsets.all(8),
                                                          decoration: BoxDecoration(
                                                              color: Color(
                                                                  0xff4768b7),
                                                              borderRadius: BorderRadius
                                                                  .all(Radius
                                                                      .circular(
                                                                          25))),
                                                          child: Center(
                                                            child: Text(
                                                              'Ok, ho visto',
                                                              style: TextStyle(
                                                                  fontSize:
                                                                      media.width *
                                                                          0.05,
                                                                  fontFamily:
                                                                      'Bold',
                                                                  color: Colors
                                                                      .white),
                                                            ),
                                                          ),
                                                        ),
                                                      )
                                                    ],
                                                  )),
                                            ),
                                          ),
                                        ),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            Icon(
                                              Icons.description_outlined,
                                              size: media.width * 0.08,
                                              color: ConstantsGraphics
                                                  .COLOR_DIARY_BLUE,
                                            ),
                                            SizedBox(width: media.width * .01),
                                            Text(
                                              'Visualizza il\nreferto',
                                              style: TextStyle(
                                                  fontSize: media.width * 0.04,
                                                  color: Colors.grey[900],
                                                  fontFamily: 'Bold'),
                                            ),
                                          ],
                                        ),
                                      )
                                    : Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Icon(
                                            Icons.sd_card_alert_outlined,
                                            size: media.width * 0.08,
                                            color: ConstantsGraphics
                                                .COLOR_DIARY_BLUE,
                                          ),
                                          Text(
                                            'Nessun referto\nsalvato',
                                            style: TextStyle(
                                                fontSize: media.width * 0.04,
                                                color: Colors.grey[900],
                                                fontFamily: 'Bold'),
                                          ),
                                        ],
                                      ),
                              )
                            ],
                          ),
                          SizedBox(height: 40),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 5),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: <Widget>[
                                GestureDetector(
                                  onTap: () => showConfirmationDelete(context),
                                  child: Container(
                                    width: 135,
                                    height: 50,
                                    decoration: BoxDecoration(
                                        color: Colors.white70,
                                        border: Border.all(
                                          width: 2.0,
                                          color: Colors.red[400],
                                        ),
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(25))),
                                    child: Center(
                                      child: Text(
                                        'Elimina',
                                        style: TextStyle(
                                            fontSize: 18,
                                            color: Colors.red[400],
                                            fontFamily: 'Bold'),
                                      ),
                                    ),
                                  ),
                                ),
                                GestureDetector(
                                  onTap: () => showModifyOutcomeDialog(),
                                  child: Container(
                                    padding:
                                        EdgeInsets.symmetric(horizontal: 5),
                                    width: 135,
                                    height: 50,
                                    decoration: BoxDecoration(
                                        color: Colors.white70,
                                        border: Border.all(
                                          width: 2.0,
                                          color: Color(0xff4768b7),
                                        ),
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(25))),
                                    child: Center(
                                      child: Text('Modifica',
                                          style: TextStyle(
                                              fontSize: 18,
                                              color: Color(0xff4768b7),
                                              fontFamily: 'Bold')),
                                    ),
                                  ),
                                )
                              ],
                            ),
                          ),
                        ]),
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
              padding: EdgeInsets.all(13),
              decoration: BoxDecoration(
                color: ConstantsGraphics.COLOR_DIARY_BLUE,
                borderRadius: BorderRadius.circular(25.0),
              ),
              child: Padding(
                padding: EdgeInsets.only(left: media.width * 0.05),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    Container(
                      width: media.width * .4,
                      child: Text(
                        test.name.toUpperCase(),
                        style: TextStyle(
                          fontSize: media.width * 0.05,
                          fontWeight: FontWeight.w900,
                          color: Colors.white,
                        ),
                      ),
                    ),
                    Container(
                      width: media.width * .3,
                      child: Text(
                        DateFormat('d/M/y').format(test.reservation.date),
                        style: TextStyle(
                          fontSize: media.width * 0.05,
                          fontWeight: FontWeight.w300,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          )
        ],
      ),
    );
  }

  void showOutcomeImage() {}

  void showCustomDialog(BuildContext ctx) {
    Dialog simpleDialog = Dialog(
      backgroundColor: Colors.transparent,
      child: Container(
        height: 150,
        width: 300,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: Container(
            decoration: BoxDecoration(
              color: Color(0xff4768b7),
              borderRadius: BorderRadius.circular(15),
            ),
            height: 180,
            width: 350,
            child: Center(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                child: Text(
                    'Si informa che la data è impostata automaticamente sulla base delle linee guida ministeriali relative all\'esame in questione.',
                    style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w400,
                        color: Colors.white),
                    textAlign: TextAlign.left),
              ),
            ),
          ),
        ),
      ),
    );
    showDialog(context: ctx, builder: (ctx) => simpleDialog);
  }

  void showConfirmationDelete(BuildContext ctx) {
    Size media = MediaQuery.of(context).size;

    showModalBottomSheet(
        backgroundColor: Colors.black.withOpacity(0),
        isScrollControlled: true,
        context: ctx,
        builder: (context) => Container(
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.all(Radius.circular(25))),
              margin: EdgeInsets.all(8),
              padding: EdgeInsets.symmetric(
                horizontal: media.width * 0.05,
                vertical: media.width * 0.01,
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                mainAxisSize: MainAxisSize.min,
                children: [
                  CloseLineTopModal(),
                  SizedBox(height: media.height * 0.02),
                  Container(
                    child: Text(
                      'Sei sicuro di voler eliminare l\'esito?',
                      style: TextStyle(
                        fontSize: media.width * 0.06,
                        fontFamily: 'Gotham',
                      ),
                    ),
                  ),
                  SizedBox(height: media.height * 0.02),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      GestureDetector(
                        onTap: () {
                          //Navigator.pop(context);
                          bloc.inDeleteOutcome.add(widget.testData);
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
                          ).then((value) {
                            setState(() {});
                          });
                        },
                        child: Container(
                          width: media.width * 0.3,
                          padding: EdgeInsets.all(10),
                          decoration: BoxDecoration(
                              color: Colors.white70,
                              border: Border.all(
                                width: 2.0,
                                color: Colors.red[400],
                              ),
                              borderRadius:
                                  BorderRadius.all(Radius.circular(25))),
                          child: Center(
                            child: Text(
                              'Si',
                              style: TextStyle(
                                  fontSize: 18,
                                  color: Colors.red[400],
                                  fontFamily: 'Bold'),
                            ),
                          ),
                        ),
                      ),
                      GestureDetector(
                        onTap: () => Navigator.pop(context),
                        child: Container(
                          width: media.width * 0.3,
                          padding: EdgeInsets.all(10),
                          decoration: BoxDecoration(
                              color: Colors.white70,
                              border: Border.all(
                                width: 2.0,
                                color: ConstantsGraphics.COLOR_DIARY_BLUE,
                              ),
                              borderRadius:
                                  BorderRadius.all(Radius.circular(25))),
                          child: Center(
                            child: Text(
                              'No',
                              style: TextStyle(
                                  fontSize: 18,
                                  color: ConstantsGraphics.COLOR_DIARY_BLUE,
                                  fontFamily: 'Bold'),
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                  SizedBox(
                    height: media.height * 0.015,
                  )
                ],
              ),
            ));
  }

  void showModifyOutcomeDialog() {
    DateTime d = widget.testData.item2.reservation.date;
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.black.withOpacity(0),
      isScrollControlled: true,
      builder: (context) => ModalBottomModifyOutcome(
        initialDate: '${d.day}-${d.month}-${d.year}',
        onUpdateOutcome: (values) {
          String testKey = widget.testData.item1;
          Test t = widget.testData.item2;
          t.reservation.date = values;
          bloc.updateOutcome.add(
            Tuple2<String, Test>(
              testKey,
              t,
            ),
          );
          Navigator.pop(context);
          showModalBottomSheet(
            context: context,
            builder: (context) => PrevengoModalConfirmation(
              title: 'Esito modificato!',
              iconPath: 'assets/avatars/arold_in_circle.svg',
              message:
                  'Ho moficato l\'esito dell\'esame: ${t.name.toUpperCase()}',
              colorTheme: ConstantsGraphics.COLOR_DIARY_BLUE,
              popScreensNumber: 1,
            ),
            backgroundColor: Colors.black.withOpacity(0),
            isScrollControlled: true,
          );
        },
      ),
    );
  }
}
