import 'package:flutter/material.dart';
import 'package:igea_app/widgets/ui_components/vote_button.dart';

class PsycoQuestionary extends StatefulWidget {
  PsycoQuestionary({
    Key key,
    @required this.question,
    @required this.number,
    @required this.numDots,
    @required this.setScore,
  }) : super(key: key);

  final String question;
  final int number;
  final int numDots;
  final Function(int value) setScore;

  @override
  _PsycoQuestionaryState createState() => _PsycoQuestionaryState();
}

class _PsycoQuestionaryState extends State<PsycoQuestionary> {
  List<Widget> voteButtonList = List();

  List<bool> checkVoteButtonList = List();

  void _populateVoteButtonList() {
    print('[num dots ] ' + widget.numDots.toString());
    // for (int i = 0; i < widget.numDots; i++) {
    //   checkVoteButtonList.add(false);
    //   voteButtonList.add(VoteButton(
    //       value: i, number: widget.number, check: checkVoteButtonList[i]));
    // }

    checkVoteButtonList = List<bool>.generate(widget.numDots, (index) => false);
    print('bool length ' + checkVoteButtonList.length.toString());
  }

  @override
  void initState() {
    super.initState();
    _populateVoteButtonList();
  }

  @override
  Widget build(BuildContext context) {
    Size media = MediaQuery.of(context).size;
    String _text = '';
    final children = <Widget>[];

    List<Widget> voteButtonList = List<Widget>.generate(
        widget.numDots,
        (index) => (VoteButton(
            value: index,
            number: widget.number,
            check: checkVoteButtonList[index])));

    print('vote button list length ' + voteButtonList.length.toString());
    print('bool length ' + checkVoteButtonList.length.toString());
    print(checkVoteButtonList.toString());

    return Container(
      // height: media.height * 0.022,
      margin: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      padding: EdgeInsets.symmetric(horizontal: 15, vertical: 15),
      decoration: BoxDecoration(
          color: Color(0x22000000),
          borderRadius: BorderRadius.all(Radius.circular(25))),
      child: Column(
        children: [
          Text(
            widget.question,
            style: TextStyle(
                fontFamily: 'Book',
                color: Colors.white,
                fontSize: media.height * 0.021),
          ),
          SizedBox(
            height: media.height * 0.02,
          ),
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Text(
                '1',
                style: TextStyle(
                    fontFamily: 'Gotham',
                    color: Colors.white,
                    fontSize: media.height * 0.022),
              ),
              Container(
                width: media.width * 0.065 * (widget.numDots - 1) +
                    media.width * (0.02 * 2 + 0.05),
                height: media.width * 0.08,
                padding: EdgeInsets.fromLTRB(media.width * 0.02, 0, 0, 0),
                decoration: new BoxDecoration(
                    color: Color(0x33fFFFFF),
                    borderRadius: BorderRadius.all(Radius.circular(25))),
                // child: Row(
                //   mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                //   children: [
                //     Table(
                //         border: TableBorder.all(color: Colors.black),
                //         columnWidths: {
                //           0: FixedColumnWidth(100.0),
                //           1: FixedColumnWidth(100.0)
                //         },
                //         children: [
                //           for (var i = 0; i < widget.numDots; i++)
                //             TableRow(children: [
                //               VoteButton(value: i, number: widget.number),
                //             ])
                //         ]),
                //   ],
                // ),
                child: Align(
                  alignment: Alignment.center,
                  child: ListView.separated(
                    separatorBuilder: (context, index) =>
                        SizedBox(width: media.width * 0.015),
                    itemCount: voteButtonList.length,
                    scrollDirection: Axis.horizontal,
                    itemBuilder: (context, index) {
                      return GestureDetector(
                        onTap: () {
                          setState(() {
                            print(checkVoteButtonList.toString());
                            checkVoteButtonList.replaceRange(
                                0,
                                checkVoteButtonList.length - 1,
                                List<bool>.generate(
                                    widget.numDots, (index) => false));

                            checkVoteButtonList[index] = true;

                            widget.setScore(index + 1);

                            // voteButtonList.replaceRange(
                            //     0,
                            //     voteButtonList.length - 1,
                            //     List<Widget>.generate(
                            //         voteButtonList.length - 1,
                            //         (index) => VoteButton(
                            //             value: index,
                            //             number: widget.number,
                            //             check: true)));
                          });
                        },
                        child: voteButtonList[index],
                      );
                    },
                  ),
                ),
              ),
              Text(
                widget.numDots.toString(),
                style: TextStyle(
                    fontFamily: 'Gotham',
                    color: Colors.white,
                    fontSize: media.height * 0.022),
              ),
            ],
          )
        ],
      ),
    );
  }
}
