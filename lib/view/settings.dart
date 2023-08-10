import 'package:car_app/utils/theme_mode_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

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
            child: ThemeModeTile(),
          ),
        ),
      ),
    );
  }
}


class ThemeModeTile extends ConsumerWidget {
  const ThemeModeTile({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final toggle = ref.read(themeModeProvider.notifier).toggle;

    switch (ref.watch(themeModeProvider)) {
      case (ThemeMode.light):
        return ListTile(
          leading: const Icon(Icons.light_mode_outlined),
          title: const Text('Light'),
          onTap: toggle,
        );
      case (ThemeMode.dark):
        return ListTile(
          leading: const Icon(Icons.dark_mode_outlined),
          title: const Text('Dark'),
          onTap: toggle,
        );
      case (ThemeMode.system):
        return ListTile(
          leading: const Icon(Icons.smartphone_outlined),
          title: const Text('System'),
          onTap: toggle,
        );
    }
  }
}