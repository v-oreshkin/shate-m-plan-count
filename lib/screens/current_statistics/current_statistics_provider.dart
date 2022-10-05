import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:shate_m_plan_count/domain/hive_box_name.dart';

import '../../domain/models/daily_plan_model.dart';

class CurrentStatisticsModel extends ChangeNotifier {
  List<DailyPlan> _dailyPlanList = [];

  List<DailyPlan> get dailyPlan => _dailyPlanList;
  int planSum = 0;
  int salary = 0;
  static const double generalFloorPrice = 0.10;
  static const double firstFloorPrice = 0.25;
  int _bonus = 0;

  CurrentStatisticsModel() {
    _setup();
  }

  void _setup() async {
    final box = await Hive.openBox<DailyPlan>(HiveBox.dailyPlanBox);
    _getValues(box);
    _setSalary(box);
    box.listenable().addListener(() {
      _bonus = _setBonus(planSum);
      _setSalary(box);
      _getValues(box);
    });
  }

  void _getValues(Box<DailyPlan> box) {
    _dailyPlanList = box.values.toList();
    planSum = 0;
    for (DailyPlan plan in _dailyPlanList) {
      planSum += plan.plan;
    }
    _bonus = _setBonus(planSum);
    notifyListeners();
  }

  void _setSalary(Box<DailyPlan> box) {
    _dailyPlanList = box.values.toList();
    salary = 0 + _bonus;
    for (DailyPlan plan in _dailyPlanList) {
      if (plan.floor == 1) {
        salary += (plan.plan * firstFloorPrice).toInt();
      } else {
        salary += (plan.plan * generalFloorPrice).toInt();
      }
    }
    notifyListeners();
  }

  int _setBonus(int countOfStrings) {
    int price = 0;
    if (countOfStrings > 10000 || countOfStrings == 10000) {
      price = 500;
    } else if (countOfStrings >= 11000) {
      price = 550;
    } else if (countOfStrings >= 12000) {
      price = 600;
    }
    return price;
    notifyListeners();
  }
}

class CurrentStatisticsModelProvider extends InheritedNotifier {
  const CurrentStatisticsModelProvider(
      {Key? key, required Widget child, required this.model})
      : super(key: key, child: child, notifier: model);
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
