import 'package:flutter/material.dart';

import 'app_theme.dart';
import 'create.dart';
import 'home.dart';
import 'library.dart';
import 'settings.dart';
import 'widgets/app_bottom_nav.dart';

class AppShell extends StatefulWidget {
  const AppShell({super.key});

  @override
  State<AppShell> createState() => _AppShellState();
}

class _AppShellState extends State<AppShell> {
  int _selectedIndex = 0;

  void _onSelected(int index) {
    if (index == _selectedIndex) return;
    setState(() => _selectedIndex = index);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: context.palette.background,
      body: IndexedStack(
        index: _selectedIndex,
        children: const [
          HomePage(),
          LibraryPage(),
          CreatePage(),
          SettingsPage(),
        ],
      ),
      bottomNavigationBar: AppBottomNav(
        selectedIndex: _selectedIndex,
        onSelected: _onSelected,
      ),
    );
  }
}
