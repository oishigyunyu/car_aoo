import 'package:flutter/material.dart';
import 'package:flutter_datetime_picker_plus/flutter_datetime_picker_plus.dart';
import 'package:intl/intl.dart';

import '../../../model/dto/oil_refill_record_dto.dart';
import 'alert_view.dart';

class OilRefillRecordAddView extends StatefulWidget {
  const OilRefillRecordAddView({super.key});

  @override
  State<OilRefillRecordAddView> createState() => _OilRefillRecordAddViewState();
}

class _OilRefillRecordAddViewState extends State<OilRefillRecordAddView> {
  final _formKey = GlobalKey<FormState>();
  DateTime _date = DateTime.now();
  final DateFormat _dateFormat = DateFormat('yyyy年MM月dd日');
  String _grade = '';
  String _brandName = '';
  double _totalDistance = 0.0;

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
                    return 'グレードを正しく入力してください(例:0W-20)';
                  }
                  return null;
                },
                style: Theme.of(context).textTheme.labelLarge?.apply(
                  color: Theme.of(context).colorScheme.onPrimary,
                ),
                decoration: InputDecoration(
                  fillColor: Theme.of(context).colorScheme.primary,
                  filled: true,
                  border: const OutlineInputBorder(),
                  hintText: 'グレード',
                  hintStyle: Theme.of(context).textTheme.labelLarge?.apply(
                    color: Theme.of(context).colorScheme.onPrimary,
                  ),
                ),
                onChanged: (value) {
                  setState(() {
                    _grade = value;
                    _grade = _grade ?? '';
                  });
                },
              ),
              TextFormField(
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return '銘柄を入力してください。';
                  }
                  return null;
                },
                style: Theme.of(context).textTheme.labelLarge?.apply(
                  color: Theme.of(context).colorScheme.onPrimary,
                ),
                decoration: InputDecoration(
                  fillColor: Theme.of(context).colorScheme.primary,
                  filled: true,
                  border: const OutlineInputBorder(),
                  hintText: '銘柄',
                  hintStyle: Theme.of(context).textTheme.labelLarge?.apply(
                    color: Theme.of(context).colorScheme.onPrimary,
                  ),
                ),
                onChanged: (value) {
                  setState(() {
                    _brandName = value;
                    _brandName = _brandName ?? '';
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
                  hintText: '総走行距離[km]',
                  hintStyle: Theme.of(context).textTheme.labelLarge?.apply(
                    color: Theme.of(context).colorScheme.onPrimary,
                  ),
                ),
                onChanged: (value) {
                  setState(() {
                    _totalDistance = double.parse(value);
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
                    OilRefillRecordDTO dto = OilRefillRecordDTO(
                        date: _date,
                        grade: _grade,
                        brandName: _brandName,
                        totalDistance: _totalDistance,
                        createdAt: DateTime.now());

                    showDialog<void>(
                        context: context,
                        builder: (_) {
                          return AddOilAlertDialogWidget(dto: dto);
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

