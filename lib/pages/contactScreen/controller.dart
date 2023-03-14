import 'package:chatcine/common/apis/apis.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'dart:developer' as developer;
import 'index.dart';

class ContactController extends GetxController {
  ContactController();
  final state = ContactState();

  @override
  void onReady() async {
    // TODO: implement onReady
    super.onReady();
    EasyLoading.show(
      indicator: CircularProgressIndicator(),
      maskType: EasyLoadingMaskType.clear,
      dismissOnTap: true,
    );
    state.contactList.clear();
    var result = await ContactAPI.post_contact();
    print(result.data!);
  }
}
