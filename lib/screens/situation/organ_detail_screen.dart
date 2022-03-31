import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:igea_app/blocs/situation_bloc.dart';
import 'package:igea_app/models/constants/constants.dart';
import 'package:igea_app/models/enums/status_type.dart';
import 'package:igea_app/models/organ.dart';
import 'package:igea_app/models/reservable_test.dart';
import 'package:igea_app/screens/situation/modalBottomSheets/prevengo_situation_modal_inactive_info.dart';
import 'package:igea_app/screens/situation/ui_components/blinking_icon.dart';
import 'package:igea_app/widgets/ui_components/close_line_top_modal.dart';
import 'modalBottomSheets/prevengo_situation_modal_deeping_info.dart';
import 'modalBottomSheets/prevengo_situation_modal_outofage_info.dart';

class OrganDetailScreen extends StatefulWidget {
  OrganDetailScreen({
    Key key,
    this.organKey,
  }) : super(key: key);

  final String organKey;

  @override
  _OrganDetailScreenState createState() => _OrganDetailScreenState();
}

class _OrganDetailScreenState extends State<OrganDetailScreen> {
  SituationBloc bloc;

  List<String> provinces = [
    'Pavia',
    'Milano',
    'Lodi',
    'Ragusa',
    'Enna',
    'Caltanissetta'
  ];

