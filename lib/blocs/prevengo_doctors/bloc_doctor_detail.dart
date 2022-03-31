import 'package:flutter/material.dart';
import 'package:igea_app/models/doctor.dart';
import 'package:igea_app/models/review.dart';
import 'package:igea_app/services/firestore_read.dart';
import 'package:rxdart/rxdart.dart';

class DoctorDetailBlocProvider extends InheritedWidget {
  final DoctorDetailBloc bloc;

  DoctorDetailBlocProvider({
    Key key,
    @required Widget child,
    @required String doctorKey,
  })  : bloc = DoctorDetailBloc(doctorKey),
        super(key: key, child: child);

  @override
  bool updateShouldNotify(InheritedWidget oldWidget) {
    return true;
  }

  static DoctorDetailBloc of(BuildContext context) {
    return context
        .dependOnInheritedWidgetOfExactType<DoctorDetailBlocProvider>()
        .bloc;
  }
}

class DoctorDetailBloc {
  final String _doctorKey;
  final _firestorRead = FirestoreRead.instance();

  //Stream Controllers
  final _doctorSubject = BehaviorSubject<Doctor>();
  final _reviewSubject = BehaviorSubject<List<Review>>();

  //send data to UI
  Stream<Doctor> get getDoctorDetails => _doctorSubject.stream;
  Stream<List<Review>> get getReviews => _reviewSubject.stream;

  DoctorDetailBloc(this._doctorKey) {
    _firestorRead.doctorListener(_doctorKey).listen((snapshot) {
      _doctorSubject.sink.add(Doctor.fromJson(snapshot.data()));
    });

    _firestorRead.doctorReviewsListener(_doctorKey).listen((snapshot) {
      List<Review> reviewList = [];
      snapshot.docs.forEach((element) {
        reviewList.add(Review.fromJson(element.data()));
      });
      _reviewSubject.sink.add(reviewList);
    });
  }

  dispose() {
    _doctorSubject.close();
    _reviewSubject.close();
  }
}
