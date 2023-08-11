import 'package:car_app/color_schemes.g.dart';
import 'package:car_app/utils/shared_preferences_instances.dart';
import 'package:car_app/utils/theme_mode_provider.dart';
import 'package:car_app/view/top_view.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'firebase_options.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await SharedPreferencesInstance.initialize();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

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
    return MaterialApp(
      theme: _buildTheme(Brightness.light),
      darkTheme: _buildTheme(Brightness.dark),
      themeMode: ref.watch(themeModeProvider),
      home: const TopView(),
    );
  }
}
