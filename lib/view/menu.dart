import 'package:car_app/view/camera_view.dart';
import 'package:car_app/view/information.dart';
import 'package:car_app/view/map.dart';
import 'package:car_app/view/music_view.dart';
import 'package:flutter/material.dart';

class Menu extends StatefulWidget {
  const Menu({Key? key}) : super(key: key);

  @override
  State<Menu> createState() => _MenuState();
}

class _MenuState extends State<Menu> {
  @override
  Widget build(BuildContext context) {
    final List<IconData> icons = <IconData>[
      Icons.music_note_outlined,
      Icons.info_outline_rounded,
      Icons.videocam_outlined,
      Icons.settings,
      Icons.place_outlined,
      Icons.home
    ];
    final List<String> iconNames = <String>[
      "Music",
      "Information",
      "Camera",
      "Settings",
      "Map",
      "Home",
    ];
    final size = MediaQuery.of(context).size;
    return SafeArea(
      child: Scaffold(
        body: Center(
          child: GridView.builder(
            shrinkWrap: true,
            scrollDirection: Axis.horizontal,
            itemCount: icons.length,
            itemBuilder: (BuildContext context, int index) {
              return Container(
                color: Theme.of(context).colorScheme.background,
                child: Center(
                  child: Card(
                    color: Theme.of(context).colorScheme.primaryContainer,
                    child: InkWell(
                      onTap: () {
                        if (iconNames[index] == "Music") {
                          Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (context) => const MusicView(),
                            ),
                          );
                        }
                        if (iconNames[index] == "Map") {
                          Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (context) => const MapView(),
                            ),
                          );
                        }
                        if (iconNames[index] == "Camera") {
                          Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (context) => const CameraView(),
                            ),
                          );
                        }
                        if (iconNames[index] == "Information") {
                          Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (context) => const Information(),
                            ),
                          );
                        }
                        if (iconNames[index] == "Home") {
                          Navigator.of(context).pop();
                        }
                      },
                      child: Container(
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
                                  .onPrimaryContainer,
                            ),
                            Text(
                              iconNames[index],
                              style: Theme.of(context)
                                  .textTheme
                                  .headlineSmall
                                  ?.apply(
                                      color: Theme.of(context)
                                          .colorScheme
                                          .onPrimaryContainer),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              );
            },
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              mainAxisSpacing: 1,
              crossAxisSpacing: 1,
            ),
          ),
        ),
      ),
    );
  }
}
