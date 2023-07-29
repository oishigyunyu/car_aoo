import 'package:car_app/color_schemes.g.dart';
import 'package:car_app/view/top.dart';
import 'package:flutter/material.dart';

main() {
  runApp(
    const MaterialApp(
      home: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  ThemeData _buildTheme(Brightness brightness) {
    if (brightness == Brightness.light) {
      return ThemeData(
        useMaterial3: true,
        colorScheme: lightColorScheme,
        fontFamily: "LINESeedJP",
      );
    } else if (brightness == Brightness.dark) {
      return ThemeData(
        useMaterial3: true,
        colorScheme: darkColorScheme,
        fontFamily: "LINESeedJP",
      );
    } else {
      throw Error();
    }
  }

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      body: Container(
        width: size.width,
        height: size.height,
        color: Colors.grey,
        child: SafeArea(
          child: Stack(
            children: <Widget>[
              const Align(
                alignment: Alignment.center,
                child: Clock(),
              ),
              Align(
                alignment: Alignment.bottomCenter,
                child: Container(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    "Swipe up the screen",
                    style: Theme.of(context).textTheme.titleMedium?.apply(
                          color: Theme.of(context).colorScheme.onBackground,
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
