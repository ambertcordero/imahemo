import 'package:flutter/material.dart';

import '../app_theme.dart';

class AppBottomNav extends StatelessWidget {
  const AppBottomNav({
    super.key,
    required this.selectedIndex,
    required this.onSelected,
  });

  final int selectedIndex;
  final ValueChanged<int> onSelected;

  static const List<(IconData, String)> items = [
    (Icons.home_outlined, 'Home'),
    (Icons.menu_book_outlined, 'Library'),
    (Icons.edit_outlined, 'Create'),
    (Icons.settings_outlined, 'Settings'),
  ];

  @override
  Widget build(BuildContext context) {
    final palette = context.palette;

    return Container(
      decoration: BoxDecoration(
        color: palette.surfaceVariant,
        border: Border(top: BorderSide(color: palette.border, width: 0.5)),
      ),
      child: SafeArea(
        top: false,
        child: SizedBox(
          height: 89,
          child: Row(
            children: List.generate(items.length, (index) {
              final bool isSelected = selectedIndex == index;
              final (icon, label) = items[index];

              return Expanded(
                child: GestureDetector(
                  onTap: () => onSelected(index),
                  behavior: HitTestBehavior.opaque,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        icon,
                        size: 24,
                        color: isSelected
                            ? palette.accent
                            : palette.textMuted,
                      ),
                      const SizedBox(height: 7),
                      Text(
                        label,
                        style: TextStyle(
                          color: isSelected
                              ? palette.accent
                              : palette.textMuted,
                          fontSize: 13,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ],
                  ),
                ),
              );
            }),
          ),
        ),
      ),
    );
  }
}
