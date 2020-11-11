import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:xno_taskapp/helpers/app_constants.dart';
import 'package:xno_taskapp/helpers/layout_helper.dart';
import 'package:xno_taskapp/helpers/text_styles.dart';
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

  TabBar _getTabBar() {
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
      children: List.generate(endDate.difference(startDate).inDays,
          (index) => Center(child: Text(index.toString()))),
      controller: tabController,
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
                        Get.off(AddTaskPage());
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
              //  getTimeDateUI(),
              _getTabBar(),
              Container(
                height: 100,
                child: _getTabBarView(),
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget getTimeDateUI() {
    return Container(
      width: LayoutHelper.instance.width,
      margin: const EdgeInsets.only(top: 10),
      height: 60,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        itemCount: endDate.difference(startDate).inDays,
        separatorBuilder: (context, index) {
          return Padding(
            padding: const EdgeInsets.all(8),
            child: Container(
              width: 1,
              height: 52,
              color: Colors.grey.withOpacity(0.8),
            ),
          );
        },
        itemBuilder: (BuildContext context, int index) {
          return Material(
            color: Colors.transparent,
            child: InkWell(
              focusColor: Colors.transparent,
              highlightColor: Colors.transparent,
              hoverColor: Colors.transparent,
              splashColor: Colors.grey.withOpacity(0.2),
              borderRadius: const BorderRadius.all(
                Radius.circular(4.0),
              ),
              onTap: () {
                FocusScope.of(Get.context).requestFocus(FocusNode());
                print(index);
              },
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Container(
                    padding: const EdgeInsets.fromLTRB(10, 10, 10, 5),
                    child: Text(
                      '${DateFormat("dd\nMMM").format(DateTime(startDate.year, startDate.month, startDate.day + (index)))}',
                      textAlign: TextAlign.center,
                    ),
                  ),
                  Visibility(
                    visible: index == 0,
                    child: Container(
                      width: 15,
                      height: 2,
                      color: AppConstants.appThemeColor,
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
