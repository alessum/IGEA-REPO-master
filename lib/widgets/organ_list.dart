import 'package:flutter/material.dart';
import 'package:igea_app/blocs/situation_bloc.dart';
import 'package:igea_app/models/organ.dart';
import 'package:igea_app/screens/situation/cardio_system_detail_screen.dart';
import 'package:igea_app/screens/situation/organ_detail_screen.dart';
import 'package:igea_app/widgets/organ_detail.dart';

class OrganList extends StatefulWidget {
  @override
  _OrganListState createState() => _OrganListState();
  OrganList({this.initialPage, this.organList});
  final int initialPage;
  final Map<String, Organ> organList;
}

class _OrganListState extends State<OrganList> {
  // SituationBloc bloc;
  PageController _pageController;

  @override
  void initState() {
    super.initState();
    _pageController = PageController(
        initialPage: widget.initialPage - 2, viewportFraction: 0.8);
  }

  @override
  void dispose() {
    // bloc.dispose();
    super.dispose();
  }

  callbackRefresh() {
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    var media = MediaQuery.of(context).size;
    double value = 1;

    // bloc = SituationBlocProvider.of(context);
    // bloc.fetchAllOrgans();

    return PageView.builder(
        controller: _pageController,
        itemCount: widget.organList.length,
        itemBuilder: (ctx, index) {
          String key = widget.organList.keys.elementAt(index);
          print('[DATA DEBUG]');
          //print(snapshot.data[key].reservableTestList);
          return AnimatedBuilder(
            animation: _pageController,
            builder: (ctx, child) {
              if (_pageController.position.haveDimensions) {
                value = _pageController.page - index;
                value = 1 - (value.abs() * 0.35).clamp(0.0, 1.0);
              }
              return Center(
                child: SizedBox(
                  height: Curves.easeInOut.transform(value) * 280,
                  width: Curves.easeInOut.transform(value) * 400,
                  child: GestureDetector(
                    onTap: () => Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => key == '004'
                            ? CardioSystemDetailScreen(
                                organDetails: widget.organList[key],
                                organKey: key,
                              )
                            : SituationBlocProvider(
                                organKey: key,
                                child: OrganDetailScreen(
                                  organKey: key,
                                ),
                              ),
                      ),
                    ).then((value) => Navigator.pop(context)),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 10, vertical: 10),
                      child: Container(
                        padding: const EdgeInsets.all(10),
                        width: media.width * 0.3,
                        decoration: BoxDecoration(
                            color: Color(
                                int.parse(widget.organList[key].status.color)),
                            borderRadius:
                                BorderRadius.all(Radius.circular(25.0))),
                        child: child,
                      ),
                    ),
                  ),
                ),
              );
            },
            child: OrganDetail(
                organ: widget.organList[key],
                organKey: key,
                expanded: false,
                value: value),
          );
        });

    //FIXME USA STREAMBUILDER CON LETTURA A FIRESTORE
    // return StreamBuilder(
    //   stream: bloc.allOrgans,
    //   builder: (context, AsyncSnapshot<Map<Object, Organ>> snapshot) {
    //     print(snapshot);
    //     //print(snapshot.data);
    //     if (snapshot.hasData) {
    //       return PageView.builder(
    //           controller: _pageController,
    //           itemCount: snapshot.data.length,
    //           itemBuilder: (ctx, index) {
    //             String key = snapshot.data.keys.elementAt(index);
    //             print('[DATA DEBUG]');
    //             //print(snapshot.data[key].reservableTestList);
    //             return AnimatedBuilder(
    //               animation: _pageController,
    //               builder: (ctx, child) {
    //                 if (_pageController.position.haveDimensions) {
    //                   value = _pageController.page - index;
    //                   value = 1 - (value.abs() * 0.35).clamp(0.0, 1.0);
    //                 }
    //                 return Center(
    //                   child: SizedBox(
    //                     height: Curves.easeInOut.transform(value) * 280,
    //                     width: Curves.easeInOut.transform(value) * 350,
    //                     child: GestureDetector(
    //                       onTap: () => Navigator.push(
    //                         context,
    //                         MaterialPageRoute(
    //                           builder: (context) => key == '004'
    //                               ? CardioSystemDetailScreen(
    //                                   organDetails: snapshot.data[key],
    //                                   organKey: key,
    //                                 )
    //                               : SituationBlocProvider(
    //                                   child: OrganDetailScreen(
    //                                     organDetails: snapshot.data[key],
    //                                     organKey: key,
    //                                     fetchOrgans: () {
    //                                       setState(() {
    //                                         bloc.fetchAllOrgans();
    //                                       });
    //                                     },
    //                                   ),
    //                                 ),
    //                         ),
    //                       ),
    //                       child: Padding(
    //                         padding: const EdgeInsets.symmetric(
    //                             horizontal: 2, vertical: 10),
    //                         child: Container(
    //                           padding: const EdgeInsets.all(10),
    //                           width: media.width * 0.3,
    //                           decoration: BoxDecoration(
    //                               color: Color(int.parse(
    //                                   snapshot.data[key].status.color)),
    //                               borderRadius:
    //                                   BorderRadius.all(Radius.circular(25.0))),
    //                           child: child,
    //                         ),
    //                       ),
    //                     ),
    //                   ),
    //                 );
    //               },
    //               child: OrganDetail(
    //                   organ: snapshot.data[key],
    //                   organKey: key,
    //                   expanded: _expanded,
    //                   value: value),
    //             );
    //           });

    //       // ListView.builder(
    //       //   scrollDirection: Axis.horizontal,
    //       //   itemCount: snapshot.data.length,
    //       //   itemBuilder: (ctx, index) {
    //       //     String key = snapshot.data.keys.elementAt(index);
    //       //     return Padding(
    //       //       padding: const EdgeInsets.symmetric(vertical: 12.0),
    //       //       child: _buildGestureDetector(snapshot.data[key]),
    //       //     );
    //       //   },
    //       //   controller: _scrollController,
    //       //   physics: _physics,
    //       // );
    //     } else if (snapshot.hasError) {
    //       return Text(snapshot.error.toString());
    //     }
    //     return Center(child: CircularProgressIndicator());
    //   },
    // );
  }
}

