import 'package:flutter/material.dart';

class Settings extends StatefulWidget {
  const Settings({Key? key}) : super(key: key);
  @override
  State<Settings> createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      body: SafeArea(
        child: Container(
          width: size.width,
          height: size.height,
          padding: const EdgeInsets.all(8.0),
          child: const Center(
            child: Text("WIP"),
          ),
        ),
      ),
    );
  }
}
