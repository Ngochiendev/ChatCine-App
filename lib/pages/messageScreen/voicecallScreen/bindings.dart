import 'package:get/get.dart';
import 'index.dart';

class VoiceCallBindings extends Bindings {
  @override
  void dependencies() {
    // TODO: implement dependencies
    Get.lazyPut<VoiceCallController>(() => VoiceCallController());
  }
}
