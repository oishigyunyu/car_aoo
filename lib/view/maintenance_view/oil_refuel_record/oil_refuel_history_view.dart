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
        child: StreamBuilder<QuerySnapshot>(
            stream: db
                .collection('CAR_MAINTENANCE')
                .doc('OIL_REFILL_RECORD')
                .collection('RECORDS')
                .orderBy('refillDate', descending: true)
                .snapshots(),
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
                  return Column(
                    children: snapshot.data!.docs.map((DocumentSnapshot document) {
                      return Card(
                        color: Theme.of(context).colorScheme.primary,
                        child: ListTile(
                          title: Text(
                            fromDate(document.get('refillDate').toDate()),
                            style: Theme.of(context).textTheme.labelLarge?.apply(
                                color: Theme.of(context).colorScheme.onPrimary),
                          ),
                          subtitle: Text(
                            '総走行距離: ${document.get('totalDistance')}km',
                            style: Theme.of(context).textTheme.labelMedium?.apply(
                                color: Theme.of(context).colorScheme.onPrimary),
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
            }),
      ),
    );
  }
}

class OilRefillHistoryDetail extends StatelessWidget {
  const OilRefillHistoryDetail({super.key, required this.document});

  final DocumentSnapshot document;

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
            Card(
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
                        color: Theme.of(context)
                            .colorScheme
                            .onPrimaryContainer,
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
                                  style: Theme.of(context)
                                      .textTheme
                                      .titleLarge
                                      ?.apply(
                                      color: Theme.of(context)
                                          .colorScheme
                                          .onSecondaryContainer),
                                ),
                                Text(
                                  '銘柄',
                                  style: Theme.of(context)
                                      .textTheme
                                      .titleLarge
                                      ?.apply(
                                      color: Theme.of(context)
                                          .colorScheme
                                          .onSecondaryContainer),
                                ),
                                Text(
                                  '総走行距離',
                                  style: Theme.of(context)
                                      .textTheme
                                      .titleLarge
                                      ?.apply(
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
                                  style: Theme.of(context)
                                      .textTheme
                                      .titleLarge
                                      ?.apply(
                                      color: Theme.of(context)
                                          .colorScheme
                                          .onSecondaryContainer),
                                ),
                                Text(
                                  '${document.get('brandName')}',
                                  style: Theme.of(context)
                                      .textTheme
                                      .titleLarge
                                      ?.apply(
                                      color: Theme.of(context)
                                          .colorScheme
                                          .onSecondaryContainer),
                                ),
                                Text(
                                  '${document.get('totalDistance')}',
                                  style: Theme.of(context)
                                      .textTheme
                                      .titleLarge
                                      ?.apply(
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
                                  style: Theme.of(context)
                                      .textTheme
                                      .titleLarge
                                      ?.apply(
                                      color: Theme.of(context)
                                          .colorScheme
                                          .onSecondaryContainer),
                                ),
                                Text(
                                  '',
                                  style: Theme.of(context)
                                      .textTheme
                                      .titleLarge
                                      ?.apply(
                                      color: Theme.of(context)
                                          .colorScheme
                                          .onSecondaryContainer),
                                ),
                                Text(
                                  '[km]',
                                  style: Theme.of(context)
                                      .textTheme
                                      .titleLarge
                                      ?.apply(
                                      color: Theme.of(context)
                                          .colorScheme
                                          .onSecondaryContainer),
                                ),
                              ],
                            ),
                          ],
                        ))
                  ],
                ),
              ),
            ),
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
                            return OilRefillDeleteAlertDialogWidget(
                                document: document);
                          });
                    },
                  ),
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
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}