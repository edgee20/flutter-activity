import 'package:flutter/material.dart';

/// App Theme Definitions
///
/// This file contains the complete theme configurations for both light and dark modes.
///
/// WHAT IS A THEME?
/// A theme is a collection of colors, fonts, and styles that define how your app looks.
/// Instead of setting colors for each widget individually, you define them once here
/// and Flutter applies them throughout your app automatically.
///
/// BENEFITS:
/// 1. Consistency - Same look across entire app
/// 2. Easy updates - Change color once, updates everywhere
/// 3. Dark mode - Just switch between light/dark theme
/// 4. Professional - Apps look polished and cohesive

/// LIGHT THEME
/// This is the default theme shown when app starts (unless user saved dark preference)
final ThemeData lightTheme = ThemeData(
  /// Tells Flutter we're using Material Design 3 (newest version)
  /// MD3 has more modern, rounded components
  useMaterial3: true,

  /// BRIGHTNESS:
  /// Tells Flutter this is a light theme
  /// Some widgets automatically adjust their behavior based on this
  brightness: Brightness.light,

  /// PRIMARY COLOR:
  /// Main brand color used throughout app
  /// Used for: AppBar, buttons, highlights, etc.
  primaryColor: const Color(0xFF2E3B8E), // Navy blue
  /// COLOR SCHEME:
  /// Complete set of colors for your app
  /// Flutter automatically generates complementary colors
  colorScheme: ColorScheme.fromSeed(
    /// Seed color - Flutter generates other colors from this
    seedColor: const Color(0xFF2E3B8E),

    /// Explicitly set brightness (light mode)
    brightness: Brightness.light,

    /// Primary color - Main brand color
    primary: const Color(0xFF2E3B8E),

    /// Secondary color - Accent color for variety
    /// Used for: Floating action buttons, chips, etc.
    secondary: const Color(0xFF4CAF50), // Green
    /// Error color - For error messages and warnings
    error: const Color(0xFFD32F2F), // Red
    /// Surface color - Background for cards, sheets, etc.
    surface: Colors.white,
  ),

  /// SCAFFOLD BACKGROUND:
  /// Default background color for Scaffold widgets
  /// Most screens use Scaffold, so this sets overall background
  scaffoldBackgroundColor: const Color(0xFFF5F5F5),

  /// APPBAR THEME:
  /// Consistent styling for all AppBars in the app
  appBarTheme: const AppBarTheme(
    backgroundColor: Color(0xFF2E3B8E),
    foregroundColor: Colors.white,
    elevation: 2,
    centerTitle: false,
    titleTextStyle: TextStyle(
      color: Colors.white,
      fontSize: 20,
      fontWeight: FontWeight.w600,
    ),
  ),

  /// TEXT THEME:
  /// Complete typography system with different text styles
  /// Instead of manually setting font size every time, use these styles
  textTheme: const TextTheme(
    /// Display styles - Largest text (hero sections, splash screens)
    displayLarge: TextStyle(
      fontSize: 57,
      fontWeight: FontWeight.bold,
      color: Colors.black87,
    ),
    displayMedium: TextStyle(
      fontSize: 45,
      fontWeight: FontWeight.bold,
      color: Colors.black87,
    ),
    displaySmall: TextStyle(
      fontSize: 36,
      fontWeight: FontWeight.bold,
      color: Colors.black87,
    ),

    /// Headline styles - Section headers, titles
    headlineLarge: TextStyle(
      fontSize: 32,
      fontWeight: FontWeight.bold,
      color: Colors.black87,
    ),
    headlineMedium: TextStyle(
      fontSize: 28,
      fontWeight: FontWeight.w600,
      color: Colors.black87,
    ),
    headlineSmall: TextStyle(
      fontSize: 24,
      fontWeight: FontWeight.w600,
      color: Colors.black87,
    ),

    /// Title styles - Card titles, list titles
    titleLarge: TextStyle(
      fontSize: 22,
      fontWeight: FontWeight.w600,
      color: Colors.black87,
    ),
    titleMedium: TextStyle(
      fontSize: 18,
      fontWeight: FontWeight.w500,
      color: Colors.black87,
    ),
    titleSmall: TextStyle(
      fontSize: 16,
      fontWeight: FontWeight.w500,
      color: Colors.black87,
    ),

    /// Body styles - Main content text
    bodyLarge: TextStyle(
      fontSize: 16,
      fontWeight: FontWeight.normal,
      color: Colors.black87,
    ),
    bodyMedium: TextStyle(
      fontSize: 14,
      fontWeight: FontWeight.normal,
      color: Colors.black87,
    ),
    bodySmall: TextStyle(
      fontSize: 12,
      fontWeight: FontWeight.normal,
      color: Colors.black87,
    ),

    /// Label styles - Button text, form labels
    labelLarge: TextStyle(
      fontSize: 14,
      fontWeight: FontWeight.w500,
      color: Colors.black87,
    ),
    labelMedium: TextStyle(
      fontSize: 12,
      fontWeight: FontWeight.w500,
      color: Colors.black87,
    ),
    labelSmall: TextStyle(
      fontSize: 11,
      fontWeight: FontWeight.w500,
      color: Colors.black87,
    ),
  ),

  /// ELEVATED BUTTON THEME:
  /// Styling for all ElevatedButtons (raised buttons with shadow)
  elevatedButtonTheme: ElevatedButtonThemeData(
    style: ElevatedButton.styleFrom(
      backgroundColor: const Color(0xFF2E3B8E),
      foregroundColor: Colors.white,
      elevation: 3,
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
    ),
  ),

  /// TEXT BUTTON THEME:
  /// Styling for TextButtons (flat buttons without background)
  textButtonTheme: TextButtonThemeData(
    style: TextButton.styleFrom(
      foregroundColor: const Color(0xFF2E3B8E),
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
    ),
  ),

  /// INPUT DECORATION THEME:
  /// Styling for TextFields and form inputs
  inputDecorationTheme: InputDecorationTheme(
    filled: true,
    fillColor: Colors.grey.shade50,
    border: OutlineInputBorder(
      borderRadius: BorderRadius.circular(12),
      borderSide: BorderSide(color: Colors.grey.shade300),
    ),
    enabledBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(12),
      borderSide: BorderSide(color: Colors.grey.shade300),
    ),
    focusedBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(12),
      borderSide: const BorderSide(color: Color(0xFF2E3B8E), width: 2),
    ),
    errorBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(12),
      borderSide: const BorderSide(color: Color(0xFFD32F2F)),
    ),
    contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
  ),

  /// CARD THEME:
  /// Styling for Card widgets
  cardTheme: CardThemeData(
    elevation: 4,
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
    color: Colors.white,
  ),

  /// ICON THEME:
  /// Default icon styling
  iconTheme: const IconThemeData(color: Colors.black87, size: 24),
);

