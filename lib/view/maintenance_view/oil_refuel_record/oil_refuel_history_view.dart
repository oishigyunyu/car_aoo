import 'package:car_app/Repository/oil_refill_record_repository.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import '../../../main.dart';
import '../../../utils/date_format.dart';
import 'alert_view.dart';

class OilRefillHistoryView extends StatelessWidget {
  const OilRefillHistoryView({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return SafeArea(
      child: Container(
        height: size.height,
        width: size.width,
        padding: const EdgeInsets.all(8.0),
        child: _buildStreamBuilder(context),
      ),
    );
  }

  Widget _buildStreamBuilder(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: _getStream(),
      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (snapshot.hasError) {
          return Text('Error ${snapshot.error}');
        }
        switch (snapshot.connectionState) {
          case ConnectionState.waiting:
            return const Center(
              child: Text('loading...'),
            );
          default:
            return _buildListTile(context, snapshot);
        }
      },
    );
  }

  Stream<QuerySnapshot> _getStream() {
    return db
        .collection('CAR_MAINTENANCE')
        .doc('OIL_REFILL_RECORD')
        .collection('RECORDS')
        .orderBy('refillDate', descending: true)
        .snapshots();
  }

  Widget _buildListTile(
      BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
    return Column(
      children: snapshot.data!.docs.map((DocumentSnapshot document) {
        return Card(
          color: Theme.of(context).colorScheme.primary,
          child: ListTile(
            title: Text(
              fromDate(document.get('refillDate').toDate()),
              style: Theme.of(context)
                  .textTheme
                  .labelLarge
                  ?.apply(color: Theme.of(context).colorScheme.onPrimary),
            ),
            subtitle: Text(
              '総走行距離: ${document.get('totalDistance')}km',
              style: Theme.of(context)
                  .textTheme
                  .labelMedium
                  ?.apply(color: Theme.of(context).colorScheme.onPrimary),
            ),
            trailing: Icon(
              Icons.note_outlined,
              color: Theme.of(context).colorScheme.onPrimary,
            ),
            onTap: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) =>
                      OilRefillHistoryDetail(document: document),
                ),
              );
            },
          ),
        );
      }).toList(),
    );
  }
}

class OilRefillHistoryDetail extends StatelessWidget {
  const OilRefillHistoryDetail({super.key, required this.document});

