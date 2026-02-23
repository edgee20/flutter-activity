import 'package:flutter/material.dart';
import 'dart:async';
import 'loginScreen.dart';

/// SplashScreen - Initial Screen shown when app starts
///
/// PURPOSE:
/// Display app branding/logo with animation for 3 seconds while:
/// 1. App initializes (loads resources, checks authentication, etc.)
/// 2. Provides professional first impression
/// 3. Brand recognition
///
/// ANIMATION CONCEPTS:
/// - Uses AnimationController to control animation timing
/// - Tween defines animation start and end values
/// - CurvedAnimation adds smooth easing to animation
///
/// NAVIGATION:
/// After 3 seconds, automatically navigates to Login screen
/// using pushReplacement() to remove splash from navigation stack
class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

/// SingleTickerProviderStateMixin required for AnimationController
/// Provides ticker for animation frame updates
class _SplashScreenState extends State<SplashScreen>
    with SingleTickerProviderStateMixin {
  /// AnimationController manages animation timing
  /// Controls animation duration, direction, and state
  late AnimationController _animationController;

  /// Animation for fade effect (opacity 0 to 1)
  late Animation<double> _fadeAnimation;

  /// Animation for scale effect (small to normal size)
  late Animation<double> _scaleAnimation;

  @override
  void initState() {
    super.initState();

    /// Initialize animation controller
    /// Duration: How long one complete animation cycle takes
    /// vsync: this provides ticker (from SingleTickerProviderStateMixin)
    _animationController = AnimationController(
      duration: const Duration(milliseconds: 1500),
      vsync: this,
    );

    /// FADE ANIMATION:
    /// Tween<double> defines range of values (0.0 to 1.0)
    /// This controls opacity: 0 = invisible, 1 = fully visible
    _fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      /// CurvedAnimation adds easing curve
      /// Curves.easeIn: starts slow, ends fast
      /// Makes animation feel more natural
      CurvedAnimation(parent: _animationController, curve: Curves.easeIn),
    );

    /// SCALE ANIMATION:
    /// Controls size of logo (0.5 = half size, 1.0 = normal size)
    /// Creates "zoom in" effect
    _scaleAnimation = Tween<double>(begin: 0.5, end: 1.0).animate(
      CurvedAnimation(
        parent: _animationController,
        curve: Curves.easeOutBack, // Bouncy effect at end
      ),
    );

    /// Start the animation immediately
    _animationController.forward();

    /// TIMER FOR NAVIGATION:
    /// Timer.Duration: Execute code after specified duration
    /// After 3 seconds, navigate to Login screen
    Timer(const Duration(seconds: 3), () {
      /// Check if widget is still mounted before navigating
      /// Prevents errors if user closes app during splash
      if (mounted) {
        /// pushReplacement removes splash screen from navigation stack
        /// User can't go back to splash screen
        Navigator.pushReplacement(
          context,

          /// PageRouteBuilder allows custom page transitions
          PageRouteBuilder(
            pageBuilder: (context, animation, secondaryAnimation) =>
                const LoginScreen(),

            /// Custom transition animation
            transitionsBuilder:
                (context, animation, secondaryAnimation, child) {
                  /// Fade transition when moving to login screen
                  return FadeTransition(opacity: animation, child: child);
                },

            /// Transition duration
            transitionDuration: const Duration(milliseconds: 500),
          ),
        );
      }
    });
  }

  /// Cleanup: Dispose animation controller to prevent memory leaks
  /// IMPORTANT: Always dispose controllers, listeners, and subscriptions
  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      /// Gradient background for visual appeal
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Theme.of(context).primaryColor,
              Theme.of(context).primaryColor.withOpacity(0.7),
              Colors.white,
            ],
            stops: const [0.0, 0.5, 1.0],
          ),
        ),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              /// ANIMATED LOGO SECTION:
              /// Wrapping widgets in animation builders

              /// AnimatedBuilder rebuilds UI when animation value changes
              /// Efficient: Only rebuilds animated parts, not entire screen
              AnimatedBuilder(
                animation: _animationController,
                builder: (context, child) {
                  return Opacity(
                    /// _fadeAnimation.value changes from 0.0 to 1.0
                    opacity: _fadeAnimation.value,
                    child: Transform.scale(
                      /// _scaleAnimation.value changes from 0.5 to 1.0
                      scale: _scaleAnimation.value,
                      child: child,
                    ),
                  );
                },

                /// Child doesn't rebuild (optimization)
                /// Only Transform.scale and Opacity rebuild
                child: Column(
                  children: [
                    /// Logo Icon with circular background
                    Container(
                      padding: const EdgeInsets.all(30),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        shape: BoxShape.circle,
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.2),
                            blurRadius: 20,
                            offset: const Offset(0, 10),
                          ),
                        ],
                      ),
                      child: Icon(
                        Icons.event_available,
                        size: 80,
                        color: Theme.of(context).primaryColor,
                      ),
                    ),
                    const SizedBox(height: 30),

                    /// App name
                    const Text(
                      'UNI-VENTS',
                      style: TextStyle(
                        fontSize: 42,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                        letterSpacing: 4,
                        shadows: [
                          Shadow(
                            color: Colors.black26,
                            offset: Offset(0, 4),
                            blurRadius: 8,
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 10),

                    /// Tagline
                    const Text(
                      'University Events Made Easy',
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.white,
                        letterSpacing: 1,
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 80),

              /// LOADING INDICATOR:
              /// Shows user that app is loading
              /// Animated circular progress indicator
              FadeTransition(
                opacity: _fadeAnimation,
                child: Column(
                  children: [
                    /// CircularProgressIndicator with custom colors
                    SizedBox(
                      width: 40,
                      height: 40,
                      child: CircularProgressIndicator(
                        valueColor: const AlwaysStoppedAnimation<Color>(
                          Colors.white,
                        ),
                        strokeWidth: 3,

                        /// Null value creates indeterminate progress
                        /// (continuous animation)
                      ),
                    ),
                    const SizedBox(height: 20),
                    const Text(
                      'Loading...',
                      style: TextStyle(
                        color: Colors.white70,
                        fontSize: 14,
                        letterSpacing: 1,
                      ),
                    ),
                  ],
                ),
              ),

              /// Bottom padding for spacing
              const SizedBox(height: 60),

              /// Version and attribution
              FadeTransition(
                opacity: _fadeAnimation,
                child: const Column(
                  children: [
                    Text(
                      'Version 1.0.0',
                      style: TextStyle(color: Colors.white60, fontSize: 12),
                    ),
                    SizedBox(height: 5),
                    Text(
                      'Liu, EJ F.',
                      style: TextStyle(color: Colors.white60, fontSize: 12),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

/// ANIMATION CONCEPTS SUMMARY:
/// 
/// 1. AnimationController:
///    - Controls animation timing and state
///    - forward() starts animation
///    - reverse() reverses animation
///    - repeat() loops animation
/// 
/// 2. Tween:
///    - Defines range of values (begin to end)
///    - Can be double, Color, Offset, etc.
///    - Example: Tween<double>(begin: 0, end: 100)
/// 
/// 3. CurvedAnimation:
///    - Adds easing curves to animation
///    - Makes motion feel natural
///    - Common curves: easeIn, easeOut, easeInOut, bounceIn
/// 
/// 4. AnimatedBuilder:
///    - Rebuilds widget when animation changes
///    - More efficient than setState()
///    - Only rebuilds animated portion
/// 
/// 5. Built-in Animated Widgets:
///    - FadeTransition (opacity)
///    - ScaleTransition (size)
///    - SlideTransition (position)
///    - RotationTransition (rotation)
/// 
/// WHEN TO USE ANIMATIONS:
/// - Splash screens (branding)
/// - Page transitions (smooth navigation)
/// - Loading states (feedback to user)
/// - UI interactions (button press, etc.)
/// - Drawing attention (new features, notifications)
/// 
/// ANIMATION BEST PRACTICES:
/// - Keep animations short (200-500ms for UI, 1-2s for splash)
/// - Always dispose controllers
/// - Use const where possible for performance
/// - Don't overuse - too many animations distract
/// - Test on low-end devices for performance
