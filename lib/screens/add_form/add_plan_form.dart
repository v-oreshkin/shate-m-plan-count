import 'package:flutter/material.dart';

import 'add_plan_form_provider.dart';

class AddPlanForm extends StatefulWidget {
  const AddPlanForm({Key? key}) : super(key: key);

  @override
  _AddPlanFormState createState() => _AddPlanFormState();
}

class _AddPlanFormState extends State<AddPlanForm> {
  final model = AddFormModel();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Add plan'),
        ),
        body: AddFormModelProvider(
            model: model,
            child: const _AddPlanFormBody()
        )
    );
  }
}

class _AddPlanFormBody extends StatelessWidget {
  const _AddPlanFormBody({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var inheritModel = AddFormModelProvider.obtain(context).model;
    int userInput = 0;
    var focus = FocusNode();
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 25),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          TextField(
            focusNode: focus,
            autofocus: true,
            keyboardType: TextInputType.number,
            decoration: const InputDecoration(border: OutlineInputBorder()),
            onSubmitted: (userInput) {
              inheritModel.plan = int.parse(userInput);
              focus.unfocus();
            },
            onChanged: (userInputLocal) {
              userInput = int.parse(userInputLocal);
            },
          ),
          const SizedBox(height: 15),
          Row(children: [
            Expanded(child: Container()),
            const _PopupChooseFloor()
          ]),
          const SizedBox(height: 15),
          Row(mainAxisAlignment: MainAxisAlignment.end, children: [
            ElevatedButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: const Text('Cancel')),
            const SizedBox(width: 30),
            ElevatedButton(
                onPressed: () {
                  inheritModel.plan = userInput;
                  inheritModel.addValue(context);
                },
                child: const Text('Save value'))
          ])
        ],
      ),
    );
  }
}

class _PopupChooseFloor extends StatefulWidget {
  const _PopupChooseFloor({
    Key? key,
  }) : super(key: key);

  @override
  State<_PopupChooseFloor> createState() => _PopupChooseFloorState();
}

class _PopupChooseFloorState extends State<_PopupChooseFloor> {
  int? floor;
  static const TextStyle textStyle = TextStyle(fontSize: 18);

  @override
  Widget build(BuildContext context) {
    var model = AddFormModelProvider.obtain(context).model;
    return Container(
      alignment: AlignmentDirectional.center,
      height: 30,
      width: 100,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(3),
        border: Border.all(
          width: 2,
          color: ThemeData().colorScheme.primary
        )
      ),
      child: PopupMenuButton(
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(10))
        ),
          onSelected: (val) {
            model.floor = val as int;
          },
          child: Text(
              (floor == null) ? 'Choose floor' : '$floor',
            style: textStyle
          ),
          itemBuilder: (context) => <PopupMenuItem>[
                buildPopupMenuItem(1),
                buildPopupMenuItem(2),
                buildPopupMenuItem(3),
                buildPopupMenuItem(4),
                buildPopupMenuItem(5)
              ]),
    );
  }

  PopupMenuItem<dynamic> buildPopupMenuItem(int localFloor) {
    return PopupMenuItem(
        onTap: () {
          setState(() {
            floor = localFloor;
          });
        },
        child: Text(
            '$localFloor',
          style: textStyle,
        ),
        value: localFloor
    );
  }
}
