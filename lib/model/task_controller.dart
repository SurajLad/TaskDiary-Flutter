import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:xno_taskapp/helpers/layout_helper.dart';

class TaskController extends GetxController {
  final TextEditingController taskNameController = TextEditingController();
  final TextEditingController taskDescriptionController =
      TextEditingController();

  List<bool> selectedLabelList = [];

  var selectedDate = DateTime.now().obs;
  var selectedStartTime = DateTime.now().obs;
  var selectedEndTime = DateTime.now().obs;
  String label;

  void updateSelectedList(int index, bool action) {
    for (int i = 0; i < selectedLabelList.length; i++) {
      selectedLabelList[i] = false;
    }
    selectedLabelList[index] = action;
    update();
  }

  @override
  void onInit() {
    selectedLabelList.clear();
    for (int i = 0; i < LayoutHelper.instance.labelList.length; i++) {
      selectedLabelList.add(false);
    }
    print(selectedLabelList.length);
    super.onInit();
  }

  void clearSelectedListAndInit() {
    selectedLabelList.clear();
    for (int i = 0; i < LayoutHelper.instance.labelList.length; i++) {
      selectedLabelList.add(false);
    }
    update();
  }

  @override
  void onClose() {
    super.onClose();
  }
}
