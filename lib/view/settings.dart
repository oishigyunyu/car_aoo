import 'package:car_app/view/theme_mode_selection_page.dart';
import 'package:flutter/material.dart';

class Settings extends StatefulWidget {
  const Settings({Key? key}) : super(key: key);
  @override
  State<Settings> createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {
  ThemeMode _themeMode = ThemeMode.system;
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
            children: [
              ListTile(
                leading: IconButton(
                  icon: const Icon(Icons.arrow_back),
                  onPressed: () => Navigator.pop(context),
                ),
              ),
              ListTile(
                leading: const Icon(Icons.lightbulb),
                title: const Text('Dark/Light Mode'),
                trailing: Text((_themeMode == ThemeMode.system)
                    ? 'System'
                    : (_themeMode == ThemeMode.dark ? 'Dark' : 'Light')),
                onTap: () async {
                  var ret = await Navigator.of(context).push<ThemeMode>(
                    MaterialPageRoute(
                      builder: (context) =>
                          ThemeModeSelectionPage(mode: _themeMode),
                    ),
                  );
                  setState(() => _themeMode = ret!);
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
