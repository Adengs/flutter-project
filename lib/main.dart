import 'package:ektp/splash_screen.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/services.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:shared_preferences/shared_preferences.dart';

Future<void> main() async {
  SystemChrome.setSystemUIOverlayStyle(
      SystemUiOverlayStyle(statusBarColor: Colors.transparent));

  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  await requestPermission();

  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);

  runApp(MyApp());
}

Future<void> requestPermission() async {
  FirebaseMessaging messaging = FirebaseMessaging.instance;

  NotificationSettings settings = await messaging.requestPermission(
    alert: true,
    announcement: false,
    badge: true,
    carPlay: false,
    criticalAlert: false,
    provisional: false,
    sound: true,
  );

  if (settings.authorizationStatus == AuthorizationStatus.authorized) {
    print('User granted permission');
  } else if (settings.authorizationStatus == AuthorizationStatus.provisional) {
    print('User granted provisional permission');
  } else {
    print('User declined or has not accepted permission');
  }
}

Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  print("BACKGROUND NOTIFICATION HANDLING");
  print(message.notification);
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  bool isUser = false;

  @override
  void initState() {
    super.initState();
    initCheck();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: SplashScreen(isUser),
      localizationsDelegates: [GlobalMaterialLocalizations.delegate],
      supportedLocales: [const Locale('en'), const Locale('id')],
    );
  }

  void initCheck() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    if (prefs.getBool('isUser') != null) {
      setState(() {
        isUser = prefs.getBool('isUser')!;
      });
    }
  }
}
