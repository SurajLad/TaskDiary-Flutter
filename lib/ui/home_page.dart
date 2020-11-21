import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:xno_taskapp/helpers/app_constants.dart';
import 'package:xno_taskapp/helpers/layout_helper.dart';
import 'package:xno_taskapp/helpers/text_styles.dart';
import 'package:xno_taskapp/model/hive/task.dart';
import 'package:xno_taskapp/ui/add_task.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>
    with SingleTickerProviderStateMixin {
  DateTime startDate = DateTime.now();
  DateTime endDate = DateTime.now().add(const Duration(days: 5));
  TabController tabController;
  List<Task> taskDay1 = [];
  List<Task> taskDay2 = [];
  List<Task> taskDay3 = [];
  List<Task> taskDay4 = [];
  List<Task> taskDay5 = [];

  @override
  void initState() {
    super.initState();
    for (int i = 0; i < LayoutHelper.instance.taskList.length; i++) {
      if (LayoutHelper.instance.taskList.get(i).date.day ==
          DateTime.now().day) {
        taskDay1.add(LayoutHelper.instance.taskList.get(i));
      } else if (LayoutHelper.instance.taskList.get(i).date.day ==
          DateTime.now().day + 1) {
        taskDay2.add(LayoutHelper.instance.taskList.get(i));
      } else if (LayoutHelper.instance.taskList.get(i).date.day ==
          DateTime.now().day + 2) {
        taskDay3.add(LayoutHelper.instance.taskList.get(i));
      } else if (LayoutHelper.instance.taskList.get(i).date.day ==
          DateTime.now().day + 3) {
        taskDay4.add(LayoutHelper.instance.taskList.get(i));
      } else if (LayoutHelper.instance.taskList.get(i).date.day ==
          DateTime.now().day + 4) {
        taskDay5.add(LayoutHelper.instance.taskList.get(i));
      }
    }
    tabController = TabController(
        length: endDate.difference(startDate).inDays, vsync: this);
  }

  @override
  void dispose() {
    tabController.dispose();
    super.dispose();
  }

  TabBar buildDatesTabs() {
    return TabBar(
      indicatorColor: AppConstants.appThemeColor,
      indicatorSize: TabBarIndicatorSize.label,
      tabs: List.generate(
        endDate.difference(startDate).inDays,
        (index) => Tab(
          icon: Text(
            '${DateFormat("dd\nMMM").format(DateTime(startDate.year, startDate.month, startDate.day + (index)))}',
            style: regularTxt,
            textAlign: TextAlign.center,
          ),
        ),
      ),
      controller: tabController,
    );
  }

  TabBarView _getTabBarView() {
    return TabBarView(
      physics: NeverScrollableScrollPhysics(),
      children: <Widget>[
        buildTaskList(taskDay1),
        buildTaskList(taskDay2),
        buildTaskList(taskDay3),
        buildTaskList(taskDay4),
        buildTaskList(taskDay5),
      ],
      controller: tabController,
    );
  }

  Widget buildTaskList(List<Task> taskList) {
    if (taskList.isEmpty) {
      return buildNoTasksVector();
    } else {
      return Container(
        margin: const EdgeInsets.only(top: 10),
        child: ListView.builder(
          shrinkWrap: true,
          itemCount: taskList.length,
          itemBuilder: (context, index) {
            Task personModel = taskList[index];
            return buildTaskCard(personModel);
          },
        ),
      );
    }
  }
//   TabBarView _getTabBarView() {
//     return TabBarView(
//       physics: NeverScrollableScrollPhysics(),
//       children: List.generate(
//         endDate.difference(startDate).inDays,
//         (dayIndex) => Column(
//           children: [
//             WatchBoxBuilder(
//               box: LayoutHelper.instance.taskList,
//               builder: (context, box) {
//                 Map<dynamic, dynamic> raw = box.toMap();
//                 List list = raw.values.toList();
//                 return ListView.builder(
//                   shrinkWrap: true,
//                   itemCount: list.length,
//                   itemBuilder: (context, index) {
//                     Task personModel = list[index];
//                     if (personModel.date.day ==
//                         DateTime(startDate.year, startDate.month,
//                                 startDate.day + (dayIndex))
//                             .day) {
//                       return buildTaskCard(personModel);
//                     } else {
//                       if (index == (list.length - 1)) {
//                         print(index);
//                         if (personModel.date.day ==
//                             startDate.day + (dayIndex)) {
//                           return buildNoTasksVector();
//                         } else {
//                           return Text("IF");
//                         }
//                       }
//                       return Container();
//                     }
//                   },
//                 );
//               },
//             ),
//           ],
//         ),
//       ),
//       controller: tabController,
//     );
//   }

  Container buildTaskCard(Task personModel) {
    return Container(
      margin: const EdgeInsets.fromLTRB(5, 5, 5, 5),
      padding: const EdgeInsets.fromLTRB(18, 10, 10, 10),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(0, 4, 0, 4.0),
            child: Text(personModel.name),
          ),
          Container(
            height: 1,
            color: Colors.grey[300],
          ),
          const SizedBox(height: 10),
          Row(
            children: [
              Container(
                color: Colors.red,
                width: 4,
                height: 50,
              ),
              Container(
                margin: const EdgeInsets.only(left: 10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      personModel.name,
                      style: regularBoldTxt,
                    ),
                    Text(personModel.description ?? ""),
                  ],
                ),
              )
            ],
          ),
          const SizedBox(height: 10),
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Icon(Icons.timer),
              const SizedBox(width: 10),
              Text(
                DateFormat("hh:ss a").format(personModel.startTime) +
                    " - " +
                    DateFormat("hh:ss a").format(personModel.startTime),
                style: regularTxt,
              ),
              const SizedBox(width: 20),
              Icon(Icons.people),
              const SizedBox(width: 10),
              Text(
                "1",
                style: regularTxt,
              ),
            ],
          ),
        ],
      ),
    );
  }

  Container buildNoTasksVector() {
    return Container(
      margin: const EdgeInsets.only(top: 20),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Image.asset(
            'assets/no_task_vector.png',
            height: LayoutHelper.instance.width / 1.65,
          ),
          Text("No Tasks for today", style: medBoldTxt),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: AppConstants.appBackgroundColor,
        body: Container(
          margin: const EdgeInsets.only(left: 25, top: 10, right: 25),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Flexible(
                    flex: 7,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text("Hi, Suraj Lad", style: medBoldTxt),
                        Text("Todays Quote", style: regularTxt),
                      ],
                    ),
                  ),
                  Flexible(
                    flex: 2,
                    child: buildUserProfile(),
                  )
                ],
              ),
              const SizedBox(height: 15),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Flexible(
                    flex: 6,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(DateFormat("MMM dd, yyyy").format(DateTime.now()),
                            style: regularTxt),
                        Text("Today", style: medBoldTxt),
                      ],
                    ),
                  ),
                  Flexible(
                    flex: 4,
                    child: FlatButton.icon(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8)),
                      onPressed: () {
                        Get.to(AddTaskPage());
                      },
                      color: Colors.orange[900],
                      icon: Icon(
                        Icons.add,
                        color: Colors.white,
                      ),
                      label: Text("Add Task",
                          style: regularBoldTxt.copyWith(color: Colors.white)),
                    ),
                  )
                ],
              ),
              // const SizedBox(height: 15),
              // Container(
              //   decoration: BoxDecoration(
              //     color: Colors.grey[200],
              //     borderRadius: BorderRadius.circular(12),
              //   ),
              //   child: TextFormField(
              //     decoration: InputDecoration(
              //       hintText: "Search Task",
              //       hintStyle: regularTxt,
              //       prefixIcon: Icon(
              //         Icons.search,
              //         color: Colors.black,
              //       ),
              //       border: InputBorder.none,
              //     ),
              //   ),
              // ),
              const SizedBox(height: 25),
              buildDatesTabs(),
              Expanded(
                child: _getTabBarView(),
              )
            ],
          ),
        ),
      ),
    );
  }

  Container buildUserProfile() {
    return Container(
        width: 80,
        height: 80,
        margin: const EdgeInsets.all(5),
         padding: const EdgeInsets.all(15),
        decoration: BoxDecoration(
          color: AppConstants.appThemeColor.withOpacity(0.7),
          shape: BoxShape.circle,
        ),
        child: ClipOval(
          child: Image.asset(
            'assets/avatars/male_01.png',
            fit: BoxFit.fitHeight,
          ),
        ));
  }
}
