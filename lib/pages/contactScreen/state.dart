import 'package:chatcine/common/entities/contact.dart';
import 'package:get/get.dart';

class ContactState {
  RxList<ContactItem> contactList = <ContactItem>[].obs;
  RxBool isLoading = RxBool(false);
}
