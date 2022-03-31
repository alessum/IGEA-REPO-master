import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:igea_app/models/test.dart';

class CalendarAdvisor extends StatefulWidget {
  CalendarAdvisor(
      {Key key,
      @required this.nonReservedTestList,
      @required this.selectNonReserveTestFromList})
      : super(key: key);
  final Map<String, Test> nonReservedTestList;
  final Function(bool changeSelection, Test test) selectNonReserveTestFromList;

  @override
  _CalendarAdvisorState createState() => _CalendarAdvisorState();
}

class _CalendarAdvisorState extends State<CalendarAdvisor> {
  String testKey;
  Test nonReservedTest;
  bool nonReservedTestSelected;

  @override
  void initState() {
    super.initState();
    nonReservedTestSelected = false;
  }

  @override
  Widget build(BuildContext context) {
    if (nonReservedTestSelected == true) {
      return Container(
        margin: const EdgeInsets.symmetric(horizontal: 5.0, vertical: 5.0),
        width: 360,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(25)),
          color: Colors.grey[300],
        ),
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Column(
            children: <Widget>[
              Row(
                children: <Widget>[
                  Container(
                      height: 75,
                      width: 75,
                      child: SvgPicture.asset('assets/avatars/arold_in_circle.svg')),
                  Container(
                    padding: EdgeInsets.only(left: 10),
                    width: 200,
                    child: Text(
                      'Bene! Hai selezionato ${nonReservedTest.name}, compila i campi sottostanti e poi conferma per salvare la prenotazione dell\'esame nel calendario,\noppure',
                      style: TextStyle(fontSize: 18),
                      overflow: TextOverflow.fade,
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 15,
              ),
              GestureDetector(
                onTap: () => setState(() {
                  nonReservedTestSelected = false;
                  nonReservedTest = null;
                  widget.selectNonReserveTestFromList(
                      nonReservedTestSelected, nonReservedTest);
                }),
                child: Container(
                  width: 120,
                  decoration: BoxDecoration(
                    color: Color(0xff7ccddb),
                    borderRadius: BorderRadius.circular(20.0),
                  ),
                  padding: const EdgeInsets.only(
                      top: 5.0, bottom: 5.0, left: 15.0, right: 15.0),
                  child: Center(
                    child: Text(
                      'Annulla',
                      style: TextStyle(
                          fontSize: 18,
                          color: Colors.white,
                          fontWeight: FontWeight.w300,
                          fontFamily: 'FilsonSoft'),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      );
    } else {
      return Container(
        margin: const EdgeInsets.symmetric(horizontal: 5.0, vertical: 5.0),
        width: 360,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(25)),
          color: Colors.grey[300],
        ),
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Column(
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  Container(
                      height: 75,
                      width: 75,
                      child: SvgPicture.asset('assets/avatars/arold_in_circle.svg')),
                  Container(
                    width: 200,
                    child: Text(
                      widget.nonReservedTestList.length > 1
                          ? 'Mi risulta che hai cercato di prenotare diversi esami elencati nella lista qui sotto'
                          : 'Mi risulta che hai cercato di prenotare l\'esame "${widget.nonReservedTestList.values.toList()[0].name}". Vuoi portare a termine l\'perazione?',
                      style: TextStyle(fontFamily: 'Book', fontSize: 18),
                      overflow: TextOverflow.fade,
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 10,
              ),
              widget.nonReservedTestList.length > 1
                  ? Container(
                      height: (widget.nonReservedTestList.length * 60.0),
                      padding: EdgeInsets.symmetric(vertical: 10),
                      child:
                          _buildNonReservedTestList(widget.nonReservedTestList),
                    )
                  : Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: <Widget>[
                        GestureDetector(
                          onTap: () => setState(() {
                            testKey =
                                widget.nonReservedTestList.keys.toList()[0];
                            nonReservedTest =
                                widget.nonReservedTestList.values.toList()[0];
                          }),
                          child: Container(
                            width: 120,
                            decoration: BoxDecoration(
                              color: Color(0xff7ccddb),
                              borderRadius: BorderRadius.circular(20.0),
                            ),
                            padding: const EdgeInsets.only(
                                top: 5.0, bottom: 5.0, left: 15.0, right: 15.0),
                            child: Text(
                              'Conferma',
                              style: TextStyle(
                                  fontSize: 18,
                                  color: Colors.white,
                                  fontWeight: FontWeight.w300,
                                  fontFamily: 'FilsonSoft'),
                            ),
                          ),
                        ),
                        Container(
                          width: 120,
                          decoration: BoxDecoration(
                            color: Color(0xff7ccddb),
                            borderRadius: BorderRadius.circular(20.0),
                          ),
                          padding: const EdgeInsets.only(
                              top: 5.0, bottom: 5.0, left: 15.0, right: 15.0),
                          child: Text(
                            'Elimina',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                fontSize: 18,
                                color: Colors.white,
                                fontWeight: FontWeight.w300,
                                fontFamily: 'FilsonSoft'),
                          ),
                        )
                      ],
                    ),
            ],
          ),
        ),
      );
    }
  }

  Widget _buildNonReservedTestList(Map<String, Test> testList) {
    return ListView.separated(
      itemBuilder: (BuildContext ctx, int index) {
        String key = testList.keys.elementAt(index);
        return Container(
          height: 40,
          decoration: BoxDecoration(
              color: Color(0xff7ccddb),
              borderRadius: BorderRadius.all(Radius.circular(25))),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 5),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Text(
                  testList[key].name,
                  style: TextStyle(fontSize: 18),
                ),
                Row(
                  children: <Widget>[
                    GestureDetector(
                      onTap: () => setState(() {
                        nonReservedTestSelected = true;
                        nonReservedTest = testList[key];
                        widget.selectNonReserveTestFromList(
                            nonReservedTestSelected, nonReservedTest);
                      }),
                      child: CircleAvatar(
                        backgroundColor: Colors.white,
                        radius: 15.0,
                        child: Icon(Icons.check,
                            color: Color(0xff7ccddb), size: 25),
                      ),
                    ),
                    SizedBox(
                      width: 15,
                    ),
                    CircleAvatar(
                      backgroundColor: Colors.white,
                      radius: 15.0,
                      child: Icon(Icons.delete,
                          color: Color(0xff7ccddb), size: 25),
                    ),
                  ],
                )
              ],
            ),
          ),
        );
      },
      separatorBuilder: (BuildContext ctx, int index) {
        return SizedBox(
          height: 10,
        );
      },
      itemCount: testList.length,
      scrollDirection: Axis.vertical,
    );
  }
}
