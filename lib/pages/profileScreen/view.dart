import 'dart:developer' as developer;
import 'package:chatcine/common/style/style.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'controller.dart';

class ProfilePages extends GetView<ProfileController> {
  const ProfilePages({super.key});

  AppBar _buildAppBar() {
    return AppBar(
      title: Text(
        "Profile",
        style: TextStyle(
          color: AppColor.primaryText,
          fontSize: 16.sp,
          fontWeight: FontWeight.normal,
        ),
      ),
    );
  }

  Widget _buildProfileImage() {
    return Stack(
      alignment: Alignment.center,
      children: [
        Container(
          height: 120.w,
          width: 120.w,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: AppColor.secondaryColor,
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.1),
                spreadRadius: 1,
                blurRadius: 2,
                offset: const Offset(0, 1),
              )
            ],
          ),
          child: Image.asset(
            "assets/images/account_header.png",
            fit: BoxFit.cover,
          ),
        ),
        Positioned(
          bottom: 2.w,
          right: 0.w,
          height: 35.w,
          child: GestureDetector(
            onTap: () {
              developer.log("đổi ảnh đại diện");
            },
            child: Container(
              height: 35.w,
              width: 35.w,
              decoration: const BoxDecoration(
                color: Colors.blue,
                shape: BoxShape.circle,
              ),
              child: Image.asset("assets/icons/edit.png"),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildCompleButton() {
    return GestureDetector(
      onTap: () {
        developer.log("button Complete");
      },
      child: Container(
        alignment: Alignment.center,
        margin: EdgeInsets.only(top: 60.h, bottom: 30.h),
        width: 295.w,
        height: 40.w,
        decoration: BoxDecoration(
          color: AppColor.primaryBackground,
          borderRadius: const BorderRadius.all(Radius.circular(10)),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.1),
              spreadRadius: 1,
              blurRadius: 2,
              offset: const Offset(0, 1),
            )
          ],
        ),
        child: const Text("Complete"),
      ),
    );
  }

  Widget _buildLogOut() {
    return GestureDetector(
      onTap: () {
        developer.log("button đăng xuất");
        Get.defaultDialog(
          title: "Are you sure to log out",
          content: Container(),
          onConfirm: () {
            controller.goLogOut();
          },
          onCancel: () {},
          textConfirm: "Đồng ý",
          textCancel: "Không",
        );
      },
      child: Container(
        alignment: Alignment.center,
        margin: EdgeInsets.only(bottom: 30.h),
        width: 295.w,
        height: 40.w,
        decoration: BoxDecoration(
          color: AppColor.borderColor,
          borderRadius: const BorderRadius.all(Radius.circular(10)),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.1),
              spreadRadius: 1,
              blurRadius: 2,
              offset: const Offset(0, 1),
            )
          ],
        ),
        child: const Text("Đăng xuất"),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppBar(),
      body: SafeArea(
        child: CustomScrollView(
          slivers: [
            SliverToBoxAdapter(
              child: Container(
                child: Column(
                  children: [
                    _buildProfileImage(),
                    _buildCompleButton(),
                    _buildLogOut(),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
