import 'dart:async';
import 'package:car_app/utils/position.dart';
import 'package:car_app/utils/theme_mode_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:geolocator/geolocator.dart';
import 'package:intl/intl.dart';
import 'menu_view.dart';
import 'package:geocoding/geocoding.dart' as geo_coding;

class TopView extends ConsumerWidget {
  const TopView({super.key});

  Widget _buildFairLadyZLogo(BuildContext context) {
    return SvgPicture.asset(
      'assets/static/images/nissan_fairlady_z_1.svg',
      colorFilter: ColorFilter.mode(
          Theme.of(context).colorScheme.primary, BlendMode.srcIn),
    );
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      body: GestureDetector(
        onTap: () {
          determinePosition();
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) => const MenuView(),
            ),
          );
        },
        child: Container(
          width: size.width,
          height: size.height,
          color: Theme.of(context).colorScheme.background,
          child: SafeArea(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      Icon(
                        Icons.location_on_outlined,
                        color: Theme.of(context).colorScheme.onBackground,
                      ),
                      const CurrentPositionWidget(),
                    ],
                  ),
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    const Clock(),
                    _buildFairLadyZLogo(context),
                  ],
                ),
                Container(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    "Swipe up the screen",
                    style: Theme.of(context).textTheme.titleMedium?.apply(
                          color: Theme.of(context).colorScheme.onBackground,
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
    return Container(
      padding: const EdgeInsets.all(8.0),
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

class CurrentPositionWidget extends StatefulWidget {
  const CurrentPositionWidget({super.key});

  @override
  State<CurrentPositionWidget> createState() => _CurrentPositionWidgetState();
}

class _CurrentPositionWidgetState extends State<CurrentPositionWidget> {

  Future<Map<String, String>> _getCurrentPosition() async {
    Map<String, String> pos = await determinePosition();
    return Future.value(pos);
  }


  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return FutureBuilder(
      future: _getCurrentPosition(),
      builder:
          (BuildContext context, AsyncSnapshot<Map<String, String>> snapshot) {
        if (snapshot.connectionState != ConnectionState.done) {
          return SizedBox(
            height: size.height / 30,
            width: size.height / 30,
            child: const CircularProgressIndicator(
              strokeWidth: 2.0,
            ),
          );
        }

        if (snapshot.hasError) {
          return Text(snapshot.error.toString());
        }

        if (snapshot.hasData) {
          final pos = snapshot.data;
          return Text(
            '${pos?['locality'].toString()}, ${pos?['administrativeArea'].toString()}',
            style: Theme.of(context)
                .textTheme
                .titleMedium
                ?.apply(color: Theme.of(context).colorScheme.onBackground),
          );
        } else {
          return const Text('データが存在しません');
        }
      },
    );
  }
}
