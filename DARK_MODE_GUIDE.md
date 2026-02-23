# Act #7 - Third-Party Packages Integration: Light & Dark Mode Theme

**Author:** Liu, EJ F.  
**Date:** February 24, 2026  
**Status:** ✅ Complete and Functional

---

## 🎨 What Was Implemented

### Light & Dark Mode Theme Switching
The app now has **fully functional** theme switching between light and dark modes with persistent storage!

---

## 📦 Packages Used

### 1. **provider: ^6.1.1**
- **Purpose:** State management for theme mode
- **Why we use it:** Makes theme accessible throughout entire app without passing through widget constructors
- **How it works:** When theme changes, all widgets listening to Provider automatically rebuild

### 2. **shared_preferences: ^2.2.2**
- **Purpose:** Local data persistence
- **Why we use it:** Saves user's theme preference even after app closes
- **How it works:** Stores key-value pairs locally on device (works on all platforms)

---

## 📁 Files Created

### 1. **lib/src/providers/themeProvider.dart**
**Purpose:** Manages theme state across the entire app

**Key Components:**
```dart
class ThemeProvider extends ChangeNotifier {
  ThemeMode _themeMode = ThemeMode.light;
  
  // Toggle between light and dark
  Future<void> toggleTheme() async {
    _themeMode = _themeMode == ThemeMode.light 
        ? ThemeMode.dark 
        : ThemeMode.light;
    await _saveThemePreference();
    notifyListeners(); // Triggers rebuild
  }
  
  // Load saved preference on app start
  Future<void> _loadThemePreference() async {
    _prefs = await SharedPreferences.getInstance();
    final savedTheme = _prefs?.getString('theme_mode') ?? 'light';
    _themeMode = savedTheme == 'dark' ? ThemeMode.dark : ThemeMode.light;
    notifyListeners();
  }
}
```

**What it does:**
- ✅ Manages current theme mode (light/dark)
- ✅ Loads saved theme preference on app startup
- ✅ Saves theme preference to device storage
- ✅ Notifies all listeners when theme changes

**Extensive comments covering:**
- How ChangeNotifier works
- Provider pattern explained
- SharedPreferences usage
- When to use each feature

---

### 2. **lib/src/themes/appTheme.dart**
**Purpose:** Defines comprehensive light and dark themes

**Light Theme Features:**
- Primary color: #2E3B8E (Navy Blue)
- Clean, bright interface
- High contrast for daytime use
- White surfaces and cards

