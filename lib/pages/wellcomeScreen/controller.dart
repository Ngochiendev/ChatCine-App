import 'package:chatcine/common/routes/routes.dart';
import 'package:get/get.dart';
import 'dart:developer' as developer;
import 'index.dart';

class WellcomeController extends GetxController {
  WellcomeController();
  final tilte = "ChatCine";
  final state = WellcomeState();

  @override
  void onReady() {
    // TODO: implement onReady
    super.onReady();
    Future.delayed(
        const Duration(seconds: 3), () => Get.offAllNamed(AppRoutes.SIGN_IN));
  }
}
