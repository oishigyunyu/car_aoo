import 'package:adaptive_dialog/adaptive_dialog.dart';
import 'package:car_app/utils/date_format.dart';
import 'package:car_app/utils/oil_refill_record_view_provider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_datetime_picker_plus/flutter_datetime_picker_plus.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';

import '../../../main.dart';
import '../../../model/dto/oil_refill_record_dto.dart';
import 'oil_refuel_history_view.dart';
import 'oil_refuel_record_add_view.dart';

class OilRefillRecord extends ConsumerWidget {
  const OilRefillRecord({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    int currentIndex = ref.watch(oilRefillRecordViewProvider);
    return Scaffold(
      appBar: AppBar(),
      body: currentIndex == 0
          ? const OilRefillRecordAddView()
          : const OilRefillHistoryView(),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
              icon: Icon(Icons.add_circle_outline_outlined), label: '記録'),
          BottomNavigationBarItem(
              icon: Icon(Icons.list_outlined), label: 'オイル交換履歴'),
        ],
        currentIndex: currentIndex,
        fixedColor: Colors.blueAccent,
        onTap: (value) => ref.read(oilRefillRecordViewProvider.notifier).toggle(),
        type: BottomNavigationBarType.fixed,
      ),
    );
  }
}
