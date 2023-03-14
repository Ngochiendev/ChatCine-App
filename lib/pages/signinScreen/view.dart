import 'package:chatcine/common/values/values.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'controller.dart';
import 'dart:developer' as developer;

class SignInPages extends GetView<SignInController> {
  const SignInPages({super.key});

  Widget _buildLogo() {
    return Container(
      margin: EdgeInsets.only(top: 100.h, bottom: 80.h),
      width: 200.w,
      height: 100.w,
      child: Image.asset(
        'assets/images/logo.png',
        fit: BoxFit.cover,
        filterQuality: FilterQuality.high,
      ),
    );
  }

  Widget _buildLoginButton(String logotype, String logo) {
    return GestureDetector(
      onTap: () {
        // print("button Sign in with $logotype");
        controller.handleSignIn("google");
      },
      child: Container(
        height: 44.h,
        width: 285.w,
        padding: EdgeInsets.all(10.h),
        margin: EdgeInsets.only(bottom: 15.h),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(5),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.1),
              spreadRadius: 1,
              blurRadius: 2,
              offset: const Offset(0, 1),
            ),
          ],
          color: AppColors.primaryBackground,
        ),
        child: Row(
          children: [
            Container(
              padding: EdgeInsets.only(left: 40.w, right: 20.w),
              child: logo == ""
                  ? Container()
                  : Image.asset('assets/icons/$logo.png'),
            ),
            Text(
              "Sign in with $logotype",
              textAlign: TextAlign.center,
              style: TextStyle(
                color: AppColors.primaryText,
                fontWeight: FontWeight.normal,
                fontSize: 14.sp,
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.primarySecondaryBackground,
      body: Center(
        child: Column(
          children: [
            _buildLogo(),
            _buildLoginButton("Google", "google"),
            _buildLoginButton("Facebook", "facebook"),
            _buildLoginButton("Apple", "apple"),
            _buildOrWidget(),
            _buildLoginButton("phone number", ""),
            SizedBox(height: 20.h),
            Column(
              children: [
                Text(
                  "Already have an account",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: AppColors.primaryText,
                    fontWeight: FontWeight.normal,
                    fontSize: 12.sp,
                  ),
                ),
                SizedBox(height: 2.h),
                GestureDetector(
                  onTap: () {
                    developer.log("đăng ký");
                  },
                  child: Text(
                    "Sign up here",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: AppColors.primaryElement,
                      fontWeight: FontWeight.normal,
                      fontSize: 12.sp,
                    ),
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}

// ignore: camel_case_types
class _buildOrWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 20.h, bottom: 30.h),
      child: Row(
        children: [
          Expanded(
            child: Divider(
              indent: 40.h,
              height: 2.h,
              color: AppColors.primarySecondaryElementText,
            ),
          ),
          const Text(" Or "),
          Expanded(
            child: Divider(
              endIndent: 40.h,
              height: 2.h,
              color: AppColors.primarySecondaryElementText,
            ),
          ),
        ],
      ),
    );
  }
}
