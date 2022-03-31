import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:igea_app/blocs/diary/bloc_new_outcome.dart';
import 'package:igea_app/models/constants/constants_graphics.dart';
import 'package:igea_app/models/enums/test_type.dart';
import 'package:igea_app/models/reservable_test.dart';
import 'package:igea_app/models/test.dart';
import 'package:igea_app/screens/calendar/modalBottomSheets/reservable_test_selection.dart';
import 'package:igea_app/widgets/customExpansionTileBloodTestInsert.dart';
import 'package:igea_app/widgets/customExpansionTileScreeningInsert.dart';
import 'package:igea_app/screens/diary/outcome_widgets_factory.dart';
import 'package:intl/intl.dart';

class DiaryAddOutcomeScreen extends StatefulWidget {
  DiaryAddOutcomeScreen({Key key}) : super(key: key);

  @override
  _DiaryAddOutcomeScreenState createState() => _DiaryAddOutcomeScreenState();
}

class _DiaryAddOutcomeScreenState extends State<DiaryAddOutcomeScreen> {
  TextEditingController dateController = TextEditingController();
  String testNameValue;
  TestType testType;

  NewOutcomeBloc bloc;
  OutcomeWidgetsFactory formFactory = OutcomeWidgetsFactory.instance();
  ReservableTest _reservableTest;

  @override
  Widget build(BuildContext context) {
    Size media = MediaQuery.of(context).size;
    bloc = NewOutcomeBlocProvider.of(context);

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leadingWidth: media.width * 0.12,
        titleSpacing: media.width * 0.05,
        leading: Padding(
          padding: const EdgeInsets.only(left: 8.0),
          child: GestureDetector(
            onTap: () => Navigator.pop(context),
            child: SvgPicture.asset(
              'assets/icons/circle_left.svg',
              color: Colors.black,
            ),
          ),
        ),
        title: Text(
          'Aggiungi un esito',
          textAlign: TextAlign.left,
          style: TextStyle(
              fontSize: media.width * 0.07,
              color: Colors.black,
              fontFamily: 'Gotham'),
        ),
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.all(8),
          child: Column(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              _selectTestTypeForm(media),
              SizedBox(height: media.height * 0.01),
              StreamBuilder<Object>(
                    stream: bloc.getOldReservableTest,
                    builder: (context, snapshot) =>
                      snapshot.hasData ? formFactory.createOutcomeFormInput(
                          context,
                          snapshot.data,
                        ) : Container()
                  ),
              //_suggesteOutcomeInsertList(media),
            ],
          ),
        ),
      ),
    );
  }

  Widget _selectTestTypeForm(Size media) {
    return Container(
      padding: EdgeInsets.all(media.width * 0.05),
      decoration: BoxDecoration(
        color: Colors.grey[200],
        borderRadius: BorderRadius.all(
          Radius.circular(25),
        ),
      ),
      child: Column(
        children: [
          Container(
            alignment: Alignment.topLeft,
            child: Text(
              'Scegli l\'esame per cui inserire un esito',
              style: TextStyle(
                fontSize: media.width * 0.05,
                fontFamily: 'Gotham',
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Text('Tipo esame: ',
                    style: TextStyle(
                        fontSize: media.width * 0.05,
                        fontFamily: 'Book',
                        color: Colors.grey[900])),
                GestureDetector(
                  onTap: () => showExamTypeSelector(),
                  child: Container(
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.all(Radius.circular(25))),
                    width: media.width * 0.4,
                    padding: EdgeInsets.all(8.0),
                    child: Center(
                      child: StreamBuilder<ReservableTest>(
                        stream: bloc.getOldReservableTest,
                        builder: (context, snapshot) =>
                          Text(
                            snapshot.hasData ? snapshot.data.name : 'Scegli esame',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                fontFamily: 'Book',
                                color: snapshot.hasData
                                    ? Colors.grey[700]
                                    : Colors.grey[600],
                                fontSize: media.width * 0.04),
                          ),
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _suggesteOutcomeInsertList(Size media) {
    return Expanded(
      child: StreamBuilder<Map<String, Test>>(
        stream: bloc.allTests,
        builder: (context, snapshot) => snapshot.hasData
            ? ListView.separated(
                separatorBuilder: (BuildContext context, int index) {
                  return SizedBox(height: 10);
                },
                itemCount: snapshot.data.length,
                itemBuilder: (ctx, index) {
                  String key = snapshot.data.keys.elementAt(index);
                  //TODO IMPLEMENTARE FACTORY
                  if (snapshot.data[key].type != TestType.BLOOD_TEST) {
                    return CustomExpansionTileScreeningInsert(
                        updateDiary: () {
                          //FIXME così non rebuilda la pagina perchè utilizza sempre la lista che gli passa lo screen precedente
                          setState(() {});
                        },
                        leading: snapshot.data[key].name,
                        trailing: DateFormat('d/M/y')
                            .format(snapshot.data[key].reservation.date),
                        testKey: key,
                        organKey: snapshot.data[key].organKey,
                        testType: snapshot.data[key].type);
                  } else {
                    return CustomExpansionTileBloodTestInsert(
                      leading: snapshot.data[key].name,
                      trailing: DateFormat('d/M/y')
                          .format(snapshot.data[key].reservation.date),
                    );
                  }
                })
            : Center(
                child: CircularProgressIndicator(),
              ),
      ),
    );
  }

  showExamTypeSelector() {
    showModalBottomSheet(
      context: context,
      builder: (context) => ModalBottomReservableTestSelection(
        colorTheme: ConstantsGraphics.COLOR_DIARY_BLUE,
        reservableTestSelection: (reservableTest) {
          bloc.updateOldReservableTest.add(reservableTest);
        },
      ),
      backgroundColor: Colors.black.withOpacity(0),
      isScrollControlled: true,
    );
  }
}
