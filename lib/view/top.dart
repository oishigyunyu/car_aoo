import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'menu.dart';

class TopPage extends StatefulWidget {
  const TopPage({super.key});

  @override
  State<TopPage> createState() => _TopPage();
}

class _TopPage extends State<TopPage> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;

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
                          child: Center(
                            child: Text("wowow"),
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
                    backgroundColor:
                        Theme.of(context).colorScheme.primaryContainer,
                    onPressed: () {},
                    child: Icon(
                      Icons.power_settings_new,
                      color: Theme.of(context).colorScheme.onPrimaryContainer,
                    ),
                  ),
                ),
              ),
              Align(
                alignment: Alignment.bottomLeft,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    padding: const EdgeInsets.all(8.0),
                    width: size.width / 4,
                    height: size.height / 5,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.end,
                      textBaseline: TextBaseline.ideographic,
                      children: <Widget>[
                        Column(
                          mainAxisAlignment: MainAxisAlignment.end,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Text(
                              "4月7日(金)",
                              style: Theme.of(context)
                                  .textTheme
                                  .titleLarge
                                  ?.apply(
                                      color: Theme.of(context)
                                          .colorScheme
                                          .background),
                            ),
                            Text(
                              "23:59",
                              style: Theme.of(context)
                                  .textTheme
                                  .displayLarge
                                  ?.apply(
                                      color: Theme.of(context)
                                          .colorScheme
                                          .background),
                            ),
                          ],
                        ),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.end,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: <Widget>[
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: <Widget>[
                                Icon(
                                  Icons.cloud,
                                  size: size.height / 20,
                                  color:
                                      Theme.of(context).colorScheme.background,
                                ),
                                Text(
                                  "18°",
                                  style: Theme.of(context)
                                      .textTheme
                                      .titleLarge
                                      ?.apply(
                                          color: Theme.of(context)
                                              .colorScheme
                                              .background),
                                ),
                              ],
                            ),
                            const SizedBox(
                              height: 6,
                            )
                          ],
                        )
                      ],
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
