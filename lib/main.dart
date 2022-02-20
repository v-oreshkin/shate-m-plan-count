import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:shate_m_plan_count/domain/hive_box_name.dart';
import 'package:shate_m_plan_count/domain/pages_path.dart';
import 'package:shate_m_plan_count/screens/add_form/add_plan_form.dart';
import 'package:shate_m_plan_count/screens/current_statistics/current_statistics.dart';

import 'domain/models/daily_plan_model.dart';

void main() async{
  await Hive.initFlutter();
  Hive.registerAdapter(DailyPlanAdapter());
  await Hive.openBox<DailyPlan>(HiveBox.dailyPlanBox);
  await Hive.box<DailyPlan>(HiveBox.dailyPlanBox).clear();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Shate-M plan count',
      theme: ThemeData.light(),
      initialRoute: PagesPath.currentStatistics,
      routes: {
        PagesPath.currentStatistics:(context)=>const CurrentStatistics(),
        PagesPath.addPlanForm:(context)=> const AddPlanForm()
      }
    );
  }
}
