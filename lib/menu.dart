import 'package:flutter/material.dart';

class Menu extends StatelessWidget {
  const Menu({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final List<IconData> icons = <IconData>[
      Icons.music_note_outlined,
      Icons.place_outlined,
      Icons.info_outline_rounded,
      Icons.settings,
    ];
    final List<int> colorCodes = <int>[600, 500, 100, 300];
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
                  color: Colors.amber[colorCodes[index]],
                  child: Center(
                    child: InkWell(
                      onTap: () {},
                      child: Container(
                        width: size.width / icons.length - 50,
                        height: size.height,
                        decoration: const BoxDecoration(
                          shape: BoxShape.circle,
                          color: Colors.cyan,
                        ),
                        child: Center(
                          child: Icon(
                            icons[index],
                            size: size.width / icons.length / 2,
                            color: Colors.purpleAccent,
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
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          child: const Icon(
            Icons.home,
          ),
        ),
      ),
    );
  }
}
