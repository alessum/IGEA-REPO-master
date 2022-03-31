import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:igea_app/widgets/ui_components/psyco_question.dart';

class BehaviourQuestionary1 extends StatefulWidget {
  BehaviourQuestionary1({Key key, @required this.flashToPage})
      : super(key: key);

  final Function(int page) flashToPage;

  @override
  _BehaviourQuestionary1State createState() => _BehaviourQuestionary1State();
}

class _BehaviourQuestionary1State extends State<BehaviourQuestionary1> {
  final PageController _pageController = PageController(initialPage: 0);
  List<int> _answList = List<int>(6); //NOTE: insert here number of questions

  @override
  Widget build(BuildContext context) {
    Size media = MediaQuery.of(context).size;

    List<Widget> questionList = [
      PsycoQuestionary(
          question:
              'Se mi ammalo è proprio il mio comportamento che determina quanto preso starò bene di nuovo',
          number: 1,
          numDots: 5,
          setScore: (score) {
            _answList[0] = score;
          }),
      PsycoQuestionary(
          question:
              'Non importa ciò che faccio: se mi devo ammalare, mi ammalerò',
          number: 2,
          numDots: 5,
          setScore: (score) {
            _answList[1] = score;
          }),
      PsycoQuestionary(
          question:
              'Avere dei contatti regolari con il mio medico è il miglior modo per evitare la malattia',
          number: 3,
          numDots: 5,
          setScore: (score) {
            _answList[2] = score;
          }),
      PsycoQuestionary(
          question:
              'Molte cose che compromettono la mia salute mi accadono per caso',
          number: 4,
          numDots: 5,
          setScore: (score) {
            _answList[3] = score;
          }),
      PsycoQuestionary(
          question:
              'Nel caso in cui non mi sentissi bene, dovrei consultare un medico',
          number: 5,
          numDots: 5,
          setScore: (score) {
            _answList[4] = score;
          }),
      PsycoQuestionary(
          question: 'Ti piace ricevere molte notifiche?',
          number: 6,
          numDots: 5,
          setScore: (score) {
            _answList[5] = score;
          }),
      GestureDetector(
        onTap: () {
          widget.flashToPage(0);
        },
        child: Container(
            margin: EdgeInsets.symmetric(horizontal: 120),
            padding: EdgeInsets.symmetric(vertical: 10),
            decoration: BoxDecoration(
              color: Color(0xff6DAEBF),
              borderRadius: BorderRadius.all(Radius.circular(25)),
            ),
            child: Center(
              child: Text(
                'Conferma',
                style: TextStyle(
                    fontSize: media.width * 0.05,
                    color: Colors.white,
                    fontFamily: 'Gotham'),
              ),
            )),
      )
    ];
    return Scaffold(
      backgroundColor: Color(0xFF87C0D3),
      // appBar: AppBar(
      //   backgroundColor: Color(0xFF87C0D3),
      //   elevation: 0,
      //   title: Platform.isIOS
      //       ? GestureDetector(
      //           onTap: () {
      //             widget.flashToPage(2);
      //           },
      //           child: Container(
      //             width: media.width * 0.22,
      //             height: media.width * 0.18,
      //             padding: EdgeInsets.symmetric(vertical: 8, horizontal: 5),
      //             child: Align(
      //               alignment: Alignment.center,
      //               child: Container(
      //                 width: media.width * 0.5,
      //                 padding: EdgeInsets.all(media.width < 350 ? 5 : 8),
      //                 decoration: BoxDecoration(
      //                     color: Color(0xFF5C88C1),
      //                     borderRadius: BorderRadius.all(Radius.circular(35)),
      //                     border: Border.all(
      //                         style: BorderStyle.solid,
      //                         color: Colors.white,
      //                         width: 1.5)),
      //                 child: Center(
      //                     child: Icon(
      //                   Icons.arrow_upward,
      //                   color: Colors.white,
      //                   size: media.width * 0.09,
      //                 )),
      //               ),
      //             ),
      //           ))
      //       : Column(
      //           children: [
      //             SizedBox(
      //               height: media.height * 0.004,
      //             ),
      //             Center(
      //               child: GestureDetector(
      //                   onTap: () {
      //                     widget.flashToPage(2);
      //                   },
      //                   child: Container(
      //                     width: media.width * 0.21,
      //                     height: media.width * 0.17,
      //                     padding:
      //                         EdgeInsets.symmetric(vertical: 8, horizontal: 5),
      //                     child: Align(
      //                       alignment: Alignment.center,
      //                       child: Container(
      //                         width: media.width * 0.5,
      //                         padding:
      //                             EdgeInsets.all(media.width < 350 ? 5 : 8),
      //                         decoration: BoxDecoration(
      //                             color: Color(0xFF5C88C1),
      //                             borderRadius:
      //                                 BorderRadius.all(Radius.circular(35)),
      //                             border: Border.all(
      //                                 style: BorderStyle.solid,
      //                                 color: Colors.white,
      //                                 width: 1.5)),
      //                         child: Center(
      //                             child: Icon(
      //                           Icons.arrow_upward,
      //                           color: Colors.white,
      //                           size: media.width * 0.09,
      //                         )),
      //                       ),
      //                     ),
      //                   )),
      //             ),
      //           ],
      //         ),
      // ),
      body: SafeArea(
        child: Container(
            child: Column(
          children: [
            Container(
              height: media.height * 0.05,
              padding: EdgeInsets.only(left: 10),
              margin: EdgeInsets.symmetric(horizontal: 35),
              decoration: BoxDecoration(
                  color: Color(0xff6DAEBF),
                  borderRadius: BorderRadius.all(Radius.circular(25)),
                  border: Border.all(
                      style: BorderStyle.solid,
                      color: Colors.white,
                      width: 1.5)),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  SvgPicture.asset(
                    'assets/icons/numbers/1.svg',
                    width: 23,
                  ),
                  SizedBox(width: 10),
                  Text(
                    'Questionario Locus of Control',
                    style: TextStyle(
                        fontFamily: 'Gotham',
                        fontSize: media.width * 0.04,
                        color: Colors.white),
                  ),
                ],
              ),
            ),
            SizedBox(height: media.height * 0.01),
            Container(
              height: media.height * 0.7,
              // child: PageView(
              //   controller: _pageController,
              //   scrollDirection: Axis.vertical,
              //   physics: NeverScrollableScrollPhysics(),
              //   children: <Widget>[buildQuestionsList(media)],
              // ),
              child: ListView.separated(
                itemCount: questionList.length,
                itemBuilder: (context, index) => questionList[index],
                separatorBuilder: (context, index) => SizedBox(height: 1),
              ),
            )
          ],
        )),
      ),
    );
  }

  Widget buildQuestionsList(
    Size media,
  ) {
    return Container(
      //TODO listview di domande
      child: Column(
        children: [
          PsycoQuestionary(
              question: 'Ti piace ricevere molte notifiche?',
              number: 1,
              numDots: 4,
              setScore: (score) {
                _answList[0] = score;
              }),
          PsycoQuestionary(
              question: 'Ti piace ricevere molte notifiche?',
              number: 2,
              numDots: 5,
              setScore: (score) {
                _answList[1] = score;
              }),
          PsycoQuestionary(
              question: 'Ti piace ricevere molte notifiche?',
              number: 3,
              numDots: 7,
              setScore: (score) {
                _answList[2] = score;
              }),
          PsycoQuestionary(
              question: 'Ti piace ricevere molte notifiche?',
              number: 4,
              numDots: 4,
              setScore: (score) {
                _answList[3] = score;
              }),
        ],
      ),
    );
  }
}
