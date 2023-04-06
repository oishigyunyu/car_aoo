import 'package:flutter/material.dart';

import 'menu.dart';

class TopPage extends StatefulWidget {
  const TopPage({super.key, required this.title});
  final String title;

  @override
  State<TopPage> createState() => _TopPage();
}

class _TopPage extends State<TopPage> {
  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    var now = DateTime.now();
    final List<String> days = ['Sun', 'Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat'];
    final List<String> months = [
      'Jan',
      'Feb',
      'Mar',
      'Apr',
      'May',
      'Jun',
      'Jul',
      'Aug',
      'Sep',
      'Oct',
      'Nov',
      'Dec'
    ];
    return SafeArea(
      child: Scaffold(
        body: GestureDetector(
          onTap: () {
            Navigator.of(context).push(
              MaterialPageRoute(builder: (context) => const Menu()),
            );
          },
          behavior: HitTestBehavior.opaque,
          child: Container(
            width: size.width,
            height: size.height,
            padding: const EdgeInsets.all(8.0),
            decoration:
                BoxDecoration(color: Theme.of(context).colorScheme.background),
          ),
        ),
      ),
    );
  }
}
