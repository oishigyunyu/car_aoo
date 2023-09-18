import 'package:flutter/material.dart';

class MusicMainView extends StatefulWidget {
  const MusicMainView({Key? key}) : super(key: key);

  @override
  State<MusicMainView> createState() => _MusicMainViewState();
}

class _MusicMainViewState extends State<MusicMainView> {
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
              style: Theme.of(context).textTheme.displayMedium,
            ),
          ),
        ),
      ),
    );
  }
}
