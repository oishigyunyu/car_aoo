import 'dart:async';

import 'package:car_app/view/menu.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class TopPage extends StatefulWidget {
  const TopPage({super.key});

  @override
  State<TopPage> createState() => _TopPage();
}

class _TopPage extends State<TopPage> {
  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;

    return SafeArea(
      child: Scaffold(
        body: SizedBox(
          width: size.width,
          height: size.height,
          child: Ink.image(
            image: const AssetImage("assets/static/images/dash.jpeg"),
            fit: BoxFit.fill,
            child: InkWell(
              splashColor:
                  Theme.of(context).colorScheme.surfaceVariant.withOpacity(0.5),
              onTap: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => const Menu(),
                  ),
                );
              },
              child: Stack(
                children: const <Widget>[
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
  final _now = DateTime.now();

  String _time = "";
  String _weekDay = "";
  String _date = "";

  String _getWeekDay() {
    return _weekDays.keys.elementAt(DateTime.now().weekday);
  }

  String _getCurrentTime() {
    return DateFormat.Hm().format(_now);
  }

  String _getCurrentDate() {
    return DateFormat("MM/dd").format(_now);
  }

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
      height: size.height / 4,
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
                style: Theme.of(context)
                    .textTheme
                    .titleLarge
                    ?.apply(color: Theme.of(context).colorScheme.background),
              ),
              Text(
                _time,
                style: Theme.of(context)
                    .textTheme
                    .displayLarge
                    ?.apply(color: Theme.of(context).colorScheme.background),
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
                    color: Theme.of(context).colorScheme.background,
                  ),
                  Text(
                    "18°",
                    style: Theme.of(context).textTheme.titleLarge?.apply(
                        color: Theme.of(context).colorScheme.background),
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
    );
  }
}
