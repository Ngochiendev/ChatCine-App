import 'package:get/get.dart';
import 'controller.dart';

class WellcomeBindings extends Bindings {
  @override
  void dependencies() {
    // TODO: implement dependencies
    Get.lazyPut<WellcomeController>(() => WellcomeController());
  }
}
