import 'package:flutter/material.dart';

class ThemeModeSelectionPage extends StatefulWidget {
  final ThemeMode mode;
  const ThemeModeSelectionPage({
    Key? key,
    required this.mode,
  }) : super(key: key);

  @override
  State<ThemeModeSelectionPage> createState() => _ThemeModeSelectionPageState();
}

class _ThemeModeSelectionPageState extends State<ThemeModeSelectionPage> {
  late ThemeMode _current;

  @override
  void initState() {
    super.initState();
    _current = widget.mode;
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      body: SafeArea(
        child: Container(
          width: size.width,
          height: size.height,
          padding: const EdgeInsets.all(8.0),
          child: ListView(
            children: <Widget>[
              ListTile(
                leading: IconButton(
                  icon: const Icon(Icons.arrow_back),
                  onPressed: () => Navigator.pop(context),
                ),
              ),
              RadioListTile<ThemeMode>(
                value: ThemeMode.system,
                groupValue: _current,
                title: const Text("System"),
                onChanged: (val) => {setState(() => _current = val!)},
              ),
              RadioListTile<ThemeMode>(
                value: ThemeMode.dark,
                groupValue: _current,
                title: const Text("Dark"),
                onChanged: (val) => {setState(() => _current = val!)},
              ),
              RadioListTile<ThemeMode>(
                value: ThemeMode.light,
                groupValue: _current,
                title: const Text("Light"),
                onChanged: (val) => {setState(() => _current = val!)},
              ),
            ],
          ),
        ),
      ),
    );
  }
}
