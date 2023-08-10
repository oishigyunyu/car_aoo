import 'dart:collection';

import 'package:car_app/view/instrument_view.dart';
import 'package:car_app/view/maintenance_view.dart';
import 'package:car_app/view/map_view.dart';
import 'package:car_app/view/music_main_view.dart';
import 'package:car_app/view/settings_view.dart';
import 'package:flutter/material.dart';
import 'camera_view.dart';
import 'information_view.dart';
import 'tyre_information.dart';

class Menu extends StatelessWidget {
  const Menu({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    const Map<String, IconData> icons = {
      "Information": Icons.info_outline_rounded,
      "Map": Icons.place_outlined,
      "Maintenance": Icons.car_repair_outlined,
      "Music": Icons.music_note_outlined,
      "Settings": Icons.settings,
    };
    final size = MediaQuery.of(context).size;
    const double thickness = 2.0;
    return SafeArea(
      child: Scaffold(
        backgroundColor: Theme.of(context).colorScheme.background,
        body: Scrollbar(
          thickness: thickness,
          child: GridView.count(
            padding: const EdgeInsets.all(8.0),
            shrinkWrap: true,
            scrollDirection: Axis.vertical,
            crossAxisCount: 1,
            children: <Widget>[
              for (int index = 0; index < icons.length; index++) ...{
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Card(
                    color: Theme.of(context).colorScheme.primaryContainer,
                    child: InkWell(
                      onTap: () {
                        switch (icons.keys.elementAt(index)) {
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
                        }
                      },
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: <Widget>[
                            Icon(
                              icons.values.elementAt(index),
                              size: size.width / 4,
                              color: Theme.of(context)
                                  .colorScheme
                                  .onPrimaryContainer,
                            ),
                            Text(
                              icons.keys.elementAt(index),
                              style:
                                  Theme.of(context).textTheme.titleLarge?.apply(
                                        color: Theme.of(context)
                                            .colorScheme
                                            .onPrimaryContainer,
                                      ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              },
            ],
          ),
        ),
      ),
    );
  }
}
