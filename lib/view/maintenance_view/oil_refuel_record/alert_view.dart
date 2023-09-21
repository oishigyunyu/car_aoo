
import 'package:car_app/repository/oil_refill_record_repository.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import '../../../model/dto/oil_refill_record_dto.dart';

class AddOilAlertDialogWidget extends StatefulWidget {
  const AddOilAlertDialogWidget({Key? key, required this.dto}) : super(key: key);

  final OilRefillRecordDTO dto;

  @override
  State<AddOilAlertDialogWidget> createState() => _AddOilAlertDialogWidgetState();
}

class _AddOilAlertDialogWidgetState extends State<AddOilAlertDialogWidget> {

  OilRefillRecordRepository repository = const OilRefillRecordRepository();

  Future<void> _addRecord(OilRefillRecordDTO dto, BuildContext context) async {
    try {
      repository.addData(dto.toMap());
      if (!mounted) {
        return;
      }
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: const Text('データが保存されました'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
                Navigator.of(context).pop();
              },
              child: const Text('OK'),
            ),
          ],
        ),
      );


    } on FirebaseException catch (e) {
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: const Text('データの保存に失敗しました'),
          content: Text(e.message.toString()),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('OK'),
            ),
          ],
        ),
      );
    }
  }

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
            FocusManager.instance.primaryFocus?.unfocus();
            _addRecord(widget.dto, context);
          },
        )
      ],
    );
  }
}

