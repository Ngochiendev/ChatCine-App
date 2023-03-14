import 'package:chatcine/common/routes/names.dart';
import 'package:chatcine/common/style/style.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'index.dart';
import 'dart:developer' as developer;

class MessagePages extends GetView<MessageController> {
  const MessagePages({super.key});

  //slivers

  Widget _headBar() {
    return Center(
      child: Container(
        width: 320.w,
        height: 44.w,
        margin: EdgeInsets.only(top: 20.h, bottom: 20.h),
        child: Row(
          children: [
            Stack(
              children: [
                InkWell(
                  onTap: () {
                    developer.log("chuyển trang profile");
                    controller.goProfile();
                  },
                  child: Container(
                    width: 44.w,
                    height: 44.w,
                    decoration: BoxDecoration(
                      color: AppColor.scaffoldBackground,
                      shape: BoxShape.circle,
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.1),
                          spreadRadius: 5,
                          blurRadius: 5,
                          offset: const Offset(0, 1),
                        )
                      ],
                    ),
                    child: controller.state.head_detail.value.avatar == null
                        ? Image.asset('assets/images/account_header.png')
                        : Text("hi"),
                  ),
                ),
                Positioned(
                  bottom: 2.w,
                  right: 0.w,
                  height: 14.w,
                  child: Container(
                    width: 14.w,
                    height: 14.w,
                    decoration: BoxDecoration(
                      border: Border.all(
                          width: 2.w, color: AppColor.scaffoldBackground),
                      shape: BoxShape.circle,
                      color: Colors.green,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: [
            CustomScrollView(
              slivers: [
                SliverAppBar(
                  pinned: true,
                  title: _headBar(),
                )
              ],
            ),
            Positioned(
              right: 20.w,
              bottom: 70.w,
              height: 50.w,
              width: 50.w,
              child: GestureDetector(
                onTap: () {
                  print('chuyển page contact');
                  Get.toNamed(AppRoutes.Contact);
                },
                child: Container(
                  height: 50.w,
                  width: 50.w,
                  padding: EdgeInsets.all(10.w),
                  decoration: BoxDecoration(
                      color: AppColor.primaryBackground,
                      borderRadius: BorderRadius.all(Radius.circular(40.w))),
                  child: Image.asset('assets/icons/contact.png'),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
