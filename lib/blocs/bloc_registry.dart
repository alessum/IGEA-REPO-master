import 'package:flutter/cupertino.dart';
import 'package:igea_app/models/constants/constants.dart';
import 'package:igea_app/models/organ.dart';
import 'package:igea_app/models/registry.dart';
import 'package:igea_app/resources/prevention_repository.dart';
import 'package:rxdart/subjects.dart';

export 'situation_bloc.dart';

abstract class BaseBloc {
  void dispose();
}

class RegistryBlocProvider extends InheritedWidget {
  final RegistryBloc bloc;

  RegistryBlocProvider({Key key, Widget child})
      : bloc = RegistryBloc(),
        super(key: key, child: child);

  @override
  bool updateShouldNotify(InheritedWidget oldWidget) {
    return true;
  }

  static RegistryBloc of(BuildContext context) {
    return context
        .dependOnInheritedWidgetOfExactType<RegistryBlocProvider>()
        .bloc;
  }
}

class RegistryBloc {
  PreventionRepository _repository = PreventionRepository.instance();
  final _organsfetcher = PublishSubject<Map<String, Organ>>();
  final _registryFetcher = PublishSubject<RegistryData>();
  final _updateRegistry = PublishSubject<Map<dynamic,dynamic>>();

  Stream<Map<Object, Organ>> get allOrgans => _organsfetcher.stream;
  Stream<RegistryData> get registry => _registryFetcher.stream;

  Sink<Map<dynamic,dynamic>> get inRegistry =>
      _updateRegistry.sink;


  RegistryBloc(){
    _updateRegistry.stream.listen((input){
      Map<dynamic,dynamic> _jsonRegistry;
      _jsonRegistry = RegistryData(
        input[Constants.REGISTRY_USERNAME_KEY],
        input[Constants.REGISTRY_NAME_KEY],
        input[Constants.REGISTRY_SURNAME_KEY],
        input[Constants.REGISTRY_DATE_OF_BIRTH_KEY],
        input[Constants.REGISTRY_DOMICILE_KEY],
        input[Constants.REGISTRY_FISCAL_CODE_KEY],
        input[Constants.REGISTRY_GENDER_KEY],
      ).toJson();
      _repository.updateRegistry(_jsonRegistry);
    });
  }

  
  // Future<void> fetchOrgans() async {
  //   await _repository.fetchAllOrgans().then((organList) {
  //     _organsfetcher.sink.add(organList);
  //   });
  // }


  // Future<void> fetchRegistry() async {
  //   await _repository.fetchRegistry().then((registry) {
  //     _registryFetcher.sink.add(registry);
  //   });
  // }

  void dispose() async {
    _organsfetcher.close();
    _registryFetcher.close();
    _updateRegistry.close();
  }
}
