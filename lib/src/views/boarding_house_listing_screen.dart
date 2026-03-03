import 'package:flutter/material.dart';
import '../models/boarding_house.dart';
import '../widgets/boarding_house_card.dart';
import 'boarding_house_details_screen.dart';

/// Boarding House Listing Screen
///
/// Displays available boarding houses in a tropical-themed card layout
/// Supports light and dark mode with tropical color palette
///
/// Features:
/// - Modern card layout with images
/// - Smooth navigation to details
/// - Full dark mode support
/// - Tropical Filipino hospitality theme
class BoardingHouseListingScreen extends StatelessWidget {
  const BoardingHouseListingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final boardingHouses = BoardingHouse.getMockData();
    final theme = Theme.of(context);

    return Scaffold(
      backgroundColor: theme.scaffoldBackgroundColor,
      appBar: AppBar(
        title: Row(
          children: [
            Icon(Icons.home_work, size: 24, color: Colors.white),
            const SizedBox(width: 12),
            const Text('Available Stays'),
          ],
        ),
        elevation: 0,
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(1),
          child: Container(
            height: 3,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  const Color(0xFF26C6DA), // Aqua
                  const Color(0xFF66BB6A), // Palm Green
                  const Color(0xFFFFC107), // Mango
                  const Color(0xFFFF8A65), // Coral
                ],
              ),
            ),
          ),
        ),
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: boardingHouses.length,
        itemBuilder: (context, index) {
          return BoardingHouseCard(
            boardingHouse: boardingHouses[index],
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => BoardingHouseDetailsScreen(
                    boardingHouse: boardingHouses[index],
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
