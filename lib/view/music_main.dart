import 'package:flutter/material.dart';

class MusicMain extends StatefulWidget {
  const MusicMain({Key? key}) : super(key: key);

  @override
  State<MusicMain> createState() => _MusicMainState();
}

class _MusicMainState extends State<MusicMain> {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
      body: SafeArea(
        child: Container(
          width: size.width,
          height: size.height,
          padding: const EdgeInsets.all(8.0),
          child: Center(
            child: Text(
              "WIP",
              style: Theme.of(context).textTheme.headlineSmall,
            ),
          ),
        ),
      ),
    );
  }
}
