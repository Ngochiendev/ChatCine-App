import 'package:chatcine/common/apis/apis.dart';
import 'package:chatcine/common/entities/base.dart';
import 'package:chatcine/common/routes/routes.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:get/get.dart';
import 'dart:developer' as developer;
import 'index.dart';

class MessageController extends GetxController {
  MessageController();
  final state = MessageState();
  void goProfile() async {
    await Get.toNamed(AppRoutes.Profile);
  }

  @override
  void onReady() {
    // TODO: implement onReady
    super.onReady();
    firebaseMessageSetup();
  }

  firebaseMessageSetup() async {
    String? fcmToken = await FirebaseMessaging.instance.getToken();
    print('=========> my device fcm token is $fcmToken');
    if (fcmToken != null) {
      BindFcmTokenRequestEntity bindFcmTokenRequestEntity =
          BindFcmTokenRequestEntity();
      bindFcmTokenRequestEntity.fcmtoken = fcmToken;
      await ChatAPI.bind_fcmtoken(params: bindFcmTokenRequestEntity);
    }
  }
}
