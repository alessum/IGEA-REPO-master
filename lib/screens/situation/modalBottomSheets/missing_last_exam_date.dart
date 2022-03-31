import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:igea_app/blocs/bloc_onboarding.dart';
import 'package:igea_app/models/constants/constants.dart';
import 'package:igea_app/models/enums/test_type.dart';
import 'package:igea_app/models/status.dart';
import 'package:igea_app/widgets/modal_bottom_sheets/registry_input_date.dart';
import 'package:igea_app/widgets/ui_components/close_line_top_modal.dart';

class ModalBottomMissingLastExamDate extends StatefulWidget {
  ModalBottomMissingLastExamDate({
    Key key,
    @required this.organStatus,
    @required this.notifyClose,
    @required this.organKey,
  }) : super(key: key);

  final Status organStatus;
  final Function() notifyClose;
  final String organKey;

  @override
  _ModalBottomMissingLastExamDateState createState() =>
      _ModalBottomMissingLastExamDateState();
}

class _ModalBottomMissingLastExamDateState
    extends State<ModalBottomMissingLastExamDate> {
  int _examYear;
  OnboardingBloc bloc;
  @override
  Widget build(BuildContext context) {
    Size media = MediaQuery.of(context).size;
    bloc = OnboardingBlocProvider.of(context);
    return Container(
      margin: EdgeInsets.all(8),
      padding: EdgeInsets.all(15),
      height: media.height * 0.4,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.all(Radius.circular(25)),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          CloseLineTopModal(),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            mainAxisSize: MainAxisSize.max,
            children: [
              Container(
                width: media.width * 0.6,
                child: Text(
                  'Devi ancora inserire la data dell\'ultimo esame che hai fatto',
                  style: TextStyle(
                    fontSize: media.width * 0.05,
                    fontFamily: 'Bold',
                  ),
                ),
              ),
              Container(
                width: media.width * 0.25,
                child: Center(
                  child: SvgPicture.asset(
                    '${widget.organStatus.iconPath}',
                    fit: BoxFit.cover,
                    height: media.height * 0.05,
                  ),
                ),
              )
            ],
          ),
          SizedBox(height: media.height * 0.01),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            mainAxisSize: MainAxisSize.max,
            children: [
              Container(
                width: media.width * 0.6,
                child: Text(
                  'Inserisci l\'anno in cui hai fatto l\'esame',
                  style: TextStyle(
                    fontSize: media.width * 0.045,
                    fontFamily: 'Book',
                  ),
                ),
              ),
              GestureDetector(
                onTap: () {
                  showModalBottomSheet(
                    context: context,
                    builder: (_) => ModalBottomInputDate(
                      setDate: (value) {
                        setState(() {
                          _examYear = value.year;
                        });
                        Navigator.pop(context);
                      },
                      titleLabel: 'Inserisci l\'anno di nascita',
                      dateFormat: 'yyyy',
                      colorTheme: Color(int.parse(widget.organStatus.color)),
                      limitUpToday: true,
                    ),
                    backgroundColor: Colors.black.withOpacity(0),
                    isScrollControlled: true,
                  );
                },
                child: Container(
                  height: media.height < 700
                      ? media.height * 0.07
                      : media.height * 0.05,
                  width: media.width * 0.25,
                  decoration: BoxDecoration(
                      color: Color(int.parse(widget.organStatus.color)),
                      borderRadius: BorderRadius.all(Radius.circular(25)),
                      border: Border.all(
                          style: BorderStyle.solid,
                          color: Colors.white,
                          width: 1.5)),
                  child: Center(
                    child: Text(
                      _examYear != null ? _examYear.toString() : 'aaaa',
                      style: TextStyle(
                          fontSize: media.width * 0.05,
                          fontFamily: 'Book',
                          color: Colors.white),
                    ),
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: media.height * 0.03),
          GestureDetector(
            onTap: () {
              Map<String, dynamic> data = Map();
              data.addAll({
                Constants.ORGAN_KEY: widget.organKey,
                Constants.LAST_TEST_DATE_KEY: null,
              });
              bloc.inUpdateOrganData.add(data);

              Map<String, dynamic> algorithmData = Map();
              algorithmData.addAll({
                Constants.ORGAN_KEY: widget.organKey,
                Constants.TEST_TYPE_KEY: TestType.PAP_TEST.index,
              });
              bloc.inCalcNextDateData.add(algorithmData);
              widget.notifyClose();
            },
            child: Container(
              width: media.width * 0.8,
              padding: EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: Colors.white,
                border: Border.all(
                  style: BorderStyle.solid,
                  width: 3,
                  color: Color(
                    int.parse(widget.organStatus.color),
                  ),
                ),
                borderRadius: BorderRadius.all(
                  Radius.circular(25),
                ),
              ),
              child: Center(
                child: Text(
                  'Non mi ricordo, seguimi tu da zero',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: media.width * 0.04,
                    fontFamily: 'Bold',
                  ),
                ),
              ),
            ),
          ),
          GestureDetector(
            onTap: () {
              DateTime lastTestDate = DateTime(_examYear);
              Map<String, dynamic> data = Map();
              data.addAll({
                Constants.LAST_TEST_DATE_KEY: lastTestDate,
                Constants.ORGAN_KEY: widget.organKey,
              });
              bloc.inUpdateOrganData.add(data);
              Map<String, dynamic> algorithmData = Map();
              algorithmData.addAll({
                Constants.ORGAN_KEY: widget.organKey,
                Constants.LAST_TEST_DATE_KEY: lastTestDate,
                Constants.TEST_TYPE_KEY: TestType.PAP_TEST.index,
              });
              bloc.inCalcNextDateData.add(algorithmData);
              widget.notifyClose();
            },
            child: Container(
              width: media.width * 0.8,
              padding: EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: Color(int.parse(widget.organStatus.color)),
                borderRadius: BorderRadius.all(
                  Radius.circular(25),
                ),
              ),
              child: Center(
                child: Text(
                  'Inserisci anno',
                  style: TextStyle(
                    fontSize: media.width * 0.04,
                    fontFamily: 'Bold',
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
