import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:igea_app/models/doctor.dart';
import 'package:igea_app/services/firestore_read.dart';
import 'package:rxdart/rxdart.dart';

class DoctorListBlocProvider extends InheritedWidget {
  final DoctorListBloc bloc;

  DoctorListBlocProvider({Key key, Widget child})
      : bloc = DoctorListBloc(),
        super(key: key, child: child);

  @override
  bool updateShouldNotify(InheritedWidget oldWidget) {
    return true;
  }

  static DoctorListBloc of(BuildContext context) {
    return context
        .dependOnInheritedWidgetOfExactType<DoctorListBlocProvider>()
        .bloc;
  }
}

class DoctorListBloc {
  final _firestoreRead = FirestoreRead.instance();

  // stream controllers
  final _doctorListSubject = BehaviorSubject<Map<String, Doctor>>();

  // send data to UI
  Stream<Map<String, Doctor>> get getDoctorList => _doctorListSubject.stream;

  DoctorListBloc() {
    _firestoreRead.doctorsByDistanceListener().listen((snapshot) {
      Map<String, Doctor> doctorList = Map.fromIterable(
        snapshot.docs.where((element) => element.data() != null),
        key: (element) => (element as DocumentSnapshot).id,
        value: (element) =>
            Doctor.fromJson((element as DocumentSnapshot).data()),
      );
      print(doctorList.values.elementAt(0).toJson());
      _doctorListSubject.sink.add(doctorList);
    });
  }

  dispose() {
    _doctorListSubject.close();
  }
}
