import 'package:chatcine/common/routes/routes.dart';
import 'package:chatcine/common/store/user.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'dart:developer' as developer;
import 'index.dart';

class ProfileController extends GetxController {
  ProfileController();
  final state = ProfileState();

  void goLogOut() async {
    await GoogleSignIn().signOut();
    await UserStore.to.onLogout();
  }
}
