// import 'dart:math';
// import 'package:flutter/material.dart';
// import 'package:flutter/rendering.dart';
// import 'package:igea_app/blocs/bloc_calendar.dart';
// import 'package:igea_app/models/enums/test_type.dart';
// import 'package:igea_app/models/reservable_test.dart';
// import 'package:igea_app/models/test.dart';
// import 'package:igea_app/widgets/calendar_advisor.dart';
// import 'package:intl/intl.dart';
// import 'customExpansionTileTipology.dart';
// import 'package:igea_app/models/constants/constants.dart';

// class CustomExpansionTileCalendarAddExam extends StatefulWidget {
//   @override
//   _CustomExpansionTileCalendarAddExamState createState() =>
//       _CustomExpansionTileCalendarAddExamState();

//   final Map<String, Test> nonReservedTestList;
//   CustomExpansionTileCalendarAddExam({@required this.nonReservedTestList});
// }

// class _CustomExpansionTileCalendarAddExamState
//     extends State<CustomExpansionTileCalendarAddExam>
//     with SingleTickerProviderStateMixin {
//   CalendarBloc bloc;

//   AnimationController _controller;
//   Animation<double> _expandAnimation;
//   Animation<double> _rotateAnimation;
//   bool _expand = true;
//   bool _addingNewExam = false;

//   DateTime date;
//   TextEditingController dateController = TextEditingController();
//   TimeOfDay time;
//   TextEditingController timeController = TextEditingController();

//   String organKey;
//   String testKey;
//   ReservableTest _reservableTest;
//   Test _nonReservedTest;
//   String place;
//   String inputDescription;

//   Stream<Map<dynamic, dynamic>> reservableTestList;

//   bool nonReservedTestSelected;
//   Test selectedTest;

//   @override
//   void initState() {
//     super.initState();
//     prepareAnimations();
//     _runExpandCheck();
//     nonReservedTestSelected = false;
//   }

//   @override
//   void didChangeDependencies() {
//     bloc = CalendarBlocProvider.of(context);

//     super.didChangeDependencies();
//   }

//   ///Setting up the animation
//   void prepareAnimations() {
//     _controller =
//         AnimationController(vsync: this, duration: Duration(milliseconds: 200));
//     Animation curve = CurvedAnimation(
//       parent: _controller,
//       curve: Curves.ease,
//     );
//     _expandAnimation = Tween(begin: 0.0, end: 1.0).animate(curve)
//       ..addListener(() {
//         setState(() {});
//       });
//     _rotateAnimation = Tween(begin: 0.0, end: pi / 2).animate(curve)
//       ..addListener(() {
//         setState(() {});
//       });
//   }

//   void _runExpandCheck() {
//     if (_expand) {
//       _controller.forward();
//     } else {
//       _controller.reverse();
//     }
//   }

