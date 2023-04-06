import 'package:car_app/view/camera_view.dart';
import 'package:car_app/view/information.dart';
import 'package:car_app/view/map/map.dart';
import 'package:car_app/view/music_view.dart';
import 'package:flutter/material.dart';

class Menu extends StatelessWidget {
  const Menu({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final List<IconData> icons = <IconData>[
      Icons.music_note_outlined,
      Icons.place_outlined,
      Icons.videocam_outlined,
      Icons.info_outline_rounded,
      Icons.settings,
    ];
    final List<String> iconNames = <String>[
      "Music",
      "Map",
      "Camera",
      "Information",
      "Settings"
    ];
    final size = MediaQuery.of(context).size;
    return SafeArea(
      child: Scaffold(
        body: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            ListView.builder(
              shrinkWrap: true,
              scrollDirection: Axis.horizontal,
              itemCount: icons.length,
              itemBuilder: (BuildContext context, int index) {
                return Container(
                  width: size.width / icons.length,
                  height: size.height,
                  color: Theme.of(context).colorScheme.background,
                  child: Center(
                    child: Center(
                      child: Card(
                        color: Theme.of(context).colorScheme.tertiaryContainer,
                        child: InkWell(
                          onTap: () {
                            if (index == 0) {
                              Navigator.of(context).push(
                                MaterialPageRoute(
                                  builder: (context) => const MusicView(),
                                ),
                              );
                            }
                            if (index == 1) {
                              Navigator.of(context).push(
                                MaterialPageRoute(
                                  builder: (context) => const MapView(),
                                ),
                              );
                            }
                            if (index == 2) {
                              Navigator.of(context).push(
                                MaterialPageRoute(
                                  builder: (context) => const CameraView(),
                                ),
                              );
                            }
                            if (index == 3) {
                              Navigator.of(context).push(
                                MaterialPageRoute(
                                  builder: (context) => const Information(),
                                ),
                              );
                            }
                          },
                          child: SizedBox(
                            width: size.width / icons.length,
                            height: size.width / icons.length,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(
                                  icons[index],
                                  size: size.width / 30,
                                  color: Theme.of(context)
                                      .colorScheme
                                      .onTertiaryContainer,
                                ),
                                Text(
                                  iconNames[index],
                                  style: TextStyle(
                                      fontSize: size.width / 40,
                                      color: Theme.of(context)
                                          .colorScheme
                                          .onTertiaryContainer),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                );
              },
            ),
          ],
        ),
        floatingActionButton: FloatingActionButton.large(
          onPressed: () {
            Navigator.of(context).pop();
          },
          child: Icon(
            Icons.home,
            color: Theme.of(context).colorScheme.onPrimaryContainer,
          ),
        ),
      ),
    );
  }
}
