import 'package:flutter_riverpod/flutter_riverpod.dart';

/// Theme Mode Provider
///
/// Manages the app's theme state (light/dark mode)
class ThemeModeNotifier extends StateNotifier<bool> {
  ThemeModeNotifier() : super(false); // false = light theme, true = dark theme

  /// Toggle between light and dark theme
  void toggleTheme() {
    state = !state;
  }

  /// Set specific theme mode
  void setDarkMode(bool isDark) {
    state = isDark;
  }

  /// Get current theme mode
  bool get isDarkMode => state;
  bool get isLightMode => !state;
}

/// Provider for Theme Mode State
final themeModeProvider = StateNotifierProvider<ThemeModeNotifier, bool>((ref) {
  return ThemeModeNotifier();
});