  @override
  void initState() {
    super.initState();
    SchedulerBinding.instance.addPostFrameCallback((_) {
      bloc.getOrgan.listen((event) {
        if (event.status.statusType == StatusType.DEEPENING) {
          showModalBottomSheet(
            context: context,
            builder: (context) => PrevengoSituationModalDeepingInfo(),
            backgroundColor: Colors.black.withOpacity(0),
            isScrollControlled: true,
          );
        } else if (event.status.statusType == StatusType.OUT_OF_AGE) {
          showModalBottomSheet(
            context: context,
            builder: (context) => PrevengoSituationModalOutofageInfo(),
            backgroundColor: Colors.black.withOpacity(0),
            isScrollControlled: true,
          );
        } else if (event.status.statusType == StatusType.INACTIVE) {
          showModalBottomSheet(
            context: context,
            builder: (context) => PrevengoSituationModalInactiveInfo(
              organKey: widget.organKey,
            ),
            backgroundColor: Colors.black.withOpacity(0),
            isScrollControlled: true,
          );
        }
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    Size media = MediaQuery.of(context).size;
    bloc = SituationBlocProvider.of(context);

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        leadingWidth: 0,
        title: FittedBox(
          fit: BoxFit.fitWidth,
          child: Text(
            'Situazione',
            textAlign: TextAlign.left,
            style: TextStyle(
                fontSize: media.width * 0.08,
                color: Colors.black,
                fontFamily: 'Gotham'),
          ),
        ),
        backgroundColor: Colors.white,
        elevation: 0,
      ),
      body: Align(
        alignment: Alignment.bottomLeft,
        child: StreamBuilder<Organ>(
          stream: bloc.getOrgan,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return Container(
                width: media.width,
                height: media.height * 0.85,
                decoration: BoxDecoration(
                    color: Color(
                      int.parse(snapshot.data.status.color),
                    ),
                    borderRadius:
                        BorderRadius.only(topRight: Radius.circular(80))),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    SizedBox(
                      height: media.height * 0.01,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: <Widget>[
                        Flexible(
                          flex: 4,
                          fit: FlexFit.loose,
                          child: ListTile(
                            leading: GestureDetector(
                                onTap: () => Navigator.pop(context),
                                child: SvgPicture.asset(
                                  'assets/icons/circle_left.svg',
                                  width: media.width * 0.09,
                                )),
                            title: Text(snapshot.data.name,
                                textAlign: TextAlign.left,
                                style: TextStyle(
                                    fontSize: media.width * 0.08,
                                    color: Colors.white,
                                    fontFamily: 'Gotham')),
                          ),
                        ),
                        Flexible(
                          flex: 1,
                          child: Align(
                            alignment: Alignment.centerLeft,
                            child: GestureDetector(
                              onTap: () {
                                if (bloc.inAlert()) {
                                  bloc.checkOrganAlert();
                                  showModalBottomSheet(
                                    context: context,
                                    builder: (context) => StreamBuilder<Widget>(
                                      stream: bloc.getOrganAlert,
                                      builder: (context, snapshot) =>
                                          snapshot.hasData
                                              ? snapshot.data
                                              : Container(
                                                  child: Center(
                                                    child:
                                                        CircularProgressIndicator(),
                                                  ),
                                                ),
                                    ),
                                    backgroundColor:
                                        Colors.black.withOpacity(0),
                                    isScrollControlled: true,
                                  ).then((value) {
                                    setState(() {});
                                  });
                                }
                              },
                              child: BlinkingIcon(
                                blinking: bloc.inAlert(),
                                child: SvgPicture.asset(
                                  '${snapshot.data.status.iconPath}',
                                  fit: BoxFit.cover,
                                  height: media.height * 0.05,
                                ),
                              ),
                            ),
                          ),
                        )
                      ],
                    ),
                    Container(
                        child: SvgPicture.asset(
                      '${snapshot.data.imagePath}',
                      height: snapshot.data.imagePath == 'assets/icons/utero.svg'
                          ? media.height * 0.12
                          : media.height * 0.18,
                      fit: BoxFit.cover,
                      color: snapshot.data.imagePath.contains('vaccine')
                          ? Colors.white
                          : null,
                    )),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: <Widget>[
                        Container(
                          width: media.width * 0.45,
                          child: Text(
                            'Prossimo esame',
                            style: TextStyle(
                                fontFamily: 'Book',
                                color: Colors.white,
                                fontSize: media.width * 0.05),
                          ),
                        ),
                        Stack(
                          children: <Widget>[
                            Container(
                              margin: EdgeInsets.only(left: 15),
                              width: media.width * 0.32,
                              height: 50,
                              decoration: BoxDecoration(
                                  color: Color.lerp(
                                      Colors.white70,
                                      Color(int.parse(
                                          snapshot.data.status.color)),
                                      0.8),
                                  borderRadius: BorderRadius.circular(25)),
                              child: Center(
                                child: Text(
                                  snapshot.data.nextTestDate != null
                                      ? snapshot.data.nextTestDate.year
                                          .toString()
                                      : '--',
                                  style: TextStyle(
                                    fontSize: media.width * 0.06,
                                    fontFamily: 'Book',
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                            ),
                            Positioned(
                              left: -25,
                              child: RawMaterialButton(
                                onPressed: () =>
                                    showNextTestInfo(context, snapshot.data),
                                child: SvgPicture.asset(
                                  'assets/icons/info_white.svg',
                                  width: media.width * 0.09,
                                  color: Color(
                                      int.parse(snapshot.data.status.color)),
                                ),
                                shape: CircleBorder(),
                                elevation: 3,
                                fillColor: Colors.white,
                              ),
                            ),
                          ],
                        )
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: <Widget>[
                        Container(
                          width: media.width * 0.45,
                          child: Text(
                            'Ultimo esame',
                            style: TextStyle(
                                fontFamily: 'Book',
                                color: Colors.white,
                                fontSize: media.width * 0.05),
                          ),
                        ),
                        Stack(
                          children: <Widget>[
                            Container(
                              margin: EdgeInsets.only(left: 15),
                              width: media.width * 0.32,
                              height: 50,
                              decoration: BoxDecoration(
                                  color: Color.lerp(
                                      Colors.white70,
                                      Color(int.parse(
                                          snapshot.data.status.color)),
                                      0.8),
                                  borderRadius: BorderRadius.circular(25)),
                              child: Center(
                                child: Padding(
                                  padding: const EdgeInsets.only(left: 10),
                                  child: Text(
                                    snapshot.data.lastTestDate == null
                                        ? '--'
                                        : snapshot.data.lastTestDate.year
                                            .toString(),
                                    style: TextStyle(
                                      fontSize: media.width * 0.06,
                                      fontFamily: 'Book',
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            Positioned(
                              left: -25,
                              child: RawMaterialButton(
                                onPressed: () =>
                                    showNextTestInfo(context, snapshot.data),
                                child: SvgPicture.asset(
                                  'assets/icons/info_white.svg',
                                  width: media.width * 0.09,
                                  color: Color(
                                      int.parse(snapshot.data.status.color)),
                                ),
                                shape: CircleBorder(),
                                elevation: 3,
                                fillColor: Colors.white,
                              ),
                            ),
                          ],
                        )
                      ],
                    ),
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Padding(
                        padding: const EdgeInsets.only(left: 15.0),
                        child: Text(
                          'Test prenotabili',
                          style: TextStyle(
                            fontSize: media.width * 0.08,
                            color: Colors.white,
                            fontFamily: 'Gotham',
                          ),
                        ),
                      ),
                    ),
                    Align(
                      alignment: Alignment.center,
                      child: Container(
                        width: media.width * 0.8,
                        height: media.height * 0.18,
                        margin:
                            EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: <Widget>[
                            Expanded(
                              child: ListView.builder(
                                  itemCount:
                                      snapshot.data.reservableTestList.length,
                                  itemBuilder: (ctx, index) {
                                    List<ReservableTest> testList =
                                        snapshot.data.reservableTestList;
                                    print(testList);
                                    return Opacity(
                                      opacity: 1,
                                      child: Card(
                                        elevation: 0,
                                        shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(25.0),
                                        ),
                                        color: Color.alphaBlend(
                                            Colors.white60,
                                            Color(int.parse(
                                                snapshot.data.status.color))),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          children: <Widget>[
                                            Row(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.end,
                                              children: <Widget>[
                                                SizedBox(
                                                  width: 10,
                                                ),
                                                Text(
                                                  testList[index]
                                                      .name
                                                      .toUpperCase(),
                                                  style: TextStyle(
                                                    fontSize:
                                                        media.width * 0.05,
                                                    fontFamily: 'Bold',
                                                    color: Colors.white,
                                                  ),
                                                ),
                                              ],
                                            ),
                                            Align(
                                              alignment: Alignment.centerRight,
                                              child: RawMaterialButton(
                                                onPressed: () =>
                                                    _showReservableTest(
                                                        context,
                                                        testList[index],
                                                        snapshot.data),
                                                child: SvgPicture.asset(
                                                  'assets/icons/info_white.svg',
                                                  width: media.width * 0.09,
                                                ),
                                                shape: CircleBorder(),
                                                elevation: 0,
                                                fillColor: Color(int.parse(
                                                    snapshot
                                                        .data.status.color)),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    );
                                  }),
                            ),
                          ],
                        ),
                      ),
                    )
                  ],
                ),
              );
            } else
              return Container(
                child: Center(
                  child: CircularProgressIndicator(),
                ),
              );
          },
        ),
      ),
    );
  }

  void _showReservableTest(
      BuildContext ctx, ReservableTest reservableTest, Organ organ) {
    Size media = MediaQuery.of(ctx).size;
    double modalHeight = media.height * 0.7;
    showModalBottomSheet(
      context: ctx,
      builder: (_) {
        return StatefulBuilder(
          builder: (context, setState) {
            return Container(
                padding: EdgeInsets.all(10),
                margin: EdgeInsets.all(8),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(25)),
                    color: Colors.white),
                height: modalHeight,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    CloseLineTopModal(),
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Container(
                        padding: const EdgeInsets.symmetric(horizontal: 40),
                        child: Text(reservableTest.name.toUpperCase(),
                            style: TextStyle(
                                fontSize: media.width * 0.07,
                                fontFamily: 'Gotham',
                                color: Colors.black87)),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 40),
                      child: Placeholder(
                        fallbackHeight: 110,
                      ),
                    ),
                    Container(
                      height: 130,
                      width: media.width,
                      padding: EdgeInsets.symmetric(horizontal: 40),
                      child: Text(reservableTest.description,
                          style: TextStyle(
                              fontSize: media.height < 600 ? 16 : 18,
                              color: Colors.black87,
                              fontFamily: 'Book')),
                    ),
                    GestureDetector(
                      onTap: () {
                        _showReservationCallMenu(
                            context, reservableTest, organ);
                      },
                      child: Container(
                        margin: EdgeInsets.symmetric(horizontal: 40),
                        height: 50,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.all(Radius.circular(25)),
                            color: Color(int.parse(organ.status.color))),
                        child: Center(
                          child: Text(
                            'Prenota',
                            style: TextStyle(
                                fontSize: media.width * 0.06,
                                color: Colors.white,
                                fontFamily: 'Bold'),
                          ),
                        ),
                      ),
                    ),
                  ],
                ));
          },
        );
      },
      backgroundColor: Colors.black.withOpacity(0),
      isScrollControlled: true,
    );
  }

  void _showReservationCallMenu(
      BuildContext context, ReservableTest reservableTest, Organ organ) {
    Size media = MediaQuery.of(context).size;
    int selectedIndex = -1;
    showModalBottomSheet(
      context: context,
      builder: (_) => Container(
        margin: EdgeInsets.all(8),
        padding: EdgeInsets.all(10),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.vertical(
                top: Radius.circular(25), bottom: Radius.circular(25)),
            color: Colors.white),
        height: media.height * 0.45,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            CloseLineTopModal(),
            Container(
                padding: EdgeInsets.all(8),
                child: Text(
                  'Seleziona la provincia di domicilio e premi il pulsante "Chiama" per effettuare la prenotazione',
                  style: TextStyle(
                    fontFamily: 'Book',
                    fontSize: media.width * 0.05,
                  ),
                )),
            Container(
              height: 150,
              margin: EdgeInsets.symmetric(horizontal: 40),
              decoration: BoxDecoration(
                  color: Colors.grey[200],
                  borderRadius: BorderRadius.all(Radius.circular(25))),
              child: ListView.builder(
                scrollDirection: Axis.vertical,
                itemCount: provinces.length,
                itemBuilder: (buildContext, index) {
                  return Center(
                    child: GestureDetector(
                      onTap: () => setState(() {
                        selectedIndex = index;
                      }),
                      child: Container(
                        padding: EdgeInsets.symmetric(
                            horizontal: 30.0, vertical: 10.0),
                        child: Text(provinces[index],
                            style: TextStyle(
                                fontSize: media.width * 0.05,
                                fontFamily: 'Book',
                                color: selectedIndex != index
                                    ? Colors.black87
                                    : Colors.white)),
                        decoration: BoxDecoration(
                            color: selectedIndex == index
                                ? Color(int.parse(organ.status.color))
                                : Colors.grey[200],
                            borderRadius:
                                BorderRadius.all(Radius.circular(45))),
                      ),
                    ),
                  );
                },
              ),
            ),
            GestureDetector(
              onTap: () {
                if (selectedIndex != -1) {
                  bloc.createTest.add({
                    Constants.TEST_NAME_KEY: reservableTest.name,
                    Constants.TEST_ORGAN_KEY_KEY: widget.organKey,
                    Constants.TEST_TYPE_KEY: reservableTest.type,
                    Constants.TEST_DESCRIPTION_KEY: reservableTest.description,
                  });
                  String phoneNumber = Constants
                      .PROVINCE_TO_PHONE_NUMBER[provinces[selectedIndex]];
                  //launch("tel://" + phoneNumber);
                }
              },
              child: Container(
                margin: EdgeInsets.symmetric(horizontal: 40),
                height: 50,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(25)),
                    color: selectedIndex != -1
                        ? Color(int.parse(organ.status.color))
                        : Colors.grey[300]),
                child: Center(
                  child: Text(
                    'Chiama',
                    style: TextStyle(
                        fontSize: media.width * 0.05,
                        color: selectedIndex != -1
                            ? Colors.white
                            : Colors.grey[400],
                        fontFamily: 'Gotham'),
                  ),
                ),
              ),
            )
          ],
        ),
      ),
      backgroundColor: Colors.black.withOpacity(0),
      isScrollControlled: true,
    );
  }

  void showNextTestInfo(BuildContext ctx, Organ organ) {
    Size media = MediaQuery.of(ctx).size;
    showModalBottomSheet(
      context: ctx,
      builder: (_) => Container(
        margin: EdgeInsets.only(bottom: 8, left: 8, right: 8),
        padding: EdgeInsets.only(bottom: 10),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.vertical(
                top: Radius.circular(25), bottom: Radius.circular(25)),
            color: Colors.white),
        height: media.height * 0.3,
        child: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              Container(
                padding: EdgeInsets.symmetric(vertical: 30, horizontal: 30),
                  child: Text(
                    'In base ai dati che hai inserito le linee guida ministeriali suggersicono l\'esecuzione del test ogni:',
                    style: TextStyle(
                      fontSize: media.width * 0.06,
                      color: Colors.black87,
                      fontFamily: 'Book'),
                ),
              ),
              Align(
                alignment: Alignment.bottomRight,
                child: Container(
                  margin: EdgeInsets.only(right: 30),
                  padding: EdgeInsets.all(15),
                  decoration: BoxDecoration(
                      color: Color(int.parse(organ.status.color)),
                      borderRadius: BorderRadius.all(Radius.circular(45))),
                  child: Text(
                    '3 anni',
                    style: TextStyle(
                        fontSize: 25, fontFamily: 'Bold', color: Colors.white),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
      backgroundColor: Colors.black.withOpacity(0),
      isScrollControlled: true,
    );
  }

  void showCustomDialog(BuildContext ctx, Organ organ) {
    Size media = MediaQuery.of(context).size;
    Dialog simpleDialog = Dialog(
      insetPadding: EdgeInsets.all(10),
      backgroundColor: Colors.transparent,
      child: Container(
        height: media.height * 0.39,
        child: Stack(
          children: <Widget>[
            Container(
              decoration: BoxDecoration(
                color: Color(int.parse(organ.status.color)),
                borderRadius: BorderRadius.circular(15),
              ),
              height: media.height * 0.36,
              child: Center(
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 15.0, vertical: 15.0),
                  child: Text(
                      'In base ai dati che hai inserito le linee guida ministeriali suggersicono l\'esecuzione del test ogni',
                      style: TextStyle(
                          fontSize: 25,
                          fontWeight: FontWeight.w400,
                          color: Colors.white),
                      textAlign: TextAlign.left),
                ),
              ),
            ),
            Align(
              alignment: Alignment.bottomRight,
              child: Container(
                margin: EdgeInsets.only(
                    right: MediaQuery.of(context).size.width * 0.03),
                decoration: BoxDecoration(
                  color: Color.lerp(
                      Colors.black, Color(int.parse(organ.status.color)), 0.7),
                  borderRadius: BorderRadius.circular(15),
                ),
                height: 50,
                width: 100,
                child: Center(
                  child: Text(
                    '3 anni',
                    style: TextStyle(
                        fontSize: 25,
                        fontWeight: FontWeight.w600,
                        color: Colors.white),
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
    showDialog(context: ctx, builder: (ctx) => simpleDialog);
  }

  // void _showMissingLastExamDateAlert(BuildContext ctx) {
  //   showModalBottomSheet(
  //     context: ctx,
  //     builder: (_) => OnboardingBlocProvider(
  //       child: ModalBottomMissingLastExamDate(
  //         organStatus: widget.organDetails.status,
  //         notifyClose: () {
  //           Navigator.pop(context);
  //           widget.fetchOrgans();
  //           setState(() {
  //             //situationBloc.fetchAllOrgans();
  //           });
  //         },
  //         organKey: widget.organKey,
  //       ),
  //     ),
  //     backgroundColor: Colors.black.withOpacity(0),
  //     isScrollControlled: true,
  //   );
  // }

  // void _showOutOfAgeAlert(BuildContext ctx) {
  //   Size media = MediaQuery.of(context).size;
  //   showModalBottomSheet(
  //     context: ctx,
  //     builder: (_) => Container(
  //       margin: EdgeInsets.all(8),
  //       padding: EdgeInsets.all(15),
  //       height: media.height * 0.4,
  //       decoration: BoxDecoration(
  //         color: Colors.white,
  //         borderRadius: BorderRadius.all(Radius.circular(25)),
  //       ),
  //       child: Column(
  //         mainAxisAlignment: MainAxisAlignment.spaceBetween,
  //         crossAxisAlignment: CrossAxisAlignment.center,
  //         children: [
  //           CloseLineTopModal(),
  //           Row(
  //             mainAxisAlignment: MainAxisAlignment.spaceBetween,
  //             mainAxisSize: MainAxisSize.max,
  //             children: [
  //               Container(
  //                 width: media.width * 0.7,
  //                 child: Text(
  //                   'Sei fuori età per rientrare nel programma di screening',
  //                   style: TextStyle(
  //                     fontSize: media.width * 0.05,
  //                     fontFamily: 'Bold',
  //                   ),
  //                 ),
  //               ),
  //               Container(
  //                 width: media.width * 0.15,
  //                 child: Center(
  //                   child: SvgPicture.asset(
  //                     '${widget.organDetails.status.iconPath}',
  //                     fit: BoxFit.cover,
  //                     height: media.height * 0.05,
  //                   ),
  //                 ),
  //               )
  //             ],
  //           ),
  //           SizedBox(height: media.height * 0.01),
  //           Container(
  //             width: media.width * 0.8,
  //             child: Text(
  //               'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Proin et gravida augue. Sed quis lacus ut lectus aliquet finibus.',
  //               style: TextStyle(
  //                 fontSize: media.width * 0.045,
  //                 fontFamily: 'Book',
  //               ),
  //             ),
  //           ),
  //           SizedBox(height: media.height * 0.03),
  //           GestureDetector(
  //             onTap: () => Navigator.pop(context),
  //             child: Container(
  //               width: media.width * 0.8,
  //               padding: EdgeInsets.all(10),
  //               decoration: BoxDecoration(
  //                 color: Color(int.parse(widget.organDetails.status.color)),
  //                 borderRadius: BorderRadius.all(
  //                   Radius.circular(25),
  //                 ),
  //               ),
  //               child: Center(
  //                 child: Text(
  //                   'Ok, ho capito',
  //                   style: TextStyle(
  //                     color: Colors.white,
  //                     fontSize: media.width * 0.04,
  //                     fontFamily: 'Bold',
  //                   ),
  //                 ),
  //               ),
  //             ),
  //           )
  //         ],
  //       ),
  //     ),
  //     backgroundColor: Colors.black.withOpacity(0),
  //     isScrollControlled: true,
  //   );
  // }

  // void _showMissingQuestionaryAlert(BuildContext ctx) {
  //   String title = 'Per poterti aiutare devi compilare il questionario ';
  //   title += widget.organKey == Constants.COLON_KEY
  //       ? 'sul '
  //       : 'sulla ' + '${widget.organDetails.name}';

  //   Size media = MediaQuery.of(context).size;
  //   showModalBottomSheet(
  //     context: ctx,
  //     builder: (_) => Container(
  //       margin: EdgeInsets.all(8),
  //       padding: EdgeInsets.all(15),
  //       height: media.height * 0.4,
  //       decoration: BoxDecoration(
  //         color: Colors.white,
  //         borderRadius: BorderRadius.all(Radius.circular(25)),
  //       ),
  //       child: Column(
  //         mainAxisAlignment: MainAxisAlignment.spaceBetween,
  //         crossAxisAlignment: CrossAxisAlignment.center,
  //         children: [
  //           CloseLineTopModal(),
  //           Row(
  //             mainAxisAlignment: MainAxisAlignment.spaceBetween,
  //             mainAxisSize: MainAxisSize.max,
  //             children: [
  //               Container(
  //                 width: media.width * 0.7,
  //                 child: Text(
  //                   title,
  //                   style: TextStyle(
  //                     fontSize: media.width * 0.05,
  //                     fontFamily: 'Bold',
  //                   ),
  //                 ),
  //               ),
  //               Container(
  //                 width: media.width * 0.15,
  //                 child: Center(
  //                   child: SvgPicture.asset(
  //                     '${widget.organDetails.status.iconPath}',
  //                     fit: BoxFit.cover,
  //                     height: media.height * 0.05,
  //                   ),
  //                 ),
  //               )
  //             ],
  //           ),
  //           SizedBox(height: media.height * 0.01),
  //           Container(
  //             width: media.width * 0.8,
  //             child: Text(
  //               'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Proin et gravida augue. Sed quis lacus ut lectus aliquet finibus.',
  //               style: TextStyle(
  //                 fontSize: media.width * 0.045,
  //                 fontFamily: 'Book',
  //               ),
  //             ),
  //           ),
  //           SizedBox(height: media.height * 0.03),
  //           GestureDetector(
  //             onTap: () => _showOrganQuestionary(ctx),
  //             child: Container(
  //               width: media.width * 0.8,
  //               padding: EdgeInsets.all(10),
  //               decoration: BoxDecoration(
  //                 color: Color(int.parse(widget.organDetails.status.color)),
  //                 borderRadius: BorderRadius.all(
  //                   Radius.circular(25),
  //                 ),
  //               ),
  //               child: Center(
  //                 child: Text(
  //                   'Ok, compila il questionario',
  //                   style: TextStyle(
  //                     color: Colors.white,
  //                     fontSize: media.width * 0.04,
  //                     fontFamily: 'Bold',
  //                   ),
  //                 ),
  //               ),
  //             ),
  //           )
  //         ],
  //       ),
  //     ),
  //     backgroundColor: Colors.black.withOpacity(0),
  //     isScrollControlled: true,
  //   );
  // }

  // void _showOrganQuestionary(BuildContext ctx) {
  //   Size media = MediaQuery.of(context).size;
  //   showModalBottomSheet(
  //     context: ctx,
  //     builder: (_) => Container(
  //       margin: EdgeInsets.all(8),
  //       height: media.height * 0.9,
  //       decoration: BoxDecoration(
  //         color: Colors.white,
  //         borderRadius: BorderRadius.all(Radius.circular(25)),
  //       ),
  //       child: OnboardingBlocProvider(
  //         child: (() {
  //           switch (widget.organKey) {
  //             case Constants.BREAST_KEY:
  //               return BreastQuestionarySituation(
  //                   notifyClose: () => _notifyClose());
  //               break;
  //             case Constants.COLON_KEY:
  //               return ColonQuestionarySituation(
  //                   notifyClose: () => _notifyClose());
  //               break;
  //             case Constants.UTERUS_KEY:
  //               return UterusQuestionarySituation(
  //                   notifyClose: () => _notifyClose());
  //           }
  //         }()),
  //       ),
  //     ),
  //     backgroundColor: Colors.black.withOpacity(0),
  //     isScrollControlled: true,
  //   );
  // }

  // _notifyClose() {
  //   Navigator.pop(context);
  //   setState(() {
  //     //situationBloc.fetchAllOrgans();
  //   });
  // }
}
