import 'dart:io';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:nebulashoppy/screen/account.dart';
import 'package:nebulashoppy/screen/categorylist.dart';
import 'package:nebulashoppy/screen/home.dart';
import 'package:nebulashoppy/screen/mycartlist.dart';
import 'package:nebulashoppy/screen/myorder/myorderlist.dart';
import 'package:nebulashoppy/screen/search.dart';
import 'package:nebulashoppy/screen/splash.dart';
import 'package:nebulashoppy/screen/tabscreen.dart';
import 'package:nebulashoppy/screen/test.dart';
import 'package:nebulashoppy/uttils/constant.dart';
import 'package:nebulashoppy/widget/AppBarWidget.dart';
import 'package:nebulashoppy/widget/BottomNavBarWidget.dart';
import 'package:nebulashoppy/widget/BottomNavBarWidgetLogin.dart';
import 'package:nebulashoppy/widget/cartCounter.dart';
import 'network/service.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:nebulashoppy/uttils/sharedpref.dart';
import 'package:provider/provider.dart';

final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  RemoteNotification? notification = message.notification;
  AndroidNotification? android = message.notification?.android;
  print("Notification" + notification.toString());
  if (notification != null && android != null) {
    _generateNotification(message, notification);
  }
  print('Handling a background message 3${message.messageId}');
}

  void _registerForegroundMessageHandler() {
      FirebaseMessaging.onMessage.listen((remoteMessage) {
       RemoteNotification? notification = remoteMessage.notification;
       AndroidNotification? android = remoteMessage.notification?.android;
      print(" --- foreground message received ---" + notification!.body.toString());
      final _localNotifications = FlutterLocalNotificationsPlugin();
       showlocalNotification(_localNotifications,notification,android);
    });
  }

late AndroidNotificationChannel channel;
FlutterLocalNotificationsPlugin? flutterLocalNotificationsPlugin;

Future<void> _generateNotification(
    RemoteMessage message, RemoteNotification notification) async {
 
  if (notification.android!.smallIcon.toString().isNotEmpty &&
      notification.android!.smallIcon.toString() != "") {
    flutterLocalNotificationsPlugin?.show(
      notification.hashCode,
      notification.title,
      notification.body,
      NotificationDetails(
        android: AndroidNotificationDetails(channel.id, channel.name,
            icon: '@mipmap/ic_launcher',
            importance: Importance.max,
            priority: Priority.high,
            playSound: true,
            styleInformation: BigPictureStyleInformation(
              FilePathAndroidBitmap("bigPicturePath"),
              largeIcon: FilePathAndroidBitmap("bigPicturePath"),
              contentTitle: notification.title,
              htmlFormatContentTitle: true,
              summaryText: notification.body,
              hideExpandedLargeIcon: true,
              htmlFormatSummaryText: true,
            )),
      ),
    );
  } else {
    flutterLocalNotificationsPlugin?.show(
      notification.hashCode,
      notification.title,
      notification.body,
      NotificationDetails(
          android: AndroidNotificationDetails(
        channel.id,
        channel.name,
        icon: '@mipmap/ic_launcher',
        importance: Importance.max,
        priority: Priority.high,
        playSound: true,
      )),
    );
  }

  FirebaseMessaging.onMessage.listen((RemoteMessage event) {
    print("message recieved");
    print(event.notification!.body);
   _generateNotification(message, notification);
  });
  
 
 FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage event) {
    print("Notification Recevied");
    print(event.notification!.body);
     _generateNotification(message, notification);
  });

  // _onClickNotification(message.data);
}

void main() async {

  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  await FirebaseMessaging.instance
      .setForegroundNotificationPresentationOptions(
        alert: true,
        badge: true,
        sound: true,
      )
      .then((value) {});

  channel = const AndroidNotificationChannel(
    'nebulashoppy', // id
    'Nebula Shoppy', // title
    importance: Importance.high,
    enableLights: true,
    enableVibration: true,
    showBadge: true,
  );

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    WidgetsFlutterBinding.ensureInitialized();
    FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);
    checkUserLoginOrNot();
    getToken();
    init();

    return ChangeNotifierProvider(
      create: (context) => CartCounter(),
      child: MaterialApp(
        home: Splash(),
        theme: ThemeData(
            fontFamily: 'Roboto',
            primaryColor: Colors.white,
            primaryColorDark: Colors.white,
            backgroundColor: Colors.white),
        debugShowCheckedModeBanner: false,
      ),
    );
  }
}

 Future init() async {
   _registerForegroundMessageHandler();
  }

 Future<NotificationSettings> _requestPermission() async {
  final FirebaseMessaging _firebaseMessaging = FirebaseMessaging.instance;
    return await _firebaseMessaging.requestPermission(
        alert: true,
        badge: true,
        sound: true,
        carPlay: false,
        criticalAlert: false,
        provisional: false,
        announcement: false);
  }


int currentIndex = 1;

void navigateToScreens(int index) {
  currentIndex = index;
}

getToken() async {
  String? token = await FirebaseMessaging.instance.getToken();
  SharedPref.saveString(str_FCMToken, token);
  print("FCM_TOKEN -> $token");
}
