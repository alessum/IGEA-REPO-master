import 'package:flutter/cupertino.dart';
import 'package:igea_app/models/breast.dart';
import 'package:igea_app/models/colon.dart';
import 'package:igea_app/models/constants/constants.dart';
import 'package:igea_app/models/enums/breast_familiarity_type.dart';
import 'package:igea_app/models/enums/colon_familiarity_type.dart';
import 'package:igea_app/models/enums/status_type.dart';
import 'package:igea_app/models/heart.dart';
import 'package:igea_app/models/organ.dart';
import 'package:igea_app/models/test.dart';
import 'package:igea_app/models/uterus.dart';
import 'package:igea_app/screens/situation/modalBottomSheets/prevengo_situation_modal_alert.dart';
import 'package:igea_app/screens/situation/modalBottomSheets/prevengo_situation_modal_deeping_info.dart';
import 'package:igea_app/screens/situation/modalBottomSheets/prevengo_situation_modal_inactive_info.dart';
import 'package:igea_app/screens/situation/modalBottomSheets/prevengo_situation_modal_outofage_info.dart';
import 'package:igea_app/services/firestore_read.dart';
import 'package:igea_app/services/firestore_write.dart';
import 'package:rxdart/subjects.dart';

export 'situation_bloc.dart';

abstract class BaseBloc {
  void dispose();
}

class SituationBlocProvider extends InheritedWidget {
  final SituationBloc bloc;

  SituationBlocProvider({Key key, Widget child, @required String organKey})
      : bloc = SituationBloc(organKey),
        super(key: key, child: child);

  @override
  bool updateShouldNotify(InheritedWidget oldWidget) {
    return true;
  }

  static SituationBloc of(BuildContext context) {
    return context
        .dependOnInheritedWidgetOfExactType<SituationBlocProvider>()
        .bloc;
  }
}

class SituationBloc {
  final _firestoreRead = FirestoreRead.instance();
  final _firestoreWrite = FirestoreWrite.instance();

  final String _organKey;
  Organ _organ;

  //Stream controllers
  final _organListenerSubject = BehaviorSubject<Organ>();
  final _sendTestSubject = PublishSubject<Map<dynamic, dynamic>>();
  final _organAlertSubject = BehaviorSubject<Widget>();

  //Send data to UI
  Stream<Organ> get getOrgan => _organListenerSubject.stream;
  Stream<Widget> get getOrganAlert => _organAlertSubject.stream;

  //Get data from UI
  Sink<Map<Object, Object>> get createTest => _sendTestSubject.sink;

  SituationBloc(this._organKey) {
    _firestoreRead.organListener(_organKey).listen((snapshot) {
      switch (snapshot.id) {
        case '001':
          _organ = Breast.fromJson(snapshot.data());
          break;
        case '002':
          _organ = Colon.fromJson(snapshot.data());
          break;
        case '003':
          _organ = Uterus.fromJson(snapshot.data());
          break;
        case '004':
          _organ = Heart.fromJson(snapshot.data());
          break;
      }
      _organListenerSubject.sink.add(_organ);
    });

    _sendTestSubject.stream.listen((input) {
      Map<dynamic, dynamic> jsonTest;
      jsonTest = Test(
        input[Constants.TEST_NAME_KEY],
        input[Constants.TEST_ORGAN_KEY_KEY],
        input[Constants.TEST_TYPE_KEY],
        input[Constants.TEST_DESCRIPTION_KEY],
      ).toJson();
      print(jsonTest.toString());
      _firestoreWrite.createTest(jsonTest);
    });
  }

  bool inAlert() {
    return _organ.status.statusType == StatusType.DEEPENING ||
        _organ.status.statusType == StatusType.INACTIVE ||
        _organ.status.statusType == StatusType.OUT_OF_AGE ||
        (() {
          if (_organ is Breast) {
            return (_organ as Breast).familiarityRisk.type !=
                BreastFamiliarityType.NULL;
          } else if (_organ is Colon) {
            return (_organ as Colon).familiarityRisk.type !=
                ColonFamiliarityType.NULL;
          } else if (_organ is Uterus) {
            return (_organ as Uterus).hpvVaccine == false;
          }
        }());
  }

