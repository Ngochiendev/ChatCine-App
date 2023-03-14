import 'package:get/get.dart';
import 'index.dart';

class MessageBindings extends Bindings {
  @override
  void dependencies() {
    // TODO: implement dependencies
    Get.lazyPut<MessageController>(() => MessageController());
  }
}
