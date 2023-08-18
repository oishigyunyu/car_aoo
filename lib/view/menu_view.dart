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
        child: SizedBox(
          height: size.height,
          width: size.width,
          child: ListView.builder(
            itemExtent: size.height / 4,
            itemCount: iconsMaps.length - 1,
            itemBuilder: (context, index) {
              return Card(
                child: ListTile(
                  dense: true,
                  tileColor: Theme
                      .of(context)
                      .colorScheme
                      .primaryContainer,
                  shape: const RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(
                      Radius.circular(10.0),
                    ),
                  ),
                  title: Center(
                    child: Text(
                      iconsMaps.keys.elementAt(index),
                      style: Theme
                          .of(context)
                          .textTheme
                          .headlineLarge
                          ?.apply(
                        color:
                        Theme
                            .of(context)
                            .colorScheme
                            .onPrimaryContainer,),
                    ),
                  ),
                  leading: Icon(
                    iconsMaps.values.elementAt(index),
                    size: size.width / 8,
                  ),
                  onTap: () {
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
      ),
    );
  }
}
