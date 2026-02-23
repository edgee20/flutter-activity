# UNI-VENTS - University Events Management App

**Author:** Liu, EJ F.  
**Activities:** #6, #7, #8  
**Date:** February 24, 2026

## 📱 About The Application

UNI-VENTS is a comprehensive Flutter application for managing university events and workshops. This app demonstrates multiple Flutter concepts including navigation, theming, JSON data handling, responsive design, and custom widgets.

## ✨ Features Implemented

### Act #6: Multiple Screen Implementation

#### 1. **Multiple Screens (6 Screens Total)**

- **Splash Screen** - Animated intro screen with fade and scale effects
- **Login Screen** (Screen 1) - User authentication interface
- **Dashboard Screen** (Screen 2) - Main hub showing events
- **Profile Screen** (Screen 3) - User profile and statistics
- **Products/Events Screen** (Screen 4) - Browse events with JSON data
- **Settings Screen** (Screen 5) - App preferences and account settings

#### 2. **Navigation Patterns**

**a) push() - Forward Navigation**

- Used when user should be able to go back
- Examples:
  - Dashboard → Profile
  - Dashboard → Products
  - Profile → Settings
  - Bottom navigation bar items
- Navigation Stack: [Screen A, Screen B]
- Back button returns to previous screen

**b) pushReplacement() - Replace Navigation**

- Used when you don't want user to go back to previous screen
- Examples:
  - Splash → Login (after 3 seconds)
  - Login → Dashboard (after successful login)
- Navigation Stack: [Screen B] (Screen A is removed)
- Back button exits app or goes to earlier screen

**c) pushAndRemoveUntil() - Clear Stack Navigation**

- Used to remove all previous screens from navigation history
- Example:
  - Settings → Login (logout action)
- Navigation Stack: [Login Screen] (all others removed)
- Prevents going back to authenticated screens after logout

#### 3. **Theme Implementation**

**Comprehensive ThemeData with:**

- Primary color scheme (Blue: #2E3B8E)
- Typography hierarchy (Display, Headline, Title, Body, Label)
- AppBar theme (consistent across all screens)
- Button themes (ElevatedButton styling)
- Input decoration (TextField styling)
- Card theme (consistent card appearance)
- Icon theme (default icon colors)

**Benefits:**

- Consistent look and feel across all screens
- Easy to change app-wide colors in one place
- Supports future dark mode implementation
- Reduces code duplication

#### 4. **JSON Data Implementation**

**Location:** `assets/data/products.json`

**Features:**

- Local JSON file with 8 event/workshop items
- Async data loading using `rootBundle.loadString()`
- JSON parsing with `json.decode()`
- Error handling for loading failures
- Display in responsive GridView
- Filter by category
- Detailed product information dialog

**Data Structure:**

```json
{
  "id": 1,
  "name": "Event Name",
  "category": "Category",
  "price": 500.0,
  "rating": 4.8,
  "description": "Description",
  "instructor": "Instructor Name",
  "duration": "Duration",
  "students": 245
}
```

#### 5. **Responsive Design**

**Techniques Used:**

**a) LayoutBuilder**

- Detects parent widget constraints
- Determines device type (phone/tablet)
- Adjusts layout based on available space
- Example: Profile screen adapts padding and font sizes

**b) MediaQuery**

- Gets screen dimensions (width/height)
- Adapts layouts to screen size
- Example: Dashboard adjusts card sizes

**c) Responsive GridView**

- Phone (< 600px): 1 column
- Tablet (600-900px): 2 columns
- Desktop (> 900px): 3 columns

**d) Conditional Styling**

- Font sizes adjust for tablet/phone
- Padding changes based on device
- Icon sizes scale appropriately

#### 6. **Animations**

**Splash Screen Animations:**

- Fade animation (opacity 0.0 → 1.0)
- Scale animation (size 0.5 → 1.0)
- Custom page transition (fade) to Login
- Duration: 3 seconds display + 500ms transition

**Animation Components:**

- AnimationController (timing control)
- Tween (value range definition)
- CurvedAnimation (easing curves)
- AnimatedBuilder (efficient rebuilds)
- FadeTransition (built-in fade effect)

### Act #7: Third-Party Packages Integration (Placeholders)

**Prepared for future implementation:**

- `http` - API calls for authentication and data fetching
- `provider` - State management for theme switching
- `shared_preferences` - Store user preferences and login state
- Comments marked with `TODO (Act #7)` indicate integration points

### Act #8: Custom Widgets Creation

**Location:** `lib/src/widgets/customWidgets.dart`

**8 Reusable Custom Widgets:**

1. **CustomButton** - Consistent button styling with loading state
2. **CustomTextField** - Styled text input with validation
3. **CustomCard** - Card container with shadow and tap support
4. **InfoCard** - Statistics card with icon, title, and value
5. **SectionHeader** - Page section headers with optional actions
6. **EmptyState** - Empty list/grid placeholder
7. **LoadingOverlay** - Full-screen loading indicator
8. **CategoryBadge** - Category label with icon and color
9. **RatingStars** - Star rating display component
10. **ResponsiveBuilder** - Helper for responsive layouts

