import 'package:car_app/utils/date_format.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_datetime_picker_plus/flutter_datetime_picker_plus.dart';
import 'package:intl/intl.dart';

import '../main.dart';

class FuelRecordModel {
  FuelRecordModel(
      {required this.date,
      required this.fuelQuantity,
      required this.unitPrice,
      required this.droveDistanceFromLastRefuel});

  String _id = '';
  final DateTime date;
  final double fuelQuantity;
  final double unitPrice;
  final double droveDistanceFromLastRefuel;
  late final DateTime createdAt = DateTime.now();

  set id(String s) {
    if (s.isNotEmpty) {
      _id = s;
    } else {
      print('id値が不正です。 $s');
    }
  }
}

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
    final size = MediaQuery.of(context).size;
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
  const AddAlertDialogWidget({Key? key, required this.dto}) : super(key: key);

  final FuelRecordModel dto;

  Future<void> _addRecord(FuelRecordModel dto) async {
    final collectionRef = db
        .collection('CAR_MAINTENANCE')
        .doc('REFUEL_RECORD')
        .collection('RECORDS');
    await collectionRef.doc().set({
      'refuelDate': dto.date,
      'fuelQuantity': dto.fuelQuantity,
      'unitPrice': dto.unitPrice,
      'droveDistanceFromLastRefuel': dto.droveDistanceFromLastRefuel,
      'createdAt': DateTime.now()
    });
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
            _addRecord(dto).then((value) {
              print('data added');
              Navigator.pop(context);
              FocusManager.instance.primaryFocus?.unfocus();
            }).catchError((error) => 'failed to add data: $error');
          },
        )
      ],
    );
  }
}

class FuelRecordAddView extends StatefulWidget {
  const FuelRecordAddView({super.key});

  @override
  State<FuelRecordAddView> createState() => _FuelRecordAddViewState();
}

class _FuelRecordAddViewState extends State<FuelRecordAddView> {
  final _formKey = GlobalKey<FormState>();

  DateTime _date = DateTime.now();
  final DateFormat _dateFormat = DateFormat('yyyy年MM月dd日');
  double _fuelQuantity = 0.0;
  double _unitPrice = 0.0;
  double _droveDistanceFromLastRefuel = 0.0;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return SafeArea(
      child: Container(
        height: size.height,
        width: size.width,
        padding: const EdgeInsets.all(8.0),
        color: Theme.of(context).colorScheme.background,
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Text(
                    _dateFormat.format(_date),
                    style: Theme.of(context).textTheme.labelLarge?.apply(
                          color: Theme.of(context).colorScheme.onBackground,
                        ),
                  ),
                  TextButton(
                    style: TextButton.styleFrom(
                      backgroundColor: Theme.of(context).colorScheme.secondary,
                      shape: const RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(
                          Radius.circular(10.0),
                        ),
                      ),
                    ),
                    onPressed: () {
                      DatePicker.showDatePicker(
                        context,
                        showTitleActions: true,
                        minTime: DateTime(2023, 1, 1),
                        maxTime: DateTime(2099, 12, 31),
                        onChanged: (date) {
                          setState(() {
                            _date = date;
                          });
                        },
                        currentTime: DateTime.now(),
                        locale: LocaleType.jp,
                      );
                    },
                    child: Text(
                      '日付を選択',
                      style: Theme.of(context).textTheme.labelLarge?.apply(
                          color: Theme.of(context).colorScheme.onSecondary),
                    ),
                  ),
                ],
              ),
              TextFormField(
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return '給油量を正しく入力してください';
                  }
                  return null;
                },
                style: Theme.of(context).textTheme.labelLarge?.apply(
                      color: Theme.of(context).colorScheme.onPrimary,
                    ),
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  fillColor: Theme.of(context).colorScheme.primary,
                  filled: true,
                  border: const OutlineInputBorder(),
                  hintText: '給油量[L]',
                  hintStyle: Theme.of(context).textTheme.labelLarge?.apply(
                        color: Theme.of(context).colorScheme.onPrimary,
                      ),
                ),
                onChanged: (value) {
                  setState(() {
                    _fuelQuantity = double.tryParse(value) ?? 0.0;
                  });
                },
              ),
              TextFormField(
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return '単価を正しく入力してください';
                  }
                  return null;
                },
                style: Theme.of(context).textTheme.labelLarge?.apply(
                      color: Theme.of(context).colorScheme.onPrimary,
                    ),
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  fillColor: Theme.of(context).colorScheme.primary,
                  filled: true,
                  border: const OutlineInputBorder(),
                  hintText: '単価[円/L]',
                  hintStyle: Theme.of(context).textTheme.labelLarge?.apply(
                        color: Theme.of(context).colorScheme.onPrimary,
                      ),
                ),
                onChanged: (value) {
                  setState(() {
                    _unitPrice = double.parse(value);
                  });
                },
              ),
              TextFormField(
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return '走行距離を正しく入力してください';
                  }
                  return null;
                },
                style: Theme.of(context).textTheme.labelLarge?.apply(
                      color: Theme.of(context).colorScheme.onPrimary,
                    ),
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  fillColor: Theme.of(context).colorScheme.primary,
                  filled: true,
                  border: const OutlineInputBorder(),
                  hintText: '前回給油からの走行距離[km]',
                  hintStyle: Theme.of(context).textTheme.labelLarge?.apply(
                        color: Theme.of(context).colorScheme.onPrimary,
                      ),
                ),
                onChanged: (value) {
                  setState(() {
                    _droveDistanceFromLastRefuel = double.parse(value);
                  });
                },
              ),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Theme.of(context).colorScheme.secondary,
                  foregroundColor: Theme.of(context).colorScheme.onSecondary,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                ),
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    FuelRecordModel dto = FuelRecordModel(
                        date: _date,
                        fuelQuantity: _fuelQuantity,
                        unitPrice: _unitPrice,
                        droveDistanceFromLastRefuel:
                            _droveDistanceFromLastRefuel);

                    showDialog<void>(
                        context: context,
                        builder: (_) {
                          return AddAlertDialogWidget(
                            dto: dto,
                          );
                        });
                  }
                },
                child: Text(
                  '登録',
                  style: Theme.of(context)
                      .textTheme
                      .labelMedium
                      ?.apply(color: Theme.of(context).colorScheme.onSecondary),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class FuelHistoryView extends StatelessWidget {
  const FuelHistoryView({super.key});

  @override
  Widget build(BuildContext context) {
    final dtoList = List<FuelRecordModel>.empty(growable: true);

    db
        .collection('CAR_MAINTENANCE')
        .doc('REFUEL_RECORD')
        .collection('RECORDS')
        .orderBy('refuelDate', descending: true)
        .get()
        .then(
      (querySnapshot) {
        print("successfully conpleted");
        for (var docSnapshot in querySnapshot.docs) {
          Map<String, dynamic> data = docSnapshot.data();
          FuelRecordModel dto = FuelRecordModel(
              date: data['refuelDate'].toDate(),
              fuelQuantity: data['fuelQuantity'],
              unitPrice: data['unitPrice'],
              droveDistanceFromLastRefuel: data['droveDistanceFromLastRefuel']);
          dto.id = docSnapshot.id;
          dtoList.add(dto);
        }
      },
      onError: (e) => print('Error completing: $e'),
    );

    for (var dto in dtoList) {
      print(dto.unitPrice);
    }

    final size = MediaQuery.of(context).size;
    return SafeArea(
        child: Container(
      height: size.height,
      width: size.width,
      padding: const EdgeInsets.all(8.0),
      child: const SingleChildScrollView(
        child: RefuelHistories(),
      ),
    ),);
  }
}

class RefuelHistories extends StatelessWidget {
  const RefuelHistories({super.key});

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
                  return Card(
                    color: Theme.of(context).colorScheme.primary,
                    child: ListTile(
                      title: Text(
                        fromDate(document.get('refuelDate').toDate()),
                        style: Theme.of(context).textTheme.labelLarge?.apply(
                            color: Theme.of(context).colorScheme.onPrimary),
                      ),
                      subtitle: Text(
                        '走行距離: ${document.get('droveDistanceFromLastRefuel')}km',
                        style: Theme.of(context).textTheme.labelMedium?.apply(
                            color: Theme.of(context).colorScheme.onPrimary),
                      ),
                      trailing: Icon(Icons.note_outlined,
                          color: Theme.of(context).colorScheme.onPrimary,),
                      onTap: () {
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (context) =>
                                HistoryDetail(document: document),
                          ),
                        );
                      },
                    ),
                  );
                }).toList(),
              );
          }
        });
  }
}

