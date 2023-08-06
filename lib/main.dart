import 'dart:async';

import 'package:car_app/color_schemes.g.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';

final themeModeProvider = StateProvider((ref) => ThemeMode.system);

main() {
  runApp(
    const ProviderScope(
      child: MyApp(),
    ),
  );
}

class MyApp extends ConsumerWidget {
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
  Widget build(BuildContext context, WidgetRef ref) {
    final themeMode = ref.watch(themeModeProvider);
    final size = MediaQuery.of(context).size;
    return MaterialApp(
      theme: _buildTheme(Brightness.light),
      darkTheme: _buildTheme(Brightness.dark),
      themeMode: themeMode,
      home: Scaffold(
        appBar: AppBar(
          title: const Text("brightness demo"),
          actions: [
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: PopupMenuButton<ThemeMode>(
                icon: const Icon(
                  Icons.settings_brightness,
                ),
                onSelected: (ThemeMode selectedThemeMode) => ref
                    .read(themeModeProvider.notifier)
                    .update((state) => selectedThemeMode),
                itemBuilder: (context) => <PopupMenuEntry<ThemeMode>>[
                  const PopupMenuItem(
                    value: ThemeMode.system,
                    child: Text("システム設定に従う"),
                  ),
                  const PopupMenuItem(
                    value: ThemeMode.light,
                    child: Text("ライトモード"),
                  ),
                  const PopupMenuItem(
                    value: ThemeMode.dark,
                    child: Text("ダークモード"),
                  ),
                ],
              ),
            ),
          ],
        ),
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
      ),
    );
  }
}

class Clock extends StatefulWidget {
  const Clock({Key? key}) : super(key: key);

  @override
  State<Clock> createState() => _ClockState();
}

class _ClockState extends State<Clock> {
  String _time = "";

  @override
  void initState() {
    super.initState();
    Timer.periodic(const Duration(seconds: 1), _onTimer);
  }

  void _onTimer(Timer timer) {
    var timeString = DateFormat.Hm().format(DateTime.now());
    setState(() {
      _time = timeString;
    });
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Container(
      padding: const EdgeInsets.all(8.0),
      width: size.width,
      height: size.height / 5,
      color: Colors.cyan,
      child: Center(
        child: Text(
          _time,
          style: Theme.of(context).textTheme.displaySmall?.apply(
                color: Theme.of(context).colorScheme.onPrimary,
              ),
        ),
      ),
    );
  }
}
