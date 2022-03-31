import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:igea_app/widgets/ui_components/psyco_question.dart';

class PsychoLocQuestionnarieScreen extends StatefulWidget {
  @override
  _PsychoLocQuestionnarieScreenState createState() =>
      _PsychoLocQuestionnarieScreenState();
}

class _PsychoLocQuestionnarieScreenState
    extends State<PsychoLocQuestionnarieScreen> {
  List<int> _answList = List<int>(6); //NOTE: insert here number of questions

  List<Widget> questionList = [
    PsycoQuestionary(
      question:
          'Se mi ammalo è proprio il mio comportamento che determina quanto preso starò bene di nuovo',
      number: 1,
      numDots: 5,
      // setScore: (score) {
      //   _answList[0] = score;
      // }),
    ),
    PsycoQuestionary(
      question: 'Non importa ciò che faccio: se mi devo ammalare, mi ammalerò',
      number: 2,
      numDots: 5,
      // setScore: (score) {
      //   _answList[1] = score;
      // }),
    ),
    PsycoQuestionary(
      question:
          'Avere dei contatti regolari con il mio medico è il miglior modo per evitare la malattia',
      number: 3,
      numDots: 5,
      // setScore: (score) {
      //   _answList[2] = score;
      // }),
    ),
    PsycoQuestionary(
      question:
          'Molte cose che compromettono la mia salute mi accadono per caso',
      number: 4,
      numDots: 5,
      // setScore: (score) {
      //   _answList[3] = score;
      // }),
    ),
    PsycoQuestionary(
      question:
          'Nel caso in cui non mi sentissi bene, dovrei consultare un medico',
      number: 5,
      numDots: 5,
      // setScore: (score) {
      //   _answList[4] = score;
      // }),
    ),
    PsycoQuestionary(
      question: 'Ti piace ricevere molte notifiche?',
      number: 6,
      numDots: 5,
      // setScore: (score) {
      //   _answList[5] = score;
      // }),
    ),
  ];
  @override
  Widget build(BuildContext context) {
    Size media = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Color(0xFF87C0D3),
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Color(0xFF87C0D3),
        title: Center(
          child: Container(
            padding: EdgeInsets.all(8),
            decoration: BoxDecoration(
                color: Color(0xff6DAEBF),
                borderRadius: BorderRadius.all(Radius.circular(25)),
                border: Border.all(
                    style: BorderStyle.solid, color: Colors.white, width: 1.5)),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                Container(
                  width: media.width * 0.08,
                  child: SvgPicture.asset(
                    'assets/icons/numbers/1.svg',
                    width: media.width * 0.07,
                  ),
                ),
                Container(
                  width: media.width * .63,
                  child: Text(
                    'Conosciamoci meglio',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        fontFamily: 'Gotham',
                        fontSize: media.width * 0.05,
                        color: Colors.white),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
      body: Container(
          padding: EdgeInsets.only(
              bottom: media.height * .02, top: media.height * .01),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                padding: EdgeInsets.symmetric(horizontal: media.width * .05),
                child: Text(
                  'Questionario sul Locus of Control',
                  style: TextStyle(
                    fontSize: media.width * .07,
                    fontFamily: 'Gotham',
                    color: Colors.white,
                  ),
                ),
              ),
              ConstrainedBox(
                constraints: BoxConstraints(maxHeight: media.height * .65),
                child: ListView.separated(
                  shrinkWrap: true,
                  itemCount: questionList.length,
                  itemBuilder: (context, index) => questionList[index],
                  separatorBuilder: (context, index) => SizedBox(height: 1),
                ),
              ),
              GestureDetector(
                onTap: () {
                  //TODO AVVIARE ALGORITMO PSICOLOGICO SUL LOCUS OF CONTROL
                  Navigator.pop(context);
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
            ],
          )),
    );
  }
}
