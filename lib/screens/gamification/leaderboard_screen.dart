import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:igea_app/models/constants/constants_graphics.dart';
import 'package:igea_app/screens/quiz/quiz_game_screen.dart';
//import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:igea_app/widgets/ui_components/close_line_top_modal.dart';

// class LeaderBoardScreen extends StatefulWidget {
//   LeaderBoardScreen({Key key}) : super(key: key);

//   @override
//   _LeaderBoardScreenState createState() => _LeaderBoardScreenState();
// }

// class _LeaderBoardScreenState extends State<LeaderBoardScreen> {

class LeaderBoardScreen extends StatefulWidget {
  @override
  _LeaderBoardScreenState createState() => _LeaderBoardScreenState();
}

class _LeaderBoardScreenState extends State<LeaderBoardScreen> {
  List<LeaderBoardItem> _leaderBoardItems = <LeaderBoardItem>[];
  List<LeaderBoardItem> _mineBoardItems = <LeaderBoardItem>[];

  @override
  Widget build(BuildContext context) {
    generateDummyData();
    generateMyData();
    Size media = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        toolbarHeight: media.height * 0.15,
        leadingWidth: 0,
        title: Text(
          'Quiz e premi',
          style: TextStyle(
              fontSize: media.width * 0.07,
              color: Colors.black,
              fontFamily: 'Gotham'),
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: Align(
        alignment: Alignment.bottomLeft,
        child: Container(
          height: media.height * 0.85,
          padding: EdgeInsets.fromLTRB(
              media.width * 0.09, media.height * 0.015, media.width * 0.09, 0),
          decoration: BoxDecoration(
            color: ConstantsGraphics.COLOR_ONBOARDING_YELLOW,
            borderRadius: BorderRadius.only(
              topRight: Radius.circular(80),
            ),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              // CloseLineTopModal(),
              SizedBox(height: media.height * 0.005),
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
                      title: Text('la Classifica',
                          textAlign: TextAlign.left,
                          style: TextStyle(
                              fontSize: media.width * 0.07,
                              color: Colors.white,
                              fontFamily: 'Gotham')),
                    ),
                  ),
                ],
              ),
              SizedBox(height: media.height * 0.01),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Text(
                    'posiz.',
                    style: TextStyle(
                      fontSize: media.width * 0.04,
                      color: Colors.white,
                      fontFamily: 'Light',
                    ),
                  ),
                  SizedBox(
                    width: media.width * 0.1,
                  ),
                  Text(
                    'nome',
                    style: TextStyle(
                      fontSize: media.width * 0.04,
                      color: Colors.white,
                      fontFamily: 'Light',
                    ),
                  ),
                  SizedBox(
                    width: media.width * 0.1,
                  ),
                  Text(
                    'punti',
                    style: TextStyle(
                      fontSize: media.width * 0.04,
                      color: Colors.white,
                      fontFamily: 'Light',
                    ),
                  ),
                ],
              ),
              SizedBox(height: media.height * 0.005),
              Container(
                height: media.height * 0.58,
                child: ListView.builder(
                    itemCount: _leaderBoardItems.length,
                    itemBuilder: (BuildContext ctxt, int index) =>
                        buildList(ctxt, index, _leaderBoardItems)),
              ),
              Container(
                height: media.height * 0.055,
                // margin: EdgeInsets.only(bottom: media.height * 0.005),
                child: ListView.builder(
                    itemCount: 1,
                    itemBuilder: (BuildContext ctxt, int index) =>
                        buildList(ctxt, index, _mineBoardItems)),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildList(
      BuildContext ctxt, int index, List<LeaderBoardItem> _leaderBoardItems) {
    Size media = MediaQuery.of(context).size;
    List<LeaderBoardItem> _list = _leaderBoardItems;
    int ind = _list[index].index;

    Widget crown;

    if (ind == 1) {
      crown = Container(
          width: media.width * 0.1,
          child: Stack(
            alignment: Alignment.center,
            children: <Widget>[
              Container(
                // padding: EdgeInsets.only(left: 8.0, top: 6),
                child: Positioned(
                    left: media.width * .035,
                    child: Text(
                      '1',
                      style: TextStyle(
                        fontSize: media.width * 0.04,
                        color: Colors.white,
                        fontFamily: 'Gotham',
                      ),
                    )),
              ),
              Positioned(
                  top: media.height * .006,
                  left: media.width * .036,
                  child: SvgPicture.asset(
                    'assets/icons/crown.svg',
                    width: media.width * 0.03,
                    color: Color(0xffFAD55E),
                  )),
            ],
          ));
    } else if (ind == 2) {
      crown = Container(
          width: media.width * 0.1,
          child: Stack(
            alignment: Alignment.center,
            children: <Widget>[
              Container(
                // padding: EdgeInsets.only(left: 8.0, top: 6),
                child: Positioned(
                    left: media.width * .035,
                    child: Text(
                      '2',
                      style: TextStyle(
                        fontSize: media.width * 0.04,
                        color: Colors.white,
                        fontFamily: 'Gotham',
                      ),
                    )),
              ),
              Positioned(
                  top: media.height * .006,
                  left: media.width * .036,
                  child: SvgPicture.asset(
                    'assets/icons/crown.svg',
                    width: media.width * 0.03,
                    color: Color(0xffD3D3C5),
                  )),
            ],
          ));
    } else if (ind == 3) {
      crown = Container(
          width: media.width * 0.1,
          child: Stack(
            alignment: Alignment.center,
            children: <Widget>[
              Container(
                // padding: EdgeInsets.only(left: 8.0, top: 6),
                child: Positioned(
                    left: media.width * .035,
                    child: Text(
                      '3',
                      style: TextStyle(
                        fontSize: media.width * 0.04,
                        color: Colors.white,
                        fontFamily: 'Gotham',
                      ),
                    )),
              ),
              Positioned(
                  top: media.height * .006,
                  left: media.width * .036,
                  child: SvgPicture.asset(
                    'assets/icons/crown.svg',
                    width: media.width * 0.03,
                    color: Color(0xffECA46A),
                  )),
            ],
          ));
    } else {
      crown = Container(
          width: media.width * 0.1,
          child: Center(
            child: Text(
              ind.toString(),
              style: TextStyle(
                fontSize: media.width * 0.04,
                color: Colors.white,
                fontFamily: 'Gotham',
              ),
            ),
          ));
    }

    return Padding(
      padding: EdgeInsets.only(
          left: media.width * 0.02,
          right: media.width * 0.02,
          top: media.height * 0.005),
      child: Container(
        height: media.height * .045,
        decoration: BoxDecoration(
          color: (_list.length == 1)
              ? Color(0x55000000)
              : (ind < 4)
                  ? Color(0x44000000)
                  : Color(0x11000000),
          borderRadius: BorderRadius.all(Radius.circular(30.0)),
          // boxShadow: [BoxShadow(color: Colors.black26, blurRadius: 5.0)]
        ),
        child: Row(
          children: <Widget>[
            Expanded(
              child: Align(
                alignment: Alignment.centerLeft,
                child: Row(
                  children: <Widget>[
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Padding(
                        padding: EdgeInsets.only(
                            left: media.width * 0.02,
                            right: media.width * 0.18),
                        child: crown,
                      ),
                    ),
                    // Align(
                    //   child: CircleAvatar(
                    //     backgroundColor: Colors.red.shade800,
                    //     child: Text('GI'),
                    //     radius: 30,
                    //   ),
                    // ),
                    Align(
                        child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Padding(
                          padding: EdgeInsets.only(left: media.width * 0.03),
                          child: Text(
                            _list[index].user,
                            style: TextStyle(
                              fontSize: media.width * 0.04,
                              color: Colors.white,
                              fontFamily: 'Light',
                            ),
                          ),
                        ),
                      ],
                    )),
                  ],
                ),
              ),
            ),
            Align(
              alignment: Alignment.centerRight,
              child: Padding(
                padding: EdgeInsets.symmetric(
                  vertical: 0,
                  horizontal: media.width * 0.03,
                ),
                child: Text(
                  _list[index].points.toString(),
                  style: TextStyle(
                    fontSize: media.width * 0.04,
                    color: Colors.white,
                    fontFamily: 'Gotham',
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  void generateDummyData() {
    _leaderBoardItems = <LeaderBoardItem>[];

    for (var i = 1; i < 15; i++) {
      LeaderBoardItem lbi = LeaderBoardItem(
        index: 15 - i,
        user: 'user$i',
        points: 1000 * i,
      );

      _leaderBoardItems.add(lbi);
    }

    _leaderBoardItems = _leaderBoardItems.reversed.toList();
  }

  void generateMyData() {
    _mineBoardItems = <LeaderBoardItem>[];

    LeaderBoardItem lbi = LeaderBoardItem(
      index: 18,
      user: 'sonoIo',
      points: 800,
    );

    _mineBoardItems.add(lbi);

    _mineBoardItems = _mineBoardItems.reversed.toList();
  }
}

class LeaderBoardItem extends StatelessWidget {
  const LeaderBoardItem({
    Key key,
    @required this.index,
    @required this.user,
    @required this.points,
  }) : super(key: key);

  final int index;
  final String user;
  final int points;

  @override
  Widget build(BuildContext context) {
    return null;
  }
}
