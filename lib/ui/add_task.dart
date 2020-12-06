import 'dart:async';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:xno_taskapp/helpers/app_constants.dart';
import 'package:xno_taskapp/helpers/layout_helper.dart';
import 'package:xno_taskapp/helpers/text_styles.dart';
import 'package:xno_taskapp/model/hive/label.dart';
import 'package:xno_taskapp/model/hive/task.dart';
import 'package:xno_taskapp/model/task_controller.dart';
import 'package:xno_taskapp/ui/home_page.dart';
import 'package:xno_taskapp/ui/widgets/calender_view.dart';
import 'package:xno_taskapp/ui/widgets/custom_textfield.dart';
import 'package:xno_taskapp/ui/widgets/label_widget.dart';
import 'package:xno_taskapp/ui/widgets/material_button.dart';
import 'package:xno_taskapp/ui/widgets/ui_helpers.dart';

class AddTaskPage extends StatelessWidget {
  final TextEditingController labelcontroller = TextEditingController();
  Color selectedLabelColor;
  final TaskController taskController = Get.put(TaskController());

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Color(0xFF6464A7),
        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              buildAppBar(context),
              Container(
                margin: const EdgeInsets.only(top: 5, bottom: 20, left: 25),
                child: Text(
                  "Add Task",
                  style: largeBoldTxt.copyWith(color: Colors.white),
                ),
              ),
              Container(
                width: LayoutHelper.instance.width,
                height: LayoutHelper.instance.height,
                padding: const EdgeInsets.only(left: 28, right: 28),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(24),
                    topRight: Radius.circular(24),
                  ),
                  color: AppConstants.appBackgroundColor,
                ),
                child: GetBuilder<TaskController>(
                  builder: (controller) {
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        const SizedBox(height: 20),
                        buildFieldTItle(title: "TASK"),
                        CustomTextField(
                          controller: taskController.taskNameController,
                          hintText: "Enter Task Name",
                          maxLines: 1,
                        ),
                        const SizedBox(height: 15),
                        buildFieldTItle(title: "DATE"),
                        InkWell(
                          onTap: () {
                            showDemoDialog(context: context);
                          },
                          child: Obx(() {
                            return TextFormField(
                              enabled: false,
                              cursorColor: AppConstants.appThemeColor,
                              decoration: InputDecoration(
                                  isDense: true,
                                  hintText: "Enter Date",
                                  labelText: DateFormat("MMM dd, yyyy")
                                      .format(controller.selectedDate.value),
                                  labelStyle: medTxt,
                                  hintStyle:
                                      medTxt.copyWith(color: Colors.black54),
                                  disabledBorder: UnderlineInputBorder(
                                      borderSide: BorderSide(
                                          color: AppConstants.fontTitleColor)),
                                  suffixIcon: Icon(
                                    Icons.calendar_today,
                                    color: AppConstants.fontTextColor,
                                  )),
                            );
                          }),
                        ),
                        const SizedBox(height: 15),
                        buildTimingWidgets(context, controller),
                        const SizedBox(height: 15),
                        buildFieldTItle(title: "DESCRIPTION"),
                        CustomTextField(
                          controller: taskController.taskDescriptionController,
                          maxLines: 3,
                          hintText: "Enter description",
                        ),
                        const SizedBox(height: 15),
                        Row(
                          children: [
                            buildFieldTItle(title: "LABEL"),
                            const SizedBox(width: 20),
                            InkWell(
                              onTap: () {
                                showModalBottomSheet(
                                    context: context,
                                    isScrollControlled: true,
                                    builder: (builder) {
                                      return Material(
                                        child: new Container(
                                          padding: const EdgeInsets.all(20),
                                          child: buildLabelWidget(),
                                        ),
                                      );
                                    });
                              },
                              child: DottedBorder(
                                color: AppConstants.appThemeColor,
                                strokeWidth: 1,
                                child: Icon(
                                  Icons.add,
                                  color: AppConstants.appThemeColor,
                                ),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 20),
                        Container(
                          width: LayoutHelper.instance.width,
                          height: 30,
                          child: ListView.builder(
                            shrinkWrap: true,
                            scrollDirection: Axis.horizontal,
                            itemCount: LayoutHelper.instance.labelList.length,
                            itemBuilder: (context, index) {

                              return InkWell(
                                splashColor: Colors.red,
                                onTap: () {
                                  if (taskController.selectedLabelList[index]) {
                                    taskController.updateSelectedList(
                                        index, false);
                                  } else {
                                    taskController.updateSelectedList(
                                        index, true);
                                    taskController.label = LayoutHelper
                                        .instance.labelList
                                        .get(index)
                                        .name;
                                  }
                                },
                                child: Container(
                                  margin: const EdgeInsets.only(right: 8),
                                  child: ColorFiltered(
                                    colorFilter: ColorFilter.mode(
                                      taskController.selectedLabelList[index]
                                          ? Colors.white
                                          : Colors.transparent,
                                      BlendMode.saturation,
                                    ),
                                    child: LabelWidget(
                                      label: LayoutHelper.instance.labelList
                                          .get(index)
                                          .name,
                                      color: LayoutHelper.instance.labelList
                                          .get(index)
                                          .color,
                                    ),
                                  ),
                                ),
                              );
                            },
                          ),
                        ),
                        const SizedBox(height: 30),
                        CustomButton(
                          color: const Color(0xFF6464A7),
                          onTap: () {
                            bool value = doValidaition();
                            if (value) {
                              showLoading(context);
                              Timer(Duration(seconds: 3), () {
                                Navigator.pop(context);
                                Task task = Task(
                                  user: null,
                                  name: taskController.taskNameController.text,
                                  description: taskController
                                      .taskDescriptionController.text,
                                  date: taskController.selectedDate.value,
                                  startTime:
                                      taskController.selectedStartTime.value,
                                  endTime: taskController.selectedEndTime.value,
                                  statusTag: taskController.label,
                                );
                                LayoutHelper.instance.taskList.add(task);
                                Get.off(HomePage()).then((value) =>
                                    showSnackbar(
                                        "Success", "Task has been created."));
                              });
                            } else {}
                          },
                        ),
                      ],
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildLabelWidget() {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          "Create new Label",
          style: medBoldTxt,
        ),
        const SizedBox(height: 5),
        CustomTextField(
          controller: labelcontroller,
          hintText: "Label name",
          maxLines: 1,
        ),
        const SizedBox(height: 15),
        Text(
          "Select Color",
          style: medBoldTxt,
        ),
        const SizedBox(height: 15),
        Container(
          height: 150,
          child: BlockPicker(
            // itemBuilder: (color, isCurrentColor, changeColor) => Container(
            //   margin: const EdgeInsets.all(6),
            //   decoration: BoxDecoration(
            //     shape: BoxShape.rectangle,
            //     color: color,
            //   ),
            // ),
            pickerColor: Color(0xff443a49),
            onColorChanged: (Color color) {
              selectedLabelColor = color;
            },
          ),
        ),
        const SizedBox(height: 15),
        FlatButton(
          minWidth: LayoutHelper.instance.width / 2,
          height: 40,
          child: Text(
            "Add Label",
            style: medBoldTxt.copyWith(color: Colors.white),
          ),
          color: AppConstants.appThemeColor.withOpacity(0.7),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
          onPressed: () {
            if (labelcontroller.text.isNotEmpty && selectedLabelColor != null) {
              Label label = Label(
                name: labelcontroller.text,
                color: selectedLabelColor.value,
              );
              LayoutHelper.instance.labelList.add(label);
              taskController.clearSelectedListAndInit();
              Navigator.pop(Get.context);
            }
          },
        ),
      ],
    );
  }

  Obx buildTimingWidgets(BuildContext context, TaskController controller) {
    return Obx(() {
      return Row(
        children: [
          Flexible(
            flex: 5,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                buildFieldTItle(title: "START TIME"),
                Material(
                  color: Colors.transparent,
                  child: InkWell(
                    highlightColor:
                        AppConstants.fontTitleColor.withOpacity(0.2),
                    onTap: () {
                      showTimerDialog(
                        context: context,
                        isStart: true,
                        initalTime: controller.selectedStartTime.value,
                      );
                    },
                    child: Container(
                        margin: const EdgeInsets.only(right: 5),
                        child: buildTimerField(
                            controller.selectedStartTime.value)),
                  ),
                ),
              ],
            ),
          ),
          Flexible(
              flex: 5,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  buildFieldTItle(title: "END TIME"),
                  Material(
                    color: Colors.transparent,
                    child: InkWell(
                      highlightColor:
                          AppConstants.fontTitleColor.withOpacity(0.2),
                      onTap: () {
                        showTimerDialog(
                          context: context,
                          isStart: false,
                          initalTime: controller.selectedStartTime.value,
                        );
                      },
                      child: Container(
                          margin: const EdgeInsets.only(left: 5),
                          child: buildTimerField(
                              controller.selectedEndTime.value)),
                    ),
                  ),
                ],
              )),
        ],
      );
    });
  }

  Container buildAppBar(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(left: 10, top: 10, right: 25),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          IconButton(
            onPressed: () {
              Get.off(HomePage());
              taskController.onClose();
            },
            icon: Icon(
              Icons.arrow_back_ios_rounded,
              color: Colors.white,
            ),
          ),
          buildUserProfile(),
        ],
      ),
    );
  }

  TextFormField buildTimerField(DateTime selectedTime) {
    return TextFormField(
      enabled: false,
      cursorColor: AppConstants.appThemeColor,
      decoration: InputDecoration(
          isDense: true,
          hintText: "Enter Date",
          labelText: DateFormat("hh:mm a").format(selectedTime),
          labelStyle: medTxt,
          hintStyle: medTxt.copyWith(color: Colors.black54),
          disabledBorder: UnderlineInputBorder(
              borderSide: BorderSide(color: AppConstants.fontTitleColor)),
          suffixIcon: Icon(
            Icons.keyboard_arrow_down,
            color: AppConstants.fontTextColor,
          )),
    );
  }

  void showDemoDialog({BuildContext context}) {
    showDialog<dynamic>(
      context: context,
      builder: (BuildContext context) => CalendarPopupView(
        barrierDismissible: true,
        initialStartDate: DateTime.now(),
        onApplyClick: (DateTime selectedDate) {
          taskController.selectedDate.value = selectedDate;
        },
        onCancelClick: () {},
      ),
    );
  }

  void showTimerDialog(
      {BuildContext context, bool isStart, DateTime initalTime}) {
    Get.dialog(
      Scaffold(
        backgroundColor: Colors.transparent,
        body: Center(
          child: Container(
            height: LayoutHelper.instance.height / 2,
            margin: const EdgeInsets.only(left: 20, right: 20),
            decoration: BoxDecoration(
              color: AppConstants.appBackgroundColor,
              borderRadius: const BorderRadius.all(Radius.circular(24.0)),
              boxShadow: <BoxShadow>[
                BoxShadow(
                    color: Colors.grey.withOpacity(0.2),
                    offset: const Offset(4, 4),
                    blurRadius: 8.0),
              ],
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Flexible(
                  flex: 8,
                  child: CupertinoDatePicker(
                    mode: CupertinoDatePickerMode.time,
                    initialDateTime: initalTime,
                    onDateTimeChanged: (DateTime newDateTime) {
                      isStart
                          ? taskController.selectedStartTime.value = newDateTime
                          : taskController.selectedEndTime.value = newDateTime;
                    },
                    use24hFormat: false,
                    minuteInterval: 1,
                  ),
                ),
                Flexible(
                  flex: 2,
                  child: Padding(
                    padding: const EdgeInsets.only(
                        left: 16, right: 16, bottom: 10, top: 8),
                    child: Container(
                      height: 48,
                      decoration: BoxDecoration(
                        color: AppConstants.appThemeColor,
                        borderRadius:
                            const BorderRadius.all(Radius.circular(24.0)),
                        boxShadow: <BoxShadow>[
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.6),
                            blurRadius: 8,
                            offset: const Offset(4, 4),
                          ),
                        ],
                      ),
                      child: Material(
                        color: Colors.transparent,
                        child: InkWell(
                          borderRadius:
                              const BorderRadius.all(Radius.circular(24.0)),
                          highlightColor: Colors.transparent,
                          onTap: () {
                            if (isStart) {
                              if (taskController.selectedStartTime.value ==
                                  null) {
                                taskController.selectedStartTime.value =
                                    DateTime.now();
                              }
                            } else {
                              if (taskController.selectedEndTime.value ==
                                  null) {
                                taskController.selectedEndTime.value =
                                    DateTime.now();
                              }
                            }
                            Navigator.pop(context);
                          },
                          child: Center(
                            child: Text(
                              'Select',
                              style: TextStyle(
                                  fontWeight: FontWeight.w500,
                                  fontSize: 18,
                                  color: Colors.white),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  Text buildFieldTItle({String title}) {
    return Text(
      title,
      style: regularBoldTxt.copyWith(color: AppConstants.fontTitleColor),
    );
  }

  Widget buildUserProfile() {
    return ClipOval(
      child: Container(
        width: 55,
        height: 55,
        decoration: BoxDecoration(
            color: AppConstants.appThemeColor.withOpacity(0.7),
            shape: BoxShape.circle,
            image: DecorationImage(
                fit: BoxFit.contain,
                image: AssetImage(
                  'assets/avatars/male_01.png',
                ))),
      ),
    );
  }

  bool doValidaition() {
    if (taskController.taskNameController.text.isEmpty) {
      showSnackbar("Failed", "Please enter task name.");
      return false;
    } else if (taskController.taskDescriptionController.text.isEmpty) {
      showSnackbar("Failed", "Please enter task description.");
      return false;
    } else if (taskController.label == null) {
      showSnackbar("Failed", "Please select task label.");
      return false;
    }
    return true;
  }
}