/// DARK THEME
/// Alternative theme for dark mode
/// Uses darker colors that are easier on eyes in low light
final ThemeData darkTheme = ThemeData(
  useMaterial3: true,

  /// BRIGHTNESS:
  /// Tells Flutter this is a dark theme
  brightness: Brightness.dark,

  /// Primary color stays same for brand consistency
  primaryColor: const Color(0xFF2E3B8E),

  /// DARK COLOR SCHEME:
  /// Different background and surface colors for dark mode
  colorScheme: ColorScheme.fromSeed(
    seedColor: const Color(0xFF2E3B8E),
    brightness: Brightness.dark,
    primary: const Color(0xFF4A5AC7), // Lighter blue for dark backgrounds
    secondary: const Color(0xFF66BB6A), // Lighter green for visibility
    error: const Color(0xFFEF5350),

    /// Dark mode uses darker surfaces and backgrounds
    surface: const Color(0xFF1E1E1E), // Dark gray
  ),

  /// SCAFFOLD BACKGROUND:
  /// Very dark gray (better than pure black)
  /// Pure black (#000000) can cause smearing on OLED screens
  scaffoldBackgroundColor: const Color(0xFF121212),

  /// APPBAR THEME (Dark Mode):
  /// Slightly lighter than background for distinction
  appBarTheme: const AppBarTheme(
    backgroundColor: Color(0xFF1E1E1E),
    foregroundColor: Colors.white,
    elevation: 0, // Flat design in dark mode
    centerTitle: false,
    titleTextStyle: TextStyle(
      color: Colors.white,
      fontSize: 20,
      fontWeight: FontWeight.w600,
    ),
  ),

  /// TEXT THEME (Dark Mode):
  /// Lighter text colors for dark backgrounds
  textTheme: const TextTheme(
    displayLarge: TextStyle(
      fontSize: 57,
      fontWeight: FontWeight.bold,
      color: Colors.white,
    ),
    displayMedium: TextStyle(
      fontSize: 45,
      fontWeight: FontWeight.bold,
      color: Colors.white,
    ),
    displaySmall: TextStyle(
      fontSize: 36,
      fontWeight: FontWeight.bold,
      color: Colors.white,
    ),

    headlineLarge: TextStyle(
      fontSize: 32,
      fontWeight: FontWeight.bold,
      color: Colors.white,
    ),
    headlineMedium: TextStyle(
      fontSize: 28,
      fontWeight: FontWeight.w600,
      color: Colors.white,
    ),
    headlineSmall: TextStyle(
      fontSize: 24,
      fontWeight: FontWeight.w600,
      color: Colors.white,
    ),

    titleLarge: TextStyle(
      fontSize: 22,
      fontWeight: FontWeight.w600,
      color: Colors.white,
    ),
    titleMedium: TextStyle(
      fontSize: 18,
      fontWeight: FontWeight.w500,
      color: Colors.white,
    ),
    titleSmall: TextStyle(
      fontSize: 16,
      fontWeight: FontWeight.w500,
      color: Colors.white,
    ),

    bodyLarge: TextStyle(
      fontSize: 16,
      fontWeight: FontWeight.normal,
      color: Colors.white70,
    ),
    bodyMedium: TextStyle(
      fontSize: 14,
      fontWeight: FontWeight.normal,
      color: Colors.white70,
    ),
    bodySmall: TextStyle(
      fontSize: 12,
      fontWeight: FontWeight.normal,
      color: Colors.white60,
    ),

    labelLarge: TextStyle(
      fontSize: 14,
      fontWeight: FontWeight.w500,
      color: Colors.white,
    ),
    labelMedium: TextStyle(
      fontSize: 12,
      fontWeight: FontWeight.w500,
      color: Colors.white,
    ),
    labelSmall: TextStyle(
      fontSize: 11,
      fontWeight: FontWeight.w500,
      color: Colors.white,
    ),
  ),

  /// ELEVATED BUTTON THEME (Dark Mode):
  elevatedButtonTheme: ElevatedButtonThemeData(
    style: ElevatedButton.styleFrom(
      backgroundColor: const Color(0xFF4A5AC7),
      foregroundColor: Colors.white,
      elevation: 2,
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
    ),
  ),

  /// TEXT BUTTON THEME (Dark Mode):
  textButtonTheme: TextButtonThemeData(
    style: TextButton.styleFrom(
      foregroundColor: const Color(0xFF4A5AC7),
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
    ),
  ),

  /// INPUT DECORATION THEME (Dark Mode):
  inputDecorationTheme: InputDecorationTheme(
    filled: true,
    fillColor: const Color(0xFF2C2C2C), // Dark gray for inputs
    border: OutlineInputBorder(
      borderRadius: BorderRadius.circular(12),
      borderSide: const BorderSide(color: Color(0xFF404040)),
    ),
    enabledBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(12),
      borderSide: const BorderSide(color: Color(0xFF404040)),
    ),
    focusedBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(12),
      borderSide: const BorderSide(color: Color(0xFF4A5AC7), width: 2),
    ),
    errorBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(12),
      borderSide: const BorderSide(color: Color(0xFFEF5350)),
    ),
    contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
  ),

  /// CARD THEME (Dark Mode):
  cardTheme: CardThemeData(
    elevation: 3,
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
    color: const Color(0xFF1E1E1E), // Dark card background
  ),

  /// ICON THEME (Dark Mode):
  iconTheme: const IconThemeData(color: Colors.white, size: 24),
);

