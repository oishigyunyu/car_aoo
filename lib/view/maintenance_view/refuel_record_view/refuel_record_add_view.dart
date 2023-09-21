import 'package:car_app/model/refuel_record_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_datetime_picker_plus/flutter_datetime_picker_plus.dart';
import 'package:intl/intl.dart';
import 'refuel_record_view.dart';

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
              Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Text(
                    '給油日',
                    style: Theme.of(context).textTheme.titleMedium?.apply(
                      color: Theme.of(context).colorScheme.outline,
                    ),
                  ),
                  Text(
                    _dateFormat.format(_date),
                    style: Theme.of(context).textTheme.titleLarge?.apply(
                      color: Theme.of(context).colorScheme.onBackground,
                    ),
                  ),
                  TextButton(
                    style: TextButton.styleFrom(
                      backgroundColor: Theme.of(context).colorScheme.primary,
                      shape: const RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(
                          Radius.circular(100.0),
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
                      style: Theme.of(context).textTheme.titleMedium?.apply(
                          color: Theme.of(context).colorScheme.onPrimary),
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
                  color: Theme.of(context).colorScheme.onBackground,
                ),
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8.0),
                    borderSide: BorderSide(
                      color: Theme.of(context).colorScheme.primary,
                      width: 2.0,
                    ),
                  ),
                  labelStyle: Theme.of(context).textTheme.titleLarge?.apply(
                    color: Theme.of(context).colorScheme.outline,
                  ),
                  labelText: '給油量[L]',
                  floatingLabelStyle: Theme.of(context).textTheme.titleMedium,
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8.0),
                    borderSide: BorderSide(
                      color: Theme.of(context).colorScheme.primary,
                      width: 1.0,
                    ),
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
                  color: Theme.of(context).colorScheme.onBackground,
                ),
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8.0),
                    borderSide: BorderSide(
                      color: Theme.of(context).colorScheme.primary,
                      width: 2.0,
                    ),
                  ),
                  labelStyle: Theme.of(context).textTheme.titleLarge?.apply(
                    color: Theme.of(context).colorScheme.outline,
                  ),
                  labelText: '1Lあたりの単価[¥]',
                  floatingLabelStyle: Theme.of(context).textTheme.titleMedium,
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8.0),
                    borderSide: BorderSide(
                      color: Theme.of(context).colorScheme.primary,
                      width: 1.0,
                    ),
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
                  color: Theme.of(context).colorScheme.onBackground,
                ),
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8.0),
                    borderSide: BorderSide(
                      color: Theme.of(context).colorScheme.primary,
                      width: 2.0,
                    ),
                  ),
                  labelStyle: Theme.of(context).textTheme.titleLarge?.apply(
                    color: Theme.of(context).colorScheme.outline,
                  ),
                  labelText: '前回の給油からの走行距離[km]',
                  floatingLabelStyle: Theme.of(context).textTheme.titleMedium,
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8.0),
                    borderSide: BorderSide(
                      color: Theme.of(context).colorScheme.primary,
                      width: 1.0,
                    ),
                  ),
                ),
                onChanged: (value) {
                  setState(() {
                    _droveDistanceFromLastRefuel = double.parse(value);
                  });
                },
              ),
              TextButton(
                style: TextButton.styleFrom(
                  backgroundColor: Theme.of(context).colorScheme.primary,
                  shape: const RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(
                      Radius.circular(100.0),
                    ),
                  ),
                ),
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    RefuelRecordModel model = RefuelRecordModel(
                        date: _date,
                        fuelQuantity: _fuelQuantity,
                        unitPrice: _unitPrice,
                        droveDistanceFromLastRefuel:
                        _droveDistanceFromLastRefuel,
                        createdAt: DateTime.now());

                    showDialog<void>(
                        context: context,
                        builder: (_) {
                          return AddAlertDialogWidget(
                            model: model,
                          );
                        });
                  }
                },
                child: Text(
                  '登録',
                  style: Theme.of(context).textTheme.labelLarge?.apply(
                      color: Theme.of(context).colorScheme.onSecondary),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