**Benefits:**

- Code reusability across screens
- Consistent UI/UX
- Easier maintenance
- Cleaner, more readable code

## 🎨 App Theme

**Primary Color:** #2E3B8E (Navy Blue)  
**Secondary Color:** #4CAF50 (Green)  
**Accent Color:** #FF9800 (Orange)  
**Design System:** Material Design 3

## 📂 Project Structure

```
lib/
├── main.dart                          # App entry point
├── src/
    ├── views/                         # Screen widgets
    │   ├── splashScreen.dart         # Animated splash (6th screen)
    │   ├── loginScreen.dart          # Authentication screen (1st)
    │   ├── dashboardScreen.dart      # Main hub (2nd)
    │   ├── profileScreen.dart        # User profile (3rd)
    │   ├── productsScreen.dart       # Events list with JSON (4th)
    │   └── settingsScreen.dart       # App settings (5th)
    └── widgets/                       # Custom reusable widgets
        └── customWidgets.dart        # 10+ custom widgets

assets/
├── data/
│   └── products.json                 # Local JSON data
├── images/                            # Image assets
├── logo/                              # App logo
├── fonts/                             # Custom fonts (if any)
└── videos/                            # Video assets
```

## 🚀 Getting Started

### Prerequisites

- Flutter SDK (3.10.7 or higher)
- Dart SDK (included with Flutter)
- Android Studio / VS Code with Flutter extensions
- Android emulator or physical device

### Installation Steps

1. **Clone/Extract the project**

   ```bash
   cd flutter_application_1
   ```

2. **Get dependencies**

   ```bash
   flutter pub get
   ```

3. **Run the application**

   ```bash
   flutter run
   ```

4. **Build APK (Android)**

   ```bash
   flutter build apk --release
   ```

5. **Build App Bundle (for Play Store)**
   ```bash
   flutter build appbundle
   ```

## 📱 How to Configure App Name

### Android

Edit `android/app/src/main/AndroidManifest.xml`:

```xml
<application
    android:label="UNI-VENTS"
    ...>
```

### iOS

Edit `ios/Runner/Info.plist`:

```xml
<key>CFBundleName</key>
<string>UNI-VENTS</string>
<key>CFBundleDisplayName</key>
<string>UNI-VENTS</string>
```

## 🎯 How to Configure Launcher Icon

### Option 1: Using flutter_launcher_icons package (Recommended)

1. **Add package to `pubspec.yaml`:**

```yaml
dev_dependencies:
  flutter_launcher_icons: ^0.13.1

flutter_launcher_icons:
  android: true
  ios: true
  image_path: "assets/logo/app_icon.png"
  min_sdk_android: 21
  adaptive_icon_background: "#2E3B8E"
  adaptive_icon_foreground: "assets/logo/app_icon_foreground.png"
```

2. **Prepare icon image:**
   - Create a 1024x1024 PNG image
   - Place it in `assets/logo/app_icon.png`
   - For adaptive icons (Android), create foreground layer

3. **Generate icons:**

```bash
flutter pub get
flutter pub run flutter_launcher_icons
```

### Option 2: Manual Configuration

#### Android

1. Create icon files for different densities:
   - mdpi: 48x48
   - hdpi: 72x72
   - xhdpi: 96x96
   - xxhdpi: 144x144
   - xxxhdpi: 192x192

2. Place in `android/app/src/main/res/mipmap-**/ic_launcher.png`

#### iOS

1. Create icon for different sizes (see Apple guidelines)
2. Use Xcode to add to `ios/Runner/Assets.xcassets/AppIcon.appiconset/`

### Quick Icon Generator Tools

- **Online:** https://appicon.co/
- **Android Studio:** Right-click res → New → Image Asset
- **Xcode:** Assets.xcassets → AppIcon

## 📖 Key Concepts Explained

### Navigation

**1. push() - Add screen to stack**

```dart
Navigator.push(
  context,
  MaterialPageRoute(builder: (context) => ProfileScreen()),
);
```

- User can go back
- Stack: [Home, Profile]

**2. pushReplacement() - Replace current screen**

```dart
Navigator.pushReplacement(
  context,
  MaterialPageRoute(builder: (context) => Dashboard()),
);
```

- Replaces current screen
- Stack: [Dashboard]

**3. pushAndRemoveUntil() - Clear all and navigate**

```dart
Navigator.pushAndRemoveUntil(
  context,
  MaterialPageRoute(builder: (context) => Login()),
  (route) => false, // Remove all routes
);
```

- Clears entire stack
- Stack: [Login]

**4. pop() - Go back**

```dart
Navigator.pop(context);
```

- Returns to previous screen
- Removes current from stack

### JSON Data Loading

