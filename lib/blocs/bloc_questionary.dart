import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:igea_app/models/breast.dart';
import 'package:igea_app/models/constants/constants.dart';
import 'package:igea_app/models/familiarity_tumor.dart';
import 'package:igea_app/models/organ.dart';
import 'package:igea_app/resources/prevention_repository.dart';
import 'package:rxdart/rxdart.dart';

class QuestionaryBlocProvider extends InheritedWidget {
  final QuestionaryBloc bloc = QuestionaryBloc();

    QuestionaryBlocProvider({Key key, Widget child})
      : super(key: key, child: child);

  @override
  bool updateShouldNotify(_) => true;

  static QuestionaryBloc of(BuildContext context) {
    return context
        .dependOnInheritedWidgetOfExactType<QuestionaryBlocProvider>()
        .bloc;
  }
}

class QuestionaryBloc {

  PreventionRepository _repository = PreventionRepository.instance();

  final _familiarityTumorController = PublishSubject<List<FamiliarityTumor>>();
  final _insertParentWithTumorController = PublishSubject<Map<dynamic,dynamic>>();

  //add data to stream
  Stream<List<FamiliarityTumor>> get parentWithTumorList => _familiarityTumorController.stream;

  //change data
  Function(Map<dynamic,dynamic>) get addNewParentWithTumor => _insertParentWithTumorController.sink.add;
  
  
  Organ breast;
  Organ colon;
  Organ uterus;
  
  List<FamiliarityTumor> familiarityTumorList = List();

  QuestionaryBloc(){
    _insertParentWithTumorController.listen((input) {
      familiarityTumorList.add(FamiliarityTumor.fromJson(input));
      _familiarityTumorController.sink.add(familiarityTumorList);
    });


  }


  // final addItemListTransformer = StreamTransformer<List<FamiliarityTumor>,Map<dynamic,dynamic>>.fromHandlers(
  //   handleData: (input,sink){
  //   }
  // );

  void dispose(){
    _familiarityTumorController.close();
  }


}