//   @override
//   void dispose() {
//     _controller.dispose();
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     print('[BOOLLLLLL] :' + nonReservedTestSelected.toString());
//     return _addingNewExam
//         ? Padding(
//             padding: const EdgeInsets.all(8.0),
//             child: Container(
//               width: 340.0,
//               child: Column(mainAxisSize: MainAxisSize.min, children: <Widget>[
//                 Container(
//                   height: 50,
//                   width: 340,
//                   child: Card(
//                       elevation: 1.0,
//                       color: Color(0xff7ccddb),
//                       shape: RoundedRectangleBorder(
//                           borderRadius: BorderRadius.circular(25.0)),
//                       child: Padding(
//                           padding:
//                               const EdgeInsets.only(left: 20.0, right: 5.0),
//                           child: Row(
//                               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                               children: <Widget>[
//                                 Text(
//                                   'Aggiungi esame',
//                                   style: TextStyle(
//                                     fontSize: 20,
//                                     fontWeight: FontWeight.w900,
//                                     color: Colors.white,
//                                   ),
//                                 ),
//                                 Row(
//                                   mainAxisAlignment:
//                                       MainAxisAlignment.spaceBetween,
//                                   children: <Widget>[
//                                     GestureDetector(
//                                         onTap: () {
//                                           setState(() {
//                                             _addingNewExam = false;
//                                           });
//                                           _runExpandCheck();
//                                         },
//                                         child: Padding(
//                                           padding: const EdgeInsets.only(
//                                               left: 15.0, right: 5.0),
//                                           child: Container(
//                                             decoration: BoxDecoration(
//                                                 shape: BoxShape.circle,
//                                                 color: Colors.white),
//                                             child: Transform.rotate(
//                                                 angle: _rotateAnimation.value,
//                                                 child: Icon(Icons.close,
//                                                     color: Color(0xff7ccddb))),
//                                           ),
//                                         ))
//                                   ],
//                                 ),
//                               ]))),
//                 ),
//                 widget.nonReservedTestList.length > 0
//                     ? _buildCalendarAdvisor()
//                     : Container(),
//                 SizeTransition(
//                   axisAlignment: 1.0,
//                   sizeFactor: _expandAnimation,
//                   child: Padding(
//                     padding: const EdgeInsets.symmetric(horizontal: 5.0),
//                     child: Container(
//                       height: 400,
//                       width: 360,
//                       color: Colors.transparent,
//                       child: Card(
//                         elevation: 1.0,
//                         color: Colors.grey[300],
//                         child: Padding(
//                           padding: const EdgeInsets.symmetric(vertical: 10.0),
//                           child: Column(
//                               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                               children: <Widget>[
//                                 Padding(
//                                   padding: const EdgeInsets.symmetric(
//                                       horizontal: 15.0),
//                                   child: Row(
//                                       mainAxisAlignment:
//                                           MainAxisAlignment.spaceBetween,
//                                       children: <Widget>[
//                                         Text('Tipologia: ',
//                                             style: TextStyle(
//                                                 fontSize: 18,
//                                                 color: Colors.grey[900])),
//                                         nonReservedTestSelected == false
//                                             ? CustomExpansionTileTipology(
//                                                 returnType: (ReservableTest
//                                                         reservableTest) =>
//                                                     setState(() {
//                                                   _reservableTest =
//                                                       reservableTest;
//                                                 }),
//                                               )
//                                             : Expanded(
//                                                 child: Center(
//                                                     child: Text(selectedTest
//                                                         .name
//                                                         .toString()))),
//                                       ]),
//                                 ),
//                                 Padding(
//                                   padding: const EdgeInsets.symmetric(
//                                       horizontal: 15.0),
//                                   child: Row(
//                                       mainAxisAlignment:
//                                           MainAxisAlignment.spaceBetween,
//                                       children: <Widget>[
//                                         Text('Ora: ',
//                                             style: TextStyle(
//                                                 fontSize: 18,
//                                                 color: Colors.grey[900])),
//                                         SizedBox(
//                                           width: 200,
//                                           child: Stack(
//                                             children: <Widget>[
//                                               Container(
//                                                   height: 50.0,
//                                                   width: 200.0,
//                                                   child: Card(
//                                                     elevation: 0.0,
//                                                     shape:
//                                                         RoundedRectangleBorder(
//                                                             borderRadius:
//                                                                 BorderRadius
//                                                                     .circular(
//                                                                         25.0)),
//                                                   )),
//                                               TextField(
//                                                   decoration:
//                                                       const InputDecoration(
//                                                           hintText:
//                                                               '- non selezionata',
//                                                           border:
//                                                               InputBorder.none,
//                                                           focusedBorder:
//                                                               InputBorder.none,
//                                                           enabledBorder:
//                                                               InputBorder.none,
//                                                           errorBorder:
//                                                               InputBorder.none,
//                                                           disabledBorder:
//                                                               InputBorder.none,
//                                                           contentPadding:
//                                                               EdgeInsets.only(
//                                                                   left: 15,
//                                                                   bottom: 11,
//                                                                   top: 11,
//                                                                   right: 15)),
//                                                   readOnly: true,
//                                                   controller: timeController,
//                                                   onTap: () {
//                                                     showTimePicker(
//                                                       context: context,
//                                                       initialTime:
//                                                           TimeOfDay.now(),
//                                                       builder:
//                                                           (BuildContext context,
//                                                               Widget child) {
//                                                         return Theme(
//                                                           data:
//                                                               ThemeData.light()
//                                                                   .copyWith(
//                                                             primaryColor:
//                                                                 const Color(
//                                                                     0xff7ccddb),
//                                                             accentColor:
//                                                                 const Color(
//                                                                     0xff7ccddb),
//                                                             colorScheme:
//                                                                 ColorScheme.light(
//                                                                     primary:
//                                                                         const Color(
//                                                                             0xff7ccddb)),
//                                                             buttonTheme:
//                                                                 ButtonThemeData(
//                                                                     textTheme:
//                                                                         ButtonTextTheme
//                                                                             .primary),
//                                                           ),
//                                                           child: child,
//                                                         );
//                                                       },
//                                                     ).then((selectedTime) {
//                                                       setState(() {
//                                                         time = selectedTime;
//                                                         timeController.text =
//                                                             formatTimeOfDay(
//                                                                 time);
//                                                         print('[TIME STAMP] ' +
//                                                             time.toString());
//                                                       });
//                                                     });
//                                                   }),
//                                             ],
//                                           ),
//                                         ),
//                                       ]),
//                                 ),
//                                 Padding(
//                                   padding: const EdgeInsets.symmetric(
//                                       horizontal: 15.0),
//                                   child: Row(
//                                       mainAxisAlignment:
//                                           MainAxisAlignment.spaceBetween,
//                                       children: <Widget>[
//                                         Text('Data: ',
//                                             style: TextStyle(
//                                                 fontSize: 18,
//                                                 color: Colors.grey[900])),
//                                         SizedBox(
//                                           width: 200.0,
//                                           child: Stack(
//                                             children: <Widget>[
//                                               Container(
//                                                   height: 50.0,
//                                                   width: 200.0,
//                                                   child: Card(
//                                                     elevation: 0.0,
//                                                     shape:
//                                                         RoundedRectangleBorder(
//                                                             borderRadius:
//                                                                 BorderRadius
//                                                                     .circular(
//                                                                         25.0)),
//                                                   )),
//                                               TextField(
//                                                   decoration:
//                                                       const InputDecoration(
//                                                           hintText:
//                                                               '- non selezionata',
//                                                           border:
//                                                               InputBorder.none,
//                                                           focusedBorder:
//                                                               InputBorder.none,
//                                                           enabledBorder:
//                                                               InputBorder.none,
//                                                           errorBorder:
//                                                               InputBorder.none,
//                                                           disabledBorder:
//                                                               InputBorder.none,
//                                                           contentPadding:
//                                                               EdgeInsets.only(
//                                                                   left: 15,
//                                                                   bottom: 11,
//                                                                   top: 11,
//                                                                   right: 15)),
//                                                   readOnly: true,
//                                                   controller: dateController,
//                                                   onTap: () {
//                                                     var dateNow =
//                                                         new DateTime.now();
//                                                     showDatePicker(
//                                                             context: context,
//                                                             initialDate:
//                                                                 DateTime.now(),
//                                                             firstDate: DateTime(
//                                                                 dateNow.year -
//                                                                     30,
//                                                                 1,
//                                                                 1),
//                                                             builder:
//                                                                 (BuildContext
//                                                                         context,
//                                                                     Widget
//                                                                         child) {
//                                                               return Theme(
//                                                                 data: ThemeData
//                                                                         .light()
//                                                                     .copyWith(
//                                                                   primaryColor:
//                                                                       const Color(
//                                                                           0xff7ccddb),
//                                                                   accentColor:
//                                                                       const Color(
//                                                                           0xff7ccddb),
//                                                                   colorScheme:
//                                                                       ColorScheme.light(
//                                                                           primary:
//                                                                               const Color(0xff7ccddb)),
//                                                                   buttonTheme: ButtonThemeData(
//                                                                       textTheme:
//                                                                           ButtonTextTheme
//                                                                               .primary),
//                                                                 ),
//                                                                 child: child,
//                                                               );
//                                                             },
//                                                             lastDate: DateTime(
//                                                                 dateNow.year +
//                                                                     10,
//                                                                 12,
//                                                                 31))
//                                                         .then((selectedDate) {
//                                                       setState(() {
//                                                         date = selectedDate;
//                                                         dateController.text =
//                                                             DateFormat.yMMMd()
//                                                                 .format(date);
//                                                         print('[DATE STAMP] ' +
//                                                             date.toString());
//                                                       });
//                                                     });
//                                                   }),
//                                             ],
//                                           ),
//                                         ),
//                                       ]),
//                                 ),
//                                 Padding(
//                                   padding: const EdgeInsets.symmetric(
//                                       horizontal: 15.0),
//                                   child: Row(
//                                       mainAxisAlignment:
//                                           MainAxisAlignment.spaceBetween,
//                                       children: <Widget>[
//                                         Text('Luogo: ',
//                                             style: TextStyle(
//                                                 fontSize: 18,
//                                                 color: Colors.grey[900])),
//                                         SizedBox(
//                                           width: 200.0,
//                                           child: Stack(
//                                             children: <Widget>[
//                                               Container(
//                                                   height: 50.0,
//                                                   width: 200.0,
//                                                   child: Card(
//                                                     elevation: 0.0,
//                                                     shape:
//                                                         RoundedRectangleBorder(
//                                                             borderRadius:
//                                                                 BorderRadius
//                                                                     .circular(
//                                                                         25.0)),
//                                                   )),
//                                               TextField(
//                                                 onChanged: (text) {
//                                                   setState(() {
//                                                     place = text;
//                                                   });
//                                                 },
//                                                 decoration:
//                                                     const InputDecoration(
//                                                         hintText:
//                                                             '- non selezionato',
//                                                         border:
//                                                             InputBorder.none,
//                                                         focusedBorder:
//                                                             InputBorder.none,
//                                                         enabledBorder:
//                                                             InputBorder.none,
//                                                         errorBorder:
//                                                             InputBorder.none,
//                                                         disabledBorder:
//                                                             InputBorder.none,
//                                                         contentPadding:
//                                                             EdgeInsets.only(
//                                                                 left: 15,
//                                                                 bottom: 11,
//                                                                 top: 11,
//                                                                 right: 15)),
//                                                 readOnly: false,
//                                               ),
//                                             ],
//                                           ),
//                                         ),
//                                       ]),
//                                 ),
//                                 Padding(
//                                   padding: const EdgeInsets.symmetric(
//                                       horizontal: 15.0),
//                                   child: Row(
//                                       mainAxisAlignment:
//                                           MainAxisAlignment.spaceBetween,
//                                       children: <Widget>[
//                                         Text('Note: ',
//                                             style: TextStyle(
//                                                 fontSize: 18,
//                                                 color: Colors.grey[900])),
//                                         SizedBox(
//                                           width: 200.0,
//                                           child: Stack(
//                                             children: <Widget>[
//                                               Container(
//                                                   height: 50.0,
//                                                   width: 200.0,
//                                                   child: Card(
//                                                     elevation: 0.0,
//                                                     shape:
//                                                         RoundedRectangleBorder(
//                                                             borderRadius:
//                                                                 BorderRadius
//                                                                     .circular(
//                                                                         25.0)),
//                                                   )),
//                                               TextField(
//                                                 onChanged: (text) {
//                                                   setState(() {
//                                                     inputDescription = text;
//                                                   });
//                                                 },
//                                                 decoration:
//                                                     const InputDecoration(
//                                                         hintText:
//                                                             '- note personali',
//                                                         border:
//                                                             InputBorder.none,
//                                                         focusedBorder:
//                                                             InputBorder.none,
//                                                         enabledBorder:
//                                                             InputBorder.none,
//                                                         errorBorder:
//                                                             InputBorder.none,
//                                                         disabledBorder:
//                                                             InputBorder.none,
//                                                         contentPadding:
//                                                             EdgeInsets.only(
//                                                                 left: 15,
//                                                                 bottom: 11,
//                                                                 top: 11,
//                                                                 right: 15)),
//                                                 readOnly: false,
//                                               ),
//                                             ],
//                                           ),
//                                         ),
//                                       ]),
//                                 ),
//                                 SizedBox(height: 10.0),
//                                 Row(
//                                   mainAxisAlignment: MainAxisAlignment.center,
//                                   children: <Widget>[
//                                     RaisedButton(
//                                       elevation: 0.0,
//                                       onPressed: () {
//                                         sendNewReservation();
//                                       },
//                                       shape: RoundedRectangleBorder(
//                                         borderRadius:
//                                             new BorderRadius.circular(30.0),
//                                       ),
//                                       padding: const EdgeInsets.all(0.0),
//                                       child: Container(
//                                         decoration: BoxDecoration(
//                                           color: Color(0xff7ccddb),
//                                           borderRadius:
//                                               BorderRadius.circular(20.0),
//                                         ),
//                                         padding: const EdgeInsets.only(
//                                             top: 5.0,
//                                             bottom: 5.0,
//                                             left: 15.0,
//                                             right: 5.0),
//                                         child: Row(
//                                           children: <Widget>[
//                                             Text('Conferma',
//                                                 style: TextStyle(
//                                                     fontSize: 18,
//                                                     color: Colors.white,
//                                                     fontWeight: FontWeight.w300,
//                                                     fontFamily: 'FilsonSoft')),
//                                             SizedBox(width: 10.0),
//                                             CircleAvatar(
//                                               backgroundColor: Colors.white,
//                                               radius: 15.0,
//                                               child: Icon(Icons.check,
//                                                   color: Color(0xff7ccddb),
//                                                   size: 25),
//                                             )
//                                           ],
//                                         ),
//                                       ),
//                                     ),
//                                   ],
//                                 ),
//                               ]),
//                         ),
//                       ),
//                     ),
//                   ),
//                 )
//               ]),
//             ),
//           )
//         : Padding(
//             padding: const EdgeInsets.only(
//                 top: 5.0, left: 42.0, right: 20.0, bottom: 20.0),
//             child: Row(children: <Widget>[
//               Expanded(
//                   child: Text('I prossimi\nappuntamenti',
//                       textAlign: TextAlign.left,
//                       style: TextStyle(
//                           fontSize: 22,
//                           color: Colors.black,
//                           fontWeight: FontWeight.w300))),
//               GestureDetector(
//                 onTap: () {
//                   setState(() {
//                     _addingNewExam = true;
//                   });
//                 },
//                 child: CircleAvatar(
//                   backgroundColor: Color(0xff7ccddb),
//                   radius: 15.0,
//                   child: Icon(Icons.add, color: Colors.white, size: 25),
//                 ),
//               )
//             ]),
//           );
//   }

