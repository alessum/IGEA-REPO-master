import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:igea_app/screens/authenticate/authenticate.dart';
import 'package:igea_app/services/auth.dart';

class NavDrawer extends StatelessWidget {
  NavDrawer(this._userName);

  final String _userName;

  @override
  Widget build(BuildContext context) {
    Size media = MediaQuery.of(context).size;

    return Drawer(
      child: Container(
        decoration: BoxDecoration(
            color: Color(0xFFEDEDED),
            borderRadius: BorderRadius.horizontal(left: Radius.circular(25))),
        padding: EdgeInsets.symmetric(vertical: media.width * 0.12),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Padding(
              padding: EdgeInsets.only(left: media.width * 0.1),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  CircleAvatar(
                      backgroundColor: Colors.blue,
                      minRadius: 20,
                      maxRadius: 20,
                      child: Container(
                        child: SvgPicture.asset(
                          'assets/avatars/arold_in_circle.svg',
                          width: media.height > 600 ? 80.0 : 65.0,
                        ),
                      )),
                  SizedBox(width: media.width * 0.04),
                  Text(
                    _userName,
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: 25,
                        fontFamily: 'Gotham'),
                  )
                ],
              ),
            ),
            SizedBox(height: media.height * 0.1),
            Padding(
                padding: EdgeInsets.only(left: media.width * 0.1),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    SvgPicture.asset(
                      'assets/icons/anagrafica.svg',
                      height: 30,
                    ),
                    SizedBox(width: media.width * 0.04),
                    Text(
                      'Anagrafica',
                      style: TextStyle(
                          fontSize: media.width * 0.05,
                          fontFamily: 'Gotham',
                          color: Color(0xFF4373B1)),
                    )
                  ],
                )),
            Padding(
                padding: EdgeInsets.only(left: media.width * 0.1),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    SvgPicture.asset(
                      'assets/icons/whoweare.svg',
                      height: 30,
                    ),
                    SizedBox(width: media.width * 0.04),
                    Text(
                      'Chi siamo',
                      style: TextStyle(
                          fontSize: media.width * 0.05,
                          fontFamily: 'Gotham',
                          color: Color(0xFF4373B1)),
                    )
                  ],
                )),
            Padding(
                padding: EdgeInsets.only(left: media.width * 0.1),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    SvgPicture.asset(
                      'assets/icons/legal.svg',
                      height: 30,
                    ),
                    SizedBox(width: media.width * 0.04),
                    Text(
                      'Informazioni legali',
                      style: TextStyle(
                          fontSize: media.width * 0.05,
                          fontFamily: 'Gotham',
                          color: Color(0xFF4373B1)),
                    )
                  ],
                )),
            Padding(
                padding: EdgeInsets.only(left: media.width * 0.1),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    SvgPicture.asset(
                      'assets/icons/credits.svg',
                      height: 30,
                    ),
                    SizedBox(width: media.width * 0.04),
                    Text(
                      'Crediti',
                      style: TextStyle(
                          fontSize: media.width * 0.05,
                          fontFamily: 'Gotham',
                          color: Color(0xFF4373B1)),
                    )
                  ],
                )),
            SizedBox(height: media.height * 0.10),
            GestureDetector(
              onTap: () {
                FirebaseAuthService authService = FirebaseAuthService();
                authService.signOut().then(
                      (_) => Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => Authenticate(),
                        ),
                      ),
                    );
              },
              child: Container(
                width: media.width * 0.4,
                padding: EdgeInsets.all(8),
                decoration: BoxDecoration(
                    color: Color(0xFF4373B1),
                    borderRadius: BorderRadius.all(Radius.circular(25))),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    SvgPicture.asset(
                      'assets/icons/logout.svg',
                      height: 30,
                    ),
                    SizedBox(width: media.width * 0.04),
                    Text(
                      'Logout',
                      style: TextStyle(
                          fontSize: media.width * 0.05,
                          fontFamily: 'Gotham',
                          color: Colors.white),
                    )
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
