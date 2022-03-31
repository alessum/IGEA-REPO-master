import 'package:flutter/material.dart';
import 'package:igea_app/models/breast.dart';
import 'package:igea_app/models/colon.dart';
import 'package:igea_app/models/constants/constants.dart';
import 'package:igea_app/models/organ.dart';
import 'package:igea_app/models/status.dart';
import 'package:igea_app/models/uterus.dart';
import 'package:igea_app/resources/prevention_repository.dart';
import 'package:rxdart/rxdart.dart';

class UserBlocProvider extends InheritedWidget {
  final UserBloc bloc;

  UserBlocProvider({Key key, Widget child})
      : bloc = UserBloc(),
        super(key: key, child: child);

  @override
  bool updateShouldNotify(InheritedWidget oldWidget) {
    return true;
  }

  static UserBloc of(BuildContext context) {
    return context.dependOnInheritedWidgetOfExactType<UserBlocProvider>().bloc;
  }
}

class UserBloc {
  PreventionRepository _repository = PreventionRepository.instance();
  final _sendOrganSubject = PublishSubject<Map<dynamic, dynamic>>();
  final _sendStatusSubject = PublishSubject<Map<dynamic, dynamic>>();

  Sink<Map<dynamic, dynamic>> get inNewOrgan => _sendOrganSubject.sink;
  Sink<Map<dynamic, dynamic>> get inNewSubject => _sendStatusSubject.sink;

  UserBloc() {
    _sendOrganSubject.stream.listen((input) {
      Map<dynamic, dynamic> jsonOrgan;
      Organ organ;
      switch (input[Constants.ORGAN_KEY]) {
        case '001':
          organ = Breast(
            input[Constants.ORGAN_NAME_KEY],
            null,
            input[Constants.ORGAN_DESCRIPTION_KEY],
          );
          // (organ as Breast).breastFamiliarity =
          //     input[Constants.ORGAN_FAMILIARITY_KEY];
          jsonOrgan = (organ as Breast).toJson();
          jsonOrgan.addAll({Constants.ORGAN_KEY: '001'});
          break;
        case '002':
          organ = Colon(
            input[Constants.ORGAN_NAME_KEY],
            null,
            input[Constants.ORGAN_DESCRIPTION_KEY],
          );
          (organ as Colon).colonFamiliarity =
              input[Constants.ORGAN_FAMILIARITY_KEY];
          jsonOrgan = (organ as Colon).toJson();
          jsonOrgan.addAll({Constants.ORGAN_KEY: '002'});
          break;
        case '003':
          organ = Uterus(
            input[Constants.ORGAN_NAME_KEY],
            null,
            input[Constants.ORGAN_DESCRIPTION_KEY],
          );
          (organ as Uterus).hpvVaccine = input[Constants.ORGAN_HPV_VACCINE_KEY];
          jsonOrgan = (organ as Uterus).toJson();
          jsonOrgan.addAll({Constants.ORGAN_KEY: '003'});
          break;
      }
      _repository.sendNewOrgan(jsonOrgan);
    });

    _sendStatusSubject.stream.listen((input) {
      Map<dynamic, dynamic> jsonStatus;
      jsonStatus = Status(
              input[Constants.STATUS_NAME_KEY],
              input[Constants.STATUS_COLOR_KEY],
              input[Constants.STATUS_ICON_KEY],
              input[Constants.STATUS_MESSAGE_KEY],
              input[Constants.STATUS_TYPE_KEY])
          .toJson();
      jsonStatus.addAll({Constants.ORGAN_KEY : input[Constants.ORGAN_KEY]});
      _repository.sendNewStatus(jsonStatus);
    });
  }

  dispose() {
    _sendOrganSubject.close();
    _sendStatusSubject.close();
  }
}