//   Widget _buildCalendarAdvisor() {
//     if (nonReservedTestSelected == true) {
//       return Container(
//         margin: const EdgeInsets.symmetric(horizontal: 5.0, vertical: 5.0),
//         width: 360,
//         decoration: BoxDecoration(
//           borderRadius: BorderRadius.all(Radius.circular(25)),
//           color: Colors.grey[300],
//         ),
//         child: Padding(
//           padding: const EdgeInsets.all(15.0),
//           child: Column(
//             children: <Widget>[
//               Row(
//                 children: <Widget>[
//                   Container(
//                     height: 75,
//                     width: 75,
//                     child: Image(
//                       image: AssetImage('assets/doctor_women_face.png'),
//                       fit: BoxFit.contain,
//                     ),
//                   ),
//                   Container(
//                     padding: EdgeInsets.only(left: 10),
//                     width: 200,
//                     child: Text(
//                       'Bene! Hai selezionato ${selectedTest.name}, compila i campi sottostanti e poi conferma per salvare la prenotazione dell\'esame nel calendario,\noppure',
//                       style: TextStyle(fontSize: 18),
//                       overflow: TextOverflow.fade,
//                     ),
//                   ),
//                 ],
//               ),
//               SizedBox(
//                 height: 15,
//               ),
//               GestureDetector(
//                 onTap: () => setState(() {
//                   nonReservedTestSelected = false;
//                   selectedTest = null;
//                   testKey = null;
//                 }),
//                 child: Container(
//                   width: 120,
//                   decoration: BoxDecoration(
//                     color: Color(0xff7ccddb),
//                     borderRadius: BorderRadius.circular(20.0),
//                   ),
//                   padding: const EdgeInsets.only(
//                       top: 5.0, bottom: 5.0, left: 15.0, right: 15.0),
//                   child: Center(
//                     child: Text(
//                       'Annulla',
//                       style: TextStyle(
//                           fontSize: 18,
//                           color: Colors.white,
//                           fontWeight: FontWeight.w300,
//                           fontFamily: 'FilsonSoft'),
//                     ),
//                   ),
//                 ),
//               ),
//             ],
//           ),
//         ),
//       );
//     } else {
//       return Container(
//         margin: const EdgeInsets.symmetric(horizontal: 5.0, vertical: 5.0),
//         width: 360,
//         decoration: BoxDecoration(
//           borderRadius: BorderRadius.all(Radius.circular(25)),
//           color: Colors.grey[300],
//         ),
//         child: Padding(
//           padding: const EdgeInsets.all(15.0),
//           child: Column(
//             children: <Widget>[
//               Row(
//                 mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                 children: <Widget>[
//                   Container(
//                     height: 75,
//                     width: 75,
//                     child: Image(
//                       image: AssetImage('assets/doctor_women_face.png'),
//                       fit: BoxFit.contain,
//                     ),
//                   ),
//                   Container(
//                     width: 200,
//                     child: Text(
//                       widget.nonReservedTestList.length > 1
//                           ? 'Mi risulta che hai cercato di prenotare diversi esami elencati nella lista qui sotto'
//                           : 'Mi risulta che hai cercato di prenotare l\'esame "${widget.nonReservedTestList.values.toList()[0].name}". Vuoi portare a termine l\'perazione?',
//                       style: TextStyle(fontSize: 18),
//                       overflow: TextOverflow.fade,
//                     ),
//                   ),
//                 ],
//               ),
//               SizedBox(
//                 height: 10,
//               ),
//               widget.nonReservedTestList.length > 1
//                   ? Container(
//                       height: (widget.nonReservedTestList.length * 60.0),
//                       padding: EdgeInsets.symmetric(vertical: 10),
//                       child:
//                           _buildNonReservedTestList(widget.nonReservedTestList),
//                     )
//                   : Row(
//                       mainAxisAlignment: MainAxisAlignment.spaceAround,
//                       children: <Widget>[
//                         GestureDetector(
//                           onTap: () => setState(() {
//                             testKey =
//                                 widget.nonReservedTestList.keys.toList()[0];
//                             selectedTest =
//                                 widget.nonReservedTestList.values.toList()[0];
//                             nonReservedTestSelected = true;
//                           }),
//                           child: Container(
//                             width: 120,
//                             decoration: BoxDecoration(
//                               color: Color(0xff7ccddb),
//                               borderRadius: BorderRadius.circular(20.0),
//                             ),
//                             padding: const EdgeInsets.only(
//                                 top: 5.0, bottom: 5.0, left: 15.0, right: 15.0),
//                             child: Text(
//                               'Conferma',
//                               style: TextStyle(
//                                   fontSize: 18,
//                                   color: Colors.white,
//                                   fontWeight: FontWeight.w300,
//                                   fontFamily: 'FilsonSoft'),
//                             ),
//                           ),
//                         ),
//                         Container(
//                           width: 120,
//                           decoration: BoxDecoration(
//                             color: Color(0xff7ccddb),
//                             borderRadius: BorderRadius.circular(20.0),
//                           ),
//                           padding: const EdgeInsets.only(
//                               top: 5.0, bottom: 5.0, left: 15.0, right: 15.0),
//                           child: Text(
//                             'Elimina',
//                             textAlign: TextAlign.center,
//                             style: TextStyle(
//                                 fontSize: 18,
//                                 color: Colors.white,
//                                 fontWeight: FontWeight.w300,
//                                 fontFamily: 'FilsonSoft'),
//                           ),
//                         )
//                       ],
//                     ),
//             ],
//           ),
//         ),
//       );
//     }
//   }

