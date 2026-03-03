import 'package:flutter/material.dart';
import '../models/boarding_house.dart';

/// Boarding House Details Screen
///
/// Displays comprehensive information about a selected boarding house
/// Supports light and dark mode with tropical theming
///
/// Features:
/// - Large hero image banner
/// - Property information sections
/// - All amenities display
/// - Contact functionality
/// - Tropical evening ambiance in dark mode
class BoardingHouseDetailsScreen extends StatelessWidget {
  final BoardingHouse boardingHouse;

  const BoardingHouseDetailsScreen({super.key, required this.boardingHouse});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    // Tropical accent colors - consistent palette
    const coralAccent = Color(0xFFFF8A65);
    const aquaAccent = Color(0xFF26C6DA);
    const palmGreen = Color(0xFF66BB6A);
    const mangoYellow = Color(0xFFFFC107);

    return Scaffold(
      backgroundColor: theme.scaffoldBackgroundColor,
      body: CustomScrollView(
        slivers: [
          // Hero Image Banner with Back Button
          SliverAppBar(
            expandedHeight: 320,
            pinned: true,
            elevation: 0,
            backgroundColor: theme.appBarTheme.backgroundColor,
            leading: Container(
              margin: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: theme.cardColor,
                shape: BoxShape.circle,
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.25),
                    blurRadius: 8,
                  ),
                ],
              ),
              child: IconButton(
                icon: Icon(Icons.arrow_back, color: theme.iconTheme.color),
                onPressed: () => Navigator.pop(context),
              ),
            ),
            flexibleSpace: FlexibleSpaceBar(
              background: Stack(
                fit: StackFit.expand,
                children: [
                  Image.network(
                    '${boardingHouse.imageUrl}?w=800&h=600&fit=crop',
                    fit: BoxFit.cover,
                    loadingBuilder: (context, child, loadingProgress) {
                      if (loadingProgress == null) return child;
                      return Container(
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            colors: [
                              aquaAccent.withOpacity(0.3),
                              palmGreen.withOpacity(0.3),
                              coralAccent.withOpacity(0.3)
                            ],
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight,
                          ),
                        ),
                        child: Center(
                          child: CircularProgressIndicator(
                            value: loadingProgress.expectedTotalBytes != null
                                ? loadingProgress.cumulativeBytesLoaded /
                                    loadingProgress.expectedTotalBytes!
                                : null,
                            color: Colors.white,
                          ),
                        ),
                      );
                    },
                    errorBuilder: (context, error, stackTrace) {
                      return Container(
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            colors: [aquaAccent, palmGreen, coralAccent],
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight,
                          ),
                        ),
                        child: Center(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(
                                Icons.home_work,
                                size: 100,
                                color: Colors.white.withOpacity(0.9),
                              ),
                              const SizedBox(height: 12),
                              Padding(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 32,
                                ),
                                child: Text(
                                  boardingHouse.name,
                                  style: theme.textTheme.headlineSmall
                                      ?.copyWith(
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold,
                                      ),
                                  textAlign: TextAlign.center,
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                  // Tropical gradient overlay
                  Positioned(
                    bottom: 0,
                    left: 0,
                    right: 0,
                    child: Container(
                      height: 150,
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                          colors: [
                            Colors.transparent,
                            Colors.black.withOpacity(0.7),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),

          // Content
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Name
                  Text(
                    boardingHouse.name,
                    style: theme.textTheme.headlineMedium?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 20),

                  // Price Card
                  Container(
                    padding: const EdgeInsets.all(24),
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: isDark
                            ? [
                                coralAccent.withOpacity(0.15),
                                aquaAccent.withOpacity(0.15),
                              ]
                            : [
                                coralAccent.withOpacity(0.1),
                                mangoYellow.withOpacity(0.1),
                              ],
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                      ),
                      borderRadius: BorderRadius.circular(20),
                      border: Border.all(
                        color: coralAccent.withOpacity(0.4),
                        width: 2,
                      ),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.payments_outlined,
                          color: coralAccent,
                          size: 36,
                        ),
                        const SizedBox(width: 16),
                        Text(
                          '₱${boardingHouse.pricePerNight.toStringAsFixed(0)}',
                          style: theme.textTheme.displaySmall?.copyWith(
                            fontWeight: FontWeight.bold,
                            color: coralAccent,
                          ),
                        ),
                        const SizedBox(width: 10),
                        Text(
                          '/ night',
                          style: theme.textTheme.titleLarge?.copyWith(
                            color: theme.textTheme.bodyMedium?.color,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 28),

                  // Tropical Wave Divider
                  _TropicalWaveDivider(isDark: isDark),
                  const SizedBox(height: 28),

                  // Address Section
                  _InfoSection(
                    icon: Icons.location_on,
                    iconColor: coralAccent,
                    title: 'Location',
                    content: boardingHouse.address,
                  ),
                  const SizedBox(height: 20),

                  // Contact Section
                  _InfoSection(
                    icon: Icons.phone,
                    iconColor: palmGreen,
                    title: 'Contact Information',
                    content: boardingHouse.contact,
                  ),
                  const SizedBox(height: 28),

                  // Amenities Section Header
                  Row(
                    children: [
                      Icon(Icons.stars, color: mangoYellow, size: 28),
                      const SizedBox(width: 12),
                      Text(
                        'Amenities & Features',
                        style: theme.textTheme.titleLarge?.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),

                  _AmenitiesGrid(
                    amenities: boardingHouse.amenities,
                    accentColor: palmGreen,
                  ),
                  const SizedBox(height: 32),

                  // Contact Now Button
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: () {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Row(
                              children: [
                                const Icon(Icons.phone, color: Colors.white),
                                const SizedBox(width: 12),
                                Expanded(
                                  child: Text(
                                    'Calling ${boardingHouse.contact}...',
                                    style: const TextStyle(
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            backgroundColor: coralAccent,
                            behavior: SnackBarBehavior.floating,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(16),
                            ),
                            duration: const Duration(seconds: 3),
                          ),
                        );
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: coralAccent,
                        foregroundColor: Colors.white,
                        padding: const EdgeInsets.symmetric(vertical: 18),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(16),
                        ),
                        elevation: 6,
                        shadowColor: coralAccent.withOpacity(0.5),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Icon(Icons.phone, size: 26),
                          const SizedBox(width: 12),
                          Text(
                            'Contact Now',
                            style: theme.textTheme.titleMedium?.copyWith(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 18,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 32),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

/// Info Section Widget - Reusable for address, contact, etc.
///
/// Displays information in a beautifully styled card
/// with icon, title, and content
class _InfoSection extends StatelessWidget {
  final IconData icon;
  final Color iconColor;
  final String title;
  final String content;

  const _InfoSection({
    required this.icon,
    required this.iconColor,
    required this.title,
    required this.content,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    return Container(
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: theme.cardColor,
        borderRadius: BorderRadius.circular(18),
        boxShadow: [
          BoxShadow(
            color: isDark
                ? Colors.black.withOpacity(0.3)
                : Colors.black.withOpacity(0.06),
            blurRadius: 10,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: iconColor.withOpacity(isDark ? 0.2 : 0.12),
              borderRadius: BorderRadius.circular(14),
            ),
            child: Icon(icon, color: iconColor, size: 26),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: theme.textTheme.bodySmall?.copyWith(
                    fontWeight: FontWeight.w600,
                    letterSpacing: 0.5,
                  ),
                ),
                const SizedBox(height: 6),
                Text(
                  content,
                  style: theme.textTheme.bodyLarge?.copyWith(
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

/// Amenities Grid Widget
///
/// Displays all amenities in a responsive wrap layout
/// with icons and tropical styling
class _AmenitiesGrid extends StatelessWidget {
  final List<String> amenities;
  final Color accentColor;

  const _AmenitiesGrid({required this.amenities, required this.accentColor});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    return Wrap(
      spacing: 12,
      runSpacing: 12,
      children: amenities.map((amenity) {
        return Container(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          decoration: BoxDecoration(
            color: accentColor.withOpacity(isDark ? 0.2 : 0.12),
            borderRadius: BorderRadius.circular(14),
            border: Border.all(color: accentColor.withOpacity(0.4), width: 1.5),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(_getAmenityIcon(amenity), size: 20, color: accentColor),
              const SizedBox(width: 10),
              Text(
                amenity,
                style: theme.textTheme.bodyMedium?.copyWith(
                  color: accentColor,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
        );
      }).toList(),
    );
  }

  /// Returns appropriate icon for each amenity
  IconData _getAmenityIcon(String amenity) {
    final lower = amenity.toLowerCase();
    if (lower.contains('wifi')) return Icons.wifi;
    if (lower.contains('air') || lower.contains('conditioning')) {
      return Icons.ac_unit;
    }
    if (lower.contains('kitchen')) return Icons.kitchen;
    if (lower.contains('parking')) return Icons.local_parking;
    if (lower.contains('pool')) return Icons.pool;
    if (lower.contains('gym')) return Icons.fitness_center;
    if (lower.contains('laundry')) return Icons.local_laundry_service;
    if (lower.contains('security')) return Icons.security;
    if (lower.contains('beach')) return Icons.beach_access;
    if (lower.contains('breakfast')) return Icons.free_breakfast;
    if (lower.contains('heater')) return Icons.whatshot;
    if (lower.contains('fan')) return Icons.air;
    if (lower.contains('hot') && lower.contains('shower')) return Icons.hot_tub;
    if (lower.contains('view')) return Icons.landscape;
    if (lower.contains('common') || lower.contains('area')) return Icons.groups;
    if (lower.contains('access')) return Icons.key;
    if (lower.contains('rooftop')) return Icons.roofing;
    if (lower.contains('surfboard')) return Icons.surfing;
    if (lower.contains('coffee') || lower.contains('bar'))
      return Icons.local_cafe;
    if (lower.contains('garden')) return Icons.yard;
    if (lower.contains('tour')) return Icons.tour;
    if (lower.contains('airport') || lower.contains('transfer'))
      return Icons.airport_shuttle;
    return Icons.check_circle;
  }
}

/// Tropical Wave Divider
///
/// Beautiful gradient divider with tropical colors
/// Creates visual separation between sections
class _TropicalWaveDivider extends StatelessWidget {
  final bool isDark;

  const _TropicalWaveDivider({required this.isDark});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 4,
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [
            Color(0xFF26C6DA), // Aqua
            Color(0xFF66BB6A), // Palm Green
            Color(0xFFFFC107), // Mango Yellow
            Color(0xFFFF8A65), // Coral
          ],
        ),
        borderRadius: BorderRadius.circular(2),
        boxShadow: [
          BoxShadow(
            color: const Color(0xFF26C6DA).withOpacity(0.3),
            blurRadius: 4,
            offset: const Offset(0, 1),
          ),
        ],
      ),
    );
  }
}
