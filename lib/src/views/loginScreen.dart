import 'package:flutter/material.dart';
import 'dashboardScreen.dart';

/// LoginScreen - First Screen in the Application
///
/// PURPOSE:
/// Authentication screen where users login to access the app.
/// After successful login, navigates to Dashboard using pushReplacement().
///
/// NAVIGATION CONCEPT - pushReplacement():
/// This navigation method REPLACES the current screen with a new one.
/// Unlike push() which adds a screen on top, pushReplacement() removes
/// the current screen from the navigation stack.
///
/// WHY USE pushReplacement() HERE:
/// After login, we don't want users to press back button and return
/// to the login screen. By replacing the login screen with dashboard,
/// the login screen is removed from navigation history.
///
/// NAVIGATION STACK:
/// Before login: [LoginScreen]
/// After login (with push): [LoginScreen, DashboardScreen] - Back button shows login
/// After login (with pushReplacement): [DashboardScreen] - Back button exits app
class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  bool _rememberMe = false;
  bool _obscurePassword = true;

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final isDesktop = screenWidth > 900;
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.bottomCenter,
            end: Alignment.topCenter,
            stops: const [0.0, 0.3],
            colors: [
              colorScheme.primary.withOpacity(0.2),
              theme.scaffoldBackgroundColor,
            ],
          ),
        ),
        child: Center(
          child: ScrollConfiguration(
            behavior: ScrollConfiguration.of(
              context,
            ).copyWith(scrollbars: false),
            child: SingleChildScrollView(
              child: Container(
                constraints: BoxConstraints(maxWidth: isDesktop ? 480 : 400),
                padding: const EdgeInsets.symmetric(
                  horizontal: 40,
                  vertical: 20,
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    // Logo
                    _buildLogo(),
                    const SizedBox(height: 40),

                    // UNI-VENTS Title
                    const Text(
                      'UNI-VENTS',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 32,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF2E3B8E),
                        letterSpacing: 2,
                      ),
                    ),
                    const SizedBox(height: 40),

                    // Username Field
                    const Text(
                      'Username',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        color: Color(0xFF2E3B8E),
                      ),
                    ),
                    const SizedBox(height: 8),
                    _buildEmailField(),
                    const SizedBox(height: 24),

                    // Password Field
                    const Text(
                      'Password',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        color: Color(0xFF2E3B8E),
                      ),
                    ),
                    const SizedBox(height: 8),
                    _buildPasswordField(),
                    const SizedBox(height: 16),

                    // Remember Me and Forgot Password
                    _buildRememberMeRow(),
                    const SizedBox(height: 32),

                    // Sign In Button
                    _buildSignInButton(),
                    const SizedBox(height: 24),

                    // Or Text
                    const Center(
                      child: Text(
                        'Or',
                        style: TextStyle(
                          color: Color(0xFF2E3B8E),
                          fontSize: 14,
                        ),
                      ),
                    ),
                    const SizedBox(height: 24),

                    // Google Login Button
                    _buildSocialButton(
                      imagePath: 'assets/images/Google__G__logo.svg.webp',
                      text: 'Login with Google',
                      onPressed: () {},
                    ),
                    const SizedBox(height: 16),

                    // Facebook Login Button
                    _buildSocialButton(
                      icon: Icons.facebook,
                      iconColor: Colors.blue.shade800,
                      text: 'Login with Facebook',
                      onPressed: () {},
                      backgroundColor: Colors.white,
                    ),
                    const SizedBox(height: 24),

                    // Sign Up Link
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text(
                          "Don't have an account? ",
                          style: TextStyle(
                            color: Color(0xFF2E3B8E),
                            fontSize: 14,
                          ),
                        ),
                        TextButton(
                          onPressed: () {},
                          style: TextButton.styleFrom(
                            padding: EdgeInsets.zero,
                            minimumSize: const Size(0, 0),
                            tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                          ),
                          child: const Text(
                            'Sign up',
                            style: TextStyle(
                              color: Color(0xFF2E3B8E),
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildLogo() {
    return SizedBox(
      width: 140,
      height: 140,
      child: Image.asset(
        'assets/logo/addulogo.png',
        fit: BoxFit.contain,
        errorBuilder: (context, error, stackTrace) {
          return Container(
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(color: const Color(0xFF2E3B8E), width: 3),
            ),
            child: const Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.school, size: 50, color: Color(0xFF2E3B8E)),
                  SizedBox(height: 4),
                  Text(
                    'AdDU',
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF2E3B8E),
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildEmailField() {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.grey.shade300),
      ),
      child: TextField(
        controller: _emailController,
        decoration: InputDecoration(
          hintText: 'abc@email.com',
          hintStyle: TextStyle(color: Colors.grey.shade400),
          prefixIcon: Icon(Icons.email_outlined, color: Colors.grey.shade600),
          border: InputBorder.none,
          contentPadding: const EdgeInsets.all(16),
        ),
      ),
    );
  }

  Widget _buildPasswordField() {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.grey.shade300),
      ),
      child: TextField(
        controller: _passwordController,
        obscureText: _obscurePassword,
        decoration: InputDecoration(
          hintText: 'Your password',
          hintStyle: TextStyle(color: Colors.grey.shade400),
          prefixIcon: Icon(Icons.lock_outline, color: Colors.grey.shade600),
          suffixIcon: IconButton(
            icon: Icon(
              _obscurePassword ? Icons.visibility_off : Icons.visibility,
              color: Colors.grey.shade600,
            ),
            onPressed: () {
              setState(() {
                _obscurePassword = !_obscurePassword;
              });
            },
          ),
          border: InputBorder.none,
          contentPadding: const EdgeInsets.all(16),
        ),
      ),
    );
  }

  Widget _buildRememberMeRow() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          children: [
            Transform.scale(
              scale: 0.8,
              child: Switch(
                value: _rememberMe,
                onChanged: (value) {
                  setState(() {
                    _rememberMe = value;
                  });
                },
                activeThumbColor: const Color(0xFF2E3B8E),
              ),
            ),
            const SizedBox(width: 4),
            const Text(
              'Remember Me',
              style: TextStyle(fontSize: 14, color: Color(0xFF2E3B8E)),
            ),
          ],
        ),
        TextButton(
          onPressed: () {},
          style: TextButton.styleFrom(
            padding: EdgeInsets.zero,
            minimumSize: const Size(0, 0),
            tapTargetSize: MaterialTapTargetSize.shrinkWrap,
          ),
          child: const Text(
            'Forgot Password?',
            style: TextStyle(fontSize: 14, color: Color(0xFF2E3B8E)),
          ),
        ),
      ],
    );
  }

  Widget _buildSignInButton() {
    return ElevatedButton(
      onPressed: () {
        /// NAVIGATION: pushReplacement()
        ///
        /// IMPORTANT: Using pushReplacement() instead of push()
        ///
        /// DIFFERENCE:
        /// - push(): Adds new screen on top, keeps current screen in stack
        /// - pushReplacement(): Replaces current screen, removes it from stack
        ///
        /// BENEFIT FOR LOGIN:
        /// User cannot go back to login screen after successful login.
        /// This is standard UX pattern for authentication flows.
        ///
        /// SYNTAX:
        /// Navigator.pushReplacement(
        ///   context,
        ///   MaterialPageRoute(builder: (context) => NewScreen()),
        /// )
        ///
        /// TODO (Act #7): Add actual authentication logic here
        /// - Validate credentials
        /// - Call API with http package
        /// - Store token using shared_preferences
        /// - Only navigate if authentication succeeds
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => const DashboardScreen()),
        );
      },
      style: ElevatedButton.styleFrom(
        backgroundColor: const Color(0xFF2E3B8E),
        foregroundColor: Colors.white,
        padding: const EdgeInsets.symmetric(vertical: 16),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        elevation: 2,
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const SizedBox(width: 40),
            const Text(
              'SIGN IN',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                letterSpacing: 1,
              ),
            ),
            Container(
              padding: const EdgeInsets.all(4),
              decoration: const BoxDecoration(
                color: Colors.white,
                shape: BoxShape.circle,
              ),
              child: const Icon(
                Icons.arrow_forward,
                size: 18,
                color: Color(0xFF2E3B8E),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSocialButton({
    required String text,
    required VoidCallback onPressed,
    String? imagePath,
    IconData? icon,
    Color? iconColor,
    Color? backgroundColor,
  }) {
    return Container(
      decoration: BoxDecoration(
        color: backgroundColor ?? Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.grey.shade300),
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: onPressed,
          borderRadius: BorderRadius.circular(12),
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 12),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                if (imagePath != null)
                  Image.asset(
                    imagePath,
                    width: 24,
                    height: 24,
                    errorBuilder: (context, error, stackTrace) {
                      return Icon(
                        icon ?? Icons.login,
                        size: 24,
                        color: iconColor ?? Colors.grey,
                      );
                    },
                  )
                else if (icon != null)
                  Icon(icon, size: 24, color: iconColor ?? Colors.grey),
                const SizedBox(width: 12),
                Text(
                  text,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                    color: Color(0xFF2E3B8E),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
