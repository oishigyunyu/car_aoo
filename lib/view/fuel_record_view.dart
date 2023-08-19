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

  final DateTime date;
  final double fuelQuantity;
  final double unitPrice;
  final double droveDistanceFromLastRefuel;
  late final DateTime createdAt = DateTime.now();
}

class FuelRecord extends StatefulWidget {
  const FuelRecord({super.key});

  @override
  State<FuelRecord> createState() => _FuelRecordState();
}

class _FuelRecordState extends State<FuelRecord> {
  final _formKey = GlobalKey<FormState>();

  DateTime _date = DateTime.now();
  final DateFormat _dateFormat = DateFormat('yyyy年MM月dd日');
  double _fuelQuantity = 0.0;
  double _unitPrice = 0.0;
  double _droveDistanceFromLastRefuel = 0.0;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(),
      body: SafeArea(
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
                        backgroundColor:
                            Theme.of(context).colorScheme.secondary,
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
                            return AlertDialogWidget(
                              dto: dto,
                            );
                          });
                    }
                  },
                  child: Text(
                    '登録',
                    style: Theme.of(context).textTheme.labelMedium?.apply(
                        color: Theme.of(context).colorScheme.onSecondary),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class AlertDialogWidget extends StatelessWidget {
  const AlertDialogWidget({Key? key, required this.dto}) : super(key: key);

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
            }).catchError((error) => 'failed to add data: $error');
          },
        )
      ],
    );
  }
}
