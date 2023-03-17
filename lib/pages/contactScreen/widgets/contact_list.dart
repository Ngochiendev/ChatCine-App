import 'package:chatcine/common/entities/contact.dart';
import 'package:chatcine/common/style/color.dart';
import 'package:chatcine/pages/contactScreen/index.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:get/get.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';

class ContactList extends GetView<ContactController> {
  const ContactList({super.key});

  Widget _buildListItem(ContactItem item) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10.0),
      child: InkWell(
        onTap: () {
          print(item.name);
          controller.goChat(item);
        },
        highlightColor: Colors.grey.withOpacity(0.3), // Màu khi nhấn vào
        splashColor: Colors.grey
            .withOpacity(0.2), // Màu xuất hiện khi tạo hiệu ứng splash
        child: Row(
          children: [
            Container(
              width: 40.w,
              height: 50.w,
              margin: EdgeInsets.only(left: 20.w, right: 5.w),
              child: CachedNetworkImage(
                imageUrl: item.avatar!,
                height: 44.w,
                width: 44.w,
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
              ),
            ),
            SizedBox(
              width: 275.w,
              height: 40.w,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    width: 200.w,
                    height: 40.w,
                    padding: EdgeInsets.only(left: 5.w),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          '${item.name}',
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: AppColor.primaryText,
                              fontSize: 16.sp),
                          maxLines: 1,
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    width: 40.w,
                    height: 40.w,
                    child: Icon(
                      PhosphorIcons.caretRightLight,
                      color: AppColor.primaryText,
                      size: 20.w,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Obx(
      () {
        return CustomScrollView(
          slivers: [
            SliverPadding(
              padding: EdgeInsets.symmetric(vertical: 0.w, horizontal: 0.w),
              sliver: SliverList(
                delegate: SliverChildBuilderDelegate(
                  (context, index) {
                    var item = controller.state.contactList[index];
                    print(item.name);
                    return _buildListItem(item);
                  },
                  childCount: controller.state.contactList.length,
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}