```dart
// 1. Load JSON file from assets
final String jsonString = await rootBundle.loadString('assets/data/products.json');

// 2. Parse JSON string to Map
final Map<String, dynamic> data = json.decode(jsonString);

// 3. Access data
List<dynamic> products = data['products'];

// 4. Use in widgets
for (var product in products) {
  print(product['name']);
}
```

### Responsive Design

```dart
// Using LayoutBuilder
LayoutBuilder(
  builder: (context, constraints) {
    if (constraints.maxWidth > 600) {
      return TabletLayout();
    }
    return PhoneLayout();
  },
)

// Using MediaQuery
final screenWidth = MediaQuery.of(context).size.width;
final isTablet = screenWidth > 600;
```

### Theme Usage

```dart
// Access theme colors
Theme.of(context).primaryColor
Theme.of(context).colorScheme.secondary

// Access text styles
Theme.of(context).textTheme.headlineMedium
Theme.of(context).textTheme.bodyLarge
```

## 🎓 Learning Objectives Achieved

### Act #6: Multiple Screen Implementation ✅

- [x] Created 6 screens with unique purposes
- [x] Implemented push() navigation
- [x] Implemented pushReplacement() navigation
- [x] Implemented pushAndRemoveUntil() navigation
- [x] Used pop() for back navigation
- [x] Applied consistent theme across all screens
- [x] Loaded and displayed JSON data
- [x] Implemented responsive layouts
- [x] Added animations (splash screen)

### Act #7: Package Integration Preparation ✅

- [x] Added TODO comments for http package usage
- [x] Prepared shared_preferences integration points
- [x] Set up provider pattern locations
- [x] Documented where packages will be used

### Act #8: Custom Widgets ✅

- [x] Created 10+ reusable custom widgets
- [x] Documented widget usage and parameters
- [x] Implemented in actual screens
- [x] Demonstrated code reusability

## 🐛 Troubleshooting

### Common Issues

**1. JSON file not loading**

- Ensure `assets/data/` is in pubspec.yaml
- Run `flutter pub get`
- Check file path is exactly `assets/data/products.json`

**2. Navigation errors**

- Check context is from Scaffold/MaterialApp
- Ensure screen imports are correct
- Verify screen constructors are const

**3. Theme not applying**

- Check Theme.of(context) is used
- Verify Material App has theme configured
- Ensure widgets are descendants of MaterialApp

**4. Responsive not working**

- Use LayoutBuilder or MediaQuery correctly
- Test on different screen sizes
- Check constraints.maxWidth values

## 📚 Additional Resources

### Flutter Documentation

- Navigation: https://docs.flutter.dev/cookbook/navigation
- Theming: https://docs.flutter.dev/cookbook/design/themes
- JSON: https://docs.flutter.dev/cookbook/networking/fetch-data
- Animations: https://docs.flutter.dev/ui/animations

### Code Comments

All code files contain extensive comments explaining:

- What each widget/function does
- How navigation works
- Why certain patterns are used
- Common pitfalls to avoid
- Future enhancement ideas

## 📝 Code Quality

### Features:

- ✅ Extensive inline documentation
- ✅ Descriptive variable and function names
- ✅ Consistent code formatting
- ✅ Error handling implemented
- ✅ Loading states for async operations
- ✅ Responsive design considerations
- ✅ Performance optimizations (const, keys)
- ✅ Memory leak prevention (dispose controllers)

## 🎯 Future Enhancements (Act #7 & Beyond)

1. **Authentication**
   - Implement actual login with API
   - Session management with tokens
   - Biometric authentication

2. **State Management**
   - Add Provider for global state
   - Theme switching (light/dark mode)
   - User preferences persistence

3. **Data Persistence**
   - Save favorites with shared_preferences
   - Cache JSON data locally
   - Offline mode support

4. **API Integration**
   - Fetch events from backend API
   - User registration and profile updates
   - Real-time notifications

5. **Advanced Features**
   - Search functionality
   - Event booking system
   - Calendar integration
   - Maps for event locations
   - QR code tickets

## 👨‍💻 Developer Notes

This application is designed as a learning resource for offline study. Every file contains detailed comments explaining concepts, patterns, and best practices. The code is structured to be beginner-friendly while demonstrating professional Flutter development practices.

### Screen Flow:

```
Splash (3s) → Login → Dashboard ⇄ Profile → Settings
                         ↓
                      Products
```

### Navigation Types Summary:

- **Splash → Login**: pushReplacement (can't go back to splash)
- **Login → Dashboard**: pushReplacement (can't go back to login)
- **Dashboard → Profile**: push (can go back)
- **Dashboard → Products**: push (can go back)
- **Profile → Settings**: push (can go back)
- **Settings → Login (logout)**: pushAndRemoveUntil (clears all screens)

---

**Created with ❤️ for learning Flutter**  
**Version:** 1.0.0  
**Last Updated:** February 24, 2026
