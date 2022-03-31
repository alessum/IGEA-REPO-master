import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:igea_app/blocs/bloc_chatbot.dart';
import 'package:igea_app/blocs/bloc_gamification.dart';
import 'package:igea_app/blocs/bloc_home.dart';
import 'package:igea_app/models/enums/gender.dart';
import 'package:igea_app/models/organ.dart';
import 'package:igea_app/models/registry.dart';
import 'package:igea_app/models/user.dart';
import 'package:igea_app/screens/calendar/calendar_screen.dart';
import 'package:igea_app/screens/diary/diary_screen.dart';
import 'package:igea_app/screens/quiz/quiz_main_screen.dart';
import 'package:igea_app/screens/situation/situation_screen.dart';
import 'package:igea_app/screens/chatbot/chatbot.dart';
import 'package:igea_app/widgets/calendarContainer.dart';
import 'package:igea_app/screens/situation/situation_card.dart';
import 'package:igea_app/widgets/category_card.dart';
import 'package:flutter_svg/svg.dart';
import "package:igea_app/constant.dart";
import 'package:igea_app/screens/gamification/gamification_screen.dart';
import 'package:igea_app/widgets/nav_drawer.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  HomeBloc bloc;

  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

  void _showSituation(BuildContext ctx, String organKey) {
    showModalBottomSheet(
      context: ctx,
      builder: (_) {
        return SituationModalBottomSheet(organKey: organKey);
      },
      backgroundColor: Colors.black.withOpacity(0),
      isScrollControlled: true,
    );
    bloc.inUserKey.add('data');
  }

  @override
  Widget build(BuildContext context) {
    var media = MediaQuery.of(context).size;
    bloc = HomeBlocProvider.of(context);
    return Scaffold(
      key: _scaffoldKey,
      backgroundColor: light_Background,
      drawerEdgeDragWidth: 0,
      endDrawer: Theme(
        data: Theme.of(context).copyWith(canvasColor: Colors.transparent),
        child: StreamBuilder<PrevengoUser>(
            stream: bloc.user,
            builder: (context, snapshot) {
              return NavDrawer(snapshot.hasData
                  ? snapshot.data.registryData.username
                  : 'Utente');
            }),
      ),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        automaticallyImplyLeading: false,
        title: StreamBuilder<PrevengoUser>(
            stream: bloc.user,
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                DateTime today = DateTime.now();
                String hello;
                if (today.hour <= 12) {
                  hello = 'Buongiorno\n';
                } else if (today.hour > 12 && today.hour <= 17) {
                  hello = 'Buon pomeriggio\n';
                } else {
                  hello = 'Buonasera\n';
                }
                return Align(
                    alignment: Alignment.centerLeft,
                    child: RichText(
                      text: TextSpan(
                        text: hello,
                        style: TextStyle(
                            color: Colors.black54,
                            fontSize: media.width * 0.06,
                            fontFamily: 'Bold'),
                        children: <TextSpan>[
                          TextSpan(
                            text: '${snapshot.data.registryData.username}',
                            style: TextStyle(
                                color: kMenuText,
                                fontSize: media.width * 0.06,
                                fontFamily: 'Gotham'),
                          ),
                          // TextSpan(text: '!'),
                        ],
                      ),
                    ));
              } else
                return Container();
            }),
        actions: <Widget>[
          Padding(
            padding: const EdgeInsets.only(right: 16),
            child: GestureDetector(
              onTap: () {
                _scaffoldKey.currentState.openEndDrawer();
                //_showRegistry(context);
                //Navigator.push(context, MaterialPageRoute(builder: (context) => RegistryScreen()));

                // AuthService authService = AuthService();
                // authService.signOut();
                // Navigator.push(context, MaterialPageRoute(builder: (context) => Authenticate()));
              },
              child: SvgPicture.asset(
                "assets/icons/menu.svg",
                height: 30,
              ),
            ),
          ),
        ],
      ),
      body: SafeArea(
        child: Stack(
          children: <Widget>[
            Container(
              padding: EdgeInsets.all(3.0),
              child: Column(
                children: <Widget>[
                  Expanded(
                    child: StaggeredGridView.count(
                      crossAxisCount: 2,
                      crossAxisSpacing: 12.0,
                      mainAxisSpacing: 12.0,
                      padding: EdgeInsets.symmetric(
                          horizontal: 16.0, vertical: 20.0),
                      children: <Widget>[
                        Card(
                            clipBehavior: Clip.antiAlias,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(25.0)),
                            color: light_Button,
                            elevation: 15,
                            child: Stack(
                              children: [
                                Align(
                                  alignment: Alignment.bottomCenter,
                                  child: SvgPicture.asset(
                                    'assets/icons/grass.svg',
                                    width: media.width * .888,
                                    color: Colors.green[400],
                                    fit: BoxFit.fill,
                                  ),
                                ),
                                Column(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceAround,
                                  children: <Widget>[
                                    ListTile(
                                      title: Align(
                                        alignment: Alignment.topLeft,
                                        child: Text(
                                          'Situazione',
                                          style: TextStyle(
                                              color: kMenuText,
                                              fontSize: media.width * 0.04,
                                              fontWeight: FontWeight.w900),
                                        ),
                                      ),
                                      trailing: CircleAvatar(
                                        backgroundColor: Colors.transparent,
                                        minRadius: 16,
                                        maxRadius: 16,
                                        child: (SvgPicture.asset(
                                            "assets/icons/location.svg",
                                            height: media.height * 0.04,
                                            color: kActiveIconColor)),
                                      ),
                                    ),
                                    Expanded(
                                      child: Padding(
                                        padding: EdgeInsets.only(bottom: 10.0),
                                        child:
                                            StreamBuilder<Map<String, Organ>>(
                                          stream: bloc.allOrgans,
                                          builder: (context, snapshot) {
                                            return snapshot.hasData
                                                ? GridView.builder(
                                                    itemCount:
                                                        snapshot.data.length,
                                                    itemBuilder:
                                                        (context, index) {
                                                      String key = snapshot
                                                          .data.keys
                                                          .elementAt(index);
                                                      return GestureDetector(
                                                        child: SituationCard(
                                                          organIcon: snapshot
                                                              .data[key]
                                                              .imagePath,
                                                          statusIcon: snapshot
                                                              .data[key]
                                                              .status
                                                              .iconPath,
                                                          statusColor: Color(
                                                            int.parse(snapshot
                                                                .data[key]
                                                                .status
                                                                .color),
                                                          ),
                                                        ),
                                                        onTap: () {
                                                          showModalBottomSheet(
                                                            context: context,
                                                            builder: (_) =>
                                                                SituationModalBottomSheet(
                                                              organList:
                                                                  snapshot.data,
                                                              organKey: key,
                                                            ),
                                                            backgroundColor:
                                                                Colors.black
                                                                    .withOpacity(
                                                                        0),
                                                            isScrollControlled:
                                                                true,
                                                          );
                                                        },
                                                      );
                                                    },
                                                    gridDelegate:
                                                        SliverGridDelegateWithFixedCrossAxisCount(
                                                      childAspectRatio:
                                                          (media.width * 0.25) /
                                                              (media.height *
                                                                  0.05),
                                                      crossAxisCount: 2,
                                                      crossAxisSpacing: 6.0,
                                                      mainAxisSpacing: 6.0,
                                                    ),
                                                  )
                                                : Center(
                                                    child:
                                                        CircularProgressIndicator(),
                                                  );
                                          },
                                        ),
                                      ),
                                    )
                                  ],
                                ),
                              ],
                            )),
                        CategoryCard(
                          title: "Diario",
                          svgSrc: "assets/icons/exam.svg",
                          press: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => DiaryScreen()));
                          },
                          shadow: "assets/icons/shadow1.svg",
                        ),
                        CategoryCard(
                          title: "Calendario",
                          svgSrc: "assets/icons/calendar.svg",
                          press: () {
                            //_showCalendar(context);
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => CalendarScreen()));
                          },
                          shadow: "assets/icons/shadow2.svg",
                        ),
                        CategoryCard(
                          title: "Divulgazione",
                          svgSrc: "assets/icons/play.svg",
                          press: () {
                            setState(() {});
                          },
                          shadow: "assets/icons/shadow3.svg",
                        ),
                        CategoryCard(
                          title: "Quiz e premi",
                          svgSrc: "assets/icons/umbrella.svg",
                          press: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => PrimaryPreventionScreen(),
                              ),
                            );
                          },
                          shadow: "assets/icons/shadow4.svg",
                        ),
                      ],
                      staggeredTiles: [
                        StaggeredTile.extent(2, 230),
                        StaggeredTile.extent(1, media.height * .19),
                        StaggeredTile.extent(1, media.height * .19),
                        StaggeredTile.extent(1, media.height * .21),
                        StaggeredTile.extent(1, media.height * .21),
                      ],
                    ),
                  )
                ],
              ),
            ),
            // Align(
            //     alignment: Alignment.bottomRight,
            //     child: Padding(
            //       padding: const EdgeInsets.fromLTRB(0.0, 0.0, 20.0, 0.0),
            //       child: FloatingActionButton(
            //         onPressed: null,
            //         backgroundColor: Colors.white,
            //       ),
            //     )),
            // Align(
            //   alignment: Alignment.topCenter,
            //   child: Container(
            //     margin: EdgeInsets.fromLTRB(10, 10, 10, 65),
            //     height: 700,
            //     width: double.maxFinite,
            //     decoration: BoxDecoration(
            //       color: Colors.white,
            //       borderRadius: BorderRadius.all(Radius.circular(25)),
            //       boxShadow: [
            //         BoxShadow(
            //           color: Colors.grey.withOpacity(0.5),
            //           spreadRadius: 2,
            //           blurRadius: 10,
            //           offset: Offset(0, 2), // changes position of shadow
            //         )
            //       ],
            //     ),
            //   ),
            // )
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
          onPressed: () => Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => ChatbotBlocProvider(
                    child: Chatbot(
                      suggestedMessageList: [],
                    ),
                  ),
                ),
              ),
          child: SvgPicture.asset(
            'assets/avatars/arold_in_circle.svg',
            height: 60,
          )),
    );
  }
}
