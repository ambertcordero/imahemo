import 'package:flutter/material.dart';

@immutable
class AppPalette {
  const AppPalette({
    required this.isLight,
    required this.background,
    required this.surface,
    required this.surfaceVariant,
    required this.border,
    required this.accent,
    required this.textPrimary,
    required this.textSecondary,
    required this.textMuted,
    required this.danger,
  });

  final bool isLight;
  final Color background;
  final Color surface;
  final Color surfaceVariant;
  final Color border;
  final Color accent;
  final Color textPrimary;
  final Color textSecondary;
  final Color textMuted;
  final Color danger;

  static const AppPalette dark = AppPalette(
    isLight: false,
    background: Color(0xFF0B101A),
    surface: Color(0xFF17212D),
    surfaceVariant: Color(0xFF151D29),
    border: Color(0xFF263141),
    accent: Color(0xFF35C7D9),
    textPrimary: Color(0xFFF1F3F8),
    textSecondary: Color(0xFFB5C0CE),
    textMuted: Color(0xFF929EAF),
    danger: Color(0xFFE66B70),
  );

  static const AppPalette light = AppPalette(
    isLight: true,
    background: Color(0xFFEDF5F7),
    surface: Color(0xFFFFFFFF),
    surfaceVariant: Color(0xFFFFFFFF),
    border: Color(0xFFD5E0E6),
    accent: Color(0xFF0E9FB5),
    textPrimary: Color(0xFF0F1826),
    textSecondary: Color(0xFF4A5A6B),
    textMuted: Color(0xFF6E7E90),
    danger: Color(0xFFD64550),
  );
}

class AppThemeController extends ChangeNotifier {
  bool _isLight = false;

  bool get isLight => _isLight;

  AppPalette get palette => _isLight ? AppPalette.light : AppPalette.dark;

  void toggle() {
    _isLight = !_isLight;
    notifyListeners();
  }

  void setLight(bool value) {
    if (value == _isLight) return;
    _isLight = value;
    notifyListeners();
  }
}

class AppThemeScope extends InheritedNotifier<AppThemeController> {
  const AppThemeScope({
    super.key,
    required AppThemeController controller,
    required super.child,
  }) : super(notifier: controller);

  static AppThemeController controllerOf(BuildContext context) {
    final scope = context
        .dependOnInheritedWidgetOfExactType<AppThemeScope>();
    assert(scope != null, 'AppThemeScope was not found in the widget tree.');
    return scope!.notifier!;
  }

  static AppPalette paletteOf(BuildContext context) =>
      controllerOf(context).palette;
}

extension AppThemeContext on BuildContext {
  AppPalette get palette => AppThemeScope.paletteOf(this);

  AppThemeController get themeController => AppThemeScope.controllerOf(this);
}

class AppTheme {
  const AppTheme._();

  static ThemeData light() => ThemeData(
    useMaterial3: true,
    brightness: Brightness.light,
    scaffoldBackgroundColor: AppPalette.light.background,
    fontFamily: 'Inter',
  );

  static ThemeData dark() => ThemeData(
    useMaterial3: true,
    brightness: Brightness.dark,
    scaffoldBackgroundColor: AppPalette.dark.background,
    fontFamily: 'Inter',
  );
}
