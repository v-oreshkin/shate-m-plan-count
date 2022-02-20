import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:shate_m_plan_count/domain/hive_box_name.dart';

import '../../domain/models/daily_plan_model.dart';

class CurrentStatisticsModel extends ChangeNotifier{
  List<DailyPlan> _dailyPlanList = [];
  List<DailyPlan> get dailyPlan => _dailyPlanList;
  int planSum = 0;

  CurrentStatisticsModel(){
    _setup();
  }
  void _setup() async{
    final box = await Hive.openBox<DailyPlan>(HiveBox.dailyPlanBox);
    _getValues(box);
   box.listenable().addListener(() {
     _getValues(box);
   });
  }
  void _getValues(Box<DailyPlan> box){
    _dailyPlanList = box.values.toList();
    planSum = 0;
      for(DailyPlan plan in _dailyPlanList){
        planSum += plan.plan;
    }
      notifyListeners();
  }
}

class CurrentStatisticsModelProvider extends InheritedNotifier {
  const CurrentStatisticsModelProvider({
    Key? key,
    required Widget child,
    required this.model
  }) : super(key: key, child: child,notifier: model);
  final CurrentStatisticsModel model;

  static CurrentStatisticsModelProvider? watch(BuildContext context) {
    return context
        .dependOnInheritedWidgetOfExactType<CurrentStatisticsModelProvider>();
  }

  @override
  bool updateShouldNotify(covariant CurrentStatisticsModelProvider oldWidget) {
    return true;
  }

}