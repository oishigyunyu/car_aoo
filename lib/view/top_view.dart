import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'menu_view.dart';


class TopView extends ConsumerWidget {
  const TopView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      body: GestureDetector(
        onTap: () {
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) => const MenuView(),
            ),
          );
        },
        child: Container(
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
                            color: Theme.of(context).colorScheme.onSecondary,
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
      color: Colors.cyan,
      child: Center(
        child: Text(
          _time,
          style: Theme.of(context).textTheme.displayMedium?.apply(
            color: Theme.of(context).colorScheme.onPrimary,
          ),
        ),
      ),
    );
  }
}