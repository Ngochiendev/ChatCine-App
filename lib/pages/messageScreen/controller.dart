import 'package:chatcine/common/routes/routes.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'dart:developer' as developer;
import 'index.dart';

class MessageController extends GetxController {
  MessageController();
  final state = MessageState();
  void goProfile() async {
    await Get.toNamed(AppRoutes.Profile);
  }
}
