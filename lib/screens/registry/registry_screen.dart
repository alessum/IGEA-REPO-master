import 'package:flutter/material.dart';
import 'package:igea_app/screens/registry/custom_expansion_card_colon.dart';
import 'package:igea_app/screens/registry/custom_expansion_card_breast.dart';
import 'package:igea_app/screens/registry/custom_expansion_card_uterus.dart';

class RegistryScreen extends StatefulWidget {
  RegistryScreen({Key key}) : super(key: key);

  @override
  _RegistryScreenState createState() => _RegistryScreenState();
}

class _RegistryScreenState extends State<RegistryScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Anagrafica',
            textAlign: TextAlign.left,
            style: TextStyle(
                fontSize: 35,
                color: Colors.black,
                fontWeight: FontWeight.w900)),
        backgroundColor: Colors.white,
        elevation: 0,
        leading: GestureDetector(
            onTap: () => Navigator.pop(context),
            child: Icon(
              Icons.arrow_back,
              color: Colors.black,
              size: 35,
            )),
      ),
      body: Container(
        margin: EdgeInsets.only(top: 50),
        child: Column(
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Container(
                  height: 125,
                  width: 125,
                  child: Image(
                    image: AssetImage('assets/avatars/doctor_women_face.png'),
                    fit: BoxFit.contain,
                  ),
                ),
                SizedBox(
                  width: 25,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text('Nome', style: TextStyle(fontSize: 17)),
                    SizedBox(height: 5),
                    Text('Cognome', style: TextStyle(fontSize: 17)),
                    SizedBox(height: 5),
                    Text('Data Nascita', style: TextStyle(fontSize: 17)),
                    SizedBox(height: 5),
                    Text('Domicilio', style: TextStyle(fontSize: 17)),
                    SizedBox(height: 5),
                    Text('Codice Fiscale', style: TextStyle(fontSize: 17)),
                  ],
                )
              ],
            ),
            SizedBox(
              height: 30,
            ),
            Expanded(
              child: ListView(
                children: <Widget>[
                  CustomExpansionCardBreast(familiarity: true,),
                  SizedBox(height: 10),
                  CustomExpansionCardColon(),
                  SizedBox(height: 10),
                  CustomExpansionCardUterus()
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
