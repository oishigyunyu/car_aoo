import 'package:adaptive_dialog/adaptive_dialog.dart';
import 'package:car_app/utils/date_format.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_datetime_picker_plus/flutter_datetime_picker_plus.dart';
import 'package:intl/intl.dart';

import '../../../main.dart';
import '../../../model/dto/oil_refill_record_dto.dart';
import 'oil_refuel_history_view.dart';
import 'oil_refuel_record_add_view.dart';

class OilRefillRecord extends StatefulWidget {
  const OilRefillRecord({super.key});

  @override
  State<OilRefillRecord> createState() => _OilRefillRecordState();
}

class _OilRefillRecordState extends State<OilRefillRecord> {
  int _currentIndex = 0;

  void _onItemTapped(int index) => setState(() => _currentIndex = index);

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(),
      body: _currentIndex == 0
          ? const OilRefillRecordAddView()
          : const OilRefillHistoryView(),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
              icon: Icon(Icons.add_circle_outline_outlined), label: '記録'),
          BottomNavigationBarItem(
              icon: Icon(Icons.list_outlined), label: 'オイル交換履歴'),
        ],
        currentIndex: _currentIndex,
        fixedColor: Colors.blueAccent,
        onTap: _onItemTapped,
        type: BottomNavigationBarType.fixed,
      ),
    );
  }
}
