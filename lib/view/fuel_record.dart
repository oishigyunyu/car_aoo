import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_datetime_picker_plus/flutter_datetime_picker_plus.dart';
import 'package:intl/intl.dart';

class FuelRecord extends StatefulWidget {
  const FuelRecord({super.key});

  @override
  State<FuelRecord> createState() => _FuelRecordState();
}

class _FuelRecordState extends State<FuelRecord> {
  DateTime _date = DateTime.now();
  final DateFormat _dateFormat = DateFormat('yyyy年MM月dd日');
  double _fuelQuantity = 0.0;
  double _unitPrice = 0.0;
  double _drivedDistanceFromLastRefuel = 0.0;

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
                        onConfirm: (date) {
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
              TextField(
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
                    _fuelQuantity = value as double;
                  });
                },
              ),
              TextField(
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
                    _unitPrice = value as double;
                  });
                },
              ),
              TextField(
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
                    _drivedDistanceFromLastRefuel = value as double;
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
                  print('submitted');
                },
                child: Text(
                  'submit',
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
