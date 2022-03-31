import 'package:flutter/material.dart';
import 'package:igea_app/blocs/bloc_registry.dart';
import 'package:igea_app/models/constants/constants.dart';
import 'package:igea_app/models/enums/gender.dart';
import 'package:igea_app/models/registry.dart';

class RegistryContent extends StatefulWidget {
  RegistryContent({Key key}) : super(key: key);

  @override
  _RegistryContentState createState() => _RegistryContentState();
}

class _RegistryContentState extends State<RegistryContent> {
  RegistryBloc bloc;
  String name;
  String surname;
  DateTime dateOfBirth;
  Gender gender;

  @override
  void didChangeDependencies() {
    bloc = RegistryBlocProvider.of(context);
    //bloc.fetchRegistry();
    super.didChangeDependencies();
  }

  @override
  void dispose() {
    bloc.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(children: <Widget>[
      Padding(
        padding: const EdgeInsets.only(
            top: 20.0, left: 42.0, right: 20.0, bottom: 10.0),
        child: Row(children: <Widget>[
          Expanded(
              child: Text('Anagrafica',
                  textAlign: TextAlign.left,
                  style: TextStyle(
                      fontSize: 35,
                      color: Colors.black,
                      fontWeight: FontWeight.w900))),
          CircleAvatar(
            backgroundColor: Colors.grey[300],
            radius: 25.0,
            child: Icon(Icons.folder, color: Colors.orangeAccent, size: 35),
          )
        ]),
      ),
      StreamBuilder(
        stream: bloc.registry,
        builder: (BuildContext context, AsyncSnapshot<RegistryData> snapshot) {
          print('[SNAPSHOT] '+ snapshot.toString());
          if (snapshot.hasData) {
            print('[DEBUG ] ' + snapshot.data.name.toString());
            print('[DEBUG ] ' + snapshot.data.surname.toString());
            print('[DEBUG ] ' + snapshot.data.dateOfBirth.toString());
            print('[DEBUG ] ' + snapshot.data.gender.toString());
            print('[DEBUG ] ' + snapshot.data.domicile.toString());
            print('[DEBUG ] ' + snapshot.data.fiscalCode.toString());
            return Container(
              child: null,
            );
          } else if (snapshot.hasError) {
            return Text(snapshot.error);
          }
          return Center(child: CircularProgressIndicator());
        },
      ),
      GestureDetector(
        onTap: () {
          bloc.inRegistry.add({
            Constants.REGISTRY_NAME_KEY : 'Alessandro',
            Constants.REGISTRY_SURNAME_KEY : 'Incremona',
            Constants.REGISTRY_DATE_OF_BIRTH_KEY : DateTime.now(),
            Constants.REGISTRY_DOMICILE_KEY : 'Pavia',
            Constants.REGISTRY_FISCAL_CODE_KEY : 'ADJOIEJDAOIEJDA',
            Constants.REGISTRY_GENDER_KEY : Gender.FEMALE
          });
        },
        child: Container(
          color: Colors.blue,
          child: Center(
            child: Text('Button'),
          ),
        ),
      ),
    ]);
  }
}
