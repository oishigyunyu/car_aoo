import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../main.dart';

class ThemeModeSelector extends StatelessWidget {
  const ThemeModeSelector({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        children: [
          ListTile(
            leading: const Icon(Icons.info_outline_rounded),
            title: const Text('About'),
            onTap: () => showLicensePage(context: context),
          ),
          const Divider(),
          const ThemeModeTile(),
        ],
      ),
    );
  }
}

class ThemeModeTile extends ConsumerWidget {
  const ThemeModeTile({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final toggle = ref.watch(themeModeProvider).toggle;
    switch (ref.watch(themeModeProvider)) {
      case ThemeMode.light:
        return ListTile(
          leading: const Icon(Icons.light_mode_rounded),
          title: const Text('Light'),
          onTap: toggle,
        );
      case ThemeMode.dark:
        return ListTile(
          leading: const Icon(Icons.dark_mode_rounded),
          title: const Text('Dark'),
          onTap: toggle,
        );
      case ThemeMode.system:
        return ListTile(
          leading: const Icon(Icons.smartphone_rounded),
          title: const Text('System'),
          onTap: toggle,
        );
    }
  }
}
