import 'package:flutter/material.dart';
import 'package:igea_app/blocs/diary/bloc_new_outcome.dart';
import 'package:igea_app/models/constants/constants_graphics.dart';
import 'package:igea_app/widgets/input_widgets/prevengo_text_field_round.dart';
import 'package:igea_app/widgets/modal_bottom_sheets/registry_input_date.dart';
import 'package:intl/intl.dart';

class GenericOutcomeInputForm extends StatefulWidget {
  GenericOutcomeInputForm({Key key}) : super(key: key);

  @override
  _GenericOutcomeInputFormState createState() =>
      _GenericOutcomeInputFormState();
}

class _GenericOutcomeInputFormState extends State<GenericOutcomeInputForm> {
  NewOutcomeBloc bloc;

  @override
  Widget build(BuildContext context) {
    Size media = MediaQuery.of(context).size;
    bloc = NewOutcomeBlocProvider.of(context);

    return Container(
      padding: const EdgeInsets.all(13),
      decoration: BoxDecoration(
        color: Colors.grey[200],
        borderRadius: BorderRadius.all(
          Radius.circular(25),
        ),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Container(
            alignment: Alignment.topLeft,
            child: Text(
              ' Inserisci i dati',
              style: TextStyle(
                fontSize: media.width * 0.05,
                fontFamily: 'Gotham',
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Titolo: ',
                  style: TextStyle(
                      fontSize: media.width * 0.05,
                      fontFamily: 'Book',
                      color: Colors.grey[900]),
                ),
                PrevengoTextFieldRound(
                  onChanged: (text) {
                    bloc.setGenericTestName.add(text);
                  },
                  hintText: 'Titolo esame',
                  widthRatio: 0.5,
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Descrizione: ',
                  style: TextStyle(
                      fontSize: media.width * 0.05,
                      fontFamily: 'Book',
                      color: Colors.grey[900]),
                ),
                PrevengoTextFieldRound(
                  onChanged: (text) {
                    bloc.setGenericDescription.add(text);
                  },
                  hintText: 'Descrizione esito',
                  widthRatio: 0.5,
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 8.0),
            child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text('Data Esame: ',
                      style: TextStyle(
                          fontSize: media.width * 0.05,
                          fontFamily: 'Book',
                          color: Colors.grey[900])),
                  GestureDetector(
                    onTap: () {
                      showModalBottomSheet(
                        context: context,
                        builder: (_) => ModalBottomInputDate(
                          setDate: (value) {
                            bloc.setGenericDate.add(value);
                            Navigator.pop(context);
                          },
                          titleLabel: 'Inserisci la data dell\'esame ',
                          dateFormat: 'dd-MMM-yyyy',
                          colorTheme: ConstantsGraphics.COLOR_DIARY_BLUE,
                          limitUpToday: true,
                        ),
                        backgroundColor: Colors.black.withOpacity(0),
                        isScrollControlled: true,
                      );
                    },
                    child: Container(
                      width: media.width * 0.5,
                      padding: const EdgeInsets.only(
                          left: 15, bottom: 11, top: 11, right: 15),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(25)),
                          color: Colors.white),
                      child: StreamBuilder<DateTime>(
                          stream: bloc.getGenericDate,
                          builder: (context, snapshot) {
                            return Text(
                              snapshot.hasData
                                  ? DateFormat('yMMMd', 'it')
                                      .format(snapshot.data)
                                  : 'Inserisci il giorno',
                              style: TextStyle(
                                fontSize: media.width * 0.04,
                                fontFamily: 'Book',
                              ),
                            );
                          }),
                    ),
                  ),
                ]),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 8.0),
            child: GestureDetector(
              onTap: () {
                bloc.createNewGenericOutcome();
                showModalBottomSheet(
                  context: context,
                  builder: (context) => StreamBuilder<Widget>(
                    stream: bloc.getAlgorithmResult,
                    builder: (context, snapshot) {
                      if (snapshot.hasData) {
                        return snapshot.data;
                      } else {
                        return Container(
                          height: 200,
                          width: 200,
                          child: Center(
                            child: CircularProgressIndicator(),
                          ),
                        );
                      }
                    },
                  ),
                  backgroundColor: Colors.black.withOpacity(0),
                  isScrollControlled: true,
                );
              },
              child: Container(
                alignment: Alignment.center,
                width: media.width * 0.4,
                padding: EdgeInsets.all(8),
                decoration: BoxDecoration(
                    color: Color(0xff4768b7),
                    borderRadius: BorderRadius.all(Radius.circular(25))),
                child: Center(
                  child: Text(
                    'Conferma',
                    style: TextStyle(
                        fontSize: media.width * 0.05,
                        fontFamily: 'Bold',
                        color: Colors.white),
                  ),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
