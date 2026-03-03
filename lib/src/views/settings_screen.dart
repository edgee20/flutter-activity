import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'login_screen.dart';
import '../providers/theme_provider.dart';

/// SettingsScreen - Tropical Filipino Festival Themed Settings
///
/// Design follows the "Liu" app brand identity:
/// - Sinulog/Ati-Atihan Festival inspiration
/// - Warm, welcoming, community-oriented
/// - Tropical colors: mango yellow, turquoise, coral, palm green
/// - Modern and breathable layout
class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  // Tropical color palette
  static const Color _mangoYellow = Color(0xFFFFC107);
  static const Color _turquoise = Color(0xFF26C6DA);
  static const Color _coral = Color(0xFFFF6F3C);
  static const Color _palmGreen = Color(0xFF66BB6A);
  static const Color _softCream = Color(0xFFFFFBF5);
  static const Color _textDark = Color(0xFF2C3E50);

  // State variables
  bool _notificationsEnabled = true;
  String _selectedLanguage = 'English';

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final isWide = constraints.maxWidth >= 700;

        return Scaffold(
          backgroundColor: Theme.of(context).scaffoldBackgroundColor,
          body: CustomScrollView(
            slivers: [
              // Tropical gradient header
              _TropicalHeader(isWide: isWide),

              // Settings content
              SliverPadding(
                padding: EdgeInsets.all(isWide ? 32.0 : 16.0),
                sliver: SliverList(
                  delegate: SliverChildListDelegate([
                    // Account Section
                    _SettingsSection(
                      title: 'Account',
                      icon: Icons.person,
                      iconColor: _turquoise,
                      isWide: isWide,
                      children: [
                        _SettingsItemTile(
                          icon: Icons.edit,
                          iconColor: _turquoise,
                          title: 'Edit Profile',
                          subtitle: 'Update your personal information',
                          onTap: () {
                            _showPlaceholder(context, 'Edit Profile');
                          },
                        ),
                        _SettingsItemTile(
                          icon: Icons.lock_outline,
                          iconColor: _coral,
                          title: 'Change Password',
                          subtitle: 'Update your security credentials',
                          onTap: () {
                            _showPlaceholder(context, 'Change Password');
                          },
                        ),
                        _SettingsItemTile(
                          icon: Icons.security,
                          iconColor: _palmGreen,
                          title: 'Privacy Settings',
                          subtitle: 'Manage your data and privacy',
                          onTap: () {
                            _showPlaceholder(context, 'Privacy Settings');
                          },
                        ),
                      ],
                    ),

                    SizedBox(height: isWide ? 28 : 20),

                    // Preferences Section
                    _SettingsSection(
                      title: 'Preferences',
                      icon: Icons.tune,
                      iconColor: _mangoYellow,
                      isWide: isWide,
                      children: [
                        _SettingsItemTile(
                          icon: Icons.notifications_outlined,
                          iconColor: _coral,
                          title: 'Notifications',
                          subtitle: 'Manage notification preferences',
                          trailing: Switch(
                            value: _notificationsEnabled,
                            onChanged: (value) {
                              setState(() {
                                _notificationsEnabled = value;
                              });
                            },
                            activeTrackColor: _coral,
                            activeThumbColor: Colors.white,
                          ),
                        ),
                        _SettingsItemTile(
                          icon: Icons.dark_mode_outlined,
                          iconColor: _textDark,
                          title: 'Dark Mode',
                          subtitle: 'Switch to dark theme',
                          trailing: Consumer<ThemeProvider>(
                            builder: (context, themeProvider, child) {
                              return Switch(
                                value: themeProvider.isDarkMode,
                                onChanged: (value) {
                                  themeProvider.setTheme(value);
                                },
                                activeTrackColor: _coral,
                                activeThumbColor: Colors.white,
                              );
                            },
                          ),
                        ),
                        _SettingsItemTile(
                          icon: Icons.language,
                          iconColor: _turquoise,
                          title: 'Language',
                          subtitle: _selectedLanguage,
                          onTap: () {
                            _showLanguageDialog(context);
                          },
                        ),
                      ],
                    ),

                    SizedBox(height: isWide ? 28 : 20),

                    // Payments Section
                    _SettingsSection(
                      title: 'Payments',
                      icon: Icons.credit_card,
                      iconColor: _palmGreen,
                      isWide: isWide,
                      children: [
                        _SettingsItemTile(
                          icon: Icons.payment,
                          iconColor: _palmGreen,
                          title: 'Payment Methods',
                          subtitle: 'Manage your payment options',
                          onTap: () {
                            _showPlaceholder(context, 'Payment Methods');
                          },
                        ),
                        _SettingsItemTile(
                          icon: Icons.receipt_long,
                          iconColor: _mangoYellow,
                          title: 'Billing History',
                          subtitle: 'View past transactions',
                          onTap: () {
                            _showPlaceholder(context, 'Billing History');
                          },
                        ),
                      ],
                    ),

                    SizedBox(height: isWide ? 28 : 20),

                    // Support Section
                    _SettingsSection(
                      title: 'Support',
                      icon: Icons.help_outline,
                      iconColor: _coral,
                      isWide: isWide,
                      children: [
                        _SettingsItemTile(
                          icon: Icons.help_center_outlined,
                          iconColor: _turquoise,
                          title: 'Help Center',
                          subtitle: 'Find answers to common questions',
                          onTap: () {
                            _showPlaceholder(context, 'Help Center');
                          },
                        ),
                        _SettingsItemTile(
                          icon: Icons.chat_bubble_outline,
                          iconColor: _palmGreen,
                          title: 'Contact Us',
                          subtitle: 'Get in touch with support',
                          onTap: () {
                            _showPlaceholder(context, 'Contact Us');
                          },
                        ),
                        _SettingsItemTile(
                          icon: Icons.info_outline,
                          iconColor: _mangoYellow,
                          title: 'About Liu',
                          subtitle: 'App version and information',
                          onTap: () {
                            _showAboutDialog(context);
                          },
                        ),
                      ],
                    ),

                    SizedBox(height: isWide ? 32 : 24),

                    // Logout Button
                    _LogoutButton(
                      isWide: isWide,
                      onTap: () {
                        _showLogoutDialog(context);
                      },
                    ),

                    SizedBox(height: isWide ? 48 : 32),
                  ]),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  void _showPlaceholder(BuildContext context, String feature) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('$feature - Coming Soon'),
        backgroundColor: _coral,
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      ),
    );
  }

  void _showLanguageDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Select Language'),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            _buildLanguageOption('English', context),
            _buildLanguageOption('Filipino', context),
            _buildLanguageOption('Cebuano', context),
          ],
        ),
      ),
    );
  }

  Widget _buildLanguageOption(String language, BuildContext context) {
    final isSelected = _selectedLanguage == language;
    return ListTile(
      title: Text(language),
      trailing: isSelected
          ? Icon(Icons.check_circle, color: _coral)
          : const Icon(Icons.circle_outlined, color: Colors.grey),
      onTap: () {
        setState(() {
          _selectedLanguage = language;
        });
        Navigator.pop(context);
      },
    );
  }

  void _showAboutDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        title: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: _turquoise.withValues(alpha: 0.1),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Icon(Icons.home_work, color: _turquoise, size: 28),
            ),
            const SizedBox(width: 12),
            const Text('About Liu'),
          ],
        ),
        content: const Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Liu - Tropical Hospitality Platform',
              style: TextStyle(fontWeight: FontWeight.w600),
            ),
            SizedBox(height: 8),
            Text('Version 1.0.0'),
            SizedBox(height: 16),
            Text(
              'Your trusted platform for Philippine boarding houses and transient stays.',
              style: TextStyle(color: Colors.grey),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text('Close', style: TextStyle(color: _coral)),
          ),
        ],
      ),
    );
  }

  void _showLogoutDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        title: const Text('Logout'),
        content: const Text('Are you sure you want to logout?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel', style: TextStyle(color: Colors.grey)),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(builder: (context) => const LoginScreen()),
                (route) => false,
              );
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: _coral,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
            ),
            child: const Text('Logout', style: TextStyle(color: Colors.white)),
          ),
        ],
      ),
    );
  }
}

