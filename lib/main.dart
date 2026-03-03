import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'src/views/splash_screen.dart';
import 'src/themes/app_theme.dart';
import 'src/providers/theme_provider.dart';

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
/// 8. Dark mode with persistent storage
void main() async {
  // Ensure Flutter bindings are initialized before async operations
  WidgetsFlutterBinding.ensureInitialized();
  
  // Initialize theme provider and load saved preference
  final themeProvider = await ThemeProvider.initialize();
  
  runApp(MyApp(themeProvider: themeProvider));
}

/// Root widget of the application
class MyApp extends StatelessWidget {
  final ThemeProvider themeProvider;
  
  const MyApp({super.key, required this.themeProvider});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider.value(
      value: themeProvider,
      child: Consumer<ThemeProvider>(
        builder: (context, themeProvider, child) {
          return MaterialApp(
            title: 'Liu',
            debugShowCheckedModeBanner: false,

            /// Light theme (tropical festival)
            theme: lightTheme,
            
            /// Dark theme (tropical night)
            darkTheme: darkTheme,
            
            /// Control theme mode via provider
            themeMode: themeProvider.isDarkMode ? ThemeMode.dark : ThemeMode.light,

            home: const SplashScreen(),
          );
        },
      ),
    );
  }
}
