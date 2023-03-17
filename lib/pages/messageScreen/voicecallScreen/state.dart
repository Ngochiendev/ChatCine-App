import 'package:get/get.dart';

class VoiceCallState {
  RxBool isJonined = false.obs;
  RxBool openMic = true.obs;
  RxBool openSpeaker = true.obs;
  RxString callTime = "00:00".obs;
  RxString callStatus = "not connected".obs;
  RxInt callDuration = 0.obs;

  var to_token = "".obs;
  var to_name = "".obs;
  var to_avatar = "".obs;
  var doc_id = "".obs;

  //riceiver audience
  //anchor is caller
  var call_role = "audience".obs;
  var channelId = "".obs;
}
