import 'package:flutter/material.dart';
import 'package:shate_m_plan_count/domain/pages_path.dart';

class CurrentStatistics extends StatefulWidget {
  const CurrentStatistics({Key? key}) : super(key: key);

  @override
  _CurrentStatisticsState createState() => _CurrentStatisticsState();
}

class _CurrentStatisticsState extends State<CurrentStatistics> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Current statistics'),
      ),
      body: const Statistics(),
      floatingActionButton: FloatingActionButton(
        onPressed: (){
          Navigator.of(context).pushNamed(PagesPath.addPlanForm);
        },
        child: const Icon(Icons.add)
      )
    );
  }
}

class Statistics extends StatelessWidget {
  const Statistics({Key? key}) : super(key: key);
  static const sizedBox25 = SizedBox(
    height: 25,
  );

  @override
  Widget build(BuildContext context) {
    return UnconstrainedBox(
      constrainedAxis: Axis.horizontal,
      child: Card(
        elevation: 10,
        child: Column(
          children: [
            Image.asset('assets/logo/logo.png'),
            sizedBox25,
            const Text("You have to do : 10000"),
            sizedBox25,
            const Text('You have made : 1459'),
            sizedBox25,
            ElevatedButton(
                onPressed: (){},
                child: const Text('Look history')
            ),
            sizedBox25
          ]
        )
      ),
    );
  }
}
