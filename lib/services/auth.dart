// FILES FOR MANAGING AUTHENTICATIONS ROUTINES
import 'dart:io';

import 'package:firebase_messaging/firebase_messaging.dart'; 
import 'package:igea_app/models/breast.dart';
import 'package:igea_app/models/colon.dart';
import 'package:igea_app/models/constants/constants.dart';
import 'package:igea_app/models/enums/status_type.dart';
import 'package:igea_app/models/enums/test_type.dart';
import 'package:igea_app/models/heart.dart';
import 'package:igea_app/models/organ.dart';
import 'package:igea_app/models/reservable_test.dart';
import 'package:igea_app/models/status.dart';
import 'package:firebase_auth/firebase_auth.dart';
//import 'package:flutter_facebook_login/flutter_facebook_login.dart'; 
import 'package:google_sign_in/google_sign_in.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:igea_app/models/uterus.dart';

class FirebaseAuthService {
  final FirebaseMessaging _fcm = FirebaseMessaging.instance; 
  final FirebaseAuth _auth = FirebaseAuth.instance;
  //final FacebookLogin _facebookLogin = FacebookLogin();
  final GoogleSignIn _googleSignIn = GoogleSignIn();

  bool firstAccess = false;

  // auth change user stream
  Stream<User> get user {
    return _auth.authStateChanges().map((firebaseUser) {
      return firebaseUser;
    });
  }