class HistoryDetail extends StatelessWidget {
  const HistoryDetail({super.key, required this.document});

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
                            Column(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: <Widget>[
                                Text(
                                  '給油量',
                                  style: Theme.of(context)
                                      .textTheme
                                      .titleLarge
                                      ?.apply(
                                          color: Theme.of(context)
                                              .colorScheme
                                              .onSecondaryContainer),
                                ),
                                Text(
                                  '1リットル単価',
                                  style: Theme.of(context)
                                      .textTheme
                                      .titleLarge
                                      ?.apply(
                                          color: Theme.of(context)
                                              .colorScheme
                                              .onSecondaryContainer),
                                ),
                                Text(
                                  '走行距離',
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
                                  '${document.get('fuelQuantity')}',
                                  style: Theme.of(context)
                                      .textTheme
                                      .titleLarge
                                      ?.apply(
                                          color: Theme.of(context)
                                              .colorScheme
                                              .onSecondaryContainer),
                                ),
                                Text(
                                  '${document.get('unitPrice')}',
                                  style: Theme.of(context)
                                      .textTheme
                                      .titleLarge
                                      ?.apply(
                                          color: Theme.of(context)
                                              .colorScheme
                                              .onSecondaryContainer),
                                ),
                                Text(
                                  '${document.get('droveDistanceFromLastRefuel')}',
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
                                  '[L]',
                                  style: Theme.of(context)
                                      .textTheme
                                      .titleLarge
                                      ?.apply(
                                          color: Theme.of(context)
                                              .colorScheme
                                              .onSecondaryContainer),
                                ),
                                Text(
                                  '[¥/L]',
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
                        backgroundColor: Theme.of(context).colorScheme.secondary,
                        foregroundColor: Theme.of(context).colorScheme.onSecondary,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10.0),
                        )
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
                    onPressed: (){
                      showDialog<void>(
                          context: context,
                          builder: (_) {
                            return DeleteAlertDialogWidget(document: document);
                          });
                    },
                  ),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Theme.of(context).colorScheme.secondary,
                      foregroundColor: Theme.of(context).colorScheme.onSecondary,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10.0),
                      )
                    ),
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
                    onPressed: (){
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

class DeleteAlertDialogWidget extends StatelessWidget {
  const DeleteAlertDialogWidget({Key? key, required this.document}) : super(key: key);

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
                .doc(document.id).delete();
            Navigator.pop(context);
            Navigator.pop(context);
          },
        )
      ],
    );
  }
}