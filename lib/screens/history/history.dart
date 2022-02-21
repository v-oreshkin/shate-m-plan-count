import 'package:flutter/material.dart';
import 'package:shate_m_plan_count/screens/history/history_provider.dart';

class History extends StatefulWidget {
  const History({Key? key}) : super(key: key);

  @override
  _HistoryState createState() => _HistoryState();
}

class _HistoryState extends State<History> {
  final model = HistoryModel();

  @override
  Widget build(BuildContext context) {
    return HistoryModelProvider(
        model: model,
        child: const _HistoryBody()
    );
  }
}

class _HistoryBody extends StatelessWidget {
  const _HistoryBody({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    //TODO scroll controller
    var controller = ScrollController();
    var model = HistoryModelProvider.watch(context)?.model;
    int? itemLength =
        model?.dailyPlanList.length;
    return Scaffold(
      appBar: AppBar(title: const Text('History'), actions: [
        IconButton(
            onPressed: () {
              model?.clearBox();
            },
            icon: const Icon(Icons.delete_rounded))
      ]),
      body: ListView.separated(
        controller: controller,
          itemBuilder: (context, index) =>
              _HistoryBodyRow(dailyPlanIndex: index),
          separatorBuilder: (context, index) => const Divider(),
          itemCount: itemLength!),
    );
  }
}

class _HistoryBodyRow extends StatelessWidget {
  final int dailyPlanIndex;

  const _HistoryBodyRow({Key? key, required this.dailyPlanIndex})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    var plan = HistoryModelProvider?.watch(context)
        ?.model
        .dailyPlanList[dailyPlanIndex];
    var model = HistoryModelProvider?.watch(context)?.model;
    return Dismissible(
      background: const ColoredBox(
        color: Colors.red,
      ),
      onDismissed: (direction) {
        model?.deletePlan(dailyPlanIndex);
      },
      key: ValueKey(dailyPlanIndex),
      child: ListTile(
          title: Text("${plan?.plan}"),
          subtitle: Text("${plan?.date}"),
          trailing: FittedBox(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Text(
                  '${plan?.floor}',
                  style: const TextStyle(fontSize: 18),
                ),
              ],
            ),
          )),
    );
  }
}
