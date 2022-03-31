import 'package:flutter/material.dart';
import 'package:igea_app/models/constants/constants.dart';
import 'package:tuple/tuple.dart';

import '../../../models/constants/constants_graphics.dart';
import '../../../models/constants/constants_graphics.dart';
import '../../../models/enums/test_type.dart';
import '../../../models/reservable_test.dart';
import '../../../widgets/ui_components/close_line_top_modal.dart';

class PrevengoDiaryModalNewTestSelection extends StatefulWidget {
  const PrevengoDiaryModalNewTestSelection({
    Key key,
    @required this.reservableTest,
    @required this.onTestSelected,
  }) : super(key: key);

  final ReservableTest reservableTest;
  final Function(ReservableTest reservableTest) onTestSelected;

  @override
  _PrevengoDiaryModalNewTestSelectionState createState() =>
      _PrevengoDiaryModalNewTestSelectionState();
}

class _PrevengoDiaryModalNewTestSelectionState
    extends State<PrevengoDiaryModalNewTestSelection> {
  List<ReservableTest> _reservableTestList = [];
  List<bool> _checkList = [];

  _fillReservableTestList() {
    _reservableTestList = Constants.allReservableTestList
        .where(
          (element) => element.organKey == widget.reservableTest.organKey,
        )
        .toList();
    _reservableTestList.forEach((element) => _checkList.add(false));
  }

  @override
  void initState() {
    super.initState();
    _fillReservableTestList();
  }

  @override
  Widget build(BuildContext context) {
    Size media = MediaQuery.of(context).size;
    return Container(
      padding: const EdgeInsets.fromLTRB(15, 8, 15, 8),
      margin: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(25),
        color: Colors.white,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          CloseLineTopModal(),
          SizedBox(height: media.height * 0.02),
          Text(
            'Seleziona uno tra i seguenti esami',
            style: TextStyle(
              fontSize: media.width * 0.05,
              fontFamily: 'Bold',
            ),
          ),
          SizedBox(height: media.height * 0.02),
          Container(
            height: media.height * (0.075 * _reservableTestList.length),
            child: ListView.separated(
              itemBuilder: (context, index) {
                return GestureDetector(
                  onTap: () => setState(() {
                    for (int i = 0; i < _checkList.length; i++) {
                      i == index ? _checkList[i] = true : _checkList[i] = false;
                    }
                  }),
                  child: Container(
                    // height: media.width * 0.12,
                    width: media.width * 0.5,
                    decoration: BoxDecoration(
                      color: _checkList[index]
                          ? ConstantsGraphics.COLOR_DIARY_BLUE
                          : Colors.grey[200],
                      borderRadius: BorderRadius.all(Radius.circular(25)),
                    ),
                    padding: EdgeInsets.all(13.0),
                    child: Center(
                      child: Text(
                        _reservableTestList.elementAt(index).name,
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            fontSize: media.width * 0.05,
                            fontFamily: 'Book',
                            color: _checkList[index]
                                ? Colors.white
                                : Colors.black54),
                      ),
                    ),
                  ),
                );
              },
              separatorBuilder: (context, index) =>
                  SizedBox(height: media.height * 0.01),
              itemCount: _reservableTestList.length,
            ),
          ),
          SizedBox(height: media.height * 0.02),
          GestureDetector(
            onTap: () {
              int index = _checkList.indexWhere((element) => element == true);
              print('INDEX $index');
              if (index != null) {
                widget.onTestSelected(_reservableTestList.elementAt(index));
                Navigator.pop(context);
              }
            },
            child: Container(
              alignment: Alignment.center,
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
          SizedBox(height: media.height * 0.02),
        ],
      ),
    );
  }
}
