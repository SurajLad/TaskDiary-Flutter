import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:xno_taskapp/helpers/app_constants.dart';
import 'package:xno_taskapp/helpers/layout_helper.dart';
import 'package:xno_taskapp/helpers/text_styles.dart';
import 'package:xno_taskapp/model/hive/task.dart';
import 'package:xno_taskapp/model/task_controller.dart';
import 'package:xno_taskapp/ui/widgets/calender_view.dart';
import 'package:xno_taskapp/ui/widgets/label_widget.dart';
import 'package:xno_taskapp/ui/widgets/material_button.dart';

class AddTaskPage extends StatelessWidget {
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
                margin: const EdgeInsets.only(top: 15, bottom: 20, left: 20),
                child: Text(
                  "Add Task",
                  style: largeBoldTxt.copyWith(color: Colors.white),
                ),
              ),
              Container(
                width: LayoutHelper.instance.width,
                height: LayoutHelper.instance.height + 40,
                padding: const EdgeInsets.only(left: 28, right: 28),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(30),
                    topRight: Radius.circular(30),
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
                        Container(
                          decoration: BoxDecoration(
                            color: Colors.grey[250],
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: TextFormField(
                            controller: taskController.taskNameController,
                            cursorColor: AppConstants.appThemeColor,
                            decoration: InputDecoration(
                              hintText: "Enter Task Name",
                              hintStyle: medTxt.copyWith(color: Colors.black54),
                              enabledBorder: UnderlineInputBorder(
                                borderSide: BorderSide(
                                    color: AppConstants.fontTitleColor),
                              ),
                              focusedBorder: UnderlineInputBorder(
                                borderSide: BorderSide(
                                    color: AppConstants.fontTitleColor),
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(height: 10),
                        buildFieldTItle(title: "RECENT MEET"),
                        Container(
                          color: Colors.amber,
                          height: 40,
                        ),
                        const SizedBox(height: 10),
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
                        Container(
                          decoration: BoxDecoration(
                            color: Colors.red[950],
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: TextFormField(
                            controller:
                                taskController.taskDescriptionController,
                            maxLines: 3,
                            cursorColor: AppConstants.appThemeColor,
                            decoration: InputDecoration(
                              hintText: "Enter description",
                              hintStyle: medTxt.copyWith(color: Colors.black54),
                              border: InputBorder.none,
                              enabledBorder: UnderlineInputBorder(
                                borderSide: BorderSide(
                                    color: AppConstants.fontTitleColor),
                              ),
                              focusedBorder: UnderlineInputBorder(
                                borderSide: BorderSide(
                                    color: AppConstants.fontTitleColor),
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(height: 10),
                        buildFieldTItle(title: "LABEL"),
                        const SizedBox(height: 10),
                        Row(
                          children: [
                            LabelWidget(label: "Running"),
                            const SizedBox(width: 10),
                            DottedBorder(
                              color: AppConstants.appThemeColor,
                              strokeWidth: 1,
                              child: Icon(
                                Icons.add,
                                color: AppConstants.appThemeColor,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 30),
                        CustomButton(
                          color: Color(0xFF6464A7),
                          onTap: () {
                            Task task = Task(
                              user: null,
                              name: taskController.taskNameController.text,
                              date: taskController.selectedDate.value,
                            );
                            LayoutHelper.instance.taskList.add(task);
                          },
                        ),
                        const SizedBox(height: 5),
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
            onPressed: () => Navigator.pop(context),
            icon: Icon(
              Icons.arrow_back_ios_rounded,
              color: Colors.white,
            ),
          ),
          CircleAvatar(
            backgroundColor: Colors.white,
            radius: 22,
          ),
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
}
