import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:igea_app/blocs/bloc_home.dart';
import 'package:igea_app/screens/home/home.dart';

class LimboScreen extends StatefulWidget {
  LimboScreen({Key key}) : super(key: key);

  @override
  _LimboScreenState createState() => _LimboScreenState();
}

class _LimboScreenState extends State<LimboScreen> {
  @override
  Widget build(BuildContext context) {
    Size media = MediaQuery.of(context).size;

    return Container(
      child: Scaffold(
          body: Container(
        padding: EdgeInsets.all(20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            SvgPicture.asset(
              'assets/avatars/arold_extended.svg',
              height: media.height * 0.3,
            ),
            SizedBox(
              height: media.height * 0.05,
            ),
            Text(
              'Ho visto che non hai ancora compilato tutti i questionari, tranquillo, lo potrai fare più tardi',
              style: TextStyle(
                  fontFamily: 'Book',
                  color: Color(0xFF445362),
                  fontSize: media.width * 0.045),
              textAlign: TextAlign.center,
            ),
            SizedBox(
              height: media.height * 0.05,
            ),
            GestureDetector(
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => HomeBlocProvider(
                        child: Home(),
                      ),
                    ));
              },
              child: Container(
                width: media.width * 0.5,
                margin: EdgeInsets.only(top: media.width * 0.05),
                padding: EdgeInsets.symmetric(vertical: 8, horizontal: 15),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: <Widget>[
                    Text(
                      'Vai alla Home',
                      style: TextStyle(
                        fontFamily: 'Gotham',
                        fontSize: media.width * 0.05,
                        color: Colors.white,
                      ),
                      textAlign: TextAlign.center,
                    )
                  ],
                ),
                decoration: BoxDecoration(
                    color: Color(0xFF5C88C1),
                    // color:
                    //     Color.alphaBlend(Colors.white12, Color(0xff4373B1)),
                    borderRadius: BorderRadius.all(Radius.circular(25)),
                    border: Border.all(
                        style: BorderStyle.solid,
                        color: Color(0xFFE2E2E2),
                        width: 1.5)),
              ),
            ),
          ],
        ),
      )),
    );
  }
}
