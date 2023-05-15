import 'package:car_app/view/instrument.dart';
import 'package:car_app/view/map.dart';
import 'package:car_app/view/music_main.dart';
import 'package:car_app/view/settings.dart';
import 'package:flutter/material.dart';

import 'camera_view.dart';
import 'information.dart';
import 'tyre_information.dart';

class Menu extends StatelessWidget {
  final String direction;

  const Menu({Key? key, required this.direction}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    const Map<String, IconData> icons = {
      "Music": Icons.music_note_outlined,
      "Information": Icons.info_outline_rounded,
      "Camera": Icons.videocam_outlined,
      "Settings": Icons.settings,
      "Map": Icons.place_outlined,
      "Home": Icons.home,
      "Tyre Pressure": Icons.air,
      "Instrument": Icons.speed,
      "Watch": Icons.watch_later_outlined,
      "Weather": Icons.sunny,
    };
    final size = MediaQuery.of(context).size;
    const double thickness = 2.0;
    print("direction: $direction");
    return SafeArea(
      child: Scaffold(
        backgroundColor: Theme.of(context).colorScheme.background,
        body: Scrollbar(
          thickness: thickness,
          child: GridView.count(
            padding: const EdgeInsets.all(8.0),
            shrinkWrap: true,
            scrollDirection: direction == "v" ? Axis.vertical : Axis.horizontal,
            crossAxisCount: 2,
            children: <Widget>[
              for (int index = 0; index < icons.length; index++) ...{
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Card(
                    color: Theme.of(context).colorScheme.primaryContainer,
                    child: InkWell(
                      onTap: () {
                        if (icons.keys.elementAt(index) == "Music") {
                          Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (context) => const MusicMain(),
                            ),
                          );
                        }
                        if (icons.keys.elementAt(index) == "Map") {
                          Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (context) => const GoogleMapView(),
                            ),
                          );
                        }
                        if (icons.keys.elementAt(index) == "Camera") {
                          Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (context) => const CameraView(),
                            ),
                          );
                        }
                        if (icons.keys.elementAt(index) == "Tyre Pressure") {
                          Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (context) => const TyreInformation(),
                            ),
                          );
                        }
                        if (icons.keys.elementAt(index) == "Information") {
                          Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (context) => const Information(),
                            ),
                          );
                        }
                        if (icons.keys.elementAt(index) == "Instrument") {
                          Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (context) => const Instrument(),
                            ),
                          );
                        }
                        if (icons.keys.elementAt(index) == "Home") {
                          Navigator.of(context).pop();
                        }
                        if (icons.keys.elementAt(index) == "Settings") {
                          Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (context) => const Settings(),
                            ),
                          );
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
                              size: size.width / 20,
                              color: Theme.of(context)
                                  .colorScheme
                                  .onPrimaryContainer,
                            ),
                            Text(
                              icons.keys.elementAt(index),
                              style: Theme.of(context)
                                  .textTheme
                                  .titleMedium
                                  ?.apply(
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
              }
            ],
          ),
        ),
      ),
    );
  }
}
