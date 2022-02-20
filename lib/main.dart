import 'package:flutter/material.dart';
import 'package:shate_m_plan_count/screens/current_statistics/current_statistics.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Shate-M plan count',
      theme: ThemeData.light(),
      home: const CurrentStatistics(),
    );
  }
}
