import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hive/hive.dart';
import 'package:path_provider/path_provider.dart';
import 'package:xno_taskapp/model/hive/label.dart';
import 'package:xno_taskapp/model/hive/task.dart';
import 'package:xno_taskapp/model/hive/user.dart';
import 'package:xno_taskapp/ui/splash_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final appDocDir = await getApplicationDocumentsDirectory();

  // We initialize Hive and we give him the current path
  Hive.init(appDocDir.path);
  Hive.registerAdapter(TaskAdapter());
  Hive.registerAdapter(LabelAdapter());
  Hive.registerAdapter(UserAdapter());

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        fontFamily: 'Poppins',
      ),
      home: SplashPage(),
    );
  }
}
