import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:igea_app/blocs/diary/bloc_diary_archive.dart';
import 'package:igea_app/blocs/diary/diary_bloc.dart';
import 'package:igea_app/models/test.dart';
import 'package:igea_app/screens/diary/archive_filter.dart';
import 'package:igea_app/widgets/customExpansionTileScreeningArchive.dart';
import 'package:tuple/tuple.dart';

class DiaryArchiveScreen extends StatefulWidget {
  DiaryArchiveScreen({
    Key key,
  }) : super(key: key);


  @override
  _DiaryArchiveScreenState createState() => _DiaryArchiveScreenState();
}

class _DiaryArchiveScreenState extends State<DiaryArchiveScreen> {

  DiaryArchiveBloc bloc;

  @override
  Widget build(BuildContext context) {
    Size media = MediaQuery.of(context).size;
    bloc = DiaryArchiveBlocProvider.of(context);

    return Scaffold(
      body: Container(
        child: Column(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Align(
              alignment: Alignment.topLeft,
              child: Padding(
                padding: EdgeInsets.fromLTRB(
                    media.width * 0.05, media.height * 0.07, 0.0, 0.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    GestureDetector(
                        onTap: () => Navigator.pop(context),
                        child: SvgPicture.asset(
                          'assets/icons/circle_left.svg',
                          color: Colors.black,
                          width: media.width * 0.095,
                        )),
                    SizedBox(width: media.width * 0.06),
                    Text('Diario',
                        textAlign: TextAlign.left,
                        style: TextStyle(
                            fontSize: media.width * 0.07,
                            color: Colors.black,
                            fontFamily: 'Gotham')),
                  ],
                ),
              ),
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              mainAxisSize: MainAxisSize.max,
              children: <Widget>[
                DiaryTestFilter(),
                Container(
                    height: media.height * 0.5,
                    margin: EdgeInsets.symmetric(
                        horizontal: media.width * 0.06,
                        vertical: media.height * 0.0),
                    child: StreamBuilder<Map<String, Test>>(
                        stream: bloc.allTests,
                        builder: (context, snapshot) => snapshot.hasData
                            ? ListView.separated(
                                separatorBuilder:
                                    (BuildContext context, int index) {
                                  return SizedBox(
                                    height: 13,
                                  );
                                },
                                itemCount: snapshot.data.length,
                                itemBuilder: (ctx, index) {
                                  String key =
                                      snapshot.data.keys.elementAt(index);
                                  return DiaryBlocProvider(
                                    child: TileScreeningOutcome(
                                      testData: Tuple2<String, Test>(
                                        key,
                                        snapshot.data[key],
                                      ),
                                      onUpdateOutcome: null,
                                    ),
                                  );
                                })
                            : CircularProgressIndicator())),
              ],
            )
          ],
        ),
      ),
    );
  }
}