**Dark Theme Features:**
- Dark backgrounds (#121212 - not pure black)
- Lighter primary colors for visibility
- Reduced elevation/shadows
- Comfortable for nighttime use

**What's included:**
- ✅ Color schemes (primary, secondary, background, surface, error)
- ✅ Typography (14 text styles from displayLarge to labelSmall)
- ✅ AppBar theme
- ✅ Button themes (elevated, text buttons)
- ✅ Input decoration (TextField styling)
- ✅ Card theme
- ✅ Icon theme

**Extensive comments covering:**
- What each property does
- Why certain colors chosen
- Dark mode best practices
- How to use themes in widgets

---

## 🔨 Files Modified

### 1. **pubspec.yaml**
**Added:**
```yaml
dependencies:
  provider: ^6.1.1           # State management
  shared_preferences: ^2.2.2  # Data persistence
```

---

### 2. **lib/main.dart**
**Changes:**
- ✅ Wrapped app with `ChangeNotifierProvider`
- ✅ Imported `provider` package
- ✅ Imported theme definitions
- ✅ Set up theme switching

**Before:**
```dart
void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(...), // Long inline theme
      home: SplashScreen(),
    );
  }
}
```

**After:**
```dart
void main() {
  runApp(
    ChangeNotifierProvider(
      create: (context) => ThemeProvider(),
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  Widget build(BuildContext context) {
    final themeProvider = context.watch<ThemeProvider>();
    
    return MaterialApp(
      theme: lightTheme,              // Imported from appTheme.dart
      darkTheme: darkTheme,           // Imported from appTheme.dart
      themeMode: themeProvider.themeMode, // Dynamic theme switching
      home: SplashScreen(),
    );
  }
}
```

**Extensive comments covering:**
- Why Provider is at root level
- How context.watch works
- Theme switching mechanism
- Complete theme flow summary

---

### 3. **lib/src/views/settingsScreen.dart**
**Changes:**
- ✅ Imported `provider` package
- ✅ Imported `ThemeProvider`
- ✅ Removed local `_darkModeEnabled` state (now uses Provider)
- ✅ Connected dark mode toggle to ThemeProvider

**Before:**
```dart
bool _darkModeEnabled = false; // Local state

SwitchListTile(
  value: _darkModeEnabled,
  onChanged: (value) {
    setState(() {
      _darkModeEnabled = value;
    });
    // Shows "Coming soon" message
  },
)
```

**After:**
```dart
// Uses Provider instead of local state

final themeProvider = context.watch<ThemeProvider>();

SwitchListTile(
  // Value from Provider - automatically updates
  value: themeProvider.isDarkMode,
  
  // Icon changes based on theme
  secondary: Icon(
    themeProvider.isDarkMode 
        ? Icons.dark_mode 
        : Icons.light_mode_outlined,
  ),
  
  // Actually works now!
  onChanged: (value) async {
    await themeProvider.toggleTheme(); // Updates entire app
    
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          value ? '🌙 Dark mode enabled' : '☀️ Light mode enabled',
        ),
      ),
    );
  },
)
```

**Extensive comments covering:**
- Why we use Provider instead of setState
- How theme updates propagate
- Scope and variable passing
- Complete integration explanation

---

## 🎯 How It Works

### Complete Flow Diagram

```
┌─────────────────────────────────────────────────────────────┐
│                      APP STARTUP                            │
└─────────────────────────────────────────────────────────────┘
                              │
                              ▼
            1. main() creates ChangeNotifierProvider
                              │
                              ▼
            2. ThemeProvider() constructor runs
                              │
                              ▼
            3. Loads saved theme from SharedPreferences
                              │
            ┌─────────────────┴─────────────────┐
            │                                   │
            ▼                                   ▼
    Found 'dark' saved                  Found 'light' or nothing
            │                                   │
            ▼                                   ▼
    Sets ThemeMode.dark               Sets ThemeMode.light
            │                                   │
            └─────────────────┬─────────────────┘
                              ▼
            4. notifyListeners() called
                              │
                              ▼
            5. MyApp.build() runs
                              │
                              ▼
            6. context.watch<ThemeProvider>() gets theme
                              │
                              ▼
            7. MaterialApp applies correct theme
                              │
                              ▼
            8. All screens render with theme colors

┌─────────────────────────────────────────────────────────────┐
│                    USER CHANGES THEME                       │
└─────────────────────────────────────────────────────────────┘
                              │
                              ▼
            1. User opens Settings screen
                              │
                              ▼
            2. Taps Dark Mode toggle
                              │
                              ▼
            3. onChanged callback triggers
                              │
                              ▼
            4. themeProvider.toggleTheme() called
                              │
            ┌─────────────────┴─────────────────┐
            │                                   │
            ▼                                   ▼
    Currently light?                    Currently dark?
    Switch to dark                      Switch to light
            │                                   │
            └─────────────────┬─────────────────┘
                              ▼
            5. Save new preference to SharedPreferences
                              │
                              ▼
            6. notifyListeners() called
                              │
            ▼─────────────────┴─────────────────▼
    All widgets using Provider rebuild
            │                                   │
            ▼                                   ▼
    MyApp rebuilds              SettingsScreen rebuilds
            │                                   │
            ▼                                   ▼
    Gets new themeMode          Toggle switch updates
            │                                   │
            ▼                                   ▼
    MaterialApp switches        Icon changes
            │                                   │
            ▼                                   ▼
    Applies dark/light theme    Text updates
            │                                   │
            └───────────────────┬───────────────┘
                                ▼
            ALL screens instantly update!
            (Dashboard, Profile, Products, etc.)

┌─────────────────────────────────────────────────────────────┐
│                    NEXT APP LAUNCH                          │
└─────────────────────────────────────────────────────────────┘
                              │
                              ▼
        1. ThemeProvider loads from SharedPreferences
                              │
                              ▼
        2. Finds saved theme preference
                              │
                              ▼
        3. App starts with user's preferred theme
                              │
                              ▼
        4. No need to change theme again!
```

---

## 🎓 Key Concepts Explained (Beginner-Friendly)

### 1. **What is Provider?**
Think of Provider as a **"global variable manager"** for Flutter.

**Without Provider:**
```dart
// Have to pass theme through every widget
HomePage(theme: theme)
  ├─ ProfilePage(theme: theme)
  │   └─ SettingsPage(theme: theme)
  │       └─ ThemeToggle(theme: theme) // Finally can use it!
```

**With Provider:**
```dart
// Theme available everywhere automatically
HomePage() // Can access theme
  ├─ ProfilePage() // Can access theme
  │   └─ SettingsPage() // Can access theme
  │       └─ ThemeToggle() // Can access theme
```

**How to use:**
```dart
// Read value (widget rebuilds when value changes)
final themeProvider = context.watch<ThemeProvider>();

// Change value (triggers rebuild in all watchers)
themeProvider.toggleTheme();
```

---

### 2. **What is SharedPreferences?**
Think of it as **"sticky notes on your phone"** that Flutter can read/write.

**What you can save:**
- ✅ Strings: `"dark"`, `"English"`, `"John"`
- ✅ Numbers: `42`, `3.14`
- ✅ Booleans: `true`, `false`
- ✅ Lists: `["apple", "banana"]`

**What you CAN'T save:**
- ❌ Complex objects (use JSON + string instead)
- ❌ Large files (use file system)
- ❌ Sensitive data (use secure storage)

**How to use:**
```dart
// Save data
final prefs = await SharedPreferences.getInstance();
await prefs.setString('theme', 'dark');
await prefs.setBool('notifications', true);

// Read data
final theme = prefs.getString('theme') ?? 'light'; // Default to 'light'
final notifications = prefs.getBool('notifications') ?? true;

// Delete data
await prefs.remove('theme');
```

---

### 3. **What is ChangeNotifier?**
Think of it as a **"news broadcaster"** for your app.

**How it works:**
```dart
class ThemeProvider extends ChangeNotifier {
  ThemeMode _theme = ThemeMode.light;
  
  void toggleTheme() {
    _theme = _theme == ThemeMode.light 
        ? ThemeMode.dark 
        : ThemeMode.light;
    
    // 📢 "Hey everyone, theme changed!"
    notifyListeners(); 
  }
}

// Widgets "subscribe" to broadcasts
// When notifyListeners() called, they rebuild
```

**Three ways to listen:**
```dart
// 1. Watch - rebuilds when changes
final provider = context.watch<ThemeProvider>();

// 2. Read - gets value once, no rebuild
final provider = context.read<ThemeProvider>();

// 3. Select - only rebuild for specific property
final isDark = context.select((ThemeProvider p) => p.isDarkMode);
```

---

## 🧪 Testing The Feature

### Test Checklist

1. **Launch App**
   - [ ] App starts with default light theme
   - [ ] All screens show correct colors

2. **Enable Dark Mode**
   - [ ] Go to Settings screen
   - [ ] Toggle "Dark Mode" switch
   - [ ] Snackbar shows "🌙 Dark mode enabled"
   - [ ] Settings screen immediately changes to dark
   - [ ] Icon changes from sun to moon

3. **Navigate Around**
   - [ ] Go back to Dashboard - now dark
   - [ ] Go to Profile - now dark
   - [ ] Go to Products - now dark
   - [ ] All screens consistently dark

4. **Disable Dark Mode**
   - [ ] Toggle switch off in Settings
   - [ ] Snackbar shows "☀️ Light mode enabled"
   - [ ] All screens immediately switch to light
   - [ ] Icon changes from moon to sun

5. **Test Persistence**
   - [ ] Enable dark mode
   - [ ] Close app completely (swipe away from recent apps)
   - [ ] Reopen app
   - [ ] App starts in dark mode (preference saved!)

6. **Test Multiple Launches**
   - [ ] Switch theme multiple times
   - [ ] Close and reopen app
   - [ ] Theme persists each time

---

## 🎨 Theme Comparison

### Light Mode
![Light Mode Colors]
- **Background:** Light gray (#F5F5F5)
- **Surface (Cards):** White
- **Text:** Dark gray/black
- **Primary:** Navy blue (#2E3B8E)
- **Best for:** Daytime use, bright environments

### Dark Mode
![Dark Mode Colors]
- **Background:** Very dark gray (#121212)
- **Surface (Cards):** Dark gray (#1E1E1E)
- **Text:** White/light gray
- **Primary:** Lighter blue (#4A5AC7)
- **Best for:** Nighttime use, battery saving (OLED)

---

## 💡 Beginner Tips

### 1. **Understanding the Widget Tree**
```
ChangeNotifierProvider (Creates ThemeProvider)
    │
    └─ MyApp (Watches ThemeProvider)
        │
        └─ MaterialApp (Uses theme from Provider)
            │
            ├─ SplashScreen
            ├─ LoginScreen
            ├─ DashboardScreen
            ├─ ProfileScreen
            ├─ ProductsScreen
            └─ SettingsScreen (Can change theme)
```

### 2. **Why Provider Must Be At Top?**
Provider must wrap `MyApp` (not inside it) because:
- MaterialApp needs to access theme
- Any widget below Provider can access it
- Widgets above Provider cannot access it

### 3. **When Does notifyListeners() Get Called?**
Every time theme changes:
- User toggles switch ➡️ notifyListeners()
- App loads saved preference ➡️ notifyListeners()
- This triggers rebuild of all watching widgets

### 4. **Why Use async/await?**
SharedPreferences reads/writes to device storage:
- This takes time (milliseconds)
- async/await prevents app from freezing
- Always use await with SharedPreferences operations

---

## 🚀 What's Next? (Future Enhancements)

### Act #7 Extensions:
1. **Save Notification Preferences**
   ```dart
   // Similar to theme
   await prefs.setBool('notifications', true);
   ```

2. **Save Language Preference**
   ```dart
   await prefs.setString('language', 'English');
   ```

3. **Add More Theme Options**
   ```dart
   // ThemeMode.system - follows device setting
   themeMode: ThemeMode.system
   ```

4. **Create Theme Service**
   - Centralize all SharedPreferences operations
   - Make reusable for other preferences

---

## 📚 Additional Resources

### Official Documentation:
- **Provider:** https://pub.dev/packages/provider
- **SharedPreferences:** https://pub.dev/packages/shared_preferences
- **Flutter Themes:** https://docs.flutter.dev/cookbook/design/themes

### Learn More:
- Provider state management patterns
- Advanced SharedPreferences usage
- Creating custom themes
- Theme animations and transitions

---

## ✅ Summary

### What You Learned:
1. ✅ How to use Provider for state management
2. ✅ How to use SharedPreferences for data persistence
3. ✅ How to create light and dark themes
4. ✅ How to switch themes dynamically
5. ✅ How to persist user preferences
6. ✅ How Provider pattern works
7. ✅ When to use ChangeNotifier
8. ✅ How to structure theme files

### What Was Delivered:
- ✅ Fully functional light/dark mode
- ✅ Theme persistence across app restarts
- ✅ Clean, maintainable code structure
- ✅ Extensive beginner-friendly comments
- ✅ Professional-looking themes
- ✅ Third-party package integration

### Act #7 Status:
**COMPLETE** ✅ - Light and dark mode with Provider and SharedPreferences successfully implemented!

---

**Created with ❤️ for learning Flutter**  
**Date:** February 24, 2026  
**Version:** 1.0.0
