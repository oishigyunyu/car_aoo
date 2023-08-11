import 'package:flutter/material.dart';
import 'package:flutter_datetime_picker_plus/flutter_datetime_picker_plus.dart';

class FireStoreView extends StatelessWidget {
  const FireStoreView({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      body: SafeArea(
        child: Container(
          width: size.width,
          height: size.height,
          padding: const EdgeInsets.all(8.0),
          child: Center(
            child: TextButton(
              onPressed: () {
                DatePicker.showDatePicker(context,
                    showTitleActions: true,
                    minTime: DateTime(1950, 1, 1),
                    maxTime: DateTime(2022, 8, 17),
                    onChanged: (date) {
                      print('change $date');
                    },
                    onConfirm: (date) {
                      print('confirm $date');
                    },
                    currentTime: DateTime.now(),
                    locale: LocaleType.jp,
                );
              },
              child: const Text(
                '生年月日を選択',
                style: TextStyle(color: Colors.blue),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
