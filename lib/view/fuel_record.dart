import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_datetime_picker_plus/flutter_datetime_picker_plus.dart';

class FuelRecord extends StatefulWidget {
  const FuelRecord({super.key});

  @override
  State<FuelRecord> createState() => _FuelRecordState();
}

class _FuelRecordState extends State<FuelRecord> {
  DateTime _date = DateTime.now();
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
          color: Theme.of(context).colorScheme.primary,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              TextButton(
                onPressed: () {
                  DatePicker.showDatePicker(
                    context,
                    showTitleActions: true,
                    minTime: DateTime(2023, 1, 1),
                    maxTime: DateTime(2099, 12, 31),
                    onChanged: (date) {
                      _date = date;
                    },
                    onConfirm: (date) {
                      _date = date;
                    },
                    currentTime: DateTime.now(),
                    locale: LocaleType.jp,
                  );
                },
                child: Text(
                  '日付を選択',
                  style: Theme.of(context)
                      .textTheme
                      .bodyMedium
                      ?.apply(color: Theme.of(context).colorScheme.onPrimary),
                ),
              ),
              TextField(
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(
                  border: InputBorder.none,
                  hintText: '給油量',
                ),
                onChanged: (value) => _fuelQuantity = value as double,
              ),
              TextField(
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(
                  border: InputBorder.none,
                  hintText: 'ガソリン単価',
                ),
                onChanged: (value) => _unitPrice = value as double,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
