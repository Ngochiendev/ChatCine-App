import 'package:chatcine/common/middlewares/middlewares.dart';
import 'package:chatcine/common/routes/routes.dart';
import 'package:chatcine/common/style/style.dart';
import 'package:chatcine/common/utils/FirebaseMassagingHandler.dart';
import 'package:chatcine/global.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:get/get.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

void main() async {
  await Global.init();
  runApp(const MyApp());
  firebasechatInit().whenComplete(() {
    FirebaseMessagingHandler.config();
  });
}

Future firebasechatInit() async {
  FirebaseMessaging.onBackgroundMessage(
    FirebaseMessagingHandler.firebaseMessagingBackground,
  );
  if (GetPlatform.isAndroid) {
    FirebaseMessagingHandler.flutterLocalNotificationsPlugin
        .resolvePlatformSpecificImplementation<
            AndroidFlutterLocalNotificationsPlugin>()!
        .createNotificationChannel(
          FirebaseMessagingHandler.channel_call,
        );
    FirebaseMessagingHandler.flutterLocalNotificationsPlugin
        .resolvePlatformSpecificImplementation<
            AndroidFlutterLocalNotificationsPlugin>()!
        .createNotificationChannel(
          FirebaseMessagingHandler.channel_message,
        );
  }
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(360, 780),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (context, child) {
        return GetMaterialApp(
          defaultTransition: Transition.native,
          title: 'Flutter Demo',
          debugShowCheckedModeBanner: false,
          theme: AppTheme.light,
          initialRoute: AppPages.INITIAL,
          getPages: AppPages.routes,
          builder: EasyLoading.init(),
        );
      },
    );
  }
}
