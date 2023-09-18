import 'package:car_app/utils/oil_refill_record_view_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
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
