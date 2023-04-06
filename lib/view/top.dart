import 'package:flutter/material.dart';

import 'menu.dart';

class TopPage extends StatefulWidget {
  const TopPage({super.key, required this.title});
  final String title;

  @override
  State<TopPage> createState() => _TopPage();
}

class _TopPage extends State<TopPage> {
  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    var now = DateTime.now();
    final List<String> days = ['Sun', 'Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat'];
    final List<String> months = [
      'Jan',
      'Feb',
      'Mar',
      'Apr',
      'May',
      'Jun',
      'Jul',
      'Aug',
      'Sep',
      'Oct',
      'Nov',
      'Dec'
    ];
    return SafeArea(
      child: Scaffold(
        body: Container(
          width: size.width,
          height: size.height,
          decoration:
              BoxDecoration(color: Theme.of(context).colorScheme.background),
          child: Stack(
            children: <Widget>[
              Row(
                children: <Widget>[
                  Card(
                    child: Container(
                      width: size.width / 5 * 3 - 8,
                      height: size.height,
                      padding: const EdgeInsets.all(8.0),
                      decoration: const BoxDecoration(
                        image: DecorationImage(
                          image:
                              AssetImage("assets/static/images/wallpaper.jpg"),
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      Card(
                        child: Container(
                          padding: const EdgeInsets.all(8.0),
                          width: size.width / 5 * 2 - 8,
                          height: size.height / 5 * 2,
                          decoration: BoxDecoration(
                              color: Theme.of(context)
                                  .colorScheme
                                  .primaryContainer),
                          child: const Center(
                            child: Text("Hello"),
                          ),
                        ),
                      ),
                      Card(
                        color: Theme.of(context).colorScheme.primaryContainer,
                        child: InkWell(
                          onTap: () {
                            Navigator.of(context).push(
                              MaterialPageRoute(
                                builder: (context) => const Menu(),
                              ),
                            );
                          },
                          child: SizedBox(
                            child: SizedBox(
                              width: size.width / 5 * 2 - 8,
                              height: (size.height / 5) * 3 - 48,
                              child: const Center(
                                child: Text("Menu"),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  )
                ],
              ),
              Align(
                alignment: Alignment.topLeft,
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: FloatingActionButton.large(
                    backgroundColor: Theme.of(context).colorScheme.primary,
                    onPressed: () {},
                    child: Icon(
                      Icons.power_settings_new,
                      color: Theme.of(context).colorScheme.onPrimary,
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
