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
                child: Text("Swipe up the screen",style: Theme.of(context).textTheme.displayMedium?.apply(
                  color: Theme.of(context).colorScheme.onBackground,
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
      width: size.width * 3 / 4,
      height: size.height / 8,
      color: Colors.cyan,
      child: Center(
        child: Text(
          _time,
          style: Theme.of(context).textTheme.displayMedium?.apply(
            color: Theme.of(context).colorScheme.onBackground,
          ),
        ),
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
