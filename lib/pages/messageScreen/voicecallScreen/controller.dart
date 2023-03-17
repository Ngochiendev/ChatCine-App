import 'dart:convert';
import 'package:agora_rtc_engine/agora_rtc_engine.dart';
import 'package:chatcine/common/apis/apis.dart';
import 'package:chatcine/common/entities/entities.dart';
import 'package:chatcine/common/store/user.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:crypto/crypto.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:just_audio/just_audio.dart';
import 'package:permission_handler/permission_handler.dart';
import 'dart:developer' as developer;
import 'index.dart';
import 'package:chatcine/common/values/server.dart';

class VoiceCallController extends GetxController {
  VoiceCallController();
  final state = VoiceCallState();
  final player = AudioPlayer();
  String appID = APPID;
  final db = FirebaseFirestore.instance;
  final profile_token = UserStore.to.profile.token;
  late final RtcEngine _engine;

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    var data = Get.parameters;
    state.to_name.value = data['to_name'] ?? "";
    state.to_avatar.value = data['to_avatar'] ?? "";
    state.call_role.value = data['call_role'] ?? "";
    state.doc_id.value = data['doc_id'] ?? "";
    state.to_token.value = data['to_token'] ?? "";
    initEngine();
  }

  @override
  void onClose() {
    // TODO: implement onClose
    _dispose();
    super.onClose();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    _dispose();
    super.dispose();
  }

  Future<void> initEngine() async {
    await player.setAsset('assets/Sound_Horizon.mp3');
    _engine = createAgoraRtcEngine();
    await _engine.initialize(RtcEngineContext(appId: appID));
    _engine.registerEventHandler(
      RtcEngineEventHandler(
        onError: (ErrorCodeType error, String msg) {
          print('[ERROR] : $error, $msg');
        },
        onJoinChannelSuccess: (RtcConnection connection, int elapsed) {
          print('onconnection => ${connection.toJson()}');
          state.isJonined.value = true;
        },
        onUserJoined: (RtcConnection connection, remoteUid, elapsed) async {
          await player.pause();
        },
        onLeaveChannel: (RtcConnection connection, RtcStats stats) {
          print('my stats => ${stats.toJson()}');
          state.isJonined.value = false;
        },
        onRtcStats: (RtcConnection connection, RtcStats stats) {
          // state.callDuration.value =
          //     state.isJonined.value ? stats.duration ?? 0 : 0;
          // print(state.callDuration.value);
          state.callDuration.value =
              state.isJonined.value ? (stats.duration ?? 0) : 0;
          print(state.callDuration.value);
        },
      ),
    );
    await _engine.enableAudio();
    await _engine.setClientRole(role: ClientRoleType.clientRoleBroadcaster);
    await _engine.setAudioProfile(
      profile: AudioProfileType.audioProfileDefault,
      scenario: AudioScenarioType.audioScenarioMeeting,
    );
    await joinChannel();
    if (state.call_role.value == 'anchor') {
      //send notifi to the other user
      await sendNotification('voice');
      await player.play();
    }
  }

  Future<void> sendNotification(String call_type) async {
    CallRequestEntity callRequestEntity = CallRequestEntity();
    callRequestEntity.call_type = call_type;
    callRequestEntity.to_token = state.to_token.value;
    callRequestEntity.to_avatar = state.to_avatar.value;
    callRequestEntity.doc_id = state.doc_id.value;
    callRequestEntity.to_name = state.to_name.value;
    print("==========> the other user token is ${state.to_token.value}");
    var res = await ChatAPI.call_notifications(params: callRequestEntity);
    if (res.code == 0) {
      print('send notification success');
    } else {
      print('send notification fail');
    }
  }

  Future<String> getToken() async {
    if (state.call_role == "anchor") {
      state.channelId.value = md5
          .convert(utf8.encode("${profile_token}_${state.to_token}"))
          .toString();
    } else {
      state.channelId.value = md5
          .convert(utf8.encode("${state.to_token}_${profile_token}"))
          .toString();
    }
    CallTokenRequestEntity callTokenRequestEntity = CallTokenRequestEntity();
    callTokenRequestEntity.channel_name = state.channelId.value;
    var res = await ChatAPI.call_token(params: callTokenRequestEntity);
    print('============> channel id is ${state.channelId.value}');
    print('============> access token authorizontal ${UserStore.to.token}');
    if (res.code == 0) {
      return res.data!;
    }
    return "";
  }

  Future<void> joinChannel() async {
    await Permission.microphone.request();
    EasyLoading.show(
      indicator: const CircularProgressIndicator(),
      maskType: EasyLoadingMaskType.clear,
      dismissOnTap: true,
    );
    String token = await getToken();
    if (token.isEmpty) {
      EasyLoading.dismiss();
      Get.back();
      return;
    }
    await _engine.joinChannel(
      // token:
      //     "007eJxTYNj3hu2CGavE1J8vJeyfLjb6LKm05t1hx/kNucLBmjf/H2xVYDBMTE1JNDM0NzQ1TTRJNDZMTDM1TzJJSjU1T7Y0tUwzmyksnNIQyMggePAJMyMDBIL43AzOGYklzpl5qY4FBQwMAGbcIkE=",
      // channelId: "ChatCineApp",
      token: token,
      channelId: state.channelId.value,
      uid: 0,
      options: const ChannelMediaOptions(
        channelProfile: ChannelProfileType.channelProfileLiveBroadcasting,
        clientRoleType: ClientRoleType.clientRoleBroadcaster,
      ),
    );
    EasyLoading.dismiss();
  }

  Future<void> leaveChannel() async {
    // await _engine.leaveChannel();
    EasyLoading.show(
      indicator: const CircularProgressIndicator(),
      maskType: EasyLoadingMaskType.clear,
      dismissOnTap: true,
    );
    await player.pause();
    state.isJonined.value = false;
    state.callDuration.value = 0;
    EasyLoading.dismiss();
    Get.back();
  }

  Future<void> _dispose() async {
    await _engine.leaveChannel();
    await player.pause();
    await _engine.release();
    await player.stop();
  }
}
