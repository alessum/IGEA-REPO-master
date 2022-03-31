import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:igea_app/blocs/bloc_registry.dart';
import 'package:igea_app/models/organ.dart';
import 'package:igea_app/models/reservable_test.dart';

class CardioSystemDetailScreen extends StatelessWidget {
  const CardioSystemDetailScreen(
      {Key key, @required this.organDetails, @required this.organKey})
      : super(key: key);
  final Organ organDetails;
  final String organKey;
  @override
  Widget build(BuildContext context) {
    return SituationBlocProvider(
      child: CardioSystemDetailScreenContent(
        organDetails: organDetails,
        organKey: organKey,
      ),
    );
  }
}

class CardioSystemDetailScreenContent extends StatefulWidget {
  CardioSystemDetailScreenContent(
      {Key key, @required this.organDetails, @required this.organKey})
      : super(key: key);
  final Organ organDetails;
  final String organKey;
  @override
  _CardioSystemDetailScreenContentState createState() =>
      _CardioSystemDetailScreenContentState();
}

class _CardioSystemDetailScreenContentState
    extends State<CardioSystemDetailScreenContent>
    with TickerProviderStateMixin {
  // int currentScreen = 1;
  // int nextScreen;

  List<Tab> tabList = List();
  TabController _tabController;

  @override
  void initState() {
    super.initState();
    tabList.add(Tab(
      icon: SvgPicture.asset(
        'assets/icons/heart.svg',
        height: 100,
      ),
    ));
    tabList.add(Tab(
      icon: SvgPicture.asset(
        'assets/icons/vasi.svg',
        height: 100,
      ),
    ));
    _tabController = TabController(vsync: this, length: tabList.length);
  }

  @override
  Widget build(BuildContext context) {
    Size media = MediaQuery.of(context).size;

    // List<Widget> stackChilds;

    // void swipeChilds() {
    //   if (currentScreen != nextScreen) {
    //     print(nextScreen);
    //     setState(() {
    //       Widget temp1 = stackChilds[0];
    //       Widget temp2 = stackChilds[1];
    //       stackChilds[0] = stackChilds[2];
    //       stackChilds[1] = stackChilds[3];
    //       stackChilds[2] = temp1;
    //       stackChilds[3] = temp2;
    //       currentScreen = nextScreen;
    //     });
    //     print(currentScreen);
    //   }
    // }

    // stackChilds = [
    //   GestureDetector(
    //     onTap: () => setState(() {
    //       nextScreen = 1;
    //       swipeChilds();
    //     }),
    //     child: Align(
    //       alignment: Alignment.topRight,
    //       child: Container(
    //           padding: EdgeInsets.only(top: 15),
    //           height: media.height * 0.2,
    //           width: media.width * 0.45,
    //           decoration: BoxDecoration(
    //               color: Color.alphaBlend(Colors.black12,
    //                   Color(int.parse(widget.organDetails.status.color))),
    //               borderRadius: BorderRadius.all(Radius.circular(25))),
    //           child: Align(
    //               alignment: Alignment.topCenter,
    //               child: SvgPicture.asset(
    //                 '${widget.organDetails.imagePath}',
    //                 fit: BoxFit.cover,
    //                 height: 80,
    //               ))),
    //     ),
    //   ),
    //   GestureDetector(
    //     onTap: () => setState(() {
    //       nextScreen = 0;
    //       swipeChilds();
    //     }),
    //     child: Align(
    //       alignment: Alignment.topLeft,
    //       child: Container(
    //           padding: EdgeInsets.only(top: 15),
    //           height: media.height * 0.2,
    //           width: media.width * 0.45,
    //           decoration: BoxDecoration(
    //               color: Color.alphaBlend(Colors.white60,
    //                   Color(int.parse(widget.organDetails.status.color))),
    //               borderRadius: BorderRadius.all(Radius.circular(25))),
    //           child: Align(
    //               alignment: Alignment.topCenter,
    //               child: SvgPicture.asset(
    //                 '${widget.organDetails.imagePath}',
    //                 fit: BoxFit.cover,
    //                 height: 80,
    //               ))),
    //     ),
    //   ),
    //   Align(
    //     alignment: Alignment.bottomCenter,
    //     child: Container(
    //       height: media.height * 0.45,
    //       width: double.maxFinite,
    //       decoration: BoxDecoration(
    //           color: Color.alphaBlend(Colors.black12,
    //               Color(int.parse(widget.organDetails.status.color))),
    //           borderRadius: BorderRadius.all(Radius.circular(25)),
    //           border: Border.all(width: 0, color: Colors.transparent)),
    //       child: Center(child: Text('Testo')),
    //     ),
    //   ),
    //   Align(
    //     alignment: Alignment.bottomCenter,
    //     child: Container(
    //       height: media.height * 0.45,
    //       width: double.maxFinite,
    //       decoration: BoxDecoration(
    //           color: Color.alphaBlend(Colors.white60,
    //               Color(int.parse(widget.organDetails.status.color))),
    //           borderRadius: BorderRadius.all(Radius.circular(25))),
    //       child: Center(child: Text('Testo')),
    //     ),
    //   ),
    // ];

    return Scaffold(
      appBar: AppBar(
        title: FittedBox(
          fit: BoxFit.fitWidth,
          child: Text('Situazione',
              textAlign: TextAlign.left,
              style: TextStyle(
                  fontSize: media.width * 0.08,
                  color: Colors.black,
                  fontWeight: FontWeight.w900)),
        ),
        backgroundColor: Colors.white,
        elevation: 0,
      ),
      body: Align(
        alignment: Alignment.bottomLeft,
        child: Container(
          width: media.width,
          height: media.height * 0.8,
          decoration: BoxDecoration(
              color: Color(int.parse(widget.organDetails.status.color)),
              borderRadius: BorderRadius.only(topRight: Radius.circular(80))),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                SizedBox(
                  height: media.height * 0.04,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    Flexible(
                      flex: 4,
                      fit: FlexFit.loose,
                      child: ListTile(
                        leading: GestureDetector(
                            onTap: () => Navigator.pop(context),
                            child: Icon(
                              Icons.arrow_back,
                              color: Colors.black,
                              size: 35,
                            )),
                        title: Text(widget.organDetails.name,
                            textAlign: TextAlign.left,
                            style: TextStyle(
                                fontSize: media.width * 0.07,
                                color: Colors.black,
                                fontWeight: FontWeight.w900)),
                      ),
                    ),
                    Flexible(
                      flex: 1,
                      child: Align(
                        alignment: Alignment.centerLeft,
                        child: SvgPicture.asset(
                          '${widget.organDetails.status.iconPath}',
                          fit: BoxFit.cover,
                          height: media.height * 0.05,
                        ),
                      ),
                    )
                  ],
                ),
                SizedBox(height: media.height * 0.04),
                Container(
                  padding: EdgeInsets.all(8),
                  height: media.height * 0.62,
                  // child: Stack(
                  //   children: stackChilds,
                  // )
                  child: Column(
                    children: <Widget>[
                      Container(
                        child: TabBar(
                          controller: _tabController,
                          indicatorColor: Colors.transparent,
                          indicatorSize: TabBarIndicatorSize.tab,
                          tabs: tabList,
                          labelPadding: EdgeInsets.all(10),
                          indicator: BoxDecoration(
                            color: Color.alphaBlend(
                              Colors.white38,
                              Color(
                                int.parse(widget.organDetails.status.color),
                              ),
                            ),
                            borderRadius: BorderRadius.all(
                              Radius.circular(100),
                            ),
                          ),
                        ),
                      ),
                      Container(
                        child: Expanded(
                          child: TabBarView(
                            controller: _tabController,
                            children: <Widget>[
                              getHeartDetails(context),
                              getVasselsDetails(context)
                            ],
                          ),
                        ),
                      )
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget getHeartDetails(BuildContext context) {
    Size media = MediaQuery.of(context).size;
    return Container(
      width: media.width,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Container(
            padding: EdgeInsets.fromLTRB(20, 30, 0, 0),
            child: Text(
              'Cuore',
              style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: <Widget>[
              Text(
                'Prossimo esame',
                style: TextStyle(fontSize: media.width * 0.06),
              ),
              Stack(
                children: <Widget>[
                  Container(
                    margin: EdgeInsets.only(left: 15),
                    width: 135,
                    height: 50,
                    decoration: BoxDecoration(
                        color: Color.lerp(
                            Colors.black38,
                            Color(int.parse(widget.organDetails.status.color)),
                            0.8),
                        borderRadius: BorderRadius.circular(25)),
                    child: Center(
                      child: Text(
                        '2022',
                        // widget.organDetails
                        //     .nextExamDate.year
                        //     .toString(),
                        style: TextStyle(
                          fontSize: media.width * 0.06,
                          fontWeight: FontWeight.w700,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                  Positioned(
                    left: -25,
                    child: RawMaterialButton(
                      onPressed: () => null, //showCustomDialog(context),
                      child: Icon(
                        Icons.info_outline,
                        size: 35,
                      ),
                      shape: CircleBorder(),
                      elevation: 5,
                      fillColor: Color.fromARGB(255, 255, 255, 255),
                    ),
                  ),
                ],
              )
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: <Widget>[
              Text(
                'Ultimo esame',
                style: TextStyle(fontSize: media.width * 0.06),
              ),
              Stack(
                children: <Widget>[
                  Container(
                    margin: EdgeInsets.only(left: 15),
                    width: 180,
                    height: 50,
                    decoration: BoxDecoration(
                        color: Color.lerp(
                            Colors.black38,
                            Color(int.parse(widget.organDetails.status.color)),
                            0.8),
                        borderRadius: BorderRadius.circular(25)),
                    child: Center(
                      child: Padding(
                        padding: const EdgeInsets.only(left: 10),
                        child: Text(
                          widget.organDetails.lastTestDate == null
                              ? '--'
                              : widget.organDetails.lastTestDate.toString(),
                          style: TextStyle(
                            fontSize: media.width * 0.05,
                            fontWeight: FontWeight.w700,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                  ),
                  Positioned(
                    left: -25,
                    child: RawMaterialButton(
                      onPressed: () => null, //showCustomDialog(context),
                      child: Icon(
                        Icons.info_outline,
                        size: 35,
                      ),
                      shape: CircleBorder(),
                      elevation: 5,
                      fillColor: Color.fromARGB(255, 255, 255, 255),
                    ),
                  ),
                ],
              )
            ],
          ),
          Align(
            alignment: Alignment.centerLeft,
            child: Padding(
              padding: const EdgeInsets.only(left: 8.0),
              child: Text(
                'Test',
                style: TextStyle(
                  fontSize: media.width * 0.08,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
          ),
          Align(
            alignment: Alignment.center,
            child: Container(
                width: media.width * 0.80,
                height: media.width * 0.3,
                margin: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    Expanded(
                      child: ListView.builder(
                          itemCount:
                              widget.organDetails.reservableTestList.length,
                          itemBuilder: (ctx, index) {
                            List<ReservableTest> testList =
                                widget.organDetails.reservableTestList;
                            print(testList);
                            return Opacity(
                              opacity: 1,
                              child: Card(
                                  elevation: 0,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(25.0),
                                  ),
                                  color: Color.alphaBlend(
                                      Colors.white60,
                                      Color(int.parse(
                                          widget.organDetails.status.color))),
                                  child: Stack(
                                    children: <Widget>[
                                      Padding(
                                        padding: EdgeInsets.symmetric(
                                            vertical: 10, horizontal: 10),
                                        child: Text(
                                          testList[index].name,
                                          style: TextStyle(
                                            fontSize: media.width * 0.06,
                                          ),
                                        ),
                                      ),
                                      Align(
                                        alignment: Alignment.centerRight,
                                        child: RawMaterialButton(
                                          onPressed: null,
                                          // onPressed: () => _showReservableTest(
                                          //     context,
                                          //     testList[
                                          //         index]),
                                          child: Icon(
                                            Icons.info_outline,
                                            size: media.width * 0.08,
                                            color: Colors.white,
                                          ),
                                          shape: CircleBorder(),
                                          elevation: 0,
                                          fillColor: Color(int.parse(widget
                                              .organDetails.status.color)),
                                        ),
                                      ),
                                    ],
                                  )),
                            );
                          }),
                    ),
                  ],
                )),
          )
        ],
      ),
    );
  }

  Widget getVasselsDetails(BuildContext context) {
    Size media = MediaQuery.of(context).size;
    return Container(
      width: media.width,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Container(
            padding: EdgeInsets.fromLTRB(20, 30, 0, 0),
            child: Text(
              'Vasi',
              style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: <Widget>[
              Text(
                'Prossimo esame',
                style: TextStyle(fontSize: media.width * 0.06),
              ),
              Stack(
                children: <Widget>[
                  Container(
                    margin: EdgeInsets.only(left: 15),
                    width: 135,
                    height: 50,
                    decoration: BoxDecoration(
                        color: Color.lerp(
                            Colors.black38,
                            Color(int.parse(widget.organDetails.status.color)),
                            0.8),
                        borderRadius: BorderRadius.circular(25)),
                    child: Center(
                      child: Text(
                        '2022',
                        // widget.organDetails
                        //     .nextExamDate.year
                        //     .toString(),
                        style: TextStyle(
                          fontSize: media.width * 0.06,
                          fontWeight: FontWeight.w700,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                  Positioned(
                    left: -25,
                    child: RawMaterialButton(
                      onPressed: () => null, //showCustomDialog(context),
                      child: Icon(
                        Icons.info_outline,
                        size: 35,
                      ),
                      shape: CircleBorder(),
                      elevation: 5,
                      fillColor: Color.fromARGB(255, 255, 255, 255),
                    ),
                  ),
                ],
              )
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: <Widget>[
              Text(
                'Ultimo esame',
                style: TextStyle(fontSize: media.width * 0.06),
              ),
              Stack(
                children: <Widget>[
                  Container(
                    margin: EdgeInsets.only(left: 15),
                    width: 180,
                    height: 50,
                    decoration: BoxDecoration(
                        color: Color.lerp(
                            Colors.black38,
                            Color(int.parse(widget.organDetails.status.color)),
                            0.8),
                        borderRadius: BorderRadius.circular(25)),
                    child: Center(
                      child: Padding(
                        padding: const EdgeInsets.only(left: 10),
                        child: Text(
                          widget.organDetails.lastTestDate == null
                              ? '--'
                              : widget.organDetails.lastTestDate.toString(),
                          style: TextStyle(
                            fontSize: media.width * 0.05,
                            fontWeight: FontWeight.w700,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                  ),
                  Positioned(
                    left: -25,
                    child: RawMaterialButton(
                      onPressed: () => null, //showCustomDialog(context),
                      child: Icon(
                        Icons.info_outline,
                        size: 35,
                      ),
                      shape: CircleBorder(),
                      elevation: 5,
                      fillColor: Color.fromARGB(255, 255, 255, 255),
                    ),
                  ),
                ],
              )
            ],
          ),
          Align(
            alignment: Alignment.centerLeft,
            child: Padding(
              padding: const EdgeInsets.only(left: 8.0),
              child: Text(
                'Test',
                style: TextStyle(
                  fontSize: media.width * 0.08,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
          ),
          Align(
            alignment: Alignment.center,
            child: Container(
                width: media.width * 0.80,
                height: media.width * 0.3,
                margin: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    Expanded(
                      child: ListView.builder(
                          itemCount:
                              widget.organDetails.reservableTestList.length,
                          itemBuilder: (ctx, index) {
                            List<ReservableTest> testList =
                                widget.organDetails.reservableTestList;
                            print(testList);
                            return Opacity(
                              opacity: 1,
                              child: Card(
                                  elevation: 0,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(25.0),
                                  ),
                                  color: Color.alphaBlend(
                                      Colors.white60,
                                      Color(int.parse(
                                          widget.organDetails.status.color))),
                                  child: Stack(
                                    children: <Widget>[
                                      Padding(
                                        padding: EdgeInsets.symmetric(
                                            vertical: 10, horizontal: 10),
                                        child: Text(
                                          testList[index].name,
                                          style: TextStyle(
                                            fontSize: media.width * 0.06,
                                          ),
                                        ),
                                      ),
                                      Align(
                                        alignment: Alignment.centerRight,
                                        child: RawMaterialButton(
                                          onPressed: null,
                                          // onPressed: () => _showReservableTest(
                                          //     context,
                                          //     testList[
                                          //         index]),
                                          child: Icon(
                                            Icons.info_outline,
                                            size: media.width * 0.08,
                                            color: Colors.white,
                                          ),
                                          shape: CircleBorder(),
                                          elevation: 0,
                                          fillColor: Color(int.parse(widget
                                              .organDetails.status.color)),
                                        ),
                                      ),
                                    ],
                                  )),
                            );
                          }),
                    ),
                  ],
                )),
          )
        ],
      ),
    );
  }
}
