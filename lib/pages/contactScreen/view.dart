import 'package:chatcine/common/style/color.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'controller.dart';
import 'widgets/contact_list.dart';

class ContactPages extends GetView<ContactController> {
  const ContactPages({super.key});

  AppBar _buildAppBar() {
    return AppBar(
      title: Text(
        'Contact',
        style: TextStyle(
          color: AppColor.primaryText,
          fontSize: 16.sp,
          fontWeight: FontWeight.normal,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppBar(),
      body: ContactList(),
    );
  }
}
