import 'package:flutter/material.dart';
import 'src/views/splash_screen.dart';
import 'src/themes/app_theme.dart'; // Import theme definitions

/// Main Entry Point of the Application
///
/// Liu, EJ F.
/// Activity #6: Multiple Screen Implementation
/// Activity #8: Custom Widgets Creation
///
/// This application demonstrates:
/// 1. Animated splash screen with transitions
/// 2. Multiple screens with navigation (6 screens total)
/// 3. Different navigation patterns (push, pushReplacement, pushAndRemoveUntil)
/// 4. JSON data loading and parsing
/// 5. Responsive design with LayoutBuilder and MediaQuery
/// 6. Custom reusable widgets
/// 7. Animations and transitions
void main() {
  runApp(const MyApp());
}

/// Root widget of the application
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'UNI-VENTS',
      debugShowCheckedModeBanner: false,

      /// Use light theme only
      theme: lightTheme,

      home: const SplashScreen(),
    );
  }
}
