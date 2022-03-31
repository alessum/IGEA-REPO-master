import 'package:flutter/material.dart';

class OnboardingPsychoBlocProvider extends InheritedWidget {
  final OnboardingPsychoBloc bloc;

  OnboardingPsychoBlocProvider({Key key, Widget child})
      : bloc = OnboardingPsychoBloc(),
        super(key: key, child: child);

  @override
  bool updateShouldNotify(InheritedWidget oldWidget) {
    return true;
  }

  static OnboardingPsychoBloc of(BuildContext context) {
    return context
        .dependOnInheritedWidgetOfExactType<OnboardingPsychoBlocProvider>()
        .bloc;
  }
}

class OnboardingPsychoBloc {}
