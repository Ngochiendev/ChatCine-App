import 'package:chatcine/common/apis/apis.dart';
import 'package:chatcine/common/entities/contact.dart';
import 'package:chatcine/common/entities/entities.dart';
import 'package:chatcine/common/routes/routes.dart';
import 'package:chatcine/common/store/user.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'dart:developer' as developer;
import 'index.dart';

class ContactController extends GetxController {
  ContactController();
  final state = ContactState();
  final token = UserStore.to.profile.token;
  final db = FirebaseFirestore.instance;

  @override
  void onReady() {
    // TODO: implement onReady
    super.onReady();
    asyncLoadAllData();
  }

  //chat gpt fix bug
  Future<void> goChat(ContactItem contactItem) async {
    try {
      final fromMessagesQuery = db
          .collection('message')
          .where('from_token', isEqualTo: token)
          .where('to_token', isEqualTo: contactItem.token)
          .withConverter<Msg>(
            fromFirestore: (snapshot, options) =>
                Msg.fromFirestore(snapshot, options),
            toFirestore: (msg, options) => msg.toFirestore(),
          );
      final toMessagesQuery = db
          .collection('message')
          .where('from_token', isEqualTo: contactItem.token)
          .where('to_token', isEqualTo: token)
          .withConverter<Msg>(
            fromFirestore: (snapshot, options) =>
                Msg.fromFirestore(snapshot, options),
            toFirestore: (msg, options) => msg.toFirestore(),
          );
      final fromMessages = await fromMessagesQuery.get();
      final toMessages = await toMessagesQuery.get();
      print('from message => ${fromMessages.docs.isNotEmpty}'
          'to message => ${toMessages.docs.isNotEmpty}');
      if (fromMessages.docs.isEmpty && toMessages.docs.isEmpty) {
        final profile = UserStore.to.profile;
        final msgData = Msg(
          from_token: profile.token,
          to_token: contactItem.token,
          from_name: profile.name,
          to_name: contactItem.name,
          from_avatar: profile.avatar,
          to_avatar: contactItem.avatar,
          from_online: profile.online,
          to_online: contactItem.online,
          last_msg: '',
          last_time: Timestamp.now(),
          msg_num: 0,
        );
        final docRef = await db
            .collection('message')
            .withConverter<Msg>(
              fromFirestore: (snapshot, options) =>
                  Msg.fromFirestore(snapshot, options),
              toFirestore: (msg, options) => msg.toFirestore(),
            )
            .add(msgData);
        final docId = docRef.id;
        Get.toNamed(
          AppRoutes.Chat,
          parameters: {
            'doc_id': docId,
            'to_token': contactItem.token ?? '',
            'to_name': contactItem.name ?? '',
            'to_avatar': contactItem.avatar ?? '',
            'to_online': contactItem.online.toString(),
          },
        );
        print('Add user in the document done!');
      } else {
        if (fromMessages.docs.isNotEmpty) {
          final docId = fromMessages.docs.first.id;
          Get.toNamed(
            AppRoutes.Chat,
            parameters: {
              'doc_id': docId,
              'to_token': contactItem.token ?? '',
              'to_name': contactItem.name ?? '',
              'to_avatar': contactItem.avatar ?? '',
              'to_online': contactItem.online.toString(),
            },
          );
        } else if (toMessages.docs.isNotEmpty) {
          final docId = toMessages.docs.first.id;
          Get.toNamed(
            AppRoutes.Chat,
            parameters: {
              'doc_id': docId,
              'to_token': contactItem.token ?? '',
              'to_name': contactItem.name ?? '',
              'to_avatar': contactItem.avatar ?? '',
              'to_online': contactItem.online.toString(),
            },
          );
        }
      }
    } catch (e, stackTrace) {
      developer.log(e.toString(), stackTrace: stackTrace);
    }
  }

  // Future<void> goChat(ContactItem contactItem) async {
  //   try {
  //     var from_message = await db
  //         .collection('message')
  //         .withConverter(
  //           fromFirestore: Msg.fromFirestore,
  //           toFirestore: (Msg msg, options) => msg.toFirestore(),
  //         )
  //         .where("from_token", isEqualTo: token)
  //         .where("to_token", isEqualTo: contactItem.token)
  //         .get();

  //     var to_message = await db
  //         .collection('message')
  //         .withConverter(
  //           fromFirestore: Msg.fromFirestore,
  //           toFirestore: (Msg msg, options) => msg.toFirestore(),
  //         )
  //         .where("from_token", isEqualTo: contactItem.token)
  //         .where("to_token", isEqualTo: token)
  //         .get();
  //     print("from message"
  //         "=>"
  //         "${from_message.docs.isNotEmpty}"
  //         "to mesage "
  //         "=>"
  //         "${to_message.docs.isNotEmpty}");

  //     if (from_message.docs.isEmpty && to_message.docs.isEmpty) {
  //       var profile = UserStore.to.profile;
  //       var msgData = Msg(
  //         from_token: profile.token,
  //         to_token: contactItem.token,
  //         from_name: profile.name,
  //         to_name: contactItem.name,
  //         from_avatar: profile.avatar,
  //         to_avatar: contactItem.avatar,
  //         from_online: profile.online,
  //         to_online: contactItem.online,
  //         last_msg: "",
  //         last_time: Timestamp.now(),
  //         msg_num: 0,
  //       );
  //       var docRef = await db
  //           .collection('message')
  //           .withConverter(
  //             fromFirestore: Msg.fromFirestore,
  //             toFirestore: (Msg msg, options) => msg.toFirestore(),
  //           )
  //           .add(msgData);
  //       var doc_id = docRef.id;

  //       Get.offAllNamed(
  //         AppRoutes.Chat,
  //         parameters: {
  //           "doc_id": doc_id,
  //           "to_token": contactItem.token ?? "",
  //           "to_name": contactItem.name ?? "",
  //           "to_avatar": contactItem.avatar ?? "",
  //           "to_online": contactItem.online.toString(),
  //         },
  //       );
  //       print(
  //           '=====================> Add user in the document done! <=========================');
  //     } else {
  //       if (from_message.docs.first.id.isNotEmpty) {
  //         Get.toNamed(
  //           AppRoutes.Chat,
  //           parameters: {
  //             "doc_id": from_message.docs.first.id,
  //             "to_token": contactItem.token ?? "",
  //             "to_name": contactItem.name ?? "",
  //             "to_avatar": contactItem.avatar ?? "",
  //             "to_online": contactItem.online.toString(),
  //           },
  //         );
  //       }
  //       if (to_message.docs.first.id.isNotEmpty) {
  //         Get.toNamed(
  //           AppRoutes.Chat,
  //           parameters: {
  //             "doc_id": to_message.docs.first.id,
  //             "to_token": contactItem.token ?? "",
  //             "to_name": contactItem.name ?? "",
  //             "to_avatar": contactItem.avatar ?? "",
  //             "to_online": contactItem.online.toString(),
  //           },
  //         );
  //       }
  //     }
  //   } catch (e) {
  //     developer.log(e.toString());
  //   }
  // }

  asyncLoadAllData() async {
    EasyLoading.show(
      indicator: const CircularProgressIndicator(),
      maskType: EasyLoadingMaskType.clear,
      dismissOnTap: true,
    );
    state.contactList.clear();
    var result = await ContactAPI.post_contact();
    if (kDebugMode) {
      developer.log('${result.data!}');
    }
    if (result.code == 0) {
      state.contactList.addAll(result.data!);
    }
    EasyLoading.dismiss();
  }
}
