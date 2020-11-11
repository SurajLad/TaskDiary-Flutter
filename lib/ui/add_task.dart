import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:xno_taskapp/helpers/app_constants.dart';
import 'package:xno_taskapp/helpers/layout_helper.dart';
import 'package:xno_taskapp/helpers/text_styles.dart';
import 'package:xno_taskapp/model/task_controller.dart';
import 'package:xno_taskapp/ui/widgets/calender_view.dart';

class AddTaskPage extends StatelessWidget {
  final TaskController taskController = Get.put(TaskController());

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Color(0xFF6464A7),
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              margin: const EdgeInsets.only(left: 10, top: 10, right: 25),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  IconButton(
                    onPressed: () {},
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
            ),
            Container(
              margin: const EdgeInsets.only(top: 15, bottom: 20, left: 20),
              child: Text(
                "Add Task",
                style: largeBoldTxt.copyWith(color: Colors.white),
              ),
            ),
            Expanded(
              child: Container(
                width: LayoutHelper.instance.width,
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
                            cursorColor: AppConstants.appThemeColor,
                            decoration: InputDecoration(
                              hintText: "Enter Task Name",
                              hintStyle: medTxt.copyWith(color: Colors.black54),
                              border: InputBorder.none,
                            ),
                          ),
                        ),
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
                          child: Container(
                            child: TextFormField(
                              enabled: false,
                              cursorColor: AppConstants.appThemeColor,
                              decoration: InputDecoration(
                                hintText: "Enter Date",
                                labelText:
                                    controller.selectedDate.value.toString(),
                                hintStyle:
                                    medTxt.copyWith(color: Colors.black54),
                                border: InputBorder.none,
                              ),
                            ),
                          ),
                        ),
                      ],
                    );
                  },
                ),
              ),
            ),
          ],
        ),
      ),
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

  Text buildFieldTItle({String title}) {
    return Text(
      title,
      style: regularBoldTxt.copyWith(color: AppConstants.appFontTextColor),
    );
  }
}
