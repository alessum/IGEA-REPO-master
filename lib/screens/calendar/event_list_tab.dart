import 'dart:collection';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:igea_app/models/test.dart';
import 'package:igea_app/widgets/customExpansionTileCalendar.dart';
import 'package:tuple/tuple.dart';

class EventListTab extends StatelessWidget {
  const EventListTab({
    Key key,
    @required this.reservedTestList,
    @required this.deleteTest,
  }) : super(key: key);


  final Map<String, Test> reservedTestList;
  final Function(String key) deleteTest;

 

  ///__Description:__ Prende gli esami futuri e li ordina in ordine crescente
  Map<String, Test> _sortReservedTestList() {
    Map<String, Test> nextReservedTestList = Map();

    reservedTestList.forEach((key, value) {
      if (value.reservation.date.isAfter(DateTime.now())) {
        nextReservedTestList.addAll({
          key: value,
        });
      }
    });

    var sortedKeys = nextReservedTestList.keys.toList(growable: false)
      ..sort((k1, k2) {
        return nextReservedTestList[k1]
            .reservation
            .date
            .compareTo(nextReservedTestList[k2].reservation.date);
      });
    return LinkedHashMap.fromIterable(
      sortedKeys,
      key: (k) => k,
      value: (k) => nextReservedTestList[k],
    );
  }


  @override
  Widget build(BuildContext context) {
    Map<String, Test> testList = _sortReservedTestList();

    Size media = MediaQuery.of(context).size;
    return testList.length > 0
        ? Padding(
          padding: const EdgeInsets.only(left: 16.0, right: 16.0, top: 8.0),
          child: Container(
            width: media.width * 0.9,
            child: ListView.separated(
              separatorBuilder: (BuildContext context, int index) {
                return SizedBox(
                  height: media.height * 0.01,
                );
              },
              itemCount: testList.length,
              itemBuilder: (ctx, index) {
                String key = testList.keys.elementAt(index);
                return CustomExpansionTileCalendar(
                  testData: Tuple2<String,Test>(key,testList[key]),
                );
              },
            ),
          ),
        )
        : Container(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SvgPicture.asset(
                  'assets/avatars/arold_extended.svg',
                  height: media.height * 0.2,
                ),
                SizedBox(height: media.height * 0.02),
                Text(
                  'Nessun esame previsto nei prossimi giorni!',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: media.width * 0.07,
                    fontFamily: 'Gotham',
                  ),
                )
              ],
            ),
          );
  }
}
