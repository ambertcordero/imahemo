import 'package:flutter/material.dart';

import 'app_shell.dart';
import 'app_theme.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final AppThemeController _themeController = AppThemeController();

  @override
  void dispose() {
    _themeController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AppThemeScope(
      controller: _themeController,
      child: Builder(
        builder: (context) {
          final isLight = context.themeController.isLight;

          return MaterialApp(
            title: 'IMAHEMO',
            debugShowCheckedModeBanner: false,
            themeMode: isLight ? ThemeMode.light : ThemeMode.dark,
            theme: AppTheme.light(),
            darkTheme: AppTheme.dark(),
            home: const AppShell(),
          );
        },
      ),
    );
  }
}
