import 'package:car_app/utils/theme_mode_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class SettingsView extends StatelessWidget {
  const SettingsView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(),
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
          subtitle: Text(
            'Light',
            style: Theme.of(context)
                .textTheme
                .labelSmall
                ?.apply(color: Theme.of(context).colorScheme.onBackground),
          ),
          title: Text(
            'ThemeMode',
            style: Theme.of(context)
                .textTheme
                .labelLarge
                ?.apply(color: Theme.of(context).colorScheme.onBackground),
          ),
          onTap: toggle,
        );
      case (ThemeMode.dark):
        return ListTile(
          leading: const Icon(Icons.dark_mode_outlined),
          subtitle: Text(
            'Dark',
            style: Theme.of(context)
                .textTheme
                .labelSmall
                ?.apply(color: Theme.of(context).colorScheme.onBackground),
          ),
          title: Text(
            'ThemeMode',
            style: Theme.of(context)
                .textTheme
                .labelLarge
                ?.apply(color: Theme.of(context).colorScheme.onBackground),
          ),
          onTap: toggle,
        );
      case (ThemeMode.system):
        return ListTile(
          leading: const Icon(Icons.smartphone_outlined),
          subtitle: Text(
            'System',
            style: Theme.of(context)
                .textTheme
                .labelSmall
                ?.apply(color: Theme.of(context).colorScheme.onBackground),
          ),
          title: Text(
            'ThemeMode',
            style: Theme.of(context)
                .textTheme
                .labelLarge
                ?.apply(color: Theme.of(context).colorScheme.onBackground),
          ),
          onTap: toggle,
        );
    }
  }
}
