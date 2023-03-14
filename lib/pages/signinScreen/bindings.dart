import 'package:get/get.dart';

import 'controller.dart';

class SignInBindings extends Bindings {
  @override
  void dependencies() {
    // TODO: implement dependencies
    Get.lazyPut<SignInController>(() => SignInController());
  }
}
