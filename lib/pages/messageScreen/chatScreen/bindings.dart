import 'package:chatcine/pages/messageScreen/chatScreen/index.dart';
import 'package:get/get.dart';

class ChatBindings extends Bindings {
  @override
  void dependencies() {
    // TODO: implement dependencies
    Get.lazyPut<ChatController>(() => ChatController());
  }
}
