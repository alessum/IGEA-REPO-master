import 'package:flutter/material.dart';
import 'package:igea_app/blocs/bloc_registry.dart';

import 'registry_content.dart';

class RegistryScreen extends StatefulWidget {
  RegistryScreen({Key key}) : super(key: key);

  @override
  _RegistryScreenState createState() => _RegistryScreenState();
}

class _RegistryScreenState extends State<RegistryScreen> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.87,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: new BorderRadius.all(const Radius.circular(25.0)),
      ),
      padding: EdgeInsets.only(
        bottom: MediaQuery.of(context).viewInsets.bottom + 10,
      ),
      child: RegistryBlocProvider(child: RegistryContent())
    ); 
  }
}