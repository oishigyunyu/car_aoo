import 'dart:async';

import 'package:car_app/theme_mode_provider.dart';
import 'package:car_app/view/menu.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';

class TopView extends ConsumerWidget {
  final String axis;
  const TopView({Key? key, required this.axis}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final size = MediaQuery.of(context).size;
    StateController<ThemeMode> themeMode = ref.read(themeModeProvider.notifier);
    return Scaffold(
      appBar: AppBar(
        title: const Text("Brightness Demo"),
        actions: [
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: PopupMenuButton<ThemeMode>(
              icon: const Icon(
                Icons.settings_brightness,
              ),
              // themeMode.state に選択された 外観モード をセットする
              onSelected: (ThemeMode selectedThemeMode) =>
                  themeMode.state = selectedThemeMode,
              itemBuilder: (context) => <PopupMenuEntry<ThemeMode>>[
                const PopupMenuItem(
                  value: ThemeMode.system,
                  child: Text('システム設定に従う'),
                ),
                const PopupMenuItem(
                  value: ThemeMode.light,
                  child: Text('ライトモード'),
                ),
                const PopupMenuItem(
                  value: ThemeMode.dark,
                  child: Text('ダークモード'),
                ),
              ],
            ),
          ),
        ],
      ),
      body: SizedBox(
        width: size.width,
        height: size.height,
        child: Ink.image(
          image: const AssetImage("assets/static/images/nissan_logo_white.png"),
          fit: BoxFit.cover,
          child: SafeArea(
            child: InkWell(
              splashColor:
                  Theme.of(context).colorScheme.surfaceVariant.withOpacity(0.9),
              onTap: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => Menu(
                      direction: axis,
                    ),
                  ),
                );
              },
              child: const Stack(
                children: <Widget>[
                  Align(
                    alignment: Alignment.topLeft,
                    child: Padding(
                      padding: EdgeInsets.all(16.0),
                      child: SleepButton(),
                    ),
                  ),
                  Align(
                    alignment: Alignment.bottomLeft,
                    child: Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Clock(),
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class SleepButton extends StatelessWidget {
  const SleepButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton.large(
      backgroundColor: Theme.of(context).colorScheme.primaryContainer,
      onPressed: () {},
      child: Icon(
        Icons.power_settings_new,
        color: Theme.of(context).colorScheme.onPrimaryContainer,
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
  final Map<String, int> _weekDays = {
    "Mon": DateTime.monday,
    "Tue": DateTime.tuesday,
    "Wed": DateTime.wednesday,
    "Thu": DateTime.thursday,
    "Fri": DateTime.friday,
    "Sat": DateTime.saturday,
    "Sun": DateTime.sunday,
  };

  String _time = "";
  String _weekDay = "";
  String _date = "";

  @override
  void initState() {
    super.initState();
    Timer.periodic(const Duration(seconds: 1), _onTimer);
  }

  void _onTimer(Timer timer) {
    var now = DateTime.now();
    var timeString = DateFormat.Hm().format(now);
    var dateString = DateFormat("MM/dd").format(now);
    var weekDayString = _weekDays.keys.elementAt(now.weekday);
    setState(() {
      _time = timeString;
      _date = dateString;
      _weekDay = weekDayString;
    });
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Container(
      padding: const EdgeInsets.all(8.0),
      width: size.width / 3,
      height: size.height / 4 + 10,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.end,
        textBaseline: TextBaseline.ideographic,
        children: <Widget>[
          Column(
            mainAxisAlignment: MainAxisAlignment.end,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                "$_date ($_weekDay)",
                style: Theme.of(context).textTheme.titleLarge?.apply(
                      color: Theme.of(context).colorScheme.onBackground,
                    ),
              ),
              Text(
                _time,
                style: Theme.of(context).textTheme.displayMedium?.apply(
                      color: Theme.of(context).colorScheme.onBackground,
                    ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class WeatherWidget extends StatefulWidget {
  const WeatherWidget({Key? key}) : super(key: key);

  @override
  State<WeatherWidget> createState() => _WeatherWidgetState();
}

class _WeatherWidgetState extends State<WeatherWidget> {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Column(
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
              color: Theme.of(context).colorScheme.onBackground,
            ),
            Text(
              "18°",
              style: Theme.of(context).textTheme.titleLarge?.apply(
                    color: Theme.of(context).colorScheme.onBackground,
                  ),
            ),
          ],
        ),
        const SizedBox(
          height: 6,
        )
      ],
    );
  }
}
