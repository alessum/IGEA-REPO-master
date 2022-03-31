import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:igea_app/blocs/onboarding/onboarding_uterus_bloc.dart';
import 'package:igea_app/models/constants/constants_chatbot_messages.dart';
import 'package:igea_app/models/constants/constants_graphics.dart';
import 'package:igea_app/models/enums/gender.dart';
import 'package:igea_app/screens/chatbot/chatbot.dart';
import 'package:igea_app/screens/diary/modal_bottom_sheets/prevengo_modal_css.dart';
import 'package:igea_app/screens/welcome/uterus/ui_components/prevengo_radio_button_text.dart';
import 'package:igea_app/services/utilities.dart';
import 'ui_components/prevengo_uterus_modal_vaccine_info.dart';

class HPVRequestPage extends StatefulWidget {
  HPVRequestPage({
    Key key,
    @required this.flashToPage,
  }) : super(key: key);

  final Function(int page) flashToPage;

  @override
  _HPVRequestPageState createState() => _HPVRequestPageState();
}

class _HPVRequestPageState extends State<HPVRequestPage> {
  OnboardingUterusBloc bloc;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    print('INIT STATE');
    WidgetsBinding.instance
        .addPostFrameCallback((_) => bloc.initHpvRequestPage());
  }

  @override
  Widget build(BuildContext context) {
    Size media = MediaQuery.of(context).size;
    bloc = OnboardingUterusBlocProvider.of(context);
    //bloc.initHpvVaccination();
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        SizedBox(height: media.height * 0.1),
        Container(
          height: media.height * 0.3,
          width: media.width,
          margin: EdgeInsets.symmetric(horizontal: 10),
          decoration: BoxDecoration(
              color: Color(0xFFD8A31E),
              borderRadius: BorderRadius.all(Radius.circular(25)),
              border: Border.all(
                  style: BorderStyle.solid, color: Colors.white, width: 1.5)),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              Container(
                height: media.height * 0.055,
                margin: EdgeInsets.only(top: 10),
                padding: EdgeInsets.symmetric(horizontal: 10),
                width: media.width * 0.7,
                decoration: BoxDecoration(
                    color: Color(0xFFD8A31E),
                    borderRadius: BorderRadius.all(Radius.circular(25)),
                    border: Border.all(
                        style: BorderStyle.solid,
                        color: Colors.white,
                        width: 1.5)),
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Text(
                        'Vaccino anti HPV',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            fontFamily: 'Book',
                            fontSize: media.width * 0.05,
                            color: Colors.white),
                      ),
                      GestureDetector(
                        onTap: () => showModalBottomSheet(
                          context: context,
                          builder: (context) =>
                              PrevengoUterusModalVaccineInfo(),
                          backgroundColor: Colors.black.withOpacity(0),
                          isScrollControlled: true,
                        ),
                        child: SvgPicture.asset(
                          'assets/icons/info.svg',
                          width: media.width * 0.06,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Container(
                child: Text(
                  'Hai fatto il vaccino anti HPV?',
                  style: TextStyle(
                      fontSize: media.width * 0.05,
                      fontFamily: 'Bold',
                      color: Colors.white),
                ),
              ),
              Container(
                height: media.height * 0.1,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    StreamBuilder<bool>(
                        stream: bloc.isHpvVaccinated,
                        builder: (context, snapshot) {
                          return PrevengoRadioButtonText(
                            width: media.width * .4,
                            fontSize: media.width * .045,
                            label: 'L\'ho fatto',
                            checked: snapshot.hasData ? snapshot.data : false,
                            onTap: () => bloc.updateHpvVaccine.add(true),
                            colorTheme: Color(0xFFE8B21C),
                          );
                        }),
                    StreamBuilder<bool>(
                        stream: bloc.isHpvVaccinated,
                        builder: (context, snapshot) {
                          return PrevengoRadioButtonText(
                            width: media.width * .4,
                            fontSize: media.width * .045,
                            label: 'Non l\'ho fatto',
                            checked: snapshot.hasData ? !snapshot.data : false,
                            onTap: () => bloc.updateHpvVaccine.add(false),
                            colorTheme: Color(0xFFE8B21C),
                          );
                        }),
                  ],
                ),
              ),
            ],
          ),
        ),
        SizedBox(
          height: media.height * 0.05,
        ),
        GestureDetector(
          onTap: () {
            if (bloc.isHpvVaccineInputValid()) {
              if (CacheManager.getValue(CacheManager.genderKey) ==
                  Gender.MALE) {
                CacheManager.saveKV(
                    CacheManager.checkQuestionaryUterusKey, true);
                if (CacheManager.getValue(
                    CacheManager.uterusAntiHpvVaccinationKey)) {
                  //messaggio vaccinazione fatta
                  bloc.updateVaccination();
                  showModalBottomSheet(
                    context: context,
                    builder: (context) => PrevengoDiaryModalCSS(
                      title: 'Ben fatto!!',
                      colorTheme: ConstantsGraphics.COLOR_ONBOARDING_YELLOW,
                      message:
                          'Il vaccino si è dimostrato utile anche negli uomini, non solo per prevenire possibili patologie legate al virus, ma anche per ridurne la circolazione',
                      iconPath: 'assets/avatars/arold_in_circle.svg',
                      isAlert: false,
                    ),
                    backgroundColor: Colors.black.withOpacity(0),
                    isScrollControlled: true,
                  );
                } else {
                  bloc.updateVaccination();
                  showModalBottomSheet(
                    context: context,
                    builder: (context) => PrevengoDiaryModalCSS(
                      title: 'Ricordati di vaccinarti!',
                      colorTheme: ConstantsGraphics.COLOR_ONBOARDING_YELLOW,
                      message:
                          'Il vaccino è rivolto in particolare alla donne tra i 12 e i 26 anni e agli uomini, non solo per prevenire possibili patologie legate al virus, ma anche per ridurne la circolazione.',
                      iconPath: 'assets/avatars/arold_in_circle.svg',
                      isAlert: false,
                    ),
                    backgroundColor: Colors.black.withOpacity(0),
                    isScrollControlled: true,
                  );
                }
              } else {
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
          child: Align(
            alignment: Alignment.bottomCenter,
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
          ),
        )
      ],
    );
  }

  void showChat(
      BuildContext context, List<String> suggestedMessageList, String message) {
    showModalBottomSheet(
      isScrollControlled: true,
      context: context,
      builder: (_) => message != null
          ? Chatbot(
              suggestedMessageList: suggestedMessageList,
              inputMessage: message,
            )
          : Chatbot(
              suggestedMessageList: suggestedMessageList,
            ),
    );
  }
}