//   Widget _buildNonReservedTestList(Map<String, Test> testList) {
//     return ListView.separated(
//       itemBuilder: (BuildContext ctx, int index) {
//         String key = testList.keys.elementAt(index);
//         return Container(
//           height: 40,
//           decoration: BoxDecoration(
//               color: Color(0xff7ccddb), //TODO
//               borderRadius: BorderRadius.all(Radius.circular(25))),
//           child: Padding(
//             padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 5),
//             child: Row(
//               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//               children: <Widget>[
//                 Text(
//                   testList[key].name,
//                   style: TextStyle(fontSize: 18),
//                 ),
//                 Row(
//                   children: <Widget>[
//                     GestureDetector(
//                       onTap: () => setState(() {
//                         nonReservedTestSelected = true;
//                         selectedTest = testList[key];
//                         testKey = key;
//                       }),
//                       child: CircleAvatar(
//                         backgroundColor: Colors.white,
//                         radius: 15.0,
//                         child: Icon(Icons.check,
//                             color: Color(0xff7ccddb), size: 25),
//                       ),
//                     ),
//                     SizedBox(
//                       width: 15,
//                     ),
//                     CircleAvatar(
//                       backgroundColor: Colors.white,
//                       radius: 15.0,
//                       child: Icon(Icons.delete,
//                           color: Color(0xff7ccddb), size: 25),
//                     ),
//                   ],
//                 )
//               ],
//             ),
//           ),
//         );
//       },
//       separatorBuilder: (BuildContext ctx, int index) {
//         return SizedBox(
//           height: 10,
//         );
//       },
//       itemCount: testList.length,
//       scrollDirection: Axis.vertical,
//     );
//   }

