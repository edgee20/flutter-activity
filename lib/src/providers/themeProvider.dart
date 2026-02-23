import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

/// ThemeProvider - Manages Theme State Across the App
/// 
/// PURPOSE:
/// This class manages the theme mode (light/dark) for the entire application.
/// It uses Provider pattern for state management and SharedPreferences for persistence.
/// 
/// KEY CONCEPTS:
/// 
/// 1. ChangeNotifier - A Flutter class that provides change notification to listeners
///    - When theme changes, it notifies all widgets listening to it
///    - Widgets automatically rebuild with new theme
/// 
/// 2. Provider Pattern - A state management solution for Flutter
///    - Makes data available to widgets without passing through constructors
///    - Reduces code complexity and improves maintainability
/// 
/// 3. SharedPreferences - Local storage for simple key-value pairs
///    - Saves user preferences even after app closes
///    - Works across all platforms (Android, iOS, Web, Desktop)
/// 
/// BEGINNER EXPLANATION:
/// Think of this as a "theme manager" that:
/// - Remembers if user prefers dark or light mode
/// - Tells all screens to update when theme changes
/// - Saves the choice so it persists across app restarts
class ThemeProvider extends ChangeNotifier {
  /// Private variable to store current theme mode
  /// ThemeMode is an enum with three values:
  /// - ThemeMode.light: Always use light theme
  /// - ThemeMode.dark: Always use dark theme
  /// - ThemeMode.system: Follow device system theme
  ThemeMode _themeMode = ThemeMode.light;
  
  /// SharedPreferences instance for saving/loading theme preference
  /// This is initialized when app starts
  SharedPreferences? _prefs;
  
  /// Key used to store theme preference in SharedPreferences
  /// Using a constant prevents typos when reading/writing
  static const String _themeModeKey = 'theme_mode';
  
  /// Constructor - Called when ThemeProvider is first created
  /// Automatically loads saved theme preference
  ThemeProvider() {
    _loadThemePreference();
  }
  
  /// Getter - Returns current theme mode
  /// Other widgets can read this but not modify directly
  /// Example usage: themeProvider.themeMode
  ThemeMode get themeMode => _themeMode;
  
  /// Getter - Checks if dark mode is currently active
  /// Returns true if dark mode, false if light mode
  /// Useful for showing correct icon in settings
  bool get isDarkMode => _themeMode == ThemeMode.dark;
  
  /// Load theme preference from local storage
  /// 
  /// ASYNC/AWAIT EXPLAINED:
  /// - async: Function performs time-consuming operations
  /// - await: Pause here until operation completes
  /// - This prevents app from freezing while loading data
  Future<void> _loadThemePreference() async {
    /// Initialize SharedPreferences
    /// This connects to device's local storage
    /// Only needs to be done once when app starts
    _prefs = await SharedPreferences.getInstance();
    
    /// Read saved theme mode from storage
    /// If nothing saved, defaults to 'light'
    /// SharedPreferences stores data as strings, so we convert later
    final savedTheme = _prefs?.getString(_themeModeKey) ?? 'light';
    
    /// Convert string to ThemeMode enum
    /// Why? SharedPreferences only stores primitive types (string, int, bool)
    /// We need to convert back to ThemeMode enum for Flutter to use
    _themeMode = savedTheme == 'dark' ? ThemeMode.dark : ThemeMode.light;
    
    /// Notify all listeners that theme has been loaded
    /// This makes widgets rebuild with correct theme
    /// First time this runs, it sets the initial theme
    notifyListeners();
  }
  
  /// Toggle between light and dark theme
  /// 
  /// WHAT HAPPENS:
  /// 1. Change theme mode
  /// 2. Save new preference to storage
  /// 3. Notify all widgets to rebuild with new theme
  Future<void> toggleTheme() async {
    /// Switch theme mode
    /// If currently dark, switch to light; if light, switch to dark
    _themeMode = _themeMode == ThemeMode.light 
        ? ThemeMode.dark 
        : ThemeMode.light;
    
    /// Save new theme preference to local storage
    /// This ensures theme persists even after app closes
    await _saveThemePreference();
    
    /// IMPORTANT: notifyListeners() tells Flutter to rebuild widgets
    /// All widgets using Provider will automatically rebuild
    /// This is what makes the theme change visible immediately
    notifyListeners();
  }
  