  final DocumentSnapshot document;
  final OilRefillRecordRepository repository =
      const OilRefillRecordRepository();

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(),
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            _buildDetailInformation(context, document),
            Container(
              padding: const EdgeInsets.all(8.0),
              height: (size.height / 2.0) * 0.3,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        backgroundColor:
                            Theme.of(context).colorScheme.secondary,
                        foregroundColor:
                            Theme.of(context).colorScheme.onSecondary,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10.0),
                        )),
                    child: Container(
                      height: (size.height / 2.0) * 0.2,
                      width: (size.width / 2.0) * 0.6,
                      child: const Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: <Widget>[
                          Icon(
                            Icons.edit,
                          ),
                          Text(
                            '修正',
                          ),
                        ],
                      ),
                    ),
                    onPressed: () {
                      print('tapped');
                    },
                  ),
                  _buildDeleteButton(
                      context, document.id, repository),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget _buildDetailInformation(
      BuildContext context, DocumentSnapshot document) {
    final size = MediaQuery.of(context).size;
    return Card(
      color: Theme.of(context).colorScheme.primaryContainer,
      child: Container(
        padding: const EdgeInsets.all(8.0),
        height: size.height / 2.0,
        width: size.width,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            Text(
              '交換日: ${fromDate(document.get('refillDate').toDate())}',
              style: Theme.of(context).textTheme.headlineSmall?.apply(
                    color: Theme.of(context).colorScheme.onPrimaryContainer,
                  ),
            ),
            Container(
              padding: const EdgeInsets.all(8.0),
              height: (size.height / 2.0) * 0.8,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: <Widget>[
                      Text(
                        'グレード',
                        style: Theme.of(context).textTheme.titleLarge?.apply(
                            color: Theme.of(context)
                                .colorScheme
                                .onSecondaryContainer),
                      ),
                      Text(
                        '銘柄',
                        style: Theme.of(context).textTheme.titleLarge?.apply(
                            color: Theme.of(context)
                                .colorScheme
                                .onSecondaryContainer),
                      ),
                      Text(
                        '総走行距離',
                        style: Theme.of(context).textTheme.titleLarge?.apply(
                            color: Theme.of(context)
                                .colorScheme
                                .onSecondaryContainer),
                      ),
                    ],
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: <Widget>[
                      Text(
                        '${document.get('grade')}',
                        style: Theme.of(context).textTheme.titleLarge?.apply(
                            color: Theme.of(context)
                                .colorScheme
                                .onSecondaryContainer),
                      ),
                      Text(
                        '${document.get('brandName')}',
                        style: Theme.of(context).textTheme.titleLarge?.apply(
                            color: Theme.of(context)
                                .colorScheme
                                .onSecondaryContainer),
                      ),
                      Text(
                        '${document.get('totalDistance')}',
                        style: Theme.of(context).textTheme.titleLarge?.apply(
                            color: Theme.of(context)
                                .colorScheme
                                .onSecondaryContainer),
                      ),
                    ],
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: <Widget>[
                      Text(
                        '',
                        style: Theme.of(context).textTheme.titleLarge?.apply(
                            color: Theme.of(context)
                                .colorScheme
                                .onSecondaryContainer),
                      ),
                      Text(
                        '',
                        style: Theme.of(context).textTheme.titleLarge?.apply(
                            color: Theme.of(context)
                                .colorScheme
                                .onSecondaryContainer),
                      ),
                      Text(
                        '[km]',
                        style: Theme.of(context).textTheme.titleLarge?.apply(
                            color: Theme.of(context)
                                .colorScheme
                                .onSecondaryContainer),
                      ),
                    ],
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget _buildDeleteButton(
      BuildContext context, String id, OilRefillRecordRepository repository) {
    final size = MediaQuery.of(context).size;
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        backgroundColor: Theme.of(context).colorScheme.secondary,
        foregroundColor: Theme.of(context).colorScheme.onSecondary,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
      ),
      child: SizedBox(
        height: (size.height / 2.0) * 0.2,
        width: (size.width / 2.0) * 0.6,
        child: const Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Icon(
              Icons.delete_outline,
            ),
            Text(
              '削除',
            ),
          ],
        ),
      ),
      onPressed: () {
        showDialog<void>(
          context: context,
          builder: (_) {
            return DeleteDialogWidget(id: id, repository: repository,);
          },
        );
      },
    );
  }
}

class DeleteDialogWidget extends StatefulWidget {
  const DeleteDialogWidget({super.key, required this.id, required this.repository});

  final String id;
  final OilRefillRecordRepository repository;

  @override
  State<DeleteDialogWidget> createState() => _DeleteDialogWidgetState();
}

class _DeleteDialogWidgetState extends State<DeleteDialogWidget> {

  Future _successDialog() {
    return showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('データが削除されました'),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
              Navigator.of(context).pop();
              Navigator.of(context).pop();
            },
            child: const Text('OK'),
          ),
        ],
      ),
    );
  }

  Future _failDialog(FirebaseException e) {
    return showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('データの削除に失敗しました'),
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
            style: Theme.of(context).textTheme.bodyLarge?.apply(
                color: Theme.of(context).colorScheme.onBackground),
          ),
          onTap: () {
            Navigator.pop(context);
          },
        ),
        GestureDetector(
          child: Text(
            'はい',
            style: Theme.of(context).textTheme.bodyLarge?.apply(
                color: Theme.of(context).colorScheme.onBackground),
          ),
          onTap: () {
            try{
              widget.repository.deleteData(widget.id);

              if(!mounted) {
                return;
              }
              _successDialog();
            } on FirebaseException catch (e) {
              _failDialog(e);
            }

          },
        ),
      ],
    );
  }
}
