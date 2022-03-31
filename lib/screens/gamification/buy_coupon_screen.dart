// import 'package:flutter/material.dart';
// import 'package:flutter_svg/svg.dart';
// import 'package:igea_app/models/constants/constants_graphics.dart';
// import 'package:igea_app/widgets/ui_components/close_line_top_modal.dart';
// import 'package:igea_app/blocs/bloc_awards.dart';
// import 'package:igea_app/widgets/ui_components/coupon_card.dart';
// import 'package:igea_app/models/gamification/coupon.dart';
// import 'package:igea_app/widgets/modal_bottom_sheets/confirmation_alert.dart';

// class BuyCouponsScreen extends StatefulWidget {
//   BuyCouponsScreen({Key key}) : super(key: key);

//   @override
//   _BuyCouponsScreenState createState() => _BuyCouponsScreenState();
// }

// class _BuyCouponsScreenState extends State<BuyCouponsScreen> {
//   AwardsBloc bloc;

//   @override
//   Widget build(BuildContext context) {
//     Size media = MediaQuery.of(context).size;
//     bloc = AwardsBlocProvider.of(context);
//     bloc.fetchPurchasableCoupons();
//     return Scaffold(
//       backgroundColor: Colors.white,
//       appBar: AppBar(
//         leadingWidth: 0,
//         title: Align(
//           alignment: Alignment.topLeft,
//           child: Text('Prevenzione primaria',
//               textAlign: TextAlign.left,
//               style: TextStyle(
//                   fontSize: media.width * 0.07,
//                   color: Colors.black,
//                   fontFamily: 'Gotham')),
//         ),
//         backgroundColor: Colors.transparent,
//         elevation: 0,
//       ),
//       body: Align(
//         alignment: Alignment.bottomLeft,
//         child: Container(
//           padding: EdgeInsets.only(
//             top: media.height * 0.01,
//             bottom: media.height * 0.02,
//           ),
//           decoration: BoxDecoration(
//             color: ConstantsGraphics.COLOR_ONBOARDING_YELLOW,
//             borderRadius: BorderRadius.only(
//               topRight: Radius.circular(80),
//             ),
//           ),
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.center,
//             mainAxisAlignment: MainAxisAlignment.spaceBetween,
//             children: [
//               CloseLineTopModal(),
//               SizedBox(height: media.height * 0.01),
//               Row(
//                 mainAxisAlignment: MainAxisAlignment.start,
//                 children: <Widget>[
//                   Flexible(
//                     flex: 4,
//                     fit: FlexFit.loose,
//                     child: ListTile(
//                       leading: GestureDetector(
//                           onTap: () => Navigator.pop(context),
//                           child: SvgPicture.asset(
//                             'assets/icons/circle_left.svg',
//                             width: media.width * 0.09,
//                           )),
//                       title: Text('Compra Coupons',
//                           textAlign: TextAlign.left,
//                           style: TextStyle(
//                               fontSize: media.width * 0.068,
//                               color: Colors.white,
//                               fontFamily: 'Gotham')),
//                     ),
//                   ),
//                 ],
//               ),
//               SizedBox(height: media.height * 0.01),
//               Container(
//                 child: Align(
//                   alignment: Alignment.centerLeft,
//                   child: Row(
//                     mainAxisAlignment: MainAxisAlignment.start,
//                     children: [
//                       SizedBox(
//                         width: media.width * 0.08,
//                       ),
//                       Text(
//                         'Crediti spendibili:',
//                         style: TextStyle(
//                             fontFamily: 'Book',
//                             fontSize: media.width * 0.04,
//                             color: Colors.white),
//                       ),
//                     ],
//                   ),
//                 ),
//               ),
//               SizedBox(height: media.height * 0.01),
//               Row(mainAxisAlignment: MainAxisAlignment.end, children: [
//                 Container(
//                   child: RichText(
//                     text: TextSpan(
//                       text: '19000 ',
//                       style: TextStyle(
//                         fontFamily: 'Gotham',
//                         fontSize: media.width * 0.07,
//                       ),
//                       children: <TextSpan>[
//                         TextSpan(
//                             text: 'crediti  ',
//                             style: TextStyle(
//                               fontFamily: 'Light',
//                               fontSize: media.width * 0.07,
//                             )),
//                       ],
//                     ),
//                   ),
//                 )
//               ]),
//               SizedBox(height: media.height * 0.01),
//               Container(
//                 child: Row(
//                   mainAxisAlignment: MainAxisAlignment.start,
//                   children: [
//                     SizedBox(
//                       width: media.width * .08,
//                     ),
//                     Text(
//                       'Coupons disponibili:',
//                       style: TextStyle(
//                         color: Colors.white,
//                         fontFamily: 'Bold',
//                         fontSize: media.width * 0.04,
//                       ),
//                     ),
//                   ],
//                 ),
//               ),
//               SizedBox(height: media.height * 0.01),
//               Container(
//                 height: media.height * 0.5,
//                 width: media.width * 0.9,
//                 child: StreamBuilder<Map<String, Coupon>>(
//                     stream: bloc.purchasableCoupons,
//                     builder: (context, snapshot) => snapshot.hasData
//                         ? ListView.separated(
//                             itemBuilder: (context, index) {
//                               String key = snapshot.data.keys.elementAt(index);
//                               return CouponCard(
//                                 title: snapshot.data[key].title,
//                                 value: snapshot.data[key].price,
//                                 logoImage: snapshot.data[key].logoImage,
//                                 buttonLabel: 'Acquista',
//                                 onTap: () => showModalBottomSheet(
//                                   context: context,
//                                   builder: (_) => ModalBottomConfirmation(
//                                     confirmationLabel: 'Sei sicuro di voler acquistare il buono per ${snapshot.data[key].price} ghiande?',
//                                     agreeButtonColor: ConstantsGraphics
//                                         .COLOR_ONBOARDING_YELLOW,
//                                     disagreeButtonColor: ConstantsGraphics
//                                         .COLOR_ONBOARDING_YELLOW,
//                                     onPress: null,
//                                   ),
//                                   backgroundColor: Colors.black.withOpacity(0),
//                                   isScrollControlled: true,
//                                 ),
//                               );
//                             },
//                             separatorBuilder: (_, __) =>
//                                 SizedBox(height: media.height * 0.03),
//                             itemCount: snapshot.data.length,
//                           )
//                         : Center(
//                             child: CircularProgressIndicator(),
//                           )),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }
