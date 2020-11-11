import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class TaskController extends GetxController {
  final TextEditingController taskNameController = TextEditingController();
  var selectedDate=DateTime.now().obs;
  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
  }

  @override
  void onClose() {
    taskNameController.dispose();
    super.onClose();
  }
}
