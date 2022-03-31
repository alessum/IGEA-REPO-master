import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:igea_app/blocs/onboarding/onboarding_colon_bloc.dart';
import 'package:igea_app/screens/diary/modal_bottom_sheets/prevengo_modal_css.dart';
import 'package:igea_app/screens/welcome/colon/familiarity_form.dart';
import 'package:igea_app/services/utilities.dart';
import 'package:igea_app/screens/chatbot/chatbot.dart';
import 'package:igea_app/widgets/modal_bottom_sheets/colon_relatives_age_question.dart';
import 'ui_components/prevengo_colon_modal_familiarity_info.dart';

class CheckFamiliarityPage extends StatefulWidget {
  CheckFamiliarityPage({
    Key key,
    @required this.flashToPage,
  }) : super(key: key);

  final Function(int page) flashToPage;
  @override
  _CheckFamiliarityPageState createState() => _CheckFamiliarityPageState();
}

class _CheckFamiliarityPageState extends State<CheckFamiliarityPage> {
  OnboardingColonBloc bloc;

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      bloc.initFamiliarityPage();
      Future.delayed(const Duration(milliseconds: 300), () {
        setState(() {
          bool flag =
              CacheManager.getValue(CacheManager.flagModalColonFamiliarity) ??
                  false;
          if (flag) {
            showModalBottomSheet(
              context: context,
              builder: (context) => PrevengoColonModalFamiliarityInfo(),
              backgroundColor: Colors.black.withOpacity(0),
              isScrollControlled: true,
            );
            CacheManager.saveKV(CacheManager.flagModalColonFamiliarity, true);
          }
        });
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    Size media = MediaQuery.of(context).size;
    bloc = OnboardingColonBlocProvider.of(context);

    return Container(
      padding: EdgeInsets.only(
        bottom: media.height * .015,
        top: media.height * .05,
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisSize: MainAxisSize.max,
        children: <Widget>[
          FamiliarityForm(),
          GestureDetector(
            onTap: () {
              int parentCount =
                  CacheManager.getValue(CacheManager.colonParentCounterKey);
              if (parentCount == 1) {
                showModalBottomSheet(
                  context: context,
                  builder: (context) => ModalBottomColonRelativesAgeQuestion(
                    onChangeAge: (val) => bloc.setParentAge.add(int.parse(val)),
                    onConfirm: () {
                      Navigator.pop(context);
                      if (bloc.isfamiliarityInputValid()) {
                        bloc.checkFamiliarityAlgorithm();
                        showModalBottomSheet(
                          context: context,
                          builder: (context) => StreamBuilder<Widget>(
                            stream: bloc.getFamiliarityAlgorithmResult,
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
                        //CHECK SULLA DATA E AGGIORNAMENTO STATO ORGANO IN OUT OF DATE SE FUORI DA SCREENING
                        if (bloc.isTooSoonForScreening()) {
                          //vai alla pagina troppo presto e calcola tre quanto dovrà fare l'esame
                          bloc.setTooSoonForScreeningStatus();
                          widget.flashToPage(3);
                        } else if (bloc.isTooLateForScreening()) {
                          //vai alla pagina di fine programma di screening
                          bloc.setTooLateForScreeningStatus();
                          widget.flashToPage(4);
                        } else {
                          //screening in corso
                          widget.flashToPage(1);
                        }
                      } else {
                        showModalBottomSheet(
                          context: context,
                          builder: (context) => PrevengoDiaryModalCSS(
                            colorTheme: Colors.grey[400],
                            title: 'C\'è un problema',
                            message:
                                'Ho bisono di questa informazione per poterti aiutare',
                            iconPath: 'assets/avatars/arold_in_circle.svg',
                            isAlert: true,
                          ),
                          backgroundColor: Colors.black.withOpacity(0),
                          isScrollControlled: true,
                        );
                      }
                    },
                  ),
                  backgroundColor: Colors.black.withOpacity(0),
                  isScrollControlled: true,
                );
              } else {
                if (bloc.isfamiliarityInputValid()) {
                  bloc.checkFamiliarityAlgorithm();
                  showModalBottomSheet(
                    context: context,
                    builder: (context) => StreamBuilder<Widget>(
                      stream: bloc.getFamiliarityAlgorithmResult,
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
                  //CHECK SULLA DATA E AGGIORNAMENTO STATO ORGANO IN OUT OF DATE SE FUORI DA SCREENING
                  if (bloc.isTooSoonForScreening()) {
                    //vai alla pagina troppo presto e calcola tre quanto dovrà fare l'esame
                    bloc.setTooSoonForScreeningStatus();
                    widget.flashToPage(3);
                  } else if (bloc.isTooLateForScreening()) {
                    //vai alla pagina di fine programma di screening
                    bloc.setTooLateForScreeningStatus();
                    widget.flashToPage(4);
                  } else {
                    //screening in corso
                    widget.flashToPage(1);
                  }
                } else {
                  showModalBottomSheet(
                    context: context,
                    builder: (context) => PrevengoDiaryModalCSS(
                      colorTheme: Colors.grey[400],
                      title: 'C\'è un problema',
                      message:
                          'Ho bisono di questa informazione per poterti aiutare',
                      iconPath: 'assets/avatars/arold_in_circle.svg',
                      isAlert: true,
                    ),
                    backgroundColor: Colors.black.withOpacity(0),
                    isScrollControlled: true,
                  );
                }
              }
            },
            child: Container(
              height: media.height > 600 ? 40 : 30,
              padding: EdgeInsets.symmetric(horizontal: 10, vertical: 4),
              margin: EdgeInsets.symmetric(vertical: 10),
              width: media.width * 0.4,
              decoration: BoxDecoration(
                  color: Color(0xFFD8A31E),
                  borderRadius: BorderRadius.all(Radius.circular(25)),
                  border: Border.all(
                      style: BorderStyle.solid,
                      color: Colors.white,
                      width: 1.5)),
              child: Align(
                alignment: Alignment.center,
                child: Text(
                  'Continua',
                  style: TextStyle(
                      fontFamily: 'Gotham',
                      fontSize: media.width * 0.05,
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
