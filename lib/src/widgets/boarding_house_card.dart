import 'package:flutter/material.dart';
import '../models/boarding_house.dart';

/// Boarding House Card Widget
///
/// A reusable, beautiful card component for displaying boarding house information
///
/// Features:
/// - Tropical-themed design with gradient accents
/// - Image banner with fallback gradient
/// - Property name, address, and price display
/// - Amenities preview (first 3)
/// - Availability badge
/// - Tap interaction with InkWell ripple
/// - Full light/dark mode support
/// - Responsive layout
///
/// Usage:
/// ```dart
/// BoardingHouseCard(
///   boardingHouse: myBoardingHouse,
///   onTap: () {
///     Navigator.push(...);
///   },
/// )
/// ```
class BoardingHouseCard extends StatelessWidget {
  final BoardingHouse boardingHouse;
  final VoidCallback onTap;

  // Tropical accent colors - consistent with app theme
  static const Color coralAccent = Color(0xFFFF8A65);
  static const Color aquaAccent = Color(0xFF26C6DA);
  static const Color palmGreen = Color(0xFF66BB6A);
  static const Color mangoYellow = Color(0xFFFFC107);

  const BoardingHouseCard({
    super.key,
    required this.boardingHouse,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    return Container(
      margin: const EdgeInsets.only(bottom: 20),
      decoration: BoxDecoration(
        color: theme.cardColor,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: isDark
                ? Colors.black.withOpacity(0.3)
                : Colors.black.withOpacity(0.08),
            blurRadius: 15,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Image Banner
              _buildImageBanner(context, theme, isDark),

              // Content Section
              Padding(
                padding: const EdgeInsets.all(18),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Name
                    Text(
                      boardingHouse.name,
                      style: theme.textTheme.titleLarge?.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: 10),

                    // Address
                    _buildAddress(theme),
                    const SizedBox(height: 14),

                    // Amenities Preview
                    _buildAmenitiesPreview(theme, isDark),

                    // More amenities indicator
                    if (boardingHouse.amenities.length > 3) ...[
                      const SizedBox(height: 8),
                      Text(
                        '+${boardingHouse.amenities.length - 3} more amenities',
                        style: theme.textTheme.bodySmall?.copyWith(
                          color: aquaAccent,
                          fontWeight: FontWeight.w500,
                          fontSize: 11,
                        ),
                      ),
                    ],

                    const SizedBox(height: 16),

                    // Price Section with Divider
                    _buildDivider(),
                    const SizedBox(height: 16),

                    _buildPriceSection(theme),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  /// Builds the image banner with gradient overlay and availability badge
  Widget _buildImageBanner(BuildContext context, ThemeData theme, bool isDark) {
    return ClipRRect(
      borderRadius: const BorderRadius.only(
        topLeft: Radius.circular(20),
        topRight: Radius.circular(20),
      ),
      child: Stack(
        children: [
          // Image
          Image.network(
            '${boardingHouse.imageUrl}?w=400&h=300&fit=crop',
            height: 200,
            width: double.infinity,
            fit: BoxFit.cover,
            loadingBuilder: (context, child, loadingProgress) {
              if (loadingProgress == null) return child;
              return Container(
                height: 200,
                width: double.infinity,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [aquaAccent.withOpacity(0.3), coralAccent.withOpacity(0.3)],
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
                height: 200,
                width: double.infinity,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [aquaAccent, coralAccent],
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
                        size: 60,
                        color: Colors.white.withOpacity(0.9),
                      ),
                      const SizedBox(height: 8),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 24),
                        child: Text(
                          boardingHouse.name,
                          style: theme.textTheme.titleMedium?.copyWith(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                          textAlign: TextAlign.center,
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          ),

          // Gradient overlay
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: Container(
              height: 80,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [Colors.transparent, Colors.black.withOpacity(0.6)],
                ),
              ),
            ),
          ),

          // Availability badge
          Positioned(
            top: 12,
            right: 12,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
              decoration: BoxDecoration(
                color: mangoYellow,
                borderRadius: BorderRadius.circular(20),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.2),
                    blurRadius: 4,
                  ),
                ],
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Icon(Icons.star, size: 14, color: Colors.white),
                  const SizedBox(width: 4),
                  Text(
                    'Available',
                    style: theme.textTheme.bodySmall?.copyWith(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 11,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  /// Builds the address row with icon
  Widget _buildAddress(ThemeData theme) {
    return Row(
      children: [
        Icon(Icons.location_on, size: 18, color: coralAccent),
        const SizedBox(width: 6),
        Expanded(
          child: Text(
            boardingHouse.address,
            style: theme.textTheme.bodyMedium?.copyWith(
              color: theme.textTheme.bodySmall?.color,
            ),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
        ),
      ],
    );
  }

  /// Builds the amenities preview chips (first 3 amenities)
  Widget _buildAmenitiesPreview(ThemeData theme, bool isDark) {
    return Wrap(
      spacing: 8,
      runSpacing: 8,
      children: boardingHouse.amenities.take(3).map((amenity) {
        return Container(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
          decoration: BoxDecoration(
            color: palmGreen.withOpacity(isDark ? 0.2 : 0.15),
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: palmGreen.withOpacity(0.4)),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(_getAmenityIcon(amenity), size: 14, color: palmGreen),
              const SizedBox(width: 6),
              Text(
                amenity,
                style: theme.textTheme.bodySmall?.copyWith(
                  color: palmGreen,
                  fontWeight: FontWeight.w600,
                  fontSize: 11,
                ),
              ),
            ],
          ),
        );
      }).toList(),
    );
  }

  /// Builds the gradient divider
  Widget _buildDivider() {
    return Container(
      height: 1,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [aquaAccent.withOpacity(0.3), palmGreen.withOpacity(0.3)],
        ),
      ),
    );
  }

  /// Builds the price section with view details button
  Widget _buildPriceSection(ThemeData theme) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        // Price
        Row(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Text(
              '₱${boardingHouse.pricePerNight.toStringAsFixed(0)}',
              style: theme.textTheme.headlineSmall?.copyWith(
                fontWeight: FontWeight.bold,
                color: coralAccent,
                fontSize: 28,
              ),
            ),
            const SizedBox(width: 6),
            Padding(
              padding: const EdgeInsets.only(bottom: 6),
              child: Text(
                '/ night',
                style: theme.textTheme.bodyMedium?.copyWith(
                  color: theme.textTheme.bodySmall?.color,
                ),
              ),
            ),
          ],
        ),
        // View Details Button
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          decoration: BoxDecoration(
            gradient: const LinearGradient(colors: [aquaAccent, palmGreen]),
            borderRadius: BorderRadius.circular(20),
            boxShadow: [
              BoxShadow(
                color: aquaAccent.withOpacity(0.3),
                blurRadius: 8,
                offset: const Offset(0, 2),
              ),
            ],
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                'View Details',
                style: theme.textTheme.bodyMedium?.copyWith(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(width: 6),
              const Icon(
                Icons.arrow_forward_ios,
                size: 14,
                color: Colors.white,
              ),
            ],
          ),
        ),
      ],
    );
  }

  /// Returns appropriate icon for amenity
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
    if (lower.contains('airport') || lower.contains('transfer')) {
      return Icons.airport_shuttle;
    }
    return Icons.check_circle;
  }
}
