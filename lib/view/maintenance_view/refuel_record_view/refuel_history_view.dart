import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import '../../../main.dart';
import '../../../utils/date_format.dart';
import 'refuel_record_view.dart';

class FuelHistoryView extends StatelessWidget {
  const FuelHistoryView({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return SafeArea(
      child: Container(
        height: size.height,
        width: size.width,
        padding: const EdgeInsets.all(8.0),
        child: const SingleChildScrollView(
          child: RefuelHistories(),
        ),
      ),
    );
  }
}

class RefuelHistories extends StatelessWidget {
  const RefuelHistories({super.key});

  Widget _buildHistoryCardWidget(
      BuildContext context, DocumentSnapshot document) {
    return Card(
      color: Theme.of(context).colorScheme.primary,
      child: ListTile(
        title: Text(
          fromDate(document.get('refuelDate').toDate()),
          style: Theme.of(context)
              .textTheme
              .labelLarge
              ?.apply(color: Theme.of(context).colorScheme.onPrimary),
        ),
        subtitle: Text(
          '走行距離: ${document.get('droveDistanceFromLastRefuel')}km',
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
              builder: (context) => HistoryDetail(document: document),
            ),
          );
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
        stream: db
            .collection('CAR_MAINTENANCE')
            .doc('REFUEL_RECORD')
            .collection('RECORDS')
            .orderBy('refuelDate', descending: true)
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
                  return _buildHistoryCardWidget(context, document);
                }).toList(),
              );
          }
        });
  }
}

class HistoryDetail extends StatelessWidget {
  const HistoryDetail({super.key, required this.document});

  final DocumentSnapshot document;

  Widget _buildFieldNameWidget(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      crossAxisAlignment: CrossAxisAlignment.end,
      children: <Widget>[
        Text(
          '給油量',
          style: Theme.of(context).textTheme.titleLarge?.apply(
              color: Theme.of(context).colorScheme.onSecondaryContainer),
        ),
        Text(
          '1リットル単価',
          style: Theme.of(context).textTheme.titleLarge?.apply(
              color: Theme.of(context).colorScheme.onSecondaryContainer),
        ),
        Text(
          '走行距離',
          style: Theme.of(context).textTheme.titleLarge?.apply(
              color: Theme.of(context).colorScheme.onSecondaryContainer),
        ),
      ],
    );
  }

  Widget _buildDataWidget(BuildContext context, DocumentSnapshot document) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      crossAxisAlignment: CrossAxisAlignment.end,
      children: <Widget>[
        Text(
          '${document.get('fuelQuantity')}',
          style: Theme.of(context).textTheme.titleLarge?.apply(
              color: Theme.of(context).colorScheme.onSecondaryContainer),
        ),
        Text(
          '${document.get('unitPrice')}',
          style: Theme.of(context).textTheme.titleLarge?.apply(
              color: Theme.of(context).colorScheme.onSecondaryContainer),
        ),
        Text(
          '${document.get('droveDistanceFromLastRefuel')}',
          style: Theme.of(context).textTheme.titleLarge?.apply(
              color: Theme.of(context).colorScheme.onSecondaryContainer),
        ),
      ],
    );
  }

  Widget _buildUnitWidget(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      crossAxisAlignment: CrossAxisAlignment.end,
      children: <Widget>[
        Text(
          '[L]',
          style: Theme.of(context).textTheme.titleLarge?.apply(
              color: Theme.of(context).colorScheme.onSecondaryContainer),
        ),
        Text(
          '[¥/L]',
          style: Theme.of(context).textTheme.titleLarge?.apply(
              color: Theme.of(context).colorScheme.onSecondaryContainer),
        ),
        Text(
          '[km]',
          style: Theme.of(context).textTheme.titleLarge?.apply(
              color: Theme.of(context).colorScheme.onSecondaryContainer),
        ),
      ],
    );
  }

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
                      '給油日: ${fromDate(document.get('refuelDate').toDate())}',
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
                          _buildFieldNameWidget(context),
                          _buildDataWidget(context, document),
                          _buildUnitWidget(context),
                        ],
                      ),
                    ),
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
                      backgroundColor: Theme.of(context).colorScheme.secondary,
                      foregroundColor:
                          Theme.of(context).colorScheme.onSecondary,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                    ),
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
                            return DeleteAlertDialogWidget(document: document);
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
            ),
          ],
        ),
      ),
    );
  }
}
