import 'package:car_app/view/fuel_record.dart';
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
      body: SafeArea(
        child: Container(
          width: size.width,
          height: size.height,
          padding: const EdgeInsets.all(8.0),
          child: Center(
            child: ListTile(
              title: const Text('給油記録'),
              trailing: const Icon(Icons.local_gas_station_outlined),
              onTap: () {
                Navigator.of(context).push(
                  MaterialPageRoute(builder: (context) => const FuelRecord(),
                  ),
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}
