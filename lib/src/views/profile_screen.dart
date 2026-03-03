import 'package:flutter/material.dart';
import 'settings_screen.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  // Tropical theme colors
  static const Color _sunsetOrange = Color(0xFFFF8A65);
  static const Color _coral = Color(0xFFFF6F3C);
  static const Color _oceanBlue = Color(0xFF00ACC1);
  static const Color _aqua = Color(0xFF26C6DA);
  static const Color _palmGreen = Color(0xFF66BB6A);
  static const Color _sand = Color(0xFFFFFBF5);

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final isWide = constraints.maxWidth >= 700;

        return Scaffold(
          backgroundColor: Theme.of(context).scaffoldBackgroundColor,
          appBar: AppBar(
            title: const Text('Liu'),
            backgroundColor: _oceanBlue,
            elevation: 0,
            foregroundColor: Colors.white,
          ),
          body: SingleChildScrollView(
            child: Column(
              children: [
                _ProfileHero(isWide: isWide),
                Padding(
                  padding: EdgeInsets.all(isWide ? 32.0 : 16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // User name and email
                      Center(
                        child: Column(
                          children: [
                            Text(
                              'Liu, EJ F.',
                              style: Theme.of(context).textTheme.headlineSmall
                                  ?.copyWith(fontWeight: FontWeight.bold),
                            ),
                            const SizedBox(height: 4),
                            Text(
                              'liu.ej@example.com',
                              style: Theme.of(context).textTheme.bodyMedium,
                            ),
                            const SizedBox(height: 12),
                            // Status badges
                            Wrap(
                              spacing: 8,
                              runSpacing: 8,
                              children: const [
                                _StatBadge(
                                  icon: Icons.verified,
                                  label: 'Verified',
                                  color: _palmGreen,
                                ),
                                _StatBadge(
                                  icon: Icons.calendar_today,
                                  label: 'Since 2025',
                                  color: _aqua,
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 24),

                      // Profile Details Section
                      _SectionCard(
                        title: 'Profile Details',
                        icon: Icons.person,
                        isWide: isWide,
                        children: const [
                          _AccountInfoTile(
                            icon: Icons.phone,
                            label: 'Phone',
                            value: '+63 912 345 6789',
                          ),
                          _AccountInfoTile(
                            icon: Icons.location_on,
                            label: 'Location',
                            value: 'Manila, Philippines',
                          ),
                          _AccountInfoTile(
                            icon: Icons.account_balance_wallet,
                            label: 'Member Type',
                            value: 'Premium',
                          ),
                        ],
                      ),
                      const SizedBox(height: 16),

                      // Quick Actions Section
                      _SectionCard(
                        title: 'Quick Actions',
                        icon: Icons.touch_app,
                        isWide: isWide,
                        children: [
                          _ActionGrid(
                            isWide: isWide,
                            actions: [
                              _ActionItem(
                                icon: Icons.settings,
                                label: 'Settings',
                                color: _oceanBlue,
                                onTap: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) =>
                                          const SettingsScreen(),
                                    ),
                                  );
                                },
                              ),
                              const _ActionItem(
                                icon: Icons.favorite,
                                label: 'Favorites',
                                color: _coral,
                              ),
                              const _ActionItem(
                                icon: Icons.history,
                                label: 'History',
                                color: _palmGreen,
                              ),
                              const _ActionItem(
                                icon: Icons.help,
                                label: 'Help',
                                color: _sunsetOrange,
                              ),
                            ],
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}

// Hero section with gradient and decorative icons
class _ProfileHero extends StatelessWidget {
  final bool isWide;

  const _ProfileHero({required this.isWide});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: isWide ? 220 : 180,
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          colors: [ProfileScreen._oceanBlue, ProfileScreen._aqua],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
      ),
      child: Stack(
        children: [
          // Decorative background icons
          Positioned(
            top: 20,
            right: 30,
            child: Icon(
              Icons.spa,
              size: isWide ? 80 : 60,
              color: Colors.white.withValues(alpha: 0.1),
            ),
          ),
          Positioned(
            bottom: 30,
            left: 20,
            child: Icon(
              Icons.local_florist,
              size: isWide ? 70 : 50,
              color: Colors.white.withValues(alpha: 0.1),
            ),
          ),
          // Profile avatar with liu.jpg image
          Center(
            child: Container(
              width: isWide ? 120 : 100,
              height: isWide ? 120 : 100,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Theme.of(context).cardColor,
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withValues(alpha: 0.2),
                    blurRadius: 12,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),
              child: ClipOval(
                child: Image.asset(
                  'assets/images/liu.jpg',
                  width: isWide ? 120 : 100,
                  height: isWide ? 120 : 100,
                  fit: BoxFit.cover,
                  errorBuilder: (context, error, stackTrace) {
                    return Icon(
                      Icons.person,
                      size: isWide ? 60 : 50,
                      color: ProfileScreen._oceanBlue,
                    );
                  },
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// Reusable white card section container
class _SectionCard extends StatelessWidget {
  final String title;
  final IconData icon;
  final List<Widget> children;
  final bool isWide;

  const _SectionCard({
    required this.title,
    required this.icon,
    required this.children,
    required this.isWide,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(isWide ? 24.0 : 16.0),
      decoration: BoxDecoration(
        color: Theme.of(context).cardColor,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.05),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(icon, color: ProfileScreen._oceanBlue, size: 24),
              const SizedBox(width: 8),
              Text(
                title,
                style: Theme.of(
                  context,
                ).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold),
              ),
            ],
          ),
          const SizedBox(height: 16),
          ...children,
        ],
      ),
    );
  }
}

// Info tile with icon, label, and value
class _AccountInfoTile extends StatelessWidget {
  final IconData icon;
  final String label;
  final String value;

  const _AccountInfoTile({
    required this.icon,
    required this.label,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12.0),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: ProfileScreen._sand,
              borderRadius: BorderRadius.circular(8),
            ),
            child: Icon(icon, size: 20, color: ProfileScreen._oceanBlue),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(label, style: Theme.of(context).textTheme.bodySmall),
                Text(
                  value,
                  style: Theme.of(
                    context,
                  ).textTheme.bodyLarge?.copyWith(fontWeight: FontWeight.w500),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

// Status badge pill
class _StatBadge extends StatelessWidget {
  final IconData icon;
  final String label;
  final Color color;

  const _StatBadge({
    required this.icon,
    required this.label,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: color.withValues(alpha: 0.3)),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 16, color: color),
          const SizedBox(width: 4),
          Text(
            label,
            style: TextStyle(
              color: color,
              fontWeight: FontWeight.w600,
              fontSize: 12,
            ),
          ),
        ],
      ),
    );
  }
}

// Action button item
class _ActionItem extends StatelessWidget {
  final IconData icon;
  final String label;
  final Color color;
  final VoidCallback? onTap;

  const _ActionItem({
    required this.icon,
    required this.label,
    required this.color,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(12),
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: color.withValues(alpha: 0.1),
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: color.withValues(alpha: 0.3)),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, color: color, size: 32),
            const SizedBox(height: 8),
            Text(
              label,
              textAlign: TextAlign.center,
              style: TextStyle(
                color: color,
                fontWeight: FontWeight.w600,
                fontSize: 13,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// Grid of action buttons (responsive: 2x2 or 4x1)
class _ActionGrid extends StatelessWidget {
  final bool isWide;
  final List<_ActionItem> actions;

  const _ActionGrid({required this.isWide, required this.actions});

  @override
  Widget build(BuildContext context) {
    return GridView.count(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      crossAxisCount: isWide ? 4 : 2,
      mainAxisSpacing: 12,
      crossAxisSpacing: 12,
      childAspectRatio: 1.1,
      children: actions,
    );
  }
}
