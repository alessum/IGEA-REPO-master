import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_svg/svg.dart';
import 'package:igea_app/blocs/diary/bloc_diary_archive.dart';
import 'package:igea_app/blocs/diary/bloc_new_outcome.dart';
import 'package:igea_app/blocs/diary/diary_bloc.dart';
import 'package:igea_app/models/constants/constants.dart';
import 'package:igea_app/models/test.dart';
import 'package:igea_app/screens/diary/diary_add_outcome_screen.dart';
import 'package:igea_app/screens/diary/diary_archive_screen.dart';
import 'package:igea_app/screens/diary/outcome_widgets_factory.dart';
import 'package:tuple/tuple.dart';

class DiaryScreen extends StatelessWidget {
  DiaryScreen({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size media = MediaQuery.of(context).size;

    return DiaryBlocProvider(
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: Colors.white,
          elevation: 0,
          leadingWidth: media.width * 0.12,
          titleSpacing: media.width * 0.05,
          leading: Padding(
            padding: const EdgeInsets.only(left: 8.0),
            child: GestureDetector(
              onTap: () => Navigator.pop(context),
              child: SvgPicture.asset(
                'assets/icons/circle_left.svg',
                color: Colors.black,
              ),
            ),
          ),
          title: Text(
            'Diario degli esiti',
            textAlign: TextAlign.left,
            style: TextStyle(
                fontSize: media.width * 0.07,
                color: Colors.black,
                fontFamily: 'Gotham'),
          ),
        ),
        body: DiaryContent(),
      ),
    );
  }
}

class DiaryContent extends StatefulWidget {
  @override
  _DiaryContentState createState() => _DiaryContentState();
}

class _DiaryContentState extends State<DiaryContent> {
  DiaryBloc bloc;
  //final ScrollController _scrollController = new ScrollController();

  @override
  void dispose() {
    bloc.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Size media = MediaQuery.of(context).size;
    bloc = DiaryBlocProvider.of(context);

    //_scrollController.jumpTo(_scrollController.position.minScrollExtent);

    return Column(
      mainAxisSize: MainAxisSize.max,
      children: <Widget>[
        Padding(
            padding: EdgeInsets.only(
                top: media.height * 0.05, bottom: media.height * 0.02),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                GestureDetector(
                  onTap: () {
                    setState(() {
                      //_diaryScreen = 'archive';
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => DiaryArchiveBlocProvider(
                              child: DiaryArchiveScreen()),
                        ),
                      );
                    });
                  },
                  child: Stack(
                    children: <Widget>[
                      Container(
                          height: media.height * 0.14,
                          width: media.width * 0.4,
                          margin: EdgeInsets.fromLTRB(10.0, 3.0, 10.0, 0),
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(25),
                              color: Color(0xFFEDF1F4))),
                      Positioned(
                        top: 15.0,
                        left: 25.0,
                        child: AutoSizeText(
                          'Archivio',
                          textAlign: TextAlign.left,
                          style: TextStyle(
                              fontSize: media.width * 0.05,
                              color: Color(0xff4768b7),
                              fontFamily: 'Gotham'),
                          maxLines: 1,
                        ),
                      ),
                      Positioned(
                          bottom: media.height * 0.017,
                          right: media.width * 0.07,
                          child: CircleAvatar(
                            backgroundColor: Colors.white,
                            radius: media.width * 0.06,
                            child: SvgPicture.asset('assets/icons/archive.svg',
                                width: media.width < 350 ? 20 : 25),
                          ))
                    ],
                  ),
                ),
                GestureDetector(
                  onTap: () => Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => NewOutcomeBlocProvider(
                        child: DiaryAddOutcomeScreen(),
                      ),
                    ),
                  ).then((value) {
                    setState(() {});
                  }),
                  child: Stack(
                    children: <Widget>[
                      Container(
                          height: media.height * 0.14,
                          width: media.width * 0.4,
                          margin: EdgeInsets.fromLTRB(10.0, 3.0, 10.0, 0),
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(25),
                              color: Color(0xFFEDF1F4))),
                      Positioned(
                        top: 15.0,
                        left: 25.0,
                        child: AutoSizeText('Aggiungi\nesito',
                            textAlign: TextAlign.left,
                            style: TextStyle(
                                fontSize: media.width * 0.05,
                                color: Color(0xff4768b7),
                                fontFamily: 'Gotham'),
                            maxLines: 2),
                      ),
                      Positioned(
                          bottom: media.height * 0.017,
                          right: media.width * 0.07,
                          child: CircleAvatar(
                            backgroundColor: Colors.white,
                            radius: media.width * 0.06,
                            child: SvgPicture.asset('assets/icons/add_esito.svg',
                                width: media.width < 350 ? 20 : 25),
                          ))
                    ],
                  ),
                ),
              ],
            )),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: media.width * 0.05),
          child: ConstrainedBox(
            constraints: BoxConstraints(
                minHeight: media.height * .4, maxHeight: media.height * .6),
            // height: media.height * 0.5,
            // margin: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            child: StreamBuilder<Map<String, Test>>(
                stream: bloc.allTests,
                builder: (context, snapshot) {
                  print('snapshot ${snapshot.data}');
                  return snapshot.hasData
                      ? ListView.separated(
                          //controller: _scrollController,
                          scrollDirection: Axis.vertical,
                          reverse: false,
                          padding: EdgeInsets.only(bottom: media.height * .05),
                          shrinkWrap: true,
                          separatorBuilder: (BuildContext context, _) {
                            return SizedBox(
                              height: 10,
                            );
                          },
                          itemCount: snapshot.data.length,
                          itemBuilder: (ctx, index) {
                            String key = snapshot.data.keys.elementAt(index);

                            var outcomeTileFactory =
                                OutcomeWidgetsFactory.instance();

                            return outcomeTileFactory.createTileTestOutcome(
                              context,
                              Tuple2(key, snapshot.data[key]),
                              (values) {
                                values.addAll({
                                  Constants.TEST_ID_KEY: key,
                                  key: snapshot.data[key]
                                });
                                //bloc.inUpdateOutcomeScreening.add(values);
                              },
                            );
                          },
                        )
                      : CircularProgressIndicator();
                }),
          ),
        ),
      ],
    );
  }
}
