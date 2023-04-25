import 'package:car_app/color_schemes.g.dart';
import 'package:car_app/shared_preferences_instance.dart';
import 'package:car_app/view/top.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final themeModeProvider = StateProvider<ThemeMode>((ref) => ThemeMode.system);

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await SharedPreferencesInstance.initialize();

  runApp(
    const ProviderScope(
      child: MyApp(),
    ),
  );
}

class MyApp extends ConsumerWidget {
  const MyApp({super.key});

  Widget _buildVertical(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      body: SafeArea(
        child: Container(
          width: size.width,
          height: size.height,
          padding: const EdgeInsets.all(8.0),
          child: Center(
            child: Text(
              "vertical is WIP",
              style: Theme.of(context).textTheme.displayMedium,
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildHorizontal(BuildContext context) {
    return const TopPage(
      direction: "horizontal",
    );
  }

  ThemeData _buildTheme(Brightness brightness) {
    final ColorScheme colorScheme;
    if (brightness == Brightness.light) {
      colorScheme = lightColorScheme;
    } else if (brightness == Brightness.dark) {
      colorScheme = darkColorScheme;
    } else {
      throw Error();
    }
    return ThemeData(
        useMaterial3: true, colorScheme: colorScheme, fontFamily: "LINESeedJP");
  }

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return MaterialApp(
      theme: _buildTheme(Brightness.light),
      darkTheme: _buildTheme(Brightness.dark),
      themeMode: ref.watch(themeModeProvider),
      home: LayoutBuilder(
        builder: (context, constraints) {
          return constraints.maxWidth < constraints.maxHeight
              ? _buildVertical(context)
              : _buildHorizontal(context);
        },
      ),
    );
  }
}
