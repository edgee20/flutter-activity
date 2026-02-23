import 'package:flutter/material.dart';
import 'package:provider/provider.dart'; // Import Provider package
import 'src/views/splashScreen.dart';
import 'src/providers/themeProvider.dart'; // Import ThemeProvider
import 'src/themes/appTheme.dart'; // Import theme definitions

/// Main Entry Point of the Application
///
/// Liu, EJ F.
/// Activity #6: Multiple Screen Implementation
/// Activity #7: Third-party Packages Integration - Provider & SharedPreferences ✅
/// Activity #8: Custom Widgets Creation
///
/// This application demonstrates:
/// 1. Animated splash screen with transitions
/// 2. Multiple screens with navigation (6 screens total)
/// 3. Different navigation patterns (push, pushReplacement, pushAndRemoveUntil)
/// 4. Theme management with ThemeData (Light & Dark Mode) ✅
/// 5. JSON data loading and parsing
/// 6. Responsive design with LayoutBuilder and MediaQuery
/// 7. Custom reusable widgets
/// 8. Animations and transitions
/// 9. State management with Provider ✅
/// 10. Data persistence with SharedPreferences ✅
void main() {
  /// PROVIDER SETUP:
  /// We wrap the entire app with ChangeNotifierProvider
  /// This makes ThemeProvider available to ALL widgets in the app
  /// 
  /// WHY AT THIS LEVEL?
  /// - Provider must be ABOVE MyApp in widget tree
  /// - Any widget below can access it using Provider.of or context.watch
  /// - Perfect for app-wide settings like theme, language, auth state
  runApp(
    /// ChangeNotifierProvider - Creates and provides ThemeProvider
    /// 
    /// HOW IT WORKS:
    /// 1. create: Creates the provider instance once when app starts
    /// 2. Automatically calls ThemeProvider constructor (loads saved theme)
    /// 3. Makes provider available to all descendant widgets
    /// 4. Automatically disposes provider when no longer needed
    ChangeNotifierProvider(
      /// create callback runs once to create provider instance
      /// context parameter is available but not used here
      create: (context) => ThemeProvider(),
      
      /// child is the widget that will have access to the provider
      /// In this case, the entire app
      child: const MyApp(),
    ),
  );
}

