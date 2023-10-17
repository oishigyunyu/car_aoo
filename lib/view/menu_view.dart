import 'dart:collection';

import 'package:car_app/view/fire_store_count_view.dart';
import 'package:car_app/view/instrument_view.dart';
import 'package:car_app/view/maintenance_view.dart';
import 'package:car_app/view/map_view.dart';
import 'package:car_app/view/music_main_view.dart';
import 'package:car_app/view/settings_view.dart';
import 'package:flutter/material.dart';
import '../utils/constants.dart';
import 'camera_view.dart';
import 'information_view.dart';
import 'tyre_information.dart';

class MenuView extends StatelessWidget {
  const MenuView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      appBar: AppBar(),
      body: SafeArea(
        child: ListView.builder(
          itemExtent: size.height / 5,
          itemCount: iconsMaps.length - 1,
          itemBuilder: (context, index) {
            return Container(
              padding: const EdgeInsets.all(8.0),
              child: ElevatedButton(
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.resolveWith(
                      (Set<MaterialState> states) {
                    Color? color = Theme.of(context).colorScheme.background;
                    return color;
                  }),
                  foregroundColor: MaterialStateProperty.resolveWith(
                      (Set<MaterialState> states) {
                    Color? color = Theme.of(context).colorScheme.onBackground;
                    return color;
                  }),
                  shape: MaterialStateProperty.resolveWith(
                      (Set<MaterialState> states) {
                    OutlinedBorder? border = RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    );
                    return border;
                  }),
                ),
                child: Text(
                  iconsMaps.keys.elementAt(index),
                  style: Theme.of(context).textTheme.displaySmall?.apply(
                        color: Theme.of(context).colorScheme.primary,
                      ),
                ),
                onPressed: () {
                  switch (iconsMaps.keys.elementAt(index)) {
                    case ('Music'):
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) => const MusicMainView(),
                        ),
                      );
                      break;
                    case ('Map'):
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) => const GoogleMapView(),
                        ),
                      );
                      break;
                    case ('Information'):
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) => const InformationView(),
                        ),
                      );
                      break;
                    case ('Settings'):
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) => const SettingsView(),
                        ),
                      );
                      break;
                    case ('Maintenance'):
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) => const MaintenanceView(),
                        ),
                      );
                      break;
                    case ('FireStore'):
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) => const FireStoreView(),
                        ),
                      );
                      break;
                  }
                },
              ),
            );
          },
        ),
      ),
    );
  }
}
