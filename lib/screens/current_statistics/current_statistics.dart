import 'package:flutter/material.dart';
import 'package:shate_m_plan_count/domain/pages_path.dart';
import 'package:shate_m_plan_count/screens/current_statistics/current_statistics_provider.dart';


class CurrentStatistics extends StatefulWidget {
  const CurrentStatistics({Key? key}) : super(key: key);

  @override
  _CurrentStatisticsState createState() => _CurrentStatisticsState();
}

class _CurrentStatisticsState extends State<CurrentStatistics> {
  final model = CurrentStatisticsModel();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Current statistics'),
        ),
        body: CurrentStatisticsModelProvider(
            model: model,
            child: const Statistics()),
        floatingActionButton: FloatingActionButton(
            onPressed: () {
              Navigator.of(context).pushNamed(PagesPath.addPlanForm);
            },
            child: const Icon(Icons.add)));
  }
}

class Statistics extends StatefulWidget {
  const Statistics({Key? key}) : super(key: key);
  static const sizedBox25 = SizedBox(
    height: 25,
  );

  @override
  State<Statistics> createState() => _StatisticsState();
}

class _StatisticsState extends State<Statistics> {
  @override
  Widget build(BuildContext context) {
    var model = CurrentStatisticsModelProvider.watch(context)?.model;
    var sum = model?.planSum;
    var salary = model?.salary;

    String haveToDone() => !(sum! >= 10000) ?'${10000 - sum!}' : 'You\'ve done plan))';

    return UnconstrainedBox(
      constrainedAxis: Axis.horizontal,
      child: Card(
          elevation: 10,
          child: Column(children: [
            Image.asset('assets/logo/logo.png'),
            Statistics.sizedBox25,
            const Text("Month plan : 10000"),
            Statistics.sizedBox25,
            Text('My current plan : $sum'),
            Statistics.sizedBox25,
            Text("${sum! < 10000 ? "Have to done: ${haveToDone()}" : haveToDone()} "),
            Statistics.sizedBox25,
            Text('Earn : $salary'),
            Statistics.sizedBox25,
            ElevatedButton(
                onPressed: () {
                  Navigator.of(context).pushNamed(PagesPath.history);
                },
                child: const Text('Look history')
            ),
            Statistics.sizedBox25
          ])),
    );
  }
}