  void checkOrganAlert() {
    if (_organ.status.statusType == StatusType.DEEPENING) {
      _organAlertSubject.sink.add(PrevengoSituationModalAlert(
        title: 'Approfondimento',
        message: Constants.PREVENGO_MESSAGE_DEEPENING,
      ));
    } else if (_organ.status.statusType == StatusType.OUT_OF_AGE) {
      _organAlertSubject.sink.add(PrevengoSituationModalAlert(
        title: 'Programma di screening terminato',
        message: Constants.PREVENGO_MESSAGE_OUTOFAGE,
      ));
    } else if (_organ.status.statusType == StatusType.INACTIVE) {
      _organAlertSubject.sink.add(PrevengoSituationModalInactiveInfo(
        organKey: _organKey,
      ));
    } else if (_organ is Breast) {
      if ((_organ as Breast).familiarityRisk.type ==
          BreastFamiliarityType.HIGH) {
        _organAlertSubject.sink.add(PrevengoSituationModalAlert(
          title: 'Rischio familiarità alto',
          message: Constants.PREVENGO_MESSAGE_BREAST_FAM_RISK_HIGH,
        ));
      } else if ((_organ as Breast).familiarityRisk.type ==
          BreastFamiliarityType.MODERATE) {
        _organAlertSubject.sink.add(PrevengoSituationModalAlert(
          title: 'Rischio familiarità moderato',
          message: Constants.PREVENGO_MESSAGE_BREAST_FAM_RISK_MODERATE,
        ));
      }
      if ((_organ as Breast).familiarityRisk.type ==
          BreastFamiliarityType.LOW) {
        _organAlertSubject.sink.add(PrevengoSituationModalAlert(
          title: 'Rischio familiarità basso',
          message: Constants.PREVENGO_MESSAGE_BREAST_FAM_RISK_LOW,
        ));
      }
    } else if (_organ is Colon) {
      if ((_organ as Colon).familiarityRisk.type ==
          ColonFamiliarityType.HIGH_OVER_40) {
        _organAlertSubject.sink.add(PrevengoSituationModalAlert(
          title: 'Rischio familiarità alto',
          message: Constants.PREVENGO_MESSAGE_COLON_FAM_RISK_HIGHOVER40,
        ));
      } else if ((_organ as Colon).familiarityRisk.type ==
          ColonFamiliarityType.HIGH_UNDER_40) {
        _organAlertSubject.sink.add(PrevengoSituationModalAlert(
          title: 'Rischio familiarità alto',
          message: Constants.PREVENGO_MESSAGE_COLON_FAM_RISK_HIGHUNDER40,
        ));
      } else if ((_organ as Colon).familiarityRisk.type ==
          ColonFamiliarityType.MEDIUM) {
        _organAlertSubject.sink.add(PrevengoSituationModalAlert(
          title: 'Rischio familiarità medio',
          message: Constants.PREVENGO_MESSAGE_COLON_FAM_RISK_MEDIUM,
        ));
      } else if ((_organ as Colon).familiarityRisk.type ==
          ColonFamiliarityType.SYNDROM) {
        _organAlertSubject.sink.add(PrevengoSituationModalAlert(
          title: 'Rischio familiarità',
          message: Constants.PREVENGO_MESSAGE_COLON_FAM_RISK_SYNDROM,
        ));
      }
    } else if (_organ is Uterus) {
      if (!(_organ as Uterus).hpvVaccine) {
        _organAlertSubject.sink.add(PrevengoSituationModalAlert(
          title: 'Vaccino anti HPV non effettuato',
          message: Constants.PREVENGO_MESSAGE_UTERUS_NO_VACCINATION,
        ));
      }
    }
  }

  void dispose() async {
    _organListenerSubject.close();
    _sendTestSubject.close();
    _organAlertSubject.close();
  }
}
