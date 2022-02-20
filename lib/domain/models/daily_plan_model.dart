import 'package:hive/hive.dart';

part 'daily_plan_model.g.dart';

@HiveType(typeId: 0)
class DailyPlan{
  @HiveField(0)
  final int plan;
  @HiveField(1)
  final int floor;
  @HiveField(2)
  final String date;

  DailyPlan(this.plan, this.floor, this.date);

  @override
  String toString() {
    return 'DailyPlan{plan: $plan, floor: $floor, date: $date}';
  }
}