  /// Set specific theme mode (light or dark)
  /// 
  /// DIFFERENCE FROM toggleTheme():
  /// - toggleTheme(): Switches between light/dark
  /// - setThemeMode(): Sets to specific mode
  /// 
  /// USE CASE:
  /// - toggleTheme(): For a switch button
  /// - setThemeMode(): For a dropdown with multiple options
  Future<void> setThemeMode(ThemeMode mode) async {
    /// Only update if theme actually changed
    /// Prevents unnecessary rebuilds and storage writes
    if (_themeMode == mode) return;
    
    _themeMode = mode;
    await _saveThemePreference();
    notifyListeners();
  }
  
  /// Save theme preference to local storage
  /// 
  /// SHAREDPREFERENCES METHODS:
  /// - setString(): Save a string value
  /// - getString(): Read a string value
  /// - setBool(): Save a boolean value
  /// - setInt(): Save an integer value
  /// - remove(): Delete a saved value
  /// - clear(): Delete all saved values
  Future<void> _saveThemePreference() async {
    /// Convert ThemeMode enum to string for storage
    /// SharedPreferences can only store primitive types
    final themeString = _themeMode == ThemeMode.dark ? 'dark' : 'light';
    
    /// Save to local storage with key 'theme_mode'
    /// This overwrites any previous value with same key
    await _prefs?.setString(_themeModeKey, themeString);
  }
}

/// PROVIDER PATTERN - HOW IT WORKS:
/// 
/// 1. CREATE PROVIDER (in main.dart):
///    ChangeNotifierProvider(
///      create: (context) => ThemeProvider(),
///      child: MyApp(),
///    )
/// 
/// 2. READ VALUE (in any widget):
///    final themeProvider = Provider.of<ThemeProvider>(context);
///    or
///    context.watch<ThemeProvider>()
/// 
/// 3. MODIFY VALUE (in any widget):
///    themeProvider.toggleTheme();
/// 
/// 4. AUTOMATIC UPDATES:
///    When notifyListeners() is called, all widgets listening
///    to this provider automatically rebuild with new values.
/// 
/// 
/// BENEFITS OF PROVIDER:
/// 
/// 1. CENTRALIZED STATE:
///    - Theme state in one place, accessible everywhere
///    - No need to pass data through multiple widget constructors
/// 
/// 2. AUTOMATIC UPDATES:
///    - Change theme once, all screens update automatically
///    - No manual widget rebuilds needed
/// 
/// 3. CLEAN CODE:
///    - Separates business logic from UI
///    - Easier to test and maintain
/// 
/// 4. PERFORMANCE:
///    - Only widgets that use Provider rebuild
///    - Rest of the app stays unchanged
/// 
/// 
/// SHAREDPREFERENCES - WHEN TO USE:
/// 
/// ✅ GOOD FOR:
/// - User preferences (theme, language, notifications)
/// - Simple settings (remember me, autoplay)
/// - Small amounts of data (< 1MB)
/// - Basic app state that should persist
/// 
/// ❌ NOT GOOD FOR:
/// - Large amounts of data (use SQLite or Hive instead)
/// - Sensitive data (use secure storage instead)
/// - Complex data structures (use proper database)
/// - Files and images (use file system)
/// 
/// 
/// COMPLETE EXAMPLE - Setting up theme:
/// 
/// // main.dart
/// void main() {
///   runApp(
///     ChangeNotifierProvider(
///       create: (context) => ThemeProvider(),
///       child: MyApp(),
///     ),
///   );
/// }
/// 
/// class MyApp extends StatelessWidget {
///   Widget build(BuildContext context) {
///     final themeProvider = context.watch<ThemeProvider>();
///     
///     return MaterialApp(
///       theme: lightTheme,
///       darkTheme: darkTheme,
///       themeMode: themeProvider.themeMode,
///       home: HomeScreen(),
///     );
///   }
/// }
/// 
/// // Any screen
/// class SettingsScreen extends StatelessWidget {
///   Widget build(BuildContext context) {
///     final themeProvider = context.watch<ThemeProvider>();
///     
///     return Switch(
///       value: themeProvider.isDarkMode,
///       onChanged: (value) => themeProvider.toggleTheme(),
///     );
///   }
/// }
