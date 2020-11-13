import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class TaskController extends GetxController {
  final TextEditingController taskNameController = TextEditingController();
  final TextEditingController taskDescriptionController = TextEditingController();

  var selectedDate = DateTime.now().obs;
  var selectedStartTime = DateTime.now().obs;
  var selectedEndTime = DateTime.now().obs;
  
  @override
  void onInit() {
    super.onInit();
  }

  @override
  void onClose() {
    taskNameController.dispose();
    taskDescriptionController.dispose();
    super.onClose();
  }
}