  // sign in with email & password
  Future signInWithEmailAndPassword(String email, String password) async {
    firstAccess = false;
    try {
      UserCredential result = await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      User fireUser = result.user;

      String fcmToken = await _fcm.getToken(); 
      FirebaseFirestore _firestore = FirebaseFirestore.instance;
      var tokens = _firestore 
          .collection('userData')
          .doc(fireUser.uid)
          .collection('tokens')
          .doc(fcmToken);

      tokens.get().then((doc) async { 
        if (doc.exists) {
          //do nothing
        } else {
          //create
          await tokens.set({
            'token': fcmToken,
            'createdAt': FieldValue.serverTimestamp(), // optional
            'platform': Platform.operatingSystem // optional
          });
        }
      }).catchError((error) {
        print('[ERROR GET FCM TOKEN] ' + error);
      });

      return fireUser;
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

// register with email & password
  Future registerWithEmailAndPassword(String email, String password) async {
    firstAccess = true;
    try {
      UserCredential result = await _auth.createUserWithEmailAndPassword(
          email: email, password: password);
      User fireUser = result.user;

      String _collection = 'userData/${fireUser.uid}';
      FirebaseFirestore _firestore = FirebaseFirestore.instance;

      //start transaction to update
      var _userRef = _firestore.doc(_collection);
      _firestore.runTransaction((transaction) {
        return transaction.get(_userRef).then((_) {
          transaction.set(_userRef, {
            'first_access': true,
          });
        });
      });

      String fcmToken = await _fcm.getToken(); 
      if (fcmToken != null) { 
        var tokens = _firestore
            .collection('userData')
            .doc(fireUser.uid)
            .collection('tokens')
            .doc(fcmToken);

        await tokens.set({
          'token': fcmToken,
          'createdAt': FieldValue.serverTimestamp(), // optional
          'platform': Platform.operatingSystem // optional
        });
      }
      //Creazione organi
      Map<dynamic, Map<dynamic, dynamic>> jsonOrgans = setAllOrgans();
      // var batch = _firestore.batch();
      // jsonOrgans.forEach((k, v) {
      //   var _organRef = _firestore
      //       .collection('userData')
      //       .document('${fireUser.uid}')
      //       .collection('organ_list')
      //       .document('$k');
      //   batch.setData(_organRef, v.cast<String, dynamic>());
      // });
      // batch.commit().catchError((onError) {
      //   print('[FIRESTORE ERROR] ' + onError);
      // });

      return fireUser;
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

// sign out
  Future signOut() async {
    try {
      await _googleSignIn.signOut();
      //await _facebookLogin.logOut();
      await _auth.signOut();
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

// password reset
  Future sendPasswordResetEmail(String email) async {
    try {
      return await _auth.sendPasswordResetEmail(email: email);
    } catch (e) {
      print(e.toString());
      return 'Indirizzo email non valido';
    }
  }

  Map<dynamic, Map<dynamic, dynamic>> setAllOrgans() {
    Map<dynamic, Map<dynamic, dynamic>> jsonOrgans = Map();
    print('[SET ALL ORGANS]');
    //MAMMELLA
    Organ breast = Breast(
      'Mammella',
      Status(
        Constants.ORGAN_STATUS_INACTIVE_NAME,
        Constants.ORGAN_STATUS_INACTIVE_COLOR,
        Constants.ORGAN_STATUS_INACTIVE_ICON,
        Constants.ORGAN_STATUS_INACTIVE_MESSAGE,
        StatusType.INACTIVE,
      ),
      'Descrizione organo',
    );
    breast.active = false;
    breast.positive = false;
    breast.reservableTestList = [
      ReservableTest.fromJson(Constants.RESTEST_MAMMOGRAPHY),
    ];
    breast.imagePath = Constants.ORGAN_BREAST_IMAGE_PATH;
    jsonOrgans.addAll({'001': (breast as Breast).toJson()});

    //COLON
    Organ colon = Colon(
      'Colon',
      Status(
        Constants.ORGAN_STATUS_INACTIVE_NAME,
        Constants.ORGAN_STATUS_INACTIVE_COLOR,
        Constants.ORGAN_STATUS_INACTIVE_ICON,
        Constants.ORGAN_STATUS_INACTIVE_MESSAGE,
        StatusType.INACTIVE,
      ),
      'Descrizione organo',
    );
    colon.active = false;
    colon.positive = false;
    colon.reservableTestList = [
      ReservableTest.fromJson(Constants.RESTEST_SOF),
    ];
    colon.imagePath = Constants.ORGAN_COLON_IMAGE_PATH;
    jsonOrgans.addAll({'002': (colon as Colon).toJson()});

    //UTERUS
    Organ uterus = Uterus(
      'Cervice Uterina',
      Status(
        Constants.ORGAN_STATUS_INACTIVE_NAME,
        Constants.ORGAN_STATUS_INACTIVE_COLOR,
        Constants.ORGAN_STATUS_INACTIVE_ICON,
        Constants.ORGAN_STATUS_INACTIVE_MESSAGE,
        StatusType.INACTIVE,
      ),
      'Descrizione organo',
    );
    uterus.active = false;
    uterus.positive = false;
    uterus.reservableTestList = [
      ReservableTest.fromJson(Constants.RESTEST_HPV_DNA),
      ReservableTest.fromJson(Constants.RESTEST_PAP_TEST),
    ];

    print('[UTERO RESERVABLE TEST TYPE]' +
        uterus.reservableTestList[0].runtimeType.toString());
    print('[UTERO RESERVABLE TEST TYPE]' +
        uterus.reservableTestList[1].runtimeType.toString());
    uterus.imagePath = Constants.ORGAN_UTERUS_IMAGE_PATH;
    jsonOrgans.addAll({'003': (uterus as Uterus).toJson()});

    Organ heart = Heart(
        'Cuore',
        Status(
          Constants.ORGAN_STATUS_INACTIVE_NAME,
          Constants.ORGAN_STATUS_INACTIVE_COLOR,
          Constants.ORGAN_STATUS_INACTIVE_ICON,
          Constants.ORGAN_STATUS_INACTIVE_MESSAGE,
          StatusType.INACTIVE,
        ),
        'Descrizione organo',
        null,
        null,
        null,
        null,
        null,
        null,
        null,
        null,
        null,
        null);
    heart.reservableTestList = [
      ReservableTest.fromJson(Constants.RESTEST_CARDIO_TEST),
      ReservableTest.fromJson(Constants.RESTEST_BLOOD_TEST),
    ];
    heart.imagePath = Constants.ORGAN_HEART_IMAGE_PATH;
    jsonOrgans.addAll({'004': (heart as Heart).toJson()});
    return jsonOrgans;
  }
}

// sign in with Facebook
// Future signInWithFacebook () async {
// _facebookLogin.loginBehavior = FacebookLoginBehavior.nativeWithFallback;
// FacebookLoginResult facebookLoginResult = await _facebookLogin.logIn(['email', 'public_profile']);
// if (facebookLoginResult.status == FacebookLoginStatus.loggedIn) {
// FacebookAccessToken facebookAccessToken = facebookLoginResult.accessToken;
// AuthCredential authCredential = FacebookAuthProvider.getCredential(accessToken: facebookAccessToken.token);
// try {
// FirebaseUser user = (await _auth.signInWithCredential(authCredential)).user;

// return _userFromFirebaseUser(user);
// } catch(e) {
// print(e.toString());
// return null;
// }
// }
// }

// Future signInWithGoogle() async {
// GoogleSignInAccount googleSignInAccount = await _googleSignIn.signIn();
// GoogleSignInAuthentication googleSignInAuthentication = await googleSignInAccount.authentication;
// AuthCredential authCredential = GoogleAuthProvider.getCredential(accessToken: googleSignInAuthentication.accessToken, idToken: googleSignInAuthentication.idToken);
// try {
// FirebaseUser user = (await _auth.signInWithCredential(authCredential)).user;
// return _userFromFirebaseUser(user);
// } catch(e) {
// print(e.toString());
// return null;
// }
// }
