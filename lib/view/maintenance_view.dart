import 'package:car_app/view/fuel_record_view.dart';
import 'package:car_app/view/maintenance_view/oil_refuel_record/oil_refill_record_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_datetime_picker_plus/flutter_datetime_picker_plus.dart';

class MaintenanceView extends StatelessWidget {
  const MaintenanceView({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery
        .of(context)
        .size;
    return Scaffold(
      appBar: AppBar(),
      body: SafeArea(
        child: Container(
          width: size.width,
          height: size.height,
          padding: const EdgeInsets.all(8.0),
          child: Center(
            child: ListView(
              children: <Widget>[
                ListTile(
                  title: const Text('給油記録'),
                  trailing: const Icon(Icons.local_gas_station_outlined),
                  onTap: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(builder: (context) => const FuelRecord(),
                      ),
                    );
                  },
                ),
                ListTile(
                  title: const Text('エンジンオイル交換記録'),
                  trailing: const Icon(Icons.oil_barrel_outlined),
                  onTap: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(builder: (context) => const OilRefillRecord(),
                      ),
                    );
                  },
                ),
                ListTile(
                  title: const Text('ウォッシャー液交換記録'),
                  trailing: const Icon(Icons.water_outlined),
                  onTap: () {print('tapped');
                  },
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
