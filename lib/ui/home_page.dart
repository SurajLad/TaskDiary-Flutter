import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hive_flutter/hive_flutter.dart';
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

  @override
  void initState() {
    super.initState();
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
      children: List.generate(
        endDate.difference(startDate).inDays,
        (dayIndex) => Column(
          children: [
            WatchBoxBuilder(
              box: LayoutHelper.instance.taskList,
              builder: (context, box) {
                Map<dynamic, dynamic> raw = box.toMap();
                List list = raw.values.toList();
                return ListView.builder(
                  shrinkWrap: true,
                  itemCount: list.length,
                  itemBuilder: (context, index) {
                    Task personModel = list[index];
                    if (personModel.date.day ==
                        DateTime(startDate.year, startDate.month,
                                startDate.day + (dayIndex))
                            .day) {
                      return buildTaskCard(personModel);
                    }
                    return buildNoTasksVector();
                  },
                );
              },
            ),
          ],
        ),
      ),
      controller: tabController,
    );
  }

  Container buildTaskCard(Task personModel) {
    return Container(
      decoration: BoxDecoration(color: Colors.white),
      child: Text(personModel.name),
    );
  }

  Column buildNoTasksVector() {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Image.asset(
          'assets/no_task_vector.png',
          height: LayoutHelper.instance.width / 1.65,
        ),
        Text("No Tasks for today", style: medBoldTxt),
      ],
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
                    flex: 3,
                    child: Image.asset('assets/profile_vector.png'),
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
              const SizedBox(height: 15),
              Container(
                decoration: BoxDecoration(
                  color: Colors.grey[200],
                  borderRadius: BorderRadius.circular(12),
                ),
                child: TextFormField(
                  decoration: InputDecoration(
                    hintText: "Search Task",
                    hintStyle: regularTxt,
                    prefixIcon: Icon(
                      Icons.search,
                      color: Colors.black,
                    ),
                    border: InputBorder.none,
                  ),
                ),
              ),
              const SizedBox(height: 15),
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
}
