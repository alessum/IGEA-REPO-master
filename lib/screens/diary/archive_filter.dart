import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:igea_app/blocs/diary/bloc_diary_archive.dart';
import 'package:igea_app/models/constants/constants_graphics.dart';
import 'package:igea_app/models/enums/test_type.dart';
import 'package:igea_app/models/reservable_test.dart';
import 'package:igea_app/screens/calendar/modalBottomSheets/reservable_test_selection.dart';
import 'package:igea_app/widgets/modal_bottom_sheets/registry_input_date.dart';

class DiaryTestFilter extends StatefulWidget {
  DiaryTestFilter({Key key}) : super(key: key);

  @override
  _DiaryTestFilterState createState() => _DiaryTestFilterState();
}

class _DiaryTestFilterState extends State<DiaryTestFilter> {
  DiaryArchiveBloc bloc;

  @override
  Widget build(BuildContext context) {
    Size media = MediaQuery.of(context).size;
    bloc = DiaryArchiveBlocProvider.of(context);

    return Container(
      height: media.height * 0.35,
      width: media.width,
      padding: EdgeInsets.all(15),
      margin: EdgeInsets.symmetric(horizontal: media.width * 0.03),
      decoration: BoxDecoration(
        color: Colors.grey[200],
        borderRadius: BorderRadius.all(Radius.circular(25)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Container(
            child: Text(
              'Filtra esami',
              style: TextStyle(
                fontSize: media.width * 0.06,
                fontFamily: 'Bold',
              ),
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                width: media.width * 0.4,
                child: Text(
                  'Tipologia esame',
                  style: TextStyle(
                    fontSize: media.width * 0.045,
                    fontFamily: 'Book',
                  ),
                ),
              ),
              GestureDetector(
                onTap: () => _showTestTypeSelection(context),
                child: StreamBuilder<ReservableTest>(
                    stream: bloc.getFilterTestType,
                    builder: (context, snapshot) {
                      return Container(
                        width: media.width * 0.42,
                        padding: EdgeInsets.all(8),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.all(Radius.circular(25)),
                        ),
                        child: Text(
                          snapshot.hasData
                              ? snapshot.data.name
                              : 'Cerca tipo esame',
                          style: TextStyle(
                            fontSize: media.width * 0.04,
                            fontFamily: 'Book',
                          ),
                        ),
                      );
                    }),
              ),
            ],
          ),
          Container(
            height: media.height * 0.08,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Container(
                      child: Text(
                        'Cerca negli anni',
                        style: TextStyle(
                          fontSize: media.width * 0.045,
                          fontFamily: 'Book',
                        ),
                      ),
                    )
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Container(
                      child: Text(
                        'Da',
                        style: TextStyle(
                          fontSize: media.width * 0.045,
                          fontFamily: 'Book',
                        ),
                      ),
                    ),
                    GestureDetector(
                      onTap: () => showModalBottomSheet(
                        context: context,
                        builder: (context) => ModalBottomInputDate(
                            setDate: (dateOfBirth) {
                              bloc.updateTestStartDateFilter(dateOfBirth);
                              Navigator.pop(context);
                            },
                            titleLabel: 'Inserisci da che anno fare la ricerca',
                            dateFormat: 'yyyy',
                            colorTheme: ConstantsGraphics.COLOR_DIARY_BLUE,
                            limitUpToday: true),
                        backgroundColor: Colors.black.withOpacity(0),
                        isScrollControlled: true,
                      ),
                      child: StreamBuilder<int>(
                          stream: bloc.getFilterStartDate,
                          builder: (context, snapshot) {
                            return Container(
                              width: media.width * 0.25,
                              padding: EdgeInsets.all(8),
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius:
                                    BorderRadius.all(Radius.circular(25)),
                              ),
                              child: Center(
                                child: Text(
                                  snapshot.hasData
                                      ? '${snapshot.data}'
                                      : 'aaaa',
                                  style: TextStyle(
                                    fontSize: media.width * 0.04,
                                    fontFamily: 'Book',
                                  ),
                                ),
                              ),
                            );
                          }),
                    ),
                    Container(
                      child: Text(
                        'A',
                        style: TextStyle(
                          fontSize: media.width * 0.045,
                          fontFamily: 'Book',
                        ),
                      ),
                    ),
                    GestureDetector(
                      onTap: () => showModalBottomSheet(
                        context: context,
                        builder: (context) => ModalBottomInputDate(
                            setDate: (dateOfBirth) {
                              bloc.updateTestEndDateFilter(dateOfBirth);
                              Navigator.pop(context);
                            },
                            titleLabel:
                                'Inserisci fino a che anno fare la ricerca',
                            dateFormat: 'yyyy',
                            colorTheme: ConstantsGraphics.COLOR_DIARY_BLUE,
                            limitUpToday: true),
                        backgroundColor: Colors.black.withOpacity(0),
                        isScrollControlled: true,
                      ),
                      child: StreamBuilder<int>(
                          stream: bloc.getFilterEndDate,
                          builder: (context, snapshot) {
                            return Container(
                              width: media.width * 0.25,
                              padding: EdgeInsets.all(8),
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius:
                                    BorderRadius.all(Radius.circular(25)),
                              ),
                              child: Center(
                                child: Text(
                                  snapshot.hasData
                                      ? '${snapshot.data}'
                                      : 'aaaa',
                                  style: TextStyle(
                                    fontSize: media.width * 0.04,
                                    fontFamily: 'Book',
                                  ),
                                ),
                              ),
                            );
                          }),
                    ),
                  ],
                ),
              ],
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              GestureDetector(
                onTap: () => bloc.resetFilter(),
                child: Container(
                  width: media.width * 0.35,
                  decoration: BoxDecoration(
                    color: Color(0xff4768b7),
                    borderRadius: BorderRadius.circular(media.width * 0.055),
                  ),
                  padding: const EdgeInsets.only(
                      top: 5.0, bottom: 5.0, left: 15.0, right: 5.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Text('Resetta',
                          style: TextStyle(
                              fontSize: media.height * 0.023,
                              color: Colors.white,
                              fontFamily: 'Bold')),
                      CircleAvatar(
                        backgroundColor: Colors.white,
                        radius: 15.0,
                        child: SvgPicture.asset(
                          'assets/icons/reset.svg',
                          width: media.width * 0.05,
                        ),
                      )
                    ],
                  ),
                ),
              ),
              SizedBox(width: media.width * 0.06),
              GestureDetector(
                onTap: () => bloc.filterTest(),
                child: Container(
                  width: media.width * 0.35,
                  decoration: BoxDecoration(
                    color: Color(0xff4768b7),
                    borderRadius: BorderRadius.circular(20.0),
                  ),
                  padding: const EdgeInsets.only(
                      top: 5.0, bottom: 5.0, left: 15.0, right: 5.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Text('Cerca',
                          style: TextStyle(
                              fontSize: media.height * 0.023,
                              color: Colors.white,
                              fontFamily: 'Bold')),
                      SizedBox(width: 10.0),
                      CircleAvatar(
                        backgroundColor: Colors.white,
                        radius: 15.0,
                        child: SvgPicture.asset(
                          'assets/icons/search.svg',
                          width: media.width * 0.045,
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  _showTestTypeSelection(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (context) => ModalBottomReservableTestSelection(
        colorTheme: ConstantsGraphics.COLOR_DIARY_BLUE,
        reservableTestSelection: (reservableTest) =>
            bloc.updateTestTypeFilter(reservableTest),
      ),
      backgroundColor: Colors.black.withOpacity(0),
      isScrollControlled: true,
    );
  }
}
