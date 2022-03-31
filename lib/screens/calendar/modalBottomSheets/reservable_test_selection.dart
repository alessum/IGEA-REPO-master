import 'package:flutter/material.dart';
import 'package:igea_app/models/constants/constants.dart';
import 'package:igea_app/models/constants/constants_graphics.dart';
import 'package:igea_app/models/reservable_test.dart';
import 'package:igea_app/widgets/ui_components/close_line_top_modal.dart';

class ModalBottomReservableTestSelection extends StatefulWidget {
  ModalBottomReservableTestSelection({
    Key key,
    @required this.reservableTestSelection,
    @required this.colorTheme,
  }) : super(key: key);

  final Function(ReservableTest reservableTest) reservableTestSelection;
  final Color colorTheme;

  @override
  _ModalBottomReservableTestSelectionState createState() =>
      _ModalBottomReservableTestSelectionState();
}

class _ModalBottomReservableTestSelectionState
    extends State<ModalBottomReservableTestSelection> {
  List<bool> _checkList = [];
  @override
  void initState() {
    super.initState();

    //init checklist to false
    Constants.allReservableTestList.forEach((element) {
      _checkList.add(false);
    });
  }

  @override
  Widget build(BuildContext context) {
    Size media = MediaQuery.of(context).size;
    return Container(
      margin: EdgeInsets.all(8),
      padding: EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.all(Radius.circular(25)),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        mainAxisSize: MainAxisSize.min,
        children: [
          CloseLineTopModal(),
          SizedBox(height: media.height * 0.02),
          Container(
            child: Text(
              'Seleziona la tipologia di esame da prenotare',
              style: TextStyle(
                fontSize: media.width * 0.05,
                fontFamily: 'Bold',
              ),
            ),
          ),
          SizedBox(height: media.height * 0.02),
          Container(
            height: media.height * (0.05 * Constants.allReservableTestList.length),
            child: ListView.separated(
              itemBuilder: (context, index) {
                return GestureDetector(
                  onTap: () => setState(() {
                    for (int i = 0; i < _checkList.length; i++) {
                      i == index ? _checkList[i] = true : _checkList[i] = false;
                    }
                  }),
                  child: Container(
                    height: media.width * 0.12,
                    width: media.width * 0.5,
                    decoration: BoxDecoration(
                        color: _checkList[index]
                            ? widget.colorTheme
                            : Colors.grey[200],
                        borderRadius: BorderRadius.all(Radius.circular(25))),
                    child: Center(
                      child: Text(
                          Constants.allReservableTestList
                              .elementAt(index)
                              .name,
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              fontSize: media.width * 0.04,
                              fontFamily: 'Book',
                              color: _checkList[index]
                                  ? Colors.white
                                  : Colors.black54)),
                    ),
                  ),
                );
              },
              separatorBuilder: (context, index) =>
                  SizedBox(height: media.height * 0.01),
              itemCount: Constants.allReservableTestList.length,
            ),
          ),
          SizedBox(height: media.height * 0.02),
          GestureDetector(
            onTap: () {
              setState(() {
                int index = _checkList.indexWhere((element) => element == true);
                ReservableTest test =
                    Constants.allReservableTestList.elementAt(index);
                widget.reservableTestSelection(test);
              });
              Navigator.pop(context);
            },
            child: Container(
              height: media.width * 0.12,
              width: media.width * 0.5,
              decoration: BoxDecoration(
                  color: widget.colorTheme,
                  borderRadius: BorderRadius.all(Radius.circular(25))),
              child: Center(
                child: Text(
                  'Conferma',
                  style: TextStyle(
                      fontFamily: 'Gotham',
                      color: Colors.white,
                      fontSize: media.width * 0.045),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
