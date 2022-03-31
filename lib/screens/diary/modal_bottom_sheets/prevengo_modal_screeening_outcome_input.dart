import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:igea_app/models/constants/constants_graphics.dart';
import 'package:igea_app/models/enums/screening_outcome_value.dart';
import 'package:igea_app/widgets/ui_components/close_line_top_modal.dart';

class PrevengoModalScreeningOutcomeInput extends StatefulWidget {
  PrevengoModalScreeningOutcomeInput({
    Key key,
    @required this.onConfirm,
  }) : super(key: key);

  final Function(ScreeningOutcomeValue value) onConfirm;

  @override
  _PrevengoModalScreeningOutcomeInputState createState() =>
      _PrevengoModalScreeningOutcomeInputState();
}

class _PrevengoModalScreeningOutcomeInputState
    extends State<PrevengoModalScreeningOutcomeInput> {
  bool outcomeNegativeSelected;

  @override
  Widget build(BuildContext context) {
    Size media = MediaQuery.of(context).size;
    return Container(
      padding: EdgeInsets.fromLTRB(15, 8, 15, 8),
      margin: EdgeInsets.all(8),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(25),
        color: Colors.white,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          CloseLineTopModal(),
          Container(
            alignment: Alignment.topLeft,
            margin: const EdgeInsets.symmetric(vertical: 15.0),
            child: Text(
              'Seleziona il tipo di esito',
              style: TextStyle(
                fontSize: media.width * 0.05,
                fontFamily: 'Gotham',
              ),
            ),
          ),
          Column(
            children: [
              GestureDetector(
                onTap: () {
                  setState(() {
                    outcomeNegativeSelected = true;
                  });
                },
                child: Container(
                  width: media.width * 0.7,
                  padding: const EdgeInsets.all(13.0),
                  margin: const EdgeInsets.symmetric(vertical: 8.0),
                  decoration: BoxDecoration(
                      color: Colors.grey[200],
                      borderRadius: BorderRadius.all(
                        Radius.circular(25),
                      ),
                      border: Border.all(
                        width: 3,
                        color: (outcomeNegativeSelected != null &&
                                outcomeNegativeSelected == true)
                            ? ConstantsGraphics.COLOR_DIARY_BLUE
                            : Colors.grey[600],
                      )),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      SvgPicture.asset(
                        'assets/icons/happy.svg',
                        height: media.width * 0.08,
                        color: (outcomeNegativeSelected != null &&
                                outcomeNegativeSelected == true)
                            ? ConstantsGraphics.COLOR_DIARY_BLUE
                            : Colors.grey[600],
                      ),
                      Text(
                        'Esito nella norma',
                        style: TextStyle(
                          fontSize: media.width * 0.045,
                          fontFamily: 'Book',
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              GestureDetector(
                onTap: () {
                  setState(() {
                    outcomeNegativeSelected = false;
                  });
                },
                child: Container(
                  width: media.width * 0.7,
                  padding: const EdgeInsets.all(13.0),
                  margin: const EdgeInsets.symmetric(vertical: 8.0),
                  decoration: BoxDecoration(
                      color: Colors.grey[200],
                      borderRadius: BorderRadius.all(
                        Radius.circular(25),
                      ),
                      border: Border.all(
                        width: 3,
                        color: (outcomeNegativeSelected != null &&
                                outcomeNegativeSelected == false)
                            ? ConstantsGraphics.COLOR_DIARY_BLUE
                            : Colors.grey[600],
                      )),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      SvgPicture.asset(
                        'assets/icons/sad.svg',
                        height: media.width * 0.08,
                        color: (outcomeNegativeSelected != null &&
                                outcomeNegativeSelected == false)
                            ? ConstantsGraphics.COLOR_DIARY_BLUE
                            : Colors.grey[600],
                      ),
                      Text(
                        'Esito da approfondire',
                        style: TextStyle(
                          fontSize: media.width * 0.045,
                          fontFamily: 'Book',
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: media.height * 0.03),
          GestureDetector(
            onTap: () {
              if (outcomeNegativeSelected != null) {
                outcomeNegativeSelected
                    ? widget.onConfirm(ScreeningOutcomeValue.NEG)
                    : widget.onConfirm(ScreeningOutcomeValue.POS);
                Navigator.pop(context);
              }
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
          )
        ],
      ),
    );
  }
}
