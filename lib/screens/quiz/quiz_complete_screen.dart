import 'package:flutter/material.dart';
import 'package:igea_app/models/constants/constants_graphics.dart';
import 'package:igea_app/blocs/bloc_home.dart';
import 'package:igea_app/screens/home/home.dart';

class QuizCompleteScreen extends StatelessWidget {
  const QuizCompleteScreen({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size media = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: ConstantsGraphics.COLOR_ONBOARDING_BLUE,
      body: Center(
        child: Container(
          height: 100,
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Container(
                  child: Center(
                    child: Text(
                      'Quiz Terminato',
                      style: TextStyle(
                        fontFamily: 'Gotham',
                        fontSize: media.width * 0.1,
                      ),
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    Navigator.push(context, MaterialPageRoute(builder: (context) => HomeBlocProvider(child: Home())));
                  },
                                  child: Container(
                    width: media.width * 0.6,
                    padding: EdgeInsets.all(15),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.all(
                        Radius.circular(25),
                      ),
                    ),
                    child: Center(
                      child: Text(
                        'Torna alla Home',
                        style: TextStyle(
                          fontFamily: 'Bold',
                          color: ConstantsGraphics.COLOR_ONBOARDING_BLUE,
                          fontSize: media.width * 0.05,
                        ),
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
