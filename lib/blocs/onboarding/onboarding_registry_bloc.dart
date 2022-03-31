import 'package:flutter/material.dart';

class OnboardingRegistryBlocProvider extends InheritedWidget {
  final OnboardingRegistryBloc bloc;

  OnboardingRegistryBlocProvider({Key key, Widget child})
      : bloc = OnboardingRegistryBloc(),
        super(key: key, child: child);

  @override
  bool updateShouldNotify(InheritedWidget oldWidget) {
    return true;
  }

  static OnboardingRegistryBloc of(BuildContext context) {
    return context
        .dependOnInheritedWidgetOfExactType<OnboardingRegistryBlocProvider>()
        .bloc;
  }
}

class OnboardingRegistryBloc {}
