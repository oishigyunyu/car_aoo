import 'package:flutter/material.dart';

class Information extends StatelessWidget {
  const Information({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
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
                  padding: EdgeInsets.all(8.0),
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
              Align(
                alignment: Alignment.topLeft,
                child: Padding(
                  padding: EdgeInsets.symmetric(
                      vertical: size.height / 8, horizontal: size.width / 6),
                  child: Card(
                    color: Theme.of(context).colorScheme.primaryContainer,
                    child: SizedBox(
                      width: size.width / 5,
                      height: size.height / 5,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: <Widget>[
                          Text("Front Left"),
                          Text("ssss"),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
              Align(
                alignment: Alignment.topRight,
                child: Padding(
                  padding: EdgeInsets.symmetric(
                      vertical: size.height / 8, horizontal: size.width / 6),
                  child: Card(
                    color: Theme.of(context).colorScheme.primaryContainer,
                    child: SizedBox(
                      width: size.width / 5,
                      height: size.height / 5,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: <Widget>[
                          Text("Front Right"),
                          Text("ssss"),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
              Align(
                alignment: Alignment.bottomLeft,
                child: Padding(
                  padding: EdgeInsets.symmetric(
                      vertical: size.height / 8, horizontal: size.width / 6),
                  child: Card(
                    color: Theme.of(context).colorScheme.primaryContainer,
                    child: SizedBox(
                      width: size.width / 5,
                      height: size.height / 5,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: <Widget>[
                          Text("Rear Left"),
                          Text("ssss"),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
              Align(
                alignment: Alignment.bottomRight,
                child: Padding(
                  padding: EdgeInsets.symmetric(
                      vertical: size.height / 8, horizontal: size.width / 6),
                  child: Card(
                    color: Theme.of(context).colorScheme.primaryContainer,
                    child: SizedBox(
                      width: size.width / 5,
                      height: size.height / 5,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: <Widget>[
                          Text("Rear Right"),
                          Text("ssss"),
                        ],
                      ),
                    ),
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
