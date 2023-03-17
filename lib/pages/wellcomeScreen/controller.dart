import 'package:chatcine/common/middlewares/middlewares.dart';
import 'package:chatcine/common/routes/routes.dart';
import 'package:chatcine/common/store/store.dart';
import 'package:get/get.dart';
import 'dart:developer' as developer;
import 'index.dart';

class WellcomeController extends GetxController {
  WellcomeController();
  final tilte = "ChatCine";
  final state = WellcomeState();

  @override
  void onReady() async {
    super.onReady();

    // // Đăng ký RouteAuthMiddleware làm middleware của GetRouter
    // Get.put<RouteWelcomeMiddleware>(RouteWelcomeMiddleware(priority: 0));

    // Nếu người dùng đã đăng nhập hoặc đang trong quá trình đăng nhập, chuyển hướng đến trang tiếp theo
    // Ngược lại, chuyển hướng đến trang đăng nhập
    await Future.delayed(const Duration(seconds: 1));
    if (UserStore.to.isLogin || UserStore.to.hasToken) {
      await Get.offAllNamed(AppRoutes.Message);
    } else {
      Future.delayed(const Duration(seconds: 2),
          () => Get.snackbar("Tips", "Login expired, please login againnnnn!"));
      Get.offAllNamed(AppRoutes.SIGN_IN); 
    }
  }
}
