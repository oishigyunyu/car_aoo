import 'package:flutter_riverpod/flutter_riverpod.dart';

class OilRefillRecordViewNotifier extends StateNotifier<int> {
  OilRefillRecordViewNotifier(): super(0);

  Future<void> toggle() async {
    int viewNumber = 0;
    switch (state) {
      case 0:
        viewNumber = 1;
        break;

      case 1:
        viewNumber = 0;
        break;
    }

    state = viewNumber;
  }

}

final oilRefillRecordViewProvider = StateNotifierProvider<OilRefillRecordViewNotifier, int>((ref) => OilRefillRecordViewNotifier());