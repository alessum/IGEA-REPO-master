import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:igea_app/blocs/onboarding/onboarding_breast_bloc.dart';
import 'package:igea_app/screens/welcome/ui_components/prevengo_modal_screening_guidelines.dart';
import 'package:igea_app/screens/welcome/ui_components/prevengo_onboarding_button.dart';
import 'package:igea_app/screens/welcome/ui_components/prevengo_onboarding_button_icon.dart';

class BreastOutputInfoPage extends StatefulWidget {
  const BreastOutputInfoPage({
    Key key,
    @required this.flashToPage,
  }) : super(key: key);

  final Function(int page) flashToPage;

  @override
  _BreastOutputInfoPageState createState() => _BreastOutputInfoPageState();
}

class _BreastOutputInfoPageState extends State<BreastOutputInfoPage> {
  OnboardingBreastBloc bloc;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Size media = MediaQuery.of(context).size;
    bloc = OnboardingBreastBlocProvider.of(context);
    bloc.calcSuggestedBooking();

    return Container(
      padding: EdgeInsets.only(bottom: media.height * .015),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.max,
        children: <Widget>[
          SizedBox(height: media.height * .05),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 35),
            child: Text(
              'Secondo le linee guida ministeriali e secondo i dati che hai inserito dovresti fare una mammografia ogni',
              style: TextStyle(
                  fontSize: media.width * 0.05,
                  color: Colors.white,
                  fontFamily: 'Bold'),
            ),
          ),
          SizedBox(height: media.height * 0.03),
          Align(
            alignment: Alignment.center,
            child: Container(
              width: media.width * 0.3,
              child: Stack(
                children: <Widget>[
                  Center(
                    child: Container(
                      height: media.height * 0.05,
                      width: media.width * 0.25,
                      padding: EdgeInsets.all(8),
                      decoration: BoxDecoration(
                          color: Color(0xFFD8B571),
                          borderRadius: BorderRadius.all(Radius.circular(25)),
                          border: Border.all(
                              style: BorderStyle.solid,
                              color: Colors.white,
                              width: 1.5)),
                      child: Center(
                          child: StreamBuilder<String>(
                        stream: bloc.getSuggestedBooking,
                        builder: (context, snapshot) => snapshot.hasData
                            ? Text(
                                snapshot.data,
                                style: TextStyle(
                                    fontSize: media.width * 0.05,
                                    color: Colors.white,
                                    fontFamily: 'Gotham'),
                              )
                            : CircularProgressIndicator(),
                      )),
                    ),
                  ),
                  // Align(
                  //   alignment: Alignment.centerRight,
                  //   child: GestureDetector(
                  //     onTap: null,
                  //     child: Container(
                  //       height: media.height * 0.05,
                  //       child: SvgPicture.asset(
                  //         'assets/icons/info.svg',
                  //         width: media.width * 0.06,
                  //       ),
                  //     ),
                  //   ),
                  // )
                ],
              ),
            ),
          ),
          SizedBox(height: media.height * 0.03),
          Container(
            margin: EdgeInsets.symmetric(horizontal: media.width * .05),
            decoration: BoxDecoration(
              color: Color(0xFFD8A31E),
              borderRadius: BorderRadius.all(Radius.circular(25)),
            ),
            padding: EdgeInsets.all(media.width * .05),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Dovresti aver ricevuto la lettera di invito dalla tua Regione',
                  style: TextStyle(
                      fontFamily: 'Bold',
                      fontSize: media.width * 0.05,
                      color: Colors.white),
                ),
                SizedBox(height: media.height * .02),
                Align(
                  alignment: Alignment.centerRight,
                  child: PrevengoOnboardingButton(
                    onTap: () => showModalBottomSheet(
                      context: context,
                      builder: (context) => PrevengoModalScreeningGuidelines(),
                      backgroundColor: Colors.black.withOpacity(0),
                      isScrollControlled: true,
                    ),
                    colorTheme: Color(0xFFD8A31E),
                    fontSize: media.width * .045,
                    label: 'Maggiori info',
                    width: media.width * .45,
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: media.height * 0.03),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 35),
            child: Text(
              'Hai mai fatto una mammografia?',
              style: TextStyle(
                  fontSize: media.width * 0.05,
                  color: Colors.white,
                  fontFamily: 'Bold'),
            ),
          ),
          SizedBox(height: media.height * 0.03),
          Container(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                PrevengoOnboardingButton(
                  onTap: () => widget.flashToPage(2),
                  colorTheme: Color(0xFFD8A31E),
                  fontSize: media.width * .05,
                  label: 'Si',
                  width: media.width * .3,
                ),
                SizedBox(width: media.width * 0.04),
                PrevengoOnboardingButton(
                  onTap: () {
                    bloc.startFromZero();
                    showModalBottomSheet(
                      context: context,
                      builder: (context) => StreamBuilder<Widget>(
                        stream: bloc.getAlgorithmResult,
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
                  },
                  colorTheme: Color(0xFFD8A31E),
                  fontSize: media.width * .05,
                  label: 'No',
                  width: media.width * .3,
                ),
              ],
            ),
          ),
          SizedBox(height: media.height * .1),
          Padding(
            padding: EdgeInsets.only(left: media.width * 0.05),
            child: PrevengoOnboardingButtonIcon(
              onTap: () => widget.flashToPage(0),
              colorTheme: Color(0xFFD8A31E),
              fontSize: media.width * .05,
              label: 'Torna indietro',
              icon: Icons.arrow_back_rounded,
              width: media.width * .5,
            ),
          ),
        ],
      ),
    );
  }
}