// ============================================================================
// REUSABLE TROPICAL WIDGETS
// ============================================================================

/// Tropical gradient header with decorative elements
class _TropicalHeader extends StatelessWidget {
  final bool isWide;

  const _TropicalHeader({required this.isWide});

  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      expandedHeight: isWide ? 200 : 180,
      pinned: false,
      elevation: 0,
      backgroundColor: Colors.transparent,
      flexibleSpace: FlexibleSpaceBar(
        background: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [
                Color(0xFF26C6DA), // Turquoise
                Color(0xFF4DD0E1), // Lighter turquoise
              ],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
          child: Stack(
            children: [
              // Decorative sunburst background
              Positioned(
                top: -30,
                right: -30,
                child: Container(
                  width: 150,
                  height: 150,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.white.withValues(alpha: 0.08),
                  ),
                ),
              ),
              Positioned(
                bottom: 20,
                left: -40,
                child: Container(
                  width: 120,
                  height: 120,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.white.withValues(alpha: 0.08),
                  ),
                ),
              ),
              // Leaf accent
              Positioned(
                top: 40,
                left: 20,
                child: Icon(
                  Icons.eco,
                  size: isWide ? 50 : 40,
                  color: Colors.white.withValues(alpha: 0.15),
                ),
              ),
              // Content
              Positioned(
                bottom: isWide ? 40 : 30,
                left: isWide ? 32 : 16,
                right: isWide ? 32 : 16,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Settings',
                      style: TextStyle(
                        fontSize: isWide ? 36 : 32,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                        letterSpacing: 0.5,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      'Manage your preferences',
                      style: TextStyle(
                        fontSize: isWide ? 18 : 16,
                        color: Colors.white.withValues(alpha: 0.9),
                        fontWeight: FontWeight.w400,
                      ),
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

/// Settings section card with tropical styling
class _SettingsSection extends StatelessWidget {
  final String title;
  final IconData icon;
  final Color iconColor;
  final List<Widget> children;
  final bool isWide;

  const _SettingsSection({
    required this.title,
    required this.icon,
    required this.iconColor,
    required this.children,
    required this.isWide,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Section header with icon
        Padding(
          padding: EdgeInsets.only(left: isWide ? 8 : 4, bottom: 12),
          child: Row(
            children: [
              Container(
                padding: const EdgeInsets.all(6),
                decoration: BoxDecoration(
                  color: iconColor.withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Icon(icon, color: iconColor, size: 20),
              ),
              const SizedBox(width: 10),
              Text(
                title,
                style: Theme.of(context).textTheme.titleLarge?.copyWith(
                  fontSize: isWide ? 20 : 18,
                  fontWeight: FontWeight.bold,
                  letterSpacing: 0.3,
                ),
              ),
            ],
          ),
        ),
        // Settings card
        Container(
          decoration: BoxDecoration(
            color: Theme.of(context).cardColor,
            borderRadius: BorderRadius.circular(20),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withValues(alpha: 0.06),
                blurRadius: 12,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          child: Column(children: _buildChildrenWithDividers()),
        ),
      ],
    );
  }

  List<Widget> _buildChildrenWithDividers() {
    final List<Widget> items = [];
    for (int i = 0; i < children.length; i++) {
      items.add(children[i]);
      if (i < children.length - 1) {
        items.add(
          Divider(
            height: 1,
            thickness: 1,
            color: const Color(0xFF66BB6A).withValues(alpha: 0.08),
            indent: 72,
          ),
        );
      }
    }
    return items;
  }
}

/// Individual settings item tile with tropical styling
class _SettingsItemTile extends StatelessWidget {
  final IconData icon;
  final Color iconColor;
  final String title;
  final String? subtitle;
  final Widget? trailing;
  final VoidCallback? onTap;

  const _SettingsItemTile({
    required this.icon,
    required this.iconColor,
    required this.title,
    this.subtitle,
    this.trailing,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(20),
        splashColor: const Color(0xFFFF6F3C).withValues(alpha: 0.1),
        highlightColor: const Color(0xFFFF6F3C).withValues(alpha: 0.05),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
          child: Row(
            children: [
              // Icon container
              Container(
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: iconColor.withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Icon(icon, color: iconColor, size: 24),
              ),
              const SizedBox(width: 16),
              // Title and subtitle
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: Theme.of(context).textTheme.titleMedium?.copyWith(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    if (subtitle != null) ...[
                      const SizedBox(height: 2),
                      Text(
                        subtitle!,
                        style: Theme.of(context).textTheme.bodySmall,
                      ),
                    ],
                  ],
                ),
              ),
              // Trailing widget or chevron
              trailing ??
                  const Icon(
                    Icons.arrow_forward_ios,
                    size: 16,
                    color: Colors.grey,
                  ),
            ],
          ),
        ),
      ),
    );
  }
}

/// Coral-accented logout button
class _LogoutButton extends StatelessWidget {
  final bool isWide;
  final VoidCallback onTap;

  const _LogoutButton({required this.isWide, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Theme.of(context).cardColor,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: const Color(0xFFFF6F3C).withValues(alpha: 0.3),
          width: 2,
        ),
        boxShadow: [
          BoxShadow(
            color: const Color(0xFFFF6F3C).withValues(alpha: 0.15),
            blurRadius: 12,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(20),
          splashColor: const Color(0xFFFF6F3C).withValues(alpha: 0.2),
          highlightColor: const Color(0xFFFF6F3C).withValues(alpha: 0.1),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 18),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: const Color(0xFFFF6F3C).withValues(alpha: 0.1),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: const Icon(
                    Icons.logout,
                    color: Color(0xFFFF6F3C),
                    size: 24,
                  ),
                ),
                const SizedBox(width: 16),
                const Text(
                  'Logout',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFFFF6F3C),
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