/// HOW TO USE THESE THEMES:
/// 
/// In main.dart:
/// MaterialApp(
///   theme: lightTheme,        // Used when ThemeMode.light
///   darkTheme: darkTheme,     // Used when ThemeMode.dark
///   themeMode: ThemeMode.system, // Follow device system setting
/// )
/// 
/// 
/// ACCESSING THEME IN WIDGETS:
/// 
/// // Get current theme
/// final theme = Theme.of(context);
/// 
/// // Use theme colors
/// Container(color: theme.primaryColor)
/// 
/// // Use text styles
/// Text('Hello', style: theme.textTheme.headlineMedium)
/// 
/// // Check if dark mode
/// final isDark = theme.brightness == Brightness.dark;
/// 
/// 
/// DARK MODE BEST PRACTICES:
/// 
/// 1. USE DARK GRAY, NOT PURE BLACK:
///    - Pure black (#000000) causes smearing on OLED
///    - Use #121212 or similar dark gray
/// 
/// 2. REDUCE ELEVATION:
///    - Dark mode cards should have less shadow
///    - Use subtle borders instead of shadows
/// 
/// 3. DESATURATE COLORS:
///    - Bright colors hurt eyes in dark mode
///    - Use slightly muted/darker versions
/// 
/// 4. SUFFICIENT CONTRAST:
///    - Ensure text is readable (WCAG AA standard)
///    - Use white70 or white60 for body text
/// 
/// 5. TEST IN LOW LIGHT:
///    - Dark mode for comfortable viewing at night
///    - Should reduce eye strain
