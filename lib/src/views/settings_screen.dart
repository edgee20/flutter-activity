import 'package:flutter/material.dart';
import 'login_screen.dart';

/// SettingsScreen - Fifth Screen in the Application
///
/// PURPOSE:
/// This screen provides app settings and user preferences including:
/// - Account management options
/// - App preferences (notifications, language)
/// - About and help sections
/// - Logout functionality with pushAndRemoveUntil()
///
/// NAVIGATION CONCEPTS DEMONSTRATED:
/// 1. pop() - Normal back navigation (already in Profile)
/// 2. pushAndRemoveUntil() - Replace entire navigation stack (logout)
///
/// pushAndRemoveUntil() EXPLAINED:
/// - Pushes new route and removes all previous routes from stack
/// - Used for logout: goes to login screen and prevents back navigation
/// - (route) => false means remove ALL previous routes
/// - (route) => route.isFirst keeps only first route
class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  /// STATE VARIABLES FOR SETTINGS:
  /// These track user preferences in the UI
  bool _notificationsEnabled = true;
  bool _emailNotifications = false;
  String _selectedLanguage = 'English';

  @override
  Widget build(BuildContext context) {
    /// LayoutBuilder for responsive design
    return LayoutBuilder(
      builder: (context, constraints) {
        final isTablet = constraints.maxWidth > 600;

        return Scaffold(
          appBar: AppBar(
            title: Text(
              'Settings',
              style: TextStyle(
                color: Theme.of(context).appBarTheme.foregroundColor,
                fontWeight: FontWeight.bold,
              ),
            ),
            backgroundColor: Theme.of(context).appBarTheme.backgroundColor,
            iconTheme: IconThemeData(
              color: Theme.of(context).appBarTheme.foregroundColor,
            ),
          ),

          /// ListView for scrollable settings
          body: ListView(
            padding: EdgeInsets.all(isTablet ? 24 : 16),
            children: [
              /// Account Section
              _buildSectionHeader('Account', isTablet),
              _buildAccountSettings(context, isTablet),

              SizedBox(height: isTablet ? 30 : 20),

              /// Preferences Section
              _buildSectionHeader('Preferences', isTablet),
              _buildPreferencesSettings(context, isTablet),

              SizedBox(height: isTablet ? 30 : 20),

              /// App Information Section
              _buildSectionHeader('About', isTablet),
              _buildAboutSettings(context, isTablet),

              SizedBox(height: isTablet ? 30 : 20),

              /// Logout Button
              _buildLogoutButton(context, isTablet),

              SizedBox(height: isTablet ? 40 : 20),
            ],
          ),
        );
      },
    );
  }

  /// Builds section header with custom styling
  Widget _buildSectionHeader(String title, bool isTablet) {
    return Padding(
      padding: EdgeInsets.only(
        bottom: isTablet ? 15 : 10,
        left: isTablet ? 5 : 0,
      ),
      child: Text(
        title,
        style: TextStyle(
          fontSize: isTablet ? 20 : 18,
          fontWeight: FontWeight.bold,
          color: Theme.of(context).primaryColor,
        ),
      ),
    );
  }

  /// Account settings with ListTile widgets
  /// ListTile provides consistent UI for settings items
  Widget _buildAccountSettings(BuildContext context, bool isTablet) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return Container(
      decoration: BoxDecoration(
        color: colorScheme.surface,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.2),
            blurRadius: 8,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Column(
        children: [
          /// Edit Profile
          ListTile(
            leading: const Icon(Icons.person_outline, color: Colors.blue),
            title: Text(
              'Edit Profile',
              style: TextStyle(
                fontSize: isTablet ? 18 : 16,
                fontWeight: FontWeight.w500,
              ),
            ),
            trailing: const Icon(Icons.arrow_forward_ios, size: 16),
            onTap: () {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Edit Profile - Coming Soon')),
              );
            },
          ),
          const Divider(height: 1),

          /// Change Password
          ListTile(
            leading: const Icon(Icons.lock_outline, color: Colors.orange),
            title: Text(
              'Change Password',
              style: TextStyle(
                fontSize: isTablet ? 18 : 16,
                fontWeight: FontWeight.w500,
              ),
            ),
            trailing: const Icon(Icons.arrow_forward_ios, size: 16),
            onTap: () {
              _showChangePasswordDialog(context);
            },
          ),
          const Divider(height: 1),

          /// Privacy Settings
          ListTile(
            leading: const Icon(
              Icons.privacy_tip_outlined,
              color: Colors.purple,
            ),
            title: Text(
              'Privacy Settings',
              style: TextStyle(
                fontSize: isTablet ? 18 : 16,
                fontWeight: FontWeight.w500,
              ),
            ),
            trailing: const Icon(Icons.arrow_forward_ios, size: 16),
            onTap: () {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Privacy Settings - Coming Soon')),
              );
            },
          ),
        ],
      ),
    );
  }

  /// Preferences settings with switches and dropdowns
  Widget _buildPreferencesSettings(BuildContext context, bool isTablet) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return Container(
      decoration: BoxDecoration(
        color: colorScheme.surface,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.2),
            blurRadius: 8,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Column(
        children: [
          /// Push Notifications Toggle
          /// SwitchListTile combines ListTile with Switch widget
          SwitchListTile(
            secondary: const Icon(
              Icons.notifications_outlined,
              color: Colors.green,
            ),
            title: Text(
              'Push Notifications',
              style: TextStyle(
                fontSize: isTablet ? 18 : 16,
                fontWeight: FontWeight.w500,
              ),
            ),
            subtitle: const Text('Receive notifications about events'),
            value: _notificationsEnabled,
            onChanged: (value) {
              setState(() {
                _notificationsEnabled = value;

                /// TODO (Act #7): Save to shared_preferences
              });
            },
          ),
          const Divider(height: 1),

          /// Email Notifications Toggle
          SwitchListTile(
            secondary: const Icon(Icons.email_outlined, color: Colors.blue),
            title: Text(
              'Email Notifications',
              style: TextStyle(
                fontSize: isTablet ? 18 : 16,
                fontWeight: FontWeight.w500,
              ),
            ),
            subtitle: const Text('Receive email updates'),
            value: _emailNotifications,
            onChanged: (value) {
              setState(() {
                _emailNotifications = value;
              });
            },
          ),
          const Divider(height: 1),

          /// Language Selection
          ListTile(
            leading: const Icon(Icons.language, color: Colors.teal),
            title: Text(
              'Language',
              style: TextStyle(
                fontSize: isTablet ? 18 : 16,
                fontWeight: FontWeight.w500,
              ),
            ),
            subtitle: Text(_selectedLanguage),
            trailing: const Icon(Icons.arrow_forward_ios, size: 16),
            onTap: () => _showLanguageDialog(),
          ),
        ],
      ),
    );
  }

  /// About section with app information
  Widget _buildAboutSettings(BuildContext context, bool isTablet) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return Container(
      decoration: BoxDecoration(
        color: colorScheme.surface,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.2),
            blurRadius: 8,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Column(
        children: [
          ListTile(
            leading: const Icon(Icons.info_outline, color: Colors.blue),
            title: Text(
              'App Version',
              style: TextStyle(
                fontSize: isTablet ? 18 : 16,
                fontWeight: FontWeight.w500,
              ),
            ),
            trailing: Text(
              '1.0.0',
              style: TextStyle(
                fontSize: isTablet ? 16 : 14,
                color: theme.textTheme.bodySmall?.color,
              ),
            ),
          ),
          const Divider(height: 1),

          ListTile(
            leading: const Icon(Icons.help_outline, color: Colors.orange),
            title: Text(
              'Help & Support',
              style: TextStyle(
                fontSize: isTablet ? 18 : 16,
                fontWeight: FontWeight.w500,
              ),
            ),
            trailing: const Icon(Icons.arrow_forward_ios, size: 16),
            onTap: () {
              _showHelpDialog(context);
            },
          ),
          const Divider(height: 1),

          ListTile(
            leading: const Icon(
              Icons.description_outlined,
              color: Colors.green,
            ),
            title: Text(
              'Terms of Service',
              style: TextStyle(
                fontSize: isTablet ? 18 : 16,
                fontWeight: FontWeight.w500,
              ),
            ),
            trailing: const Icon(Icons.arrow_forward_ios, size: 16),
            onTap: () {
              ScaffoldMessenger.of(
                context,
              ).showSnackBar(const SnackBar(content: Text('Terms of Service')));
            },
          ),
          const Divider(height: 1),

          ListTile(
            leading: const Icon(Icons.policy_outlined, color: Colors.purple),
            title: Text(
              'Privacy Policy',
              style: TextStyle(
                fontSize: isTablet ? 18 : 16,
                fontWeight: FontWeight.w500,
              ),
            ),
            trailing: const Icon(Icons.arrow_forward_ios, size: 16),
            onTap: () {
              ScaffoldMessenger.of(
                context,
              ).showSnackBar(const SnackBar(content: Text('Privacy Policy')));
            },
          ),
        ],
      ),
    );
  }

  /// Logout button with confirmation dialog
  /// Demonstrates pushAndRemoveUntil navigation
  Widget _buildLogoutButton(BuildContext context, bool isTablet) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: isTablet ? 100 : 20),
      child: ElevatedButton.icon(
        onPressed: () => _showLogoutDialog(context),
        icon: const Icon(Icons.logout),
        label: const Text('Logout'),
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.red.shade700,
          foregroundColor: Colors.white,
          padding: EdgeInsets.symmetric(vertical: isTablet ? 18 : 15),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
        ),
      ),
    );
  }

  /// Shows logout confirmation dialog
  void _showLogoutDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Logout'),
        content: const Text('Are you sure you want to logout?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: () {
              /// Close dialog first
              Navigator.pop(context);

              /// NAVIGATION: pushAndRemoveUntil()
              ///
              /// PURPOSE:
              /// Navigate to login screen and remove all previous screens
              /// from navigation stack. This prevents user from pressing
              /// back button to return to authenticated screens.
              ///
              /// SYNTAX:
              /// Navigator.pushAndRemoveUntil(
              ///   context,
              ///   route,                    // New route to push
              ///   (route) => condition      // Which routes to keep
              /// )
              ///
              /// PREDICATE OPTIONS:
              /// (route) => false          - Remove ALL routes (start fresh)
              /// (route) => route.isFirst  - Keep only first route
              /// (route) => route.settings.name == '/home'  - Keep specific route
              ///
              /// WHEN TO USE:
              /// - Logout: Clear stack and go to login
              /// - Onboarding: After completion, prevent going back
              /// - Authentication: After successful login, clear login screens
              Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(builder: (context) => const LoginScreen()),

                /// (route) => false removes ALL previous routes
                /// Navigation stack will only contain LoginScreen
                (route) => false,
              );

              /// Show confirmation message
              /// Note: We can't use ScaffoldMessenger here because
              /// context changes after navigation
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.red,
              foregroundColor: Colors.white,
            ),
            child: const Text('Logout'),
          ),
        ],
      ),
    );
  }

  /// Shows language selection dialog
  void _showLanguageDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Select Language'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            _buildLanguageOption('English', context),
            _buildLanguageOption('Filipino', context),
            _buildLanguageOption('Spanish', context),
            _buildLanguageOption('Japanese', context),
          ],
        ),
      ),
    );
  }

  /// Language option radio button
  Widget _buildLanguageOption(String language, BuildContext context) {
    return RadioListTile<String>(
      title: Text(language),
      value: language,
      groupValue: _selectedLanguage,
      onChanged: (value) {
        setState(() {
          _selectedLanguage = value!;
        });
        Navigator.pop(context);
      },
    );
  }

  /// Shows change password dialog
  void _showChangePasswordDialog(BuildContext context) {
    final currentPasswordController = TextEditingController();
    final newPasswordController = TextEditingController();
    final confirmPasswordController = TextEditingController();

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Change Password'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              controller: currentPasswordController,
              obscureText: true,
              decoration: const InputDecoration(
                labelText: 'Current Password',
                prefixIcon: Icon(Icons.lock_outline),
              ),
            ),
            const SizedBox(height: 15),
            TextField(
              controller: newPasswordController,
              obscureText: true,
              decoration: const InputDecoration(
                labelText: 'New Password',
                prefixIcon: Icon(Icons.lock),
              ),
            ),
            const SizedBox(height: 15),
            TextField(
              controller: confirmPasswordController,
              obscureText: true,
              decoration: const InputDecoration(
                labelText: 'Confirm Password',
                prefixIcon: Icon(Icons.lock),
              ),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: () {
              /// TODO (Act #7): Implement actual password change logic
              if (newPasswordController.text ==
                  confirmPasswordController.text) {
                Navigator.pop(context);
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text('Password changed successfully!'),
                    backgroundColor: Colors.green,
                  ),
                );
              } else {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text('Passwords do not match!'),
                    backgroundColor: Colors.red,
                  ),
                );
              }
            },
            child: const Text('Change'),
          ),
        ],
      ),
    );
  }

  /// Shows help dialog with instructions
  void _showHelpDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Row(
          children: [
            Icon(Icons.help_outline, color: Colors.orange),
            SizedBox(width: 10),
            Text('Help & Support'),
          ],
        ),
        content: const SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                'Need Help?',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
              ),
              SizedBox(height: 10),
              Text('• Browse events and workshops in the Products section'),
              SizedBox(height: 5),
              Text('• View your profile and activity statistics'),
              SizedBox(height: 5),
              Text('• Customize app settings to your preference'),
              SizedBox(height: 5),
              Text('• Contact support at: support@univents.edu'),
              SizedBox(height: 15),
              Text(
                'Common Issues:',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
              ),
              SizedBox(height: 10),
              Text('Q: How do I register for an event?'),
              Text('A: Tap on an event card and click "Enroll Now"'),
              SizedBox(height: 10),
              Text('Q: Can I cancel my registration?'),
              Text('A: Yes, go to My Events in your profile'),
            ],
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Close'),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.pop(context);
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Opening email client...')),
              );
            },
            child: const Text('Contact Support'),
          ),
        ],
      ),
    );
  }
}
