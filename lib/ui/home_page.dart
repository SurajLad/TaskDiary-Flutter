import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:xno_taskapp/helpers/app_constants.dart';
import 'package:xno_taskapp/helpers/layout_helper.dart';
import 'package:xno_taskapp/helpers/text_styles.dart';

class HomePage extends StatelessWidget {
  DateTime startDate = DateTime.now();
  DateTime endDate = DateTime.now().add(const Duration(days: 5));

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: AppConstants.appBackgroundColor,
        body: Container(
          margin: const EdgeInsets.only(left: 28, top: 10),
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
              Container(
                margin: const EdgeInsets.only(right: 28),
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
              getTimeDateUI(),
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
