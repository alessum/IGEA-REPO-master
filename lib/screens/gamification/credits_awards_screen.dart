import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:igea_app/blocs/bloc_awards.dart';
import 'package:igea_app/blocs/gamification/bloc_leaderboard.dart';
import 'package:igea_app/models/constants/constants_graphics.dart';
import 'package:igea_app/models/gamification/coupon.dart';
import 'package:igea_app/models/gamification/gamification_data.dart';
import 'package:igea_app/screens/gamification/buy_coupon_screen.dart';
import 'package:igea_app/screens/gamification/leaderboard_screen.dart';
import 'package:igea_app/screens/gamification/use_coupon_screen.dart';
import 'package:igea_app/widgets/ui_components/close_line_top_modal.dart';
import 'package:igea_app/widgets/ui_components/coupon_card.dart';

class CredistsAndAwardsScreen extends StatefulWidget {
  CredistsAndAwardsScreen({Key key}) : super(key: key);

  @override
  _CredistsAndAwardsScreenState createState() =>
      _CredistsAndAwardsScreenState();
}

class _CredistsAndAwardsScreenState extends State<CredistsAndAwardsScreen> {
  AwardsBloc bloc;

  @override
  Widget build(BuildContext context) {
    Size media = MediaQuery.of(context).size;
    bloc = AwardsBlocProvider.of(context);

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        leadingWidth: 0,
        title: Align(
          alignment: Alignment.topLeft,
          child: Text('Quiz e premi',
              textAlign: TextAlign.left,
              style: TextStyle(
                  fontSize: media.width * 0.07,
                  color: Colors.black,
                  fontFamily: 'Gotham')),
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: Align(
        alignment: Alignment.bottomLeft,
        child: Container(
          padding: EdgeInsets.only(
            top: media.height * 0.01,
            bottom: media.height * 0.02,
          ),
          decoration: BoxDecoration(
            color: ConstantsGraphics.COLOR_ONBOARDING_YELLOW,
            borderRadius: BorderRadius.only(
              topRight: Radius.circular(80),
            ),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            mainAxisSize: MainAxisSize.max,
            children: [
              // CloseLineTopModal(),
              SizedBox(height: media.height * .01),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: media.width * 0.05),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    GestureDetector(
                        onTap: () => Navigator.pop(context),
                        child: SvgPicture.asset(
                          'assets/icons/circle_left.svg',
                          width: media.width * 0.09,
                        )),
                    SizedBox(width: media.width * 0.03),
                    Text('Classifica e premi',
                        textAlign: TextAlign.left,
                        style: TextStyle(
                            fontSize: media.width * 0.07,
                            color: Colors.white,
                            fontFamily: 'Gotham')),
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: media.width * .07),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      width: media.width * .6,
                      child: Text(
                        'Posizione in classifica',
                        style: TextStyle(
                            fontFamily: 'Book',
                            fontSize: media.width * 0.05,
                            color: Colors.white),
                      ),
                    ),
                    Container(
                      child: StreamBuilder<int>(
                          stream: bloc.getLeaderboardPosition,
                          builder: (context, snapshot) {
                            return snapshot.hasData
                                ? Text(
                                    snapshot.data != 0
                                        ? '${snapshot.data}'
                                        : 'Nessuna',
                                    style: TextStyle(
                                        fontFamily: 'Gotham',
                                        fontSize: snapshot.data != 0
                                            ? media.width * 0.07
                                            : media.width * 0.05,
                                        color: Colors.white),
                                  )
                                : Center(
                                    child: CircularProgressIndicator(),
                                  );
                          }),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: media.width * .07),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      width: media.width * .6,
                      child: Text(
                        'Punti totali guadagnati',
                        style: TextStyle(
                            fontFamily: 'Book',
                            fontSize: media.width * 0.05,
                            color: Colors.white),
                      ),
                    ),
                    Container(
                      child: StreamBuilder<GamificationData>(
                          stream: bloc.getGamificationData,
                          builder: (context, snapshot) {
                            return snapshot.hasData
                                ? Text(
                                    snapshot.data.monthlyQuizScore != null
                                        ? '${snapshot.data.monthlyQuizScore}'
                                        : '0',
                                    style: TextStyle(
                                        fontFamily: 'Gotham',
                                        fontSize: media.width * 0.07,
                                        color: Colors.white),
                                  )
                                : Center(
                                    child: CircularProgressIndicator(),
                                  );
                          }),
                    ),
                  ],
                ),
              ),
              SizedBox(height: media.height * .01),
              Container(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    SizedBox(
                      width: media.width * .08,
                    ),
                    Text(
                      'I miei Coupons',
                      style: TextStyle(
                        color: Colors.white,
                        fontFamily: 'Bold',
                        fontSize: media.width * 0.05,
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                height: media.height * 0.5,
                width: media.width * 0.9,
                child: StreamBuilder<Map<String, Coupon>>(
                    stream: bloc.getOwnedCoupons,
                    builder: (context, snapshot) => snapshot.hasData
                        ? ListView.separated(
                            itemBuilder: (context, index) {
                              String key = snapshot.data.keys.elementAt(index);
                              return CouponCard(
                                buttonLabel: 'Utilizza',
                                title: snapshot.data[key].title,
                                value: snapshot.data[key].value,
                                logoImage: snapshot.data[key].logoImage,
                                onTap: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => UseCouponsScreen(
                                        code: snapshot.data[key].code,
                                        logoImage: snapshot.data[key].logoImage,
                                        value: snapshot.data[key].value,
                                        brand: snapshot.data[key].brand,
                                      ),
                                    ),
                                  );
                                },
                              );
                            },
                            separatorBuilder: (_, __) =>
                                SizedBox(height: media.height * 0.03),
                            itemCount: snapshot.data.length,
                          )
                        : Center(
                            child: CircularProgressIndicator(),
                          )),
              ),
              GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => LeaderboardBlocProvider(
                        child: LeaderBoardScreen(),
                      ),
                    ),
                  );
                },
                child: Container(
                  margin: EdgeInsets.symmetric(horizontal: media.width * .1),
                  padding: EdgeInsets.all(media.width * 0.03),
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.all(Radius.circular(35))),
                  child: Center(
                    child: Text(
                      'Visualizza la classifica',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: ConstantsGraphics.COLOR_ONBOARDING_YELLOW,
                        fontFamily: 'Gotham',
                        fontSize: media.width * 0.05,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
