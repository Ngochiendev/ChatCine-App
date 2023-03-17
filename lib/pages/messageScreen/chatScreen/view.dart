import 'package:cached_network_image/cached_network_image.dart';
import 'package:chatcine/common/routes/routes.dart';
import 'package:chatcine/common/style/color.dart';
import 'package:chatcine/common/values/values.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'controller.dart';

class ChatPages extends GetView<ChatController> {
  const ChatPages({super.key});

  AppBar _buildAppBar() {
    return AppBar(
      title: Obx(
        () {
          return Container(
            child: Text(
              '${controller.state.to_name.value}',
              overflow: TextOverflow.clip,
              maxLines: 1,
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 18.sp,
                color: AppColor.primaryText,
              ),
            ),
          );
        },
      ),
      actions: [
        Container(
          margin: EdgeInsets.only(right: 20.w),
          child: Stack(
            children: [
              SizedBox(
                width: 40.w,
                height: 50.w,
                child: CachedNetworkImage(
                  imageUrl: controller.state.to_avatar.value,
                  imageBuilder: (context, imageProvider) => Container(
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: imageProvider,
                      ),
                      shape: BoxShape.circle,
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.5),
                          spreadRadius: 1,
                          blurRadius: 2,
                          offset: const Offset(0, 1),
                        ),
                      ],
                    ),
                  ),
                  errorWidget: (context, url, error) => const Image(
                    image: AssetImage('assets/images/account_header.png'),
                  ),
                ),
              ),
              Positioned(
                bottom: 2.w,
                right: 0.w,
                height: 14.w,
                child: Container(
                  height: 14.w,
                  width: 14.w,
                  decoration: BoxDecoration(
                    color: controller.state.to_online.value == "1"
                        ? AppColors.primaryElementStatus
                        : AppColors.secondElementStatus,
                    shape: BoxShape.circle,
                    border: Border.all(
                        width: 2.w, color: AppColor.scaffoldBackground),
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppBar(),
      body: Obx(
        () {
          return SafeArea(
            child: Stack(
              children: [
                Positioned(
                  bottom: 0.h,
                  child: Container(
                    width: 375.w,
                    color: Colors.red,
                    padding: EdgeInsets.only(
                        left: 20.w, bottom: 5.w, top: 5.w, right: 20.w),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        // TextFeild message
                        Container(
                          width: 270.w,
                          height: 50.w,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(5.w),
                            color: AppColors.primaryBackground,
                            border: Border.all(
                              width: 1.w,
                              color: AppColors.secondElementStatus,
                            ),
                          ),
                          child: Row(
                            children: [
                              Container(
                                width: 220.w,
                                height: 50.w,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(5.w),
                                  color: AppColors.primaryBackground,
                                  // border: Border.all(
                                  //   width: 1.w,
                                  //   color: AppColors.secondElementStatus,
                                  // ),
                                ),
                                child: TextField(
                                  keyboardType: TextInputType.multiline,
                                  decoration: InputDecoration(
                                    border: InputBorder.none,
                                    hintText: 'Enter text',
                                    contentPadding: EdgeInsets.only(
                                      left: 10.w,
                                      top: 0.w,
                                      bottom: 0.w,
                                    ),
                                  ),
                                ),
                              ),
                              GestureDetector(
                                onTap: () {
                                  print('gửi');
                                },
                                child: Container(
                                  height: 40.w,
                                  width: 40.w,
                                  child: Image.asset('assets/icons/send.png'),
                                ),
                              )
                            ],
                          ),
                        ),
                        // Button action
                        GestureDetector(
                          onTap: () {
                            controller.goMore();
                          },
                          child: Container(
                            padding: const EdgeInsets.all(8),
                            height: 40.w,
                            width: 40.w,
                            decoration: const BoxDecoration(
                              color: AppColors.primaryElement,
                              shape: BoxShape.circle,
                            ),
                            child: Image.asset('assets/icons/add.png'),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                controller.state.more_status.value
                    ? Positioned(
                        right: 10.w,
                        bottom: 70.h,
                        height: 200.h,
                        width: 40.w,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            GestureDetector(
                              onTap: () {
                                print('file');
                              },
                              child: Container(
                                height: 40.h,
                                width: 40.h,
                                padding: const EdgeInsets.all(10),
                                decoration: BoxDecoration(
                                  color: AppColors.primaryBackground,
                                  shape: BoxShape.circle,
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.grey.withOpacity(0.2),
                                      spreadRadius: 2,
                                      blurRadius: 2,
                                      offset: const Offset(1, 1),
                                    ),
                                  ],
                                ),
                                child: Image.asset('assets/icons/photo.png'),
                              ),
                            ),
                            GestureDetector(
                              onTap: () {
                                print('file');
                              },
                              child: Container(
                                height: 40.h,
                                width: 40.h,
                                padding: const EdgeInsets.all(10),
                                decoration: BoxDecoration(
                                  color: AppColors.primaryBackground,
                                  shape: BoxShape.circle,
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.grey.withOpacity(0.2),
                                      spreadRadius: 2,
                                      blurRadius: 2,
                                      offset: const Offset(1, 1),
                                    ),
                                  ],
                                ),
                                child: Image.asset('assets/icons/file.png'),
                              ),
                            ),
                            GestureDetector(
                              onTap: () {
                                controller.goVoiceCall();
                              },
                              child: Container(
                                height: 40.h,
                                width: 40.h,
                                padding: const EdgeInsets.all(10),
                                decoration: BoxDecoration(
                                  color: AppColors.primaryBackground,
                                  shape: BoxShape.circle,
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.grey.withOpacity(0.2),
                                      spreadRadius: 2,
                                      blurRadius: 2,
                                      offset: const Offset(1, 1),
                                    ),
                                  ],
                                ),
                                child: Image.asset('assets/icons/call.png'),
                              ),
                            ),
                            GestureDetector(
                              onTap: () {
                                print('videoCall');
                              },
                              child: Container(
                                height: 40.h,
                                width: 40.h,
                                padding: const EdgeInsets.all(10),
                                decoration: BoxDecoration(
                                  color: AppColors.primaryBackground,
                                  shape: BoxShape.circle,
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.grey.withOpacity(0.2),
                                      spreadRadius: 2,
                                      blurRadius: 2,
                                      offset: const Offset(1, 1),
                                    ),
                                  ],
                                ),
                                child: Image.asset('assets/icons/video.png'),
                              ),
                            ),
                          ],
                        ),
                      )
                    : Container(),
              ],
            ),
          );
        },
      ),
    );
  }
}
