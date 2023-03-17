import 'package:chatcine/common/values/values.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';
import 'index.dart';

class VoiceCallPages extends GetView<VoiceCallController> {
  const VoiceCallPages({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.primary_bg,
      body: SafeArea(
        child: Obx(
          () {
            return Container(
              child: Stack(
                children: [
                  Positioned(
                    top: 10.h,
                    left: 30.w,
                    right: 30.w,
                    child: Column(
                      children: [
                        Text(
                          controller.state.callTime.value,
                          style: TextStyle(
                            color: AppColors.primaryElementText,
                            fontSize: 20.sp,
                            fontWeight: FontWeight.normal,
                          ),
                        ),
                        Container(
                          padding: EdgeInsets.all(2),
                          margin: EdgeInsets.only(top: 150.w),
                          decoration: const BoxDecoration(
                            color: AppColors.primaryBackground,
                            shape: BoxShape.circle,
                          ),
                          child: CircleAvatar(
                            radius: 90, // đường kính của avatar
                            backgroundImage: NetworkImage(controller.state
                                .to_avatar.value), // đường dẫn đến hình ảnh
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.only(top: 10.w),
                          child: Text(
                            controller.state.to_name.value,
                            style: TextStyle(
                              color: AppColors.primaryElementText,
                              fontSize: 18.sp,
                              fontWeight: FontWeight.normal,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Positioned(
                    bottom: 50.h,
                    left: 30.w,
                    right: 30.w,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        //Micro section
                        GestureDetector(
                          onTap: () {
                            print('bật/ tắt mic');
                          },
                          child: Column(
                            children: [
                              Container(
                                width: 55.w,
                                height: 55.w,
                                padding: EdgeInsets.all(15.w),
                                decoration: BoxDecoration(
                                  color: controller.state.openMic.value
                                      ? AppColors.primaryElementText
                                      : AppColors.primaryText,
                                  shape: BoxShape.circle,
                                ),
                                child: controller.state.openMic.value
                                    ? Image.asset(
                                        'assets/icons/b_microphone.png')
                                    : Image.asset(
                                        'assets/icons/a_microphone.png'),
                              ),
                              Container(
                                margin: EdgeInsets.only(top: 5.w),
                                child: Text(
                                  'Microphone',
                                  style: TextStyle(
                                    color: AppColors.primaryElementText,
                                    fontSize: 12.sp,
                                    fontWeight: FontWeight.normal,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        GestureDetector(
                          onTap: () {
                            print('bật/ tắt cuộc gọi');
                            controller.state.isJonined.value
                                ? controller.leaveChannel()
                                : controller.joinChannel();
                          },
                          child: Column(
                            children: [
                              Container(
                                width: 55.w,
                                height: 55.w,
                                padding: EdgeInsets.all(15.w),
                                decoration: BoxDecoration(
                                  color: controller.state.isJonined.value
                                      ? AppColors.primaryElementBg
                                      : AppColors.primaryElementStatus,
                                  shape: BoxShape.circle,
                                ),
                                child: controller.state.isJonined.value
                                    ? Image.asset('assets/icons/a_phone.png')
                                    : Image.asset(
                                        'assets/icons/a_telephone.png'),
                              ),
                              Container(
                                margin: EdgeInsets.only(top: 5.w),
                                child: Text(
                                  controller.state.isJonined.value
                                      ? 'End call'
                                      : 'Join call',
                                  style: TextStyle(
                                    color: AppColors.primaryElementText,
                                    fontSize: 12.sp,
                                    fontWeight: FontWeight.normal,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        GestureDetector(
                          onTap: () {
                            print('bật/ tắt tiếng');
                          },
                          child: Column(
                            children: [
                              Container(
                                width: 55.w,
                                height: 55.w,
                                padding: EdgeInsets.all(15.w),
                                decoration: BoxDecoration(
                                  color: controller.state.openSpeaker.value
                                      ? AppColors.primaryElementText
                                      : AppColors.primaryText,
                                  shape: BoxShape.circle,
                                ),
                                child: controller.state.openSpeaker.value
                                    ? Image.asset('assets/icons/b_trumpet.png')
                                    : Image.asset('assets/icons/a_trumpet.png'),
                              ),
                              Container(
                                margin: EdgeInsets.only(top: 5.w),
                                child: Text(
                                  'Speaker',
                                  style: TextStyle(
                                    color: AppColors.primaryElementText,
                                    fontSize: 12.sp,
                                    fontWeight: FontWeight.normal,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