// import 'package:flutter/material.dart';
// import 'package:igea_app/blocs/bloc_provider.dart';
// import 'package:igea_app/blocs/situation_bloc.dart';
// import 'package:igea_app/models/constants.dart';
// import 'package:igea_app/models/organ.dart';
// import 'package:igea_app/widgets/organ_detail.dart';

// class SituationContainer extends StatefulWidget {
//   @override
//   _SituationContainerState createState() => _SituationContainerState();
// }

// class _SituationContainerState extends State<SituationContainer> {
//   bool _expanded = false;
//   double _height = 300;

//   //final _scrollController = ScrollController();
//   //ScrollPhysics _physics;

//   PageController _pageController;

//   //BLoC
//   SituationBloc bloc;

//   void initState() {
//     super.initState();
//     _pageController = PageController(initialPage: 1, viewportFraction: 0.8);
//     bloc = BlocProvider.of<SituationBloc>(context);
//     bloc.fetchAllOrgans();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return AnimatedContainer(
//       duration: Duration(milliseconds: 1500),
//       curve: Curves.fastLinearToSlowEaseIn,
//       height: _height,
//       decoration: BoxDecoration(
//         color: Colors.white,
//         borderRadius: new BorderRadius.only(
//             topLeft: Radius.circular(25.0), topRight: Radius.circular(25.0)),
//       ),
//       padding: EdgeInsets.only(
//         top: 10,
//         bottom: MediaQuery.of(context).viewInsets.bottom + 10,
//       ),
//       child: Column(
//         children: <Widget>[
//           Text('Situazione',
//               style: TextStyle(
//                   fontSize: 40,
//                   color: Colors.black,
//                   fontWeight: FontWeight.w300)),
//           Expanded(
//             child: StreamBuilder(
//               stream: bloc.allOrgans,
//               builder: (context, AsyncSnapshot<Map<Object, Organ>> snapshot) {
//                 //print(snapshot.data);
//                 if (snapshot.hasData) {
//                   // _scrollController.addListener(
//                   //   () {
//                   //     if (_scrollController.position.haveDimensions &&
//                   //         _physics == null) {
//                   //       setState(() {
//                   //         var dimension =
//                   //             _scrollController.position.maxScrollExtent /
//                   //                 (snapshot.data.length - 1);
//                   //         _physics =
//                   //             CustomScrollPhysics(itemDimension: dimension);
//                   //       });
//                   //     }
//                   //   },
//                   // );
//                   return PageView.builder(
//                       controller: _pageController,
//                       itemCount: snapshot.data.length,
//                       itemBuilder: (ctx, index) {
//                         String key = snapshot.data.keys.elementAt(index);
//                         print(snapshot.data);
//                         return AnimatedBuilder(
//                           animation: _pageController,
//                           builder: (ctx, widget) {
//                             double value = 1;
//                             if (_pageController.position.haveDimensions) {
//                               value = _pageController.page - index;
//                               value = 1 - (value.abs() * 0.35).clamp(0.0, 1.0);
//                             }
//                             return Center(
//                               child: SizedBox(
//                                 height: Curves.easeInOut.transform(value) * 700,
//                                 width: Curves.easeInOut.transform(value) * 400,
//                                 child: GestureDetector(
//                                   onTap: () => setState(() {
//                                     if (!_expanded) {
//                                       _height =
//                                           MediaQuery.of(context).size.height *
//                                               0.85;
//                                       _expanded = true;
//                                     } else {
//                                       _height =
//                                           MediaQuery.of(context).size.height *
//                                               0.38;
//                                       _expanded = false;
//                                     }
//                                   }),
//                                   child: Padding(
//                                     padding: const EdgeInsets.symmetric(
//                                         horizontal: 5, vertical: 10),
//                                     child: Container(
//                                       padding: const EdgeInsets.all(10),
//                                       width: 315,
//                                       decoration: BoxDecoration(
//                                           color: Color(
//                                               snapshot.data[key].status[
//                                                   ModelConstants
//                                                       .ORGAN_STATUS_COLOR_KEY]),
//                                           borderRadius: BorderRadius.all(
//                                               Radius.circular(25.0))),
//                                       child: AnimatedOpacity(
//                                           duration: Duration(milliseconds: 300),
//                                           curve: Curves.easeInOut,
//                                           opacity: _expanded ? value : 1,
//                                           child: widget),
//                                     ),
//                                   ),
//                                 ),
//                               ),
//                             );
//                           },
//                           child: BlocProvider(
//                             bloc: SituationBloc(),
//                             child: OrganDetail(
//                               organ: snapshot.data[key],
//                               expanded: _expanded,
//                             ),
//                           ),
//                         );
//                       });

//                   // ListView.builder(
//                   //   scrollDirection: Axis.horizontal,
//                   //   itemCount: snapshot.data.length,
//                   //   itemBuilder: (ctx, index) {
//                   //     String key = snapshot.data.keys.elementAt(index);
//                   //     return Padding(
//                   //       padding: const EdgeInsets.symmetric(vertical: 12.0),
//                   //       child: _buildGestureDetector(snapshot.data[key]),
//                   //     );
//                   //   },
//                   //   controller: _scrollController,
//                   //   physics: _physics,
//                   // );
//                 } else if (snapshot.hasError) {
//                   return Text(snapshot.error.toString());
//                 }
//                 return Center(child: CircularProgressIndicator());
//               },
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }
