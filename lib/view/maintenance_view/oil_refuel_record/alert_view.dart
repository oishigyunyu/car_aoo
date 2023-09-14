
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import '../../../main.dart';
import '../../../model/dto/oil_refill_record_dto.dart';

class OilRefillDeleteAlertDialogWidget extends StatelessWidget {
  const OilRefillDeleteAlertDialogWidget({Key? key, required this.id})
      : super(key: key);

  final String id;

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
                .doc('OIL_REFILL_RECORD')
                .collection('RECORDS')
                .doc(id)
                .delete();
            Navigator.pop(context);
            Navigator.pop(context);
          },
        )
      ],
    );
  }
}


class AddOilAlertDialogWidget extends StatefulWidget {
  const AddOilAlertDialogWidget({Key? key, required this.dto}) : super(key: key);

  final OilRefillRecordDTO dto;

  @override
  State<AddOilAlertDialogWidget> createState() => _AddOilAlertDialogWidgetState();
}

class _AddOilAlertDialogWidgetState extends State<AddOilAlertDialogWidget> {
  Future<void> _addRecord(OilRefillRecordDTO dto, BuildContext context) async {
    try {
      final collectionRef = db
          .collection('CAR_MAINTENANCE')
          .doc('OIL_REFILL_RECORD')
          .collection('RECORDS');
      await collectionRef.doc().set({
        'refillDate': dto.date,
        'grade': dto.grade,
        'brandName': dto.brandName,
        'totalDistance': dto.totalDistance,
        'createdAt': DateTime.now()
      });
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
              },
              child: const Text('OK'),
            ),
          ],
        ),
      );
      FocusManager.instance.primaryFocus?.unfocus();
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
            Navigator.of(context).pop();
            _addRecord(widget.dto, context);
          },
        )
      ],
    );
  }
}

