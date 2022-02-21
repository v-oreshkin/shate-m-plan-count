import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:shate_m_plan_count/domain/hive_box_name.dart';
import 'package:shate_m_plan_count/domain/models/daily_plan_model.dart';

class HistoryModel extends ChangeNotifier{
List<DailyPlan> _dailyPlanList = [];
List<DailyPlan> get dailyPlanList => _dailyPlanList;

HistoryModel(){
  _setup();
}
void _getValue(Box<DailyPlan> box) {
_dailyPlanList = box.values.toList();
notifyListeners();
}

void _setup() async{
  Box<DailyPlan> box = await Hive.openBox<DailyPlan>(HiveBox.dailyPlanBox);
  _getValue(box);
  box.listenable().addListener(() {
    _getValue(box);
    notifyListeners();
  });
}

void clearBox() async{
  await Hive.box<DailyPlan>(HiveBox.dailyPlanBox).clear();
  notifyListeners();
}

void deletePlan(int index) async{
  await Hive.box<DailyPlan>(HiveBox.dailyPlanBox).deleteAt(index);
}
}

class HistoryModelProvider extends InheritedNotifier{
  final HistoryModel model;
  const HistoryModelProvider({
    Key? key,
    required Widget child,
    required this.model
  }) : super(key: key, child: child,notifier: model);

  static HistoryModelProvider? watch(BuildContext context) =>
      context.dependOnInheritedWidgetOfExactType<HistoryModelProvider>();

  @override
  bool updateShouldNotify(HistoryModelProvider oldWidget) {
    return true;
  }
}