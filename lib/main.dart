import 'package:flutter/material.dart';
import 'src/views/splashScreen.dart';

/// Main Entry Point of the Application
///
/// Liu, EJ F.
/// Activity #6: Multiple Screen Implementation
/// Activity #7: Third-party Packages Integration (Placeholders)
/// Activity #8: Custom Widgets Creation
///
/// This application demonstrates:
/// 1. Animated splash screen with transitions
/// 2. Multiple screens with navigation (5+ screens total)
/// 3. Different navigation patterns (push, pushReplacement, pushAndRemoveUntil)
/// 4. Theme management with ThemeData
/// 5. JSON data loading and parsing
/// 6. Responsive design with LayoutBuilder and MediaQuery
/// 7. Custom reusable widgets
/// 8. Animations and transitions
void main() {
  /// runApp() initializes Flutter framework and displays the app
  /// Must be called to start any Flutter application
  runApp(const MyApp());
}

/// Root widget of the application
/// StatelessWidget because app-level settings don't change during runtime
/// TODO (Act #7): Change to StatefulWidget for theme switching with Provider
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    /// MaterialApp - Root widget for Material Design apps
    /// Configures app-wide settings like theme, routes, and home screen
    return MaterialApp(
      /// App title shown in task switcher (Android) or window title bar (Desktop)
      title: 'UNI-VENTS',

      /// Remove debug banner in top-right corner
      /// Set to true during development to see debug info
      debugShowCheckedModeBanner: false,

      /// THEME CONFIGURATION:
      /// ThemeData defines the visual properties used throughout the app
      /// Using theme ensures consistency across all screens
      /// Benefits:
      /// 1. Consistent look and feel
      /// 2. Easy to change colors app-wide
      /// 3. Supports dark mode (can add darkTheme property)
      /// 4. Reduces code duplication
      theme: ThemeData(
        /// Primary color used for app bars, FABs, etc.
        primaryColor: const Color(0xFF2E3B8E),

        /// ColorScheme defines comprehensive color palette
        /// Material 3 uses color roles (primary, secondary, surface, etc.)
        colorScheme: ColorScheme.fromSeed(
          /// Seed color generates harmonious color palette
          seedColor: const Color(0xFF2E3B8E),
          primary: const Color(0xFF2E3B8E),
          secondary: const Color(0xFF4CAF50),

          /// Additional colors
          tertiary: const Color(0xFFFF9800),
          surface: Colors.white,
          background: Colors.grey.shade50,
          error: Colors.red.shade700,
        ),

        /// Use Material Design 3 (latest design system)
        /// Set to false for Material Design 2
        useMaterial3: true,

        /// Typography theme for text styles
        textTheme: const TextTheme(
          /// Display styles - Large headings
          displayLarge: TextStyle(
            fontSize: 32,
            fontWeight: FontWeight.bold,
            color: Color(0xFF2E3B8E),
          ),
          displayMedium: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),

          /// Headline styles - Section headers
          headlineMedium: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          headlineSmall: TextStyle(fontSize: 20, fontWeight: FontWeight.w600),

          /// Title styles - Card titles, list items
          titleLarge: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
          titleMedium: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),

          /// Body styles - Main content text
          bodyLarge: TextStyle(fontSize: 16),
          bodyMedium: TextStyle(fontSize: 14),

          /// Label styles - Button text, small labels
          labelLarge: TextStyle(fontSize: 14, fontWeight: FontWeight.w600),
        ),

        /// AppBar theme applied to all AppBars
        appBarTheme: const AppBarTheme(
          backgroundColor: Color(0xFF2E3B8E),
          foregroundColor: Colors.white,
          elevation: 0, // Flat design
          centerTitle: true,
          titleTextStyle: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),

        /// Button themes
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            backgroundColor: const Color(0xFF2E3B8E),
            foregroundColor: Colors.white,
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            elevation: 2,
          ),
        ),

        /// Input decoration theme for TextFields
        inputDecorationTheme: InputDecorationTheme(
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: const BorderSide(color: Color(0xFF2E3B8E), width: 2),
          ),
          filled: true,
          fillColor: Colors.grey.shade50,
        ),

        /// Card theme for consistent card styling
        cardTheme: CardThemeData(
          elevation: 4,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          clipBehavior: Clip.antiAlias,
        ),

        /// Icon theme
        iconTheme: const IconThemeData(color: Color(0xFF2E3B8E)),
      ),

      /// TODO (Act #7): Add dark theme support
      /// darkTheme: ThemeData.dark().copyWith(...),
      /// themeMode: ThemeMode.system, // Follows system theme

      /// Home screen - First screen shown when app starts
      /// Shows animated splash screen for 3 seconds
      /// Then automatically navigates to Login screen
      home: const SplashScreen(),

      /// TODO: Add named routes for easier navigation
      /// routes: {
      ///   '/splash': (context) => SplashScreen(),
      ///   '/login': (context) => LoginScreen(),
      ///   '/dashboard': (context) => DashboardScreen(),
      ///   '/profile': (context) => ProfileScreen(),
      /// },
    );
  }
}
