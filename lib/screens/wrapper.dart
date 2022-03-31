import 'package:flutter/material.dart';
import 'package:igea_app/blocs/bloc_home.dart';
import 'package:igea_app/blocs/bloc_wrapper.dart';
import 'package:igea_app/blocs/prevengo_doctors/bloc_doctor_list.dart';
import 'package:igea_app/models/user.dart';
import 'package:igea_app/screens/authenticate/authenticate.dart';
import 'package:igea_app/screens/prevengo_doctors/doctors_proposed_screen.dart';
import 'package:igea_app/screens/welcome/onboarding_page_view.dart';
import 'package:igea_app/screens/home/home.dart';
import 'package:igea_app/services/firestore_read.dart';
import 'authenticate/authenticate.dart';

class Wrapper extends StatefulWidget {
  @override
  _WrapperState createState() => _WrapperState();
}

class _WrapperState extends State<Wrapper> {
  WrapperBloc _bloc;

  @override
  Widget build(BuildContext context) {
    _bloc = WrapperBlocProvider.of(context);
    return StreamBuilder<PrevengoUser>(
        stream: _bloc.user,
        builder: (context, snapshot) {
          new FirestoreRead('');
          if (snapshot.hasData) {
            if (snapshot.data.firstAccess) {
              return OnboardingPageView();
            } else {
              // return OnboardingPageView();
              return HomeBlocProvider(child: Home());
              // return DoctorListBlocProvider(child: DoctorsProposedScreen());
            }
          } else {
            //return Center(child: CircularProgressIndicator());
            // return DoctorListBlocProvider(child: DoctorsProposedScreen());
            return OnboardingPageView();
            // return Authenticate();
          }
        });
  }
}
