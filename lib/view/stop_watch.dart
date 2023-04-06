import 'package:flutter/material.dart';
import 'package:stop_watch_timer/stop_watch_timer.dart';

class StopWatch extends StatefulWidget {
  const StopWatch({Key? key}) : super(key: key);

  @override
  State<StopWatch> createState() => _StopWatchState();
}

class _StopWatchState extends State<StopWatch> {
  final _stopWatchTimer = StopWatchTimer();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              MaterialButton(
                onPressed: _stopWatchTimer.onStartTimer,
                padding: const EdgeInsets.all(16.0),
                color: Colors.blue,
                textColor: Colors.white,
                shape: const CircleBorder(),
                child: const Icon(Icons.watch_later_outlined),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
