import 'package:car_app/view/tyre.dart';
import 'package:flutter/material.dart';

class TyreInformation extends StatelessWidget {
  const TyreInformation({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final Map<String, Alignment> tyrePos = {
      "Front Left": Alignment.topLeft,
      "Front Right": Alignment.topRight,
      "Rear Left": Alignment.bottomLeft,
      "Rear Right": Alignment.bottomRight
    };

    return SafeArea(
      child: Scaffold(
        body: Container(
          width: size.width,
          height: size.height,
          padding: const EdgeInsets.all(8.0),
          color: Theme.of(context).colorScheme.background,
          child: Stack(
            children: <Widget>[
              Center(
                child: Container(
                  padding: const EdgeInsets.all(8.0),
                  height: size.height / 3 * 2,
                  width: size.height / 3 * 2,
                  child: Image.asset(
                    "assets/static/images/car-top-view.png",
                    fit: BoxFit.fill,
                    color: Theme.of(context).colorScheme.onBackground,
                    colorBlendMode: BlendMode.srcIn,
                  ),
                ),
              ),
              for (int i = 0; i < tyrePos.length; i++) ...{
                Align(
                  alignment: tyrePos.values.elementAt(i),
                  child: Padding(
                    padding: EdgeInsets.symmetric(
                        vertical: size.height / 8, horizontal: size.width / 8),
                    child: Card(
                      color: Theme.of(context).colorScheme.primaryContainer,
                      child: InkWell(
                        onTap: () {
                          Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (context) => Tyre(
                                tyreName: tyrePos.keys.elementAt(i),
                              ),
                            ),
                          );
                        },
                        child: Container(
                          padding: const EdgeInsets.all(8.0),
                          width: size.width / 4,
                          height: size.height / 5,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  Text(
                                    tyrePos.keys.elementAt(i),
                                    style: Theme.of(context)
                                        .textTheme
                                        .titleSmall
                                        ?.apply(
                                            color: Theme.of(context)
                                                .colorScheme
                                                .onPrimaryContainer),
                                  ),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment: CrossAxisAlignment.end,
                                    children: <Widget>[
                                      Text(
                                        "ssss",
                                        style: Theme.of(context)
                                            .textTheme
                                            .titleSmall
                                            ?.apply(
                                                color: Theme.of(context)
                                                    .colorScheme
                                                    .onPrimaryContainer),
                                      ),
                                      Text(
                                        "[kPa]",
                                        style: Theme.of(context)
                                            .textTheme
                                            .titleSmall
                                            ?.apply(
                                                color: Theme.of(context)
                                                    .colorScheme
                                                    .onPrimaryContainer),
                                      )
                                    ],
                                  ),
                                ],
                              ),
                              Card(
                                color: Theme.of(context)
                                    .colorScheme
                                    .secondaryContainer,
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Column(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: <Widget>[
                                      Text(
                                        "Temp",
                                        style: Theme.of(context)
                                            .textTheme
                                            .labelMedium
                                            ?.apply(
                                                color: Theme.of(context)
                                                    .colorScheme
                                                    .onSecondaryContainer),
                                      ),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.baseline,
                                        textBaseline: TextBaseline.alphabetic,
                                        children: <Widget>[
                                          Text(
                                            "123",
                                            style: Theme.of(context)
                                                .textTheme
                                                .labelSmall
                                                ?.apply(
                                                    color: Theme.of(context)
                                                        .colorScheme
                                                        .onSecondaryContainer),
                                          ),
                                          Text(
                                            "[℃]",
                                            style: Theme.of(context)
                                                .textTheme
                                                .labelSmall
                                                ?.apply(
                                                    color: Theme.of(context)
                                                        .colorScheme
                                                        .onSecondaryContainer),
                                          ),
                                        ],
                                      )
                                    ],
                                  ),
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              },
              Align(
                alignment: Alignment.topRight,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: FloatingActionButton.large(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    child: const Icon(Icons.keyboard_return),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
