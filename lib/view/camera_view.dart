import 'package:flutter/material.dart';

class CameraView extends StatefulWidget {
  const CameraView({Key? key}) : super(key: key);

  @override
  State<CameraView> createState() => _CameraViewState();
}

class _CameraViewState extends State<CameraView> {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final List<String> directions = ["Front", "Rear"];

    return SafeArea(
      child: Scaffold(
        body: Container(
          width: size.width,
          height: size.height,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              ListView.builder(
                shrinkWrap: true,
                scrollDirection: Axis.horizontal,
                itemCount: directions.length,
                itemBuilder: (BuildContext context, int index) {
                  return Container(
                    width: size.width / directions.length,
                    height: size.height,
                    padding: const EdgeInsets.all(8.0),
                    color: Theme.of(context).colorScheme.background,
                    child: Center(
                      child: Card(
                        color: Theme.of(context).colorScheme.primaryContainer,
                        child: InkWell(
                          onTap: () {
                            if (directions[index] == "Front") {}
                            if (directions[index] == "Rear") {}
                          },
                          child: Container(
                            height: size.height,
                            width: size.width,
                            padding: const EdgeInsets.all(8.0),
                            child: Center(
                              child: Text(
                                directions[index],
                                style: Theme.of(context)
                                    .textTheme
                                    .displayLarge
                                    ?.apply(
                                        color: Theme.of(context)
                                            .colorScheme
                                            .onPrimaryContainer),
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
        ),
      ),
    );
  }
}
