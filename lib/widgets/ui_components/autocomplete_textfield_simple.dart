import 'package:autocomplete_textfield/autocomplete_textfield.dart';
import 'package:flutter/material.dart';

class AutocompleteTextFieldSimple extends StatefulWidget {
  AutocompleteTextFieldSimple({
    Key key,
    @required this.suggestions,
    @required this.setBirthPlace,
  }) : super(key: key);

  final List<String> suggestions;
  final Function(String value) setBirthPlace;

  @override
  _AutocompleteTextFieldSimpleState createState() =>
      _AutocompleteTextFieldSimpleState();
}

class _AutocompleteTextFieldSimpleState
    extends State<AutocompleteTextFieldSimple> {
  TextEditingController _autocompleteTextFieldController =
      TextEditingController();
  final GlobalKey<AutoCompleteTextFieldState<String>> _autoCompleteKey =
      new GlobalKey();

  _AutocompleteTextFieldSimpleState();

  @override
  Widget build(BuildContext context) {
    Size media = MediaQuery.of(context).size;

    print('itemController ' + _autocompleteTextFieldController.text);

    return AutoCompleteTextField<String>(
      clearOnSubmit: false,
      controller: _autocompleteTextFieldController,
      style: TextStyle(color: Colors.black, fontSize: 16.0),
      decoration: InputDecoration(
        suffixIcon: Container(
          width: 85.0,
          height: 80.0,
        ),
        contentPadding: EdgeInsets.fromLTRB(10.0, 30.0, 10.0, 20.0),
        filled: true,
        hintText: 'Cerca luogo di nascita',
        hintStyle: TextStyle(color: Colors.black),
      ),
      suggestions: widget.suggestions,
      itemBuilder: (context, item) {
        return Container(
          height: media.height * 0.05,
          child: Text(
            item,
            style: TextStyle(fontSize: 16.0),
          ),
        );
      },
      itemFilter: (item, query) {
        return item.toLowerCase().startsWith(query.toLowerCase());
      },
      itemSorter: (a, b) {
        return a.compareTo(b);
      },
      itemSubmitted: (item) {
        setState(() {
          _autocompleteTextFieldController.text = item;
          widget.setBirthPlace(item);
        });
      },
      key: _autoCompleteKey,
      
    );
  }
}