//   String formatTimeOfDay(TimeOfDay tod) {
//     final now = new DateTime.now();
//     final dt = DateTime(now.year, now.month, now.day, tod.hour, tod.minute);
//     final format = DateFormat.jm();
//     return format.format(dt);
//   }

//   String formatTimeOfDayInHHMM(TimeOfDay tod) {
//     final now = new DateTime.now();
//     final dt = DateTime(now.year, now.month, now.day, tod.hour, tod.minute);
//     final format = DateFormat('HH:mm');
//     return format.format(dt);
//   }

//   void sendNewReservation() {
//     //FIXME sistemare meglio!!
//     String parsedDate;
//     parsedDate = date.toString();
//     parsedDate = parsedDate.substring(0, parsedDate.indexOf(' ') + 1);
//     String stringTime = formatTimeOfDayInHHMM(time);
//     print('[DEBUG STRINGTIME] ' + stringTime);
//     // parsedDate += time.hour.toString() + ':' + time.minute.toString() + ':00';
//     parsedDate += stringTime + ':00';

//     //FIXME PROBLEMA CON IL PARSING DELLA DATA, FORMATO NON CORRETTO
//     //print('[DEBUG DATE] ' + DateTime.parse(parsedDate).toString());
//     print('[DEBUG DATE] ' + parsedDate);
//     print('[DEBUG TEST KEY] ' + testKey.toString());
//     if (testKey == null) {
//       if (_reservableTest.type == TestType.GENERIC_TEST) {
//         bloc.inNewGeneralReservation.add({
//           Constants.RESERVATION_NAME_KEY: _reservableTest.name,
//           Constants.RESERVATION_DATE_KEY: DateTime.parse(parsedDate),
//           Constants.RESERVATION_LOCATION_NAME_KEY: place,
//           Constants.RESERVATION_DESCRIPTION_KEY: inputDescription
//         });
//       } else {
//         print('In NEW TEST RESERVATION');
//         bloc.inNewTestWithReservation.add({
//           Constants.ORGAN_KEY:
//               Constants.DICT_TEST_TYPE_TO_ORGAN_KEY[_reservableTest.type],
//           Constants.TEST_TYPE_KEY: _reservableTest.type,
//           Constants.TEST_NAME_KEY: _reservableTest.name,
//           Constants.TEST_DESCRIPTION_KEY: inputDescription,
//           Constants.RESERVATION_DATE_KEY: DateTime.parse(parsedDate),
//           Constants.RESERVATION_LOCATION_NAME_KEY: place,
//         });
//       }
//     } else {
//       print(date.toString());
//       print(time.toString());
//       bloc.inNewReservation.add({
//         Constants.TEST_ID_KEY: this.testKey,
//         Constants.RESERVATION_DATE_KEY: DateTime.parse(parsedDate),
//         Constants.RESERVATION_LOCATION_NAME_KEY: this.place,
//         Constants.RESERVATION_LOCATION_KEY: null,
//         Constants.RESERVATION_DESCRIPTION_KEY: this.inputDescription,
//       });
//     }
//   }
// }
