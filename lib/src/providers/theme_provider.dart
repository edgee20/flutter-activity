import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

/// ThemeProvider - Manages Dark Mode State with Persistence
///
/// This provider handles:
/// - Current theme state (light/dark)
/// - Saving theme preference to device storage
/// - Loading saved theme on app startup
/// - Notifying all screens when theme changes
///
/// Uses ChangeNotifier for state management:
/// When isDarkMode changes, notifyListeners() tells all widgets to rebuild
class ThemeProvider with ChangeNotifier {
  /// Private field for dark mode state
  bool _isDarkMode = false;

  /// SharedPreferences instance for persistent storage
  SharedPreferences? _prefs;

  /// Storage key constant
  static const String _themeKey = 'isDarkMode';

  /// Public getter for dark mode state
  bool get isDarkMode => _isDarkMode;

  /// Constructor - loads saved theme preference
  ThemeProvider() {
    _loadThemePreference();
  }

  /// Load saved theme preference from device storage
  Future<void> _loadThemePreference() async {
    _prefs = await SharedPreferences.getInstance();
    _isDarkMode = _prefs?.getBool(_themeKey) ?? false;
    notifyListeners(); // Update UI with loaded preference
  }

  /// Toggle theme and save preference
  Future<void> toggleTheme() async {
    _isDarkMode = !_isDarkMode;

    // Save to persistent storage
    if (_prefs != null) {
      await _prefs!.setBool(_themeKey, _isDarkMode);
    }

    // Notify all listening widgets to rebuild
    notifyListeners();
  }

  /// Set theme explicitly (useful for settings screen)
  Future<void> setTheme(bool isDark) async {
    if (_isDarkMode == isDark) return; // No change needed

    _isDarkMode = isDark;

    // Save to persistent storage
    if (_prefs != null) {
      await _prefs!.setBool(_themeKey, _isDarkMode);
    }

    notifyListeners();
  }

  /// Initialize SharedPreferences before app starts
  /// Call this in main() before runApp()
  static Future<ThemeProvider> initialize() async {
    final provider = ThemeProvider();
    await provider._loadThemePreference();
    return provider;
  }
}
