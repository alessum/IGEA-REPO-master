// import 'dart:math';
// import 'package:flutter/material.dart';
// import 'package:igea_app/models/outcome_blood_test.dart';

// class CustomExpansionTileBloodTestArchive extends StatefulWidget {
//   final String leading;
//   final String trailing;
//   // final OutcomeBloodTest outcome;

//   CustomExpansionTileBloodTestArchive(
//       {this.leading = '', this.trailing = '', this.outcome});

//   @override
//   _CustomExpansionTileBloodTestArchiveState createState() =>
//       _CustomExpansionTileBloodTestArchiveState();
// }

// class _CustomExpansionTileBloodTestArchiveState
//     extends State<CustomExpansionTileBloodTestArchive>
//     with SingleTickerProviderStateMixin {
//   AnimationController _controller;
//   Animation<double> _expandAnimation;
//   Animation<double> _rotateAnimation;
//   bool _expand = false;

//   @override
//   void initState() {
//     super.initState();
//     prepareAnimations();
//     _runExpandCheck();
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
//     double mediaHeight = MediaQuery.of(context).size.height;
//     double mediaWidth = MediaQuery.of(context).size.width;
//     return Container(
//         width: 340.0,
//         child: Column(mainAxisSize: MainAxisSize.min, children: <Widget>[
//           Container(
//             height: 50,
//             width: 340,
//             child: Card(
//                 elevation: 1.0,
//                 color: Color(0xff4768b7),
//                 shape: RoundedRectangleBorder(
//                     borderRadius: BorderRadius.circular(25.0)),
//                 child: Padding(
//                     padding: const EdgeInsets.only(left: 15.0, right: 5.0),
//                     child: Row(
//                         mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                         children: <Widget>[
//                           Text(
//                             widget.leading,
//                             style: TextStyle(
//                               fontSize: mediaWidth * 0.05,
//                               fontWeight: FontWeight.w900,
//                               color: Colors.white,
//                             ),
//                           ),
//                           Row(
//                             mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                             children: <Widget>[
//                               Text(
//                                 widget.trailing,
//                                 style: TextStyle(
//                                   fontSize: mediaWidth * 0.06,
//                                   fontWeight: FontWeight.w300,
//                                   color: Colors.white,
//                                 ),
//                               ),
//                               GestureDetector(
//                                   onTap: () {
//                                     setState(() {
//                                       _expand = !_expand;
//                                     });
//                                     _runExpandCheck();
//                                   },
//                                   child: Padding(
//                                     padding: const EdgeInsets.only(
//                                         left: 15.0, right: 5.0),
//                                     child: Container(
//                                       decoration: BoxDecoration(
//                                           shape: BoxShape.circle,
//                                           color: Color(0xff142c85)),
//                                       child: Transform.rotate(
//                                           angle: _rotateAnimation.value,
//                                           child: Icon(Icons.expand_more,
//                                               color: Color(0xff4768b7))),
//                                     ),
//                                   ))
//                             ],
//                           ),
//                         ]))),
//           ),
//           SizeTransition(
//               axisAlignment: 1.0,
//               sizeFactor: _expandAnimation,
//               child: Padding(
//                   padding: const EdgeInsets.symmetric(horizontal: 20.0),
//                   child: Container(
//                       height: 500,
//                       width: 320,
//                       color: Colors.transparent,
//                       child: Card(
//                           elevation: 1.0,
//                           color: Colors.grey[200],
//                           child: Padding(
//                             padding: const EdgeInsets.symmetric(vertical: 10.0),
//                             child: Column(
//                                 mainAxisAlignment:
//                                     MainAxisAlignment.spaceBetween,
//                                 children: <Widget>[
//                                   Padding(
//                                     padding: const EdgeInsets.symmetric(
//                                         horizontal: 10.0),
//                                     child: Row(
//                                         mainAxisAlignment:
//                                             MainAxisAlignment.spaceBetween,
//                                         children: <Widget>[
//                                           Text('Trigliceridi: ',
//                                               style: TextStyle(
//                                                   fontSize: 18,
//                                                   color: Colors.grey[900])),
//                                           Row(
//                                             children: <Widget>[
//                                               SizedBox(
//                                                   width: 85,
//                                                   child: Container(
//                                                     height: 60,
//                                                     width: 10,
//                                                     child: Card(
//                                                         elevation: 0.0,
//                                                         color:
//                                                             Color(0xffdfdfdf),
//                                                         shape: RoundedRectangleBorder(
//                                                             borderRadius:
//                                                                 BorderRadius
//                                                                     .circular(
//                                                                         30.0)),
//                                                         child: Padding(
//                                                           padding:
//                                                               const EdgeInsets
//                                                                       .symmetric(
//                                                                   horizontal:
//                                                                       6.0),
//                                                           child: Center(
//                                                             child: Text(
//                                                                 '$widget.outcome.tryglicerides',
//                                                                 style:
//                                                                     TextStyle(
//                                                                   fontSize: 16,
//                                                                   fontWeight:
//                                                                       FontWeight
//                                                                           .w700,
//                                                                   color: Colors
//                                                                       .black,
//                                                                 )),
//                                                           ),
//                                                         )),
//                                                   )),
//                                               Text('[mg/dl]',
//                                                   style: TextStyle(
//                                                       fontSize: 16,
//                                                       color: Colors.grey[900])),
//                                             ],
//                                           )
//                                         ]),
//                                   ),
//                                   Padding(
//                                     padding: const EdgeInsets.symmetric(
//                                         horizontal: 10.0),
//                                     child: Row(
//                                         mainAxisAlignment:
//                                             MainAxisAlignment.spaceBetween,
//                                         children: <Widget>[
//                                           Text('Colesterolo\nTotale: ',
//                                               style: TextStyle(
//                                                   fontSize: 18,
//                                                   color: Colors.grey[900])),
//                                           Row(
//                                             children: <Widget>[
//                                               SizedBox(
//                                                   width: 85,
//                                                   child: Container(
//                                                     height: 60,
//                                                     width: 10,
//                                                     child: Card(
//                                                         elevation: 0.0,
//                                                         color:
//                                                             Color(0xffdfdfdf),
//                                                         shape: RoundedRectangleBorder(
//                                                             borderRadius:
//                                                                 BorderRadius
//                                                                     .circular(
//                                                                         30.0)),
//                                                         child: Padding(
//                                                           padding:
//                                                               const EdgeInsets
//                                                                       .symmetric(
//                                                                   horizontal:
//                                                                       6.0),
//                                                           child: Center(
//                                                             child: Text(
//                                                                 '$widget.outcome.cholesterolTot',
//                                                                 style:
//                                                                     TextStyle(
//                                                                   fontSize: 16,
//                                                                   fontWeight:
//                                                                       FontWeight
//                                                                           .w700,
//                                                                   color: Colors
//                                                                       .black,
//                                                                 )),
//                                                           ),
//                                                         )),
//                                                   )),
//                                               Text('[mg/dl]',
//                                                   style: TextStyle(
//                                                       fontSize: 16,
//                                                       color: Colors.grey[900])),
//                                             ],
//                                           )
//                                         ]),
//                                   ),
//                                   Padding(
//                                     padding: const EdgeInsets.symmetric(
//                                         horizontal: 10.0),
//                                     child: Row(
//                                         mainAxisAlignment:
//                                             MainAxisAlignment.spaceBetween,
//                                         children: <Widget>[
//                                           Text('Colesterolo\nHDL: ',
//                                               style: TextStyle(
//                                                   fontSize: 18,
//                                                   color: Colors.grey[900])),
//                                           Row(
//                                             children: <Widget>[
//                                               SizedBox(
//                                                   width: 85,
//                                                   child: Container(
//                                                     height: 60,
//                                                     width: 10,
//                                                     child: Card(
//                                                         elevation: 0.0,
//                                                         color:
//                                                             Color(0xffdfdfdf),
//                                                         shape: RoundedRectangleBorder(
//                                                             borderRadius:
//                                                                 BorderRadius
//                                                                     .circular(
//                                                                         30.0)),
//                                                         child: Padding(
//                                                           padding:
//                                                               const EdgeInsets
//                                                                       .symmetric(
//                                                                   horizontal:
//                                                                       6.0),
//                                                           child: Center(
//                                                             child: Text(
//                                                                 '$widget.outcome.cholesterolHDL',
//                                                                 style:
//                                                                     TextStyle(
//                                                                   fontSize: 16,
//                                                                   fontWeight:
//                                                                       FontWeight
//                                                                           .w700,
//                                                                   color: Colors
//                                                                       .black,
//                                                                 )),
//                                                           ),
//                                                         )),
//                                                   )),
//                                               Text('[mg/dl]',
//                                                   style: TextStyle(
//                                                       fontSize: 16,
//                                                       color: Colors.grey[900])),
//                                             ],
//                                           )
//                                         ]),
//                                   ),
//                                   Padding(
//                                     padding: const EdgeInsets.symmetric(
//                                         horizontal: 10.0),
//                                     child: Row(
//                                         mainAxisAlignment:
//                                             MainAxisAlignment.spaceBetween,
//                                         children: <Widget>[
//                                           Text('Colesterolo\nLDL: ',
//                                               style: TextStyle(
//                                                   fontSize: 18,
//                                                   color: Colors.grey[900])),
//                                           Row(
//                                             children: <Widget>[
//                                               SizedBox(
//                                                   width: 85,
//                                                   child: Container(
//                                                     height: 60,
//                                                     width: 10,
//                                                     child: Card(
//                                                         elevation: 0.0,
//                                                         color:
//                                                             Color(0xffdfdfdf),
//                                                         shape: RoundedRectangleBorder(
//                                                             borderRadius:
//                                                                 BorderRadius
//                                                                     .circular(
//                                                                         30.0)),
//                                                         child: Padding(
//                                                           padding:
//                                                               const EdgeInsets
//                                                                       .symmetric(
//                                                                   horizontal:
//                                                                       6.0),
//                                                           child: Center(
//                                                             child: Text(
//                                                                 '$widget.outcome.cholesterolLDL',
//                                                                 style:
//                                                                     TextStyle(
//                                                                   fontSize: 16,
//                                                                   fontWeight:
//                                                                       FontWeight
//                                                                           .w700,
//                                                                   color: Colors
//                                                                       .black,
//                                                                 )),
//                                                           ),
//                                                         )),
//                                                   )),
//                                               Text('[mg/dl]',
//                                                   style: TextStyle(
//                                                       fontSize: 16,
//                                                       color: Colors.grey[900])),
//                                             ],
//                                           )
//                                         ]),
//                                   ),
//                                   Padding(
//                                     padding: const EdgeInsets.only(
//                                         left: 10.0, right: 5.0),
//                                     child: Row(
//                                         mainAxisAlignment:
//                                             MainAxisAlignment.spaceBetween,
//                                         children: <Widget>[
//                                           Text('Pressione\nsistolica: ',
//                                               style: TextStyle(
//                                                   fontSize: 18,
//                                                   color: Colors.grey[900])),
//                                           Row(
//                                             //TODO rimuovere pressione sistolica
//                                             children: <Widget>[
//                                               SizedBox(
//                                                   width: 85,
//                                                   child: Container(
//                                                     height: 60,
//                                                     width: 10,
//                                                     child: Card(
//                                                         elevation: 0.0,
//                                                         color:
//                                                             Color(0xffdfdfdf),
//                                                         shape: RoundedRectangleBorder(
//                                                             borderRadius:
//                                                                 BorderRadius
//                                                                     .circular(
//                                                                         30.0)),
//                                                         child: Padding(
//                                                           padding:
//                                                               const EdgeInsets
//                                                                       .symmetric(
//                                                                   horizontal:
//                                                                       6.0),
//                                                           child: Center(
//                                                             child: Text(
//                                                                 '$widget.outcome.systolicPressure', //TODO pressione sistolica
//                                                                 style:
//                                                                     TextStyle(
//                                                                   fontSize: 16,
//                                                                   fontWeight:
//                                                                       FontWeight
//                                                                           .w700,
//                                                                   color: Colors
//                                                                       .black,
//                                                                 )),
//                                                           ),
//                                                         )),
//                                                   )),
//                                               Text('[mmHg]',
//                                                   style: TextStyle(
//                                                       fontSize: 16,
//                                                       color: Colors.grey[900])),
//                                             ],
//                                           )
//                                         ]),
//                                   ),
//                                   Padding(
//                                     padding: const EdgeInsets.only(
//                                         left: 10.0, right: 70.0),
//                                     child: Row(
//                                         mainAxisAlignment:
//                                             MainAxisAlignment.spaceBetween,
//                                         children: <Widget>[
//                                           Text('Ipertensione: ',
//                                               style: TextStyle(
//                                                   fontSize: 18,
//                                                   color: Colors.grey[900])),
//                                           SizedBox(
//                                               width: 70,
//                                               child: Container(
//                                                 height: 60,
//                                                 width: 10,
//                                                 child: Card(
//                                                     elevation: 0.0,
//                                                     color: Color(0xffdfdfdf),
//                                                     shape:
//                                                         RoundedRectangleBorder(
//                                                             borderRadius:
//                                                                 BorderRadius
//                                                                     .circular(
//                                                                         30.0)),
//                                                     child: Padding(
//                                                       padding: const EdgeInsets
//                                                               .symmetric(
//                                                           horizontal: 12.0),
//                                                       child: Center(
//                                                         //TODO VERIFICARE IPERTENSIONE
//                                                         child: Text(
//                                                             widget.outcome
//                                                                     .hypertension
//                                                                 ? 'Si'
//                                                                 : 'No',
//                                                             style: TextStyle(
//                                                               fontSize: 16,
//                                                               fontWeight:
//                                                                   FontWeight
//                                                                       .w700,
//                                                               color:
//                                                                   Colors.black,
//                                                             )),
//                                                       ),
//                                                     )),
//                                               ))
//                                         ]),
//                                   ),
//                                   SizedBox(height: 10.0),
//                                   Padding(
//                                     padding: const EdgeInsets.only(
//                                         left: 10.0, right: 30.0),
//                                     child: Row(
//                                         mainAxisAlignment:
//                                             MainAxisAlignment.spaceBetween,
//                                         children: <Widget>[
//                                           Text('Referto: ',
//                                               style: TextStyle(
//                                                   fontSize: 18,
//                                                   color: Colors.grey[900])),
//                                           SizedBox(
//                                               width: 150,
//                                               child: Center(
//                                                 child: RichText(
//                                                   text: TextSpan(
//                                                       text: 'referto.pdf',
//                                                       style: TextStyle(
//                                                           color: Colors.blue,
//                                                           fontSize: 16,
//                                                           fontWeight:
//                                                               FontWeight.bold,
//                                                           decoration:
//                                                               TextDecoration
//                                                                   .underline,
//                                                           fontFamily:
//                                                               'FilsonSoft')),
//                                                 ),
//                                               ))
//                                         ]),
//                                   ),
//                                   SizedBox(height: 10.0),
//                                   Padding(
//                                     padding: const EdgeInsets.symmetric(
//                                         horizontal: 10.0),
//                                     child: Row(
//                                       mainAxisAlignment:
//                                           MainAxisAlignment.spaceBetween,
//                                       children: <Widget>[
//                                         Column(
//                                           children: <Widget>[
//                                             Text('Prossima\nvisita:',
//                                                 style: TextStyle(
//                                                     fontSize: 18,
//                                                     color: Colors.grey[900])),
//                                           ],
//                                         ),
//                                         Stack(
//                                           children: <Widget>[
//                                             Container(
//                                               margin: EdgeInsets.only(left: 15),
//                                               width: 150,
//                                               height: 50,
//                                               decoration: BoxDecoration(
//                                                   color: Color(0xffdfdfdf),
//                                                   borderRadius:
//                                                       BorderRadius.circular(
//                                                           30)),
//                                               child: Center(
//                                                 child: Text(
//                                                   '21/06/2021',
//                                                   style: TextStyle(
//                                                     fontSize: 20,
//                                                     fontWeight: FontWeight.w700,
//                                                     color: Colors.black,
//                                                   ),
//                                                 ),
//                                               ),
//                                             ),
//                                             Positioned(
//                                               top: 13,
//                                               left: 5,
//                                               child: Container(
//                                                 decoration: BoxDecoration(
//                                                     shape: BoxShape.circle,
//                                                     color: Colors.white),
//                                                 child: GestureDetector(
//                                                     onTap: () {
//                                                       showCustomDialog(context);
//                                                     },
//                                                     child: Icon(
//                                                         Icons.info_outline,
//                                                         size: 25)),
//                                               ),
//                                             ),
//                                           ],
//                                         ),
//                                       ],
//                                     ),
//                                   )
//                                 ]),
//                           )))))
//         ]));
//   }

//   void showCustomDialog(BuildContext ctx) {
//     Dialog simpleDialog = Dialog(
//       backgroundColor: Colors.transparent,
//       child: Container(
//         height: 150,
//         width: 300,
//         child: Padding(
//           padding: const EdgeInsets.symmetric(horizontal: 10),
//           child: Container(
//             decoration: BoxDecoration(
//               color: Color(0xff4768b7),
//               borderRadius: BorderRadius.circular(15),
//             ),
//             height: 180,
//             width: 350,
//             child: Center(
//               child: Padding(
//                 padding: const EdgeInsets.symmetric(horizontal: 8.0),
//                 child: Text(
//                     'Si informa che la data è impostata automaticamente sulla base delle linee guida ministeriali relative all\'esame in questione.',
//                     style: TextStyle(
//                         fontSize: 20,
//                         fontWeight: FontWeight.w400,
//                         color: Colors.white),
//                     textAlign: TextAlign.left),
//               ),
//             ),
//           ),
//         ),
//       ),
//     );
//     showDialog(context: ctx, builder: (ctx) => simpleDialog);
//   }
// }
