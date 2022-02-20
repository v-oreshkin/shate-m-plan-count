import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:shate_m_plan_count/domain/hive_box_name.dart';
import 'package:shate_m_plan_count/domain/models/daily_plan_model.dart';

class AddFormModel {
  int plan = 0;
  int floor = 0;
  DateTime time = DateTime.now();

  void addValue(BuildContext context, [FocusNode? focusNode]) async {
    DailyPlan dailyPlan =
        DailyPlan(plan, floor, time.toString().substring(0, 10));
    await Hive.box<DailyPlan>(HiveBox.dailyPlanBox).add(dailyPlan);
    if (focusNode != null) {
      focusNode.unfocus();
    } else {
      Navigator.pop(context);
    }
  }
}

class AddFormModelProvider extends InheritedWidget {
  final AddFormModel model;

  const AddFormModelProvider(
      {Key? key, required Widget child, required this.model})
      : super(key: key, child: child);

  static AddFormModelProvider obtain(BuildContext context) => context
      .getElementForInheritedWidgetOfExactType<AddFormModelProvider>()
      ?.widget as AddFormModelProvider;

  @override
  bool updateShouldNotify(AddFormModelProvider old) {
    return true;
  }
}
