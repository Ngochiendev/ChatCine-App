import 'dart:convert';

import 'package:chatcine/common/apis/apis.dart';
import 'package:chatcine/common/entities/user.dart';
import 'package:chatcine/common/routes/routes.dart';
import 'package:chatcine/common/store/store.dart';
import 'package:chatcine/common/widgets/widgets.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'dart:developer' as developer;
import 'index.dart';

class SignInController extends GetxController {
  SignInController();
  final state = SignInState();
  final GoogleSignIn _googleSignIn = GoogleSignIn(scopes: ['openid']);

  Future<void> handleSignIn(String type) async {
    // 1: email, 2. Google, 3.Facebook, 4.Apple, 5.Phone

    try {
      if (type == "phone number") {
        if (kDebugMode) {
          developer.log(
              '================> are you login with phone number <================');
        }
      } else if (type == "google") {
        var user = await _googleSignIn.signIn();
        if (user != null) {
          final _googleAuthecation = await user.authentication;
          final _credential = GoogleAuthProvider.credential(
            idToken: _googleAuthecation.idToken,
            accessToken: _googleAuthecation.accessToken,
          );

          await FirebaseAuth.instance.signInWithCredential(_credential);

          String? displayname = user.displayName;
          String email = user.email;
          String id = user.id;
          String photoUrl = user.photoUrl ?? "assets/icons/google.png";
          LoginRequestEntity loginPanelListRequestEntity = LoginRequestEntity();
          loginPanelListRequestEntity.avatar = photoUrl;
          loginPanelListRequestEntity.name = displayname;
          loginPanelListRequestEntity.email = email;
          loginPanelListRequestEntity.open_id = id;
          loginPanelListRequestEntity.type = 2;
          print(jsonEncode(loginPanelListRequestEntity));
          asyncPostAllData(loginPanelListRequestEntity);
        }
      } else {
        if (kDebugMode) {
          print('================> login type not sure <================');
        }
      }
    } catch (e) {
      if (kDebugMode) {
        developer
            .log('================> error with login $e <================');
      }
    }
  }

  Future<void> asyncPostAllData(LoginRequestEntity loginRequestEntity) async {
    /*
      1. Save data in the database
      2. Save data in local
    */
    EasyLoading.show(
      indicator: const CircularProgressIndicator(),
      maskType: EasyLoadingMaskType.clear,
      dismissOnTap: true,
    );

    try {
      var result = await UserAPI.Login(params: loginRequestEntity);
      if (result != null) {
        if (result.code == 0) {
          await UserStore.to.saveProfile(result.data!);
          UserStore.to.printTokenValue();
          EasyLoading.dismiss();
          await Get.offAllNamed(AppRoutes.Message);
        } else {
          EasyLoading.dismiss();
          toastInfo(msg: "Invalid result value");
        }
      } else {
        EasyLoading.dismiss();
        toastInfo(msg: "Result is null");
      }
    } catch (error) {
      EasyLoading.dismiss();
      toastInfo(msg: "Internet error");
    }
  }
}