/// Root widget of the application
/// 
/// PROVIDER INTEGRATION:
/// Now uses context.watch to listen to ThemeProvider changes
/// When theme changes, MyApp rebuilds automatically with new theme
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    /// WATCH THEME PROVIDER:
    /// context.watch<ThemeProvider>() listens to ThemeProvider
    /// 
    /// WHAT HAPPENS:
    /// 1. Gets current ThemeProvider instance
    /// 2. Registers this widget as a listener
    /// 3. When provider calls notifyListeners(), this widget rebuilds
    /// 4. Automatically gets updated theme mode
    /// 
    /// ALTERNATIVE SYNTAXES (all do the same thing):
    /// - context.watch<ThemeProvider>() ✅ (recommended, shortest)
    /// - Provider.of<ThemeProvider>(context) (older syntax)
    /// - Consumer<ThemeProvider>(builder: ...) (for specific widget rebuilds)
    final themeProvider = context.watch<ThemeProvider>();
    /// MaterialApp - Root widget for Material Design apps
    /// Configures app-wide settings like theme, routes, and home screen
    return MaterialApp(
      /// App title shown in task switcher (Android) or window title bar (Desktop)
      title: 'UNI-VENTS',

      /// Remove debug banner in top-right corner
      /// Set to true during development to see debug info
      debugShowCheckedModeBanner: false,

      /// LIGHT THEME:
      /// Default theme shown during day or when light mode selected
      /// Imported from src/themes/appTheme.dart
      /// 
      /// WHY SEPARATE FILE?
      /// - Keeps main.dart clean and focused
      /// - Theme definitions are long and detailed
      /// - Easier to maintain and modify
      /// - Can be reused across multiple apps
      theme: lightTheme,
      
      /// DARK THEME:
      /// Alternative theme for dark mode
      /// Automatically applied when themeMode is ThemeMode.dark
      /// 
      /// DARK MODE BENEFITS:
      /// - Reduces eye strain in low light
      /// - Saves battery on OLED screens
      /// - Modern, professional look
      /// - User preference (many prefer dark mode)
      darkTheme: darkTheme,
      
      /// THEME MODE:
      /// Controls which theme to use (light, dark, or system)
      /// Gets value from ThemeProvider (managed by Provider package)
      /// 
      /// THREE OPTIONS:
      /// - ThemeMode.light: Always use light theme
      /// - ThemeMode.dark: Always use dark theme
      /// - ThemeMode.system: Follow device system setting
      /// 
      /// HOW IT UPDATES:
      /// 1. User toggles theme in Settings screen
      /// 2. ThemeProvider.toggleTheme() is called
      /// 3. Provider calls notifyListeners()
      /// 4. MyApp rebuilds with new themeMode
      /// 5. MaterialApp switches between light/dark theme
      /// 6. All screens automatically update
      themeMode: themeProvider.themeMode,

      /// Home screen - First screen shown when app starts
      /// Shows animated splash screen for 3 seconds
      /// Then automatically navigates to Login screen
      home: const SplashScreen(),

      /// NAMED ROUTES (Future Enhancement):
      /// Instead of Navigator.push() with MaterialPageRoute,
      /// you can use Navigator.pushNamed('/dashboard')
      /// 
      /// EXAMPLE:
      /// routes: {
      ///   '/splash': (context) => const SplashScreen(),
      ///   '/login': (context) => const LoginScreen(),
      ///   '/dashboard': (context) => const DashboardScreen(),
      ///   '/profile': (context) => const ProfileScreen(),
      ///   '/products': (context) => const ProductsScreen(),
      ///   '/settings': (context) => const SettingsScreen(),
      /// },
      /// 
      /// Navigation becomes simpler:
      /// Navigator.pushNamed(context, '/dashboard');
      /// 
      /// Benefits:
      /// - Cleaner code
      /// - Centralized route management
      /// - Easier deep linking
      /// - Type-safe with code generation tools
    );
  }
}

/// COMPLETE THEME FLOW SUMMARY:
/// 
/// 1. APP STARTUP:
///    - main() creates ChangeNotifierProvider with ThemeProvider
///    - ThemeProvider constructor loads saved theme from SharedPreferences
///    - MyApp builds with initial theme mode
/// 
/// 2. USER CHANGES THEME:
///    - User taps toggle in Settings screen
///    - Settings calls themeProvider.toggleTheme()
///    - ThemeProvider switches mode and saves to SharedPreferences
///    - notifyListeners() triggers rebuild
/// 
/// 3. APP REBUILDS:
///    - MyApp.build() runs again
///    - context.watch notices ThemeProvider changed
///    - MaterialApp gets new themeMode
///    - Flutter switches between light/dark theme
///    - All widgets update with new theme colors
/// 
/// 4. NEXT APP LAUNCH:
///    - ThemeProvider loads saved preference
///    - App starts with user's preferred theme
///    - No need to change theme again
/// 
/// 
/// PACKAGE INTEGRATION SUMMARY (Act #7):
/// 
/// ✅ provider: ^6.1.1
///    - State management for theme
///    - Makes theme accessible app-wide
///    - Automatic widget rebuilds
/// 
/// ✅ shared_preferences: ^2.2.2
///    - Persists theme preference
///    - Works offline
///    - Cross-platform support
/// 
/// FILES CREATED:
/// - lib/src/providers/themeProvider.dart (Theme state management)
/// - lib/src/themes/appTheme.dart (Light & dark theme definitions)
/// 
/// FILES MODIFIED:
/// - lib/main.dart (Provider setup and theme integration)
/// - pubspec.yaml (Added packages)
/// - lib/src/views/settingsScreen.dart (Theme toggle functionality)

