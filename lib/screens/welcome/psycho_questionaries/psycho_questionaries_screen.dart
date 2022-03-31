import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:igea_app/screens/welcome/psycho_questionaries/psycho_loc_questionnarie_screen.dart';
import 'package:igea_app/screens/welcome/psycho_questionaries/ui_components/psycho_questionnarie_card.dart';

class PsychoQuestionnariesScreen extends StatefulWidget {
  @override
  _PsychoQuestionnariesScreenState createState() =>
      _PsychoQuestionnariesScreenState();
}

class _PsychoQuestionnariesScreenState
    extends State<PsychoQuestionnariesScreen> {
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
      body: SafeArea(
        child: Container(
            child: Column(
          children: [
            PsychoQuestionnarieCard(
              title: 'Questionario Locus of Control',
              description: 'Mi serve per capire il tuo tipo di personalità',
              onStart: () => Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => PsychoLocQuestionnarieScreen(),
                ),
              ),
            ),
            PsychoQuestionnarieCard(
              title: 'Questionario psicologico',
              description:
                  'Con poche domande capiro\' quali sono i tuoi livelli d\'ansia e stress',
              onStart: () => null,
            ),
          ],
        )),
      ),
    );
  }
}
