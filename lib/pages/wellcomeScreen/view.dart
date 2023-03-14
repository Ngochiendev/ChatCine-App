import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'controller.dart';

class WellcomePages extends GetView<WellcomeController> {
  const WellcomePages({super.key});

  Widget _buildPageHeadTitle(String title) {
    return Container(
      alignment: Alignment.center,
      child: Text(
        title,
        style: TextStyle(fontSize: 45.sp),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            child: _buildPageHeadTitle(controller.tilte),
          ),
          Container(
            color: Colors.red,
            width: 350.r,
            height: 350.r,
          ),
        ],
      ),
    );
  }
}
