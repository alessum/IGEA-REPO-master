//import 'package:device_preview/device_preview.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart'; 
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:igea_app/blocs/bloc_wrapper.dart';
import 'package:igea_app/screens/wrapper.dart';
import 'package:igea_app/services/auth.dart';
import 'package:provider/provider.dart';
import 'models/user.dart';
import 'package:firebase_auth/firebase_auth.dart';

/// Define a top-level named handler which background/terminated messages will
/// call.
Future<void> _firebaseMessagingBackgroudHandler(RemoteMessage message) async { 
  await Firebase.initializeApp();
  print('Handling a background message: ${message.messageId}');
  print('background message data: ${message.data}');
  print('background message data: ${message.notification.title}');
  print('background message text: ${message.notification.body}');
}

final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
    FlutterLocalNotificationsPlugin();

void main() async {
  SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      statusBarBrightness: Brightness.light));

  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroudHandler); 

  // runApp(DevicePreview(
  //   builder: (context) => MyApp(),
  //   enabled: !kReleaseMode,
  // ));
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    super.initState();

    FirebaseMessaging.onMessage.listen((RemoteMessage message) { 
      print('Got a message whilst in the foreground!');
      print('Message data: ${message.data}');

      if (message.notification != null) {
        print('Message also contained a notification: ${message.notification}');
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      // locale: DevicePreview.of(context).locale, // <--- Add the locale
      // builder: DevicePreview.appBuilder,
      home: WrapperBlocProvider(child: Wrapper()),
    );
  }
}
