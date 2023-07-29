import 'package:car_app/color_schemes.g.dart';
import 'package:car_app/view/top.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final themeModeProvider = StateProvider<ThemeMode>((ref) => ThemeMode.system);

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersiveSticky);

  runApp(
    const ProviderScope(
      child: MyApp(),
    ),
  );
}

class MyApp extends ConsumerWidget {
  const MyApp({super.key});
  
  ThemeData _buildTheme(Brightness brightness) {
    if (brightness == Brightness.light) {
      return ThemeData(
        useMaterial3: true,
        colorScheme: lightColorScheme,
        fontFamily: "LINESeedJP",
      );
    } else if (brightness == Brightness.dark) {
      return ThemeData(
        useMaterial3: true,
        colorScheme: darkColorScheme,
        fontFamily: "LINESeedJP",
      );
    } else {
      throw Error();
    }
  }

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final themeMode = ref.watch(themeModeProvider.notifier);
    return MaterialApp(
      theme: _buildTheme(Brightness.light),
      darkTheme: _buildTheme(Brightness.dark),
      themeMode: themeMode.state,
      home: LayoutBuilder(
        builder: (context, constraints) {
          return const TopView(axis: "v");
        },
      ),
    );
  }
}
