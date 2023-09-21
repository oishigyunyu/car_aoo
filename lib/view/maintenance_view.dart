import 'package:car_app/view/maintenance_view/refuel_record_view/refuel_record_view.dart';
import 'package:car_app/view/maintenance_view/oil_refuel_record/oil_refill_record_view.dart';
import 'package:flutter/material.dart';

class MaintenanceView extends StatelessWidget {
  const MaintenanceView({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
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
                  title: Text(
                    '給油記録',
                    style: Theme.of(context).textTheme.titleLarge?.apply(
                          color: Theme.of(context).colorScheme.onBackground,
                        ),
                  ),
                  trailing: FittedBox(
                    fit: BoxFit.fill,
                    child: Icon(
                      Icons.local_gas_station_outlined,
                      color: Theme.of(context).colorScheme.onBackground,
                    ),
                  ),
                  onTap: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) => const FuelRecord(),
                      ),
                    );
                  },
                ),
                const Divider(),
                ListTile(
                  title: Text(
                    'エンジンオイル交換記録',
                    style: Theme.of(context).textTheme.titleLarge?.apply(
                          color: Theme.of(context).colorScheme.onBackground,
                        ),
                  ),
                  trailing: FittedBox(
                    fit: BoxFit.fill,
                    child: Icon(
                      Icons.oil_barrel_outlined,
                      color: Theme.of(context).colorScheme.onBackground,
                    ),
                  ),
                  onTap: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) => const OilRefillRecord(),
                      ),
                    );
                  },
                ),
                const Divider(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
