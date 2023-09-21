import 'package:car_app/model/dto/refuel_record_dto.dart';
import 'package:car_app/view/maintenance_view/refuel_record_view/refuel_history_view.dart';
import 'package:car_app/view/maintenance_view/refuel_record_view/refuel_record_add_view.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import '../../../main.dart';
import '../../../model/refuel_record_model.dart';
import '../../../repository/refuel_record_repository.dart';



class FuelRecord extends StatefulWidget {
  const FuelRecord({super.key});

  @override
  State<FuelRecord> createState() => _FuelRecordState();
}

class _FuelRecordState extends State<FuelRecord> {
  int _currentIndex = 0;

  void _onItemTapped(int index) => setState(() => _currentIndex = index);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: _currentIndex == 0
          ? const FuelRecordAddView()
          : const FuelHistoryView(),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
              icon: Icon(Icons.add_circle_outline_outlined), label: '記録'),
          BottomNavigationBarItem(
              icon: Icon(Icons.list_outlined), label: '給油履歴'),
        ],
        currentIndex: _currentIndex,
        fixedColor: Colors.blueAccent,
        onTap: _onItemTapped,
        type: BottomNavigationBarType.fixed,
      ),
    );
  }
}

class AddAlertDialogWidget extends StatelessWidget {
  const AddAlertDialogWidget({Key? key, required this.model}) : super(key: key);

  final RefuelRecordModel model;

  final RefuelRecordRepository repository = const RefuelRecordRepository();

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: Theme.of(context).colorScheme.background,
      title: Text(
        '登録します。',
        style: Theme.of(context)
            .textTheme
            .headlineSmall
            ?.apply(color: Theme.of(context).colorScheme.onBackground),
      ),
      content: Text(
        'よろしいですか？',
        style: Theme.of(context)
            .textTheme
            .bodyLarge
            ?.apply(color: Theme.of(context).colorScheme.onBackground),
      ),
      actions: <Widget>[
        GestureDetector(
          child: Text(
            'いいえ',
            style: Theme.of(context)
                .textTheme
                .bodyLarge
                ?.apply(color: Theme.of(context).colorScheme.onBackground),
          ),
          onTap: () {
            Navigator.pop(context);
          },
        ),
        GestureDetector(
          child: Text(
            'はい',
            style: Theme.of(context)
                .textTheme
                .bodyLarge
                ?.apply(color: Theme.of(context).colorScheme.onBackground),
          ),
          onTap: () {
            RefuelRecordDTO dto = RefuelRecordDTO.fromModel(model);
            repository.addData(dto.toMap());
          },
        ),
      ],
    );
  }
}

class DeleteAlertDialogWidget extends StatelessWidget {
  const DeleteAlertDialogWidget({Key? key, required this.document})
      : super(key: key);

  final DocumentSnapshot document;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: Theme.of(context).colorScheme.background,
      title: Text(
        '削除します。',
        style: Theme.of(context)
            .textTheme
            .headlineSmall
            ?.apply(color: Theme.of(context).colorScheme.onBackground),
      ),
      content: Text(
        'よろしいですか？',
        style: Theme.of(context)
            .textTheme
            .bodyLarge
            ?.apply(color: Theme.of(context).colorScheme.onBackground),
      ),
      actions: <Widget>[
        GestureDetector(
          child: Text(
            'いいえ',
            style: Theme.of(context)
                .textTheme
                .bodyLarge
                ?.apply(color: Theme.of(context).colorScheme.onBackground),
          ),
          onTap: () {
            Navigator.pop(context);
          },
        ),
        GestureDetector(
          child: Text(
            'はい',
            style: Theme.of(context)
                .textTheme
                .bodyLarge
                ?.apply(color: Theme.of(context).colorScheme.onBackground),
          ),
          onTap: () {
            db
                .collection('CAR_MAINTENANCE')
                .doc('REFUEL_RECORD')
                .collection('RECORDS')
                .doc(document.id)
                .delete();
            Navigator.pop(context);
            Navigator.pop(context);
          },
        )
      ],
    );
  }
}
