import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:igea_app/blocs/bloc_home.dart';
import 'package:igea_app/screens/welcome/onboarding_page_view.dart';
import 'package:igea_app/shared/constants.dart';
import 'package:igea_app/blocs/bloc_loading.dart';
import 'package:igea_app/screens/home/home.dart';
import 'package:igea_app/models/user.dart';
import 'dart:async';

class LoadingScreen extends StatefulWidget {
  @override
  _LoadingScreenState createState() => _LoadingScreenState();
}

class _LoadingScreenState extends State<LoadingScreen> {
  LoadingBloc bloc;

  // @override
  // void didChangeDependencies() {
  //   super.didChangeDependencies();
  //   // bloc = LoadingBlocProvider.of(context);
  //   Timer(Duration(seconds: 5), () {
  //     print('FETCH USER');
  //     // bloc.fetchUser();
  //   });
  // }

  @override
  Widget build(BuildContext context) {
    bloc = LoadingBlocProvider.of(context);
    // bloc.fetchUser();
    return StreamBuilder(
        stream: bloc.user,
        builder: (BuildContext context, AsyncSnapshot<PrevengoUser> snapshot) {
          print('[SNAPSHOT]' + snapshot.toString());
          if (snapshot.hasData) {
            bool firstAccess = snapshot.data.firstAccess;
            print('[FIRST ACCESS]' + firstAccess.toString());
            // return firstAccess
            //     ? OnboardingPageView()
            //     : HomeBlocProvider(child: Home());
            return HomeBlocProvider(child: Home());
            //return OnboardingPageView();
          } else {
            return Container(
                color: colorAuthScreens,
                child: Center(
                    child: SpinKitChasingDots(
                  color: Colors.blue[900],
                  size: 50.0,
                )));
          }
        });
  }
}
