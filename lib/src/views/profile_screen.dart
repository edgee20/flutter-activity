import 'package:flutter/material.dart';
import 'settings_screen.dart';

/// ProfileScreen - Third Screen in the Application
///
/// This screen displays user profile information including:
/// - User avatar and basic information
/// - Activity statistics (events attended, reviews, etc.)
/// - Quick action buttons
/// - Navigation to settings using push()
///
/// NAVIGATION CONCEPTS:
/// - Uses push() to navigate to Settings screen
/// - User can press back button to return here
/// - Demonstrates forward navigation pattern
class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    /// MediaQuery is used to get device screen dimensions
    /// This allows us to create responsive layouts that adapt to different screen sizes
    final screenHeight = MediaQuery.of(context).size.height;

    /// LayoutBuilder provides constraints about parent widget
    /// We use it to determine if device is tablet or phone
    return LayoutBuilder(
      builder: (context, constraints) {
        /// Determine if device is tablet based on width
        /// This affects padding, font sizes, and layout structure
        final isTablet = constraints.maxWidth > 600;

        return Scaffold(
          /// AppBar - Top navigation bar with title and actions
          appBar: AppBar(
            title: Text(
              'My Profile',
              style: TextStyle(
                color: Theme.of(context).appBarTheme.foregroundColor,
                fontWeight: FontWeight.bold,
              ),
            ),
            backgroundColor: Theme.of(context).appBarTheme.backgroundColor,
            elevation: 0,

            /// Leading widget is the back button (automatically added by Flutter)
            iconTheme: IconThemeData(
              color: Theme.of(context).appBarTheme.foregroundColor,
            ),
            actions: [
              /// Settings icon button that navigates to Settings screen
              IconButton(
                icon: const Icon(Icons.settings_outlined),
                onPressed: () {
                  /// Navigator.push() - Adds new screen on top of current screen
                  /// Creates a navigation stack: Login -> Dashboard -> Profile -> Settings
                  /// User can use back button to go back through the stack
                  ///
                  /// MaterialPageRoute creates a platform-adaptive screen transition
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const SettingsScreen(),
                    ),
                  );
                },
              ),
            ],
          ),

          /// SingleChildScrollView allows content to scroll if it exceeds screen height
          /// Important for responsive design on smaller devices
          body: SingleChildScrollView(
            child: Column(
              children: [
                /// Profile Header Section with gradient background
                _buildProfileHeader(context, isTablet, screenHeight),

                /// Statistics Cards Section
                _buildStatisticsSection(isTablet),

                /// Action Buttons Section
                _buildActionButtons(context, isTablet),

                /// Recent Activity Section
                _buildRecentActivity(isTablet),

                /// Bottom spacing
                SizedBox(height: isTablet ? 40 : 20),
              ],
            ),
          ),
        );
      },
    );
  }

  /// Builds the profile header with user avatar and basic info
  /// Uses Container with gradient decoration for visual appeal
  Widget _buildProfileHeader(
    BuildContext context,
    bool isTablet,
    double screenHeight,
  ) {
    return Container(
      width: double.infinity,

      /// Responsive height based on device type and screen size
      height: isTablet ? screenHeight * 0.35 : screenHeight * 0.3,
      decoration: BoxDecoration(
        /// LinearGradient creates smooth color transition
        /// Used for modern, professional look
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            Theme.of(context).primaryColor,
            Theme.of(context).primaryColor.withOpacity(0.7),
          ],
        ),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          /// CircleAvatar - Displays profile picture in circular shape
          /// Hero widget can be added here for smooth transitions between screens
          CircleAvatar(
            radius: isTablet ? 70 : 60,
            backgroundColor: Colors.white,
            child: CircleAvatar(
              radius: isTablet ? 65 : 55,
              backgroundColor: Colors.blue.shade100,
              child: Icon(
                Icons.person,
                size: isTablet ? 70 : 60,
                color: Theme.of(context).primaryColor,
              ),
            ),
          ),
          SizedBox(height: isTablet ? 20 : 15),

          /// User name with responsive font size
          Text(
            'Liu, EJ F.',
            style: TextStyle(
              color: Colors.white,

              /// Responsive font size based on device type
              fontSize: isTablet ? 32 : 28,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: isTablet ? 10 : 5),

          /// User email/subtitle
          Text(
            'student@university.edu',
            style: TextStyle(
              color: Colors.white.withOpacity(0.9),
              fontSize: isTablet ? 18 : 16,
            ),
          ),
          SizedBox(height: isTablet ? 15 : 10),

          /// Edit Profile Button
          ElevatedButton.icon(
            onPressed: () {
              /// TODO (Act #7): Implement edit profile functionality
              /// This would use shared_preferences to save user data
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Edit Profile - Coming Soon!')),
              );
            },
            icon: const Icon(Icons.edit, size: 18),
            label: const Text('Edit Profile'),
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.white,
              foregroundColor: Theme.of(context).primaryColor,
              padding: EdgeInsets.symmetric(
                horizontal: isTablet ? 30 : 20,
                vertical: isTablet ? 15 : 12,
              ),
            ),
          ),
        ],
      ),
    );
  }

  /// Builds statistics cards showing user activity metrics
  /// Uses GridView for responsive layout
  Widget _buildStatisticsSection(bool isTablet) {
    return Padding(
      padding: EdgeInsets.all(isTablet ? 24 : 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'My Statistics',
            style: TextStyle(
              fontSize: isTablet ? 24 : 20,
              fontWeight: FontWeight.bold,
              color: Colors.grey.shade800,
            ),
          ),
          SizedBox(height: isTablet ? 20 : 15),

          /// GridView creates a grid layout of statistics cards
          /// crossAxisCount determines number of columns
          GridView.count(
            /// shrinkWrap: true prevents GridView from taking infinite height
            /// Important when GridView is inside a Column
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            crossAxisCount: 2,
            crossAxisSpacing: isTablet ? 20 : 15,
            mainAxisSpacing: isTablet ? 20 : 15,

            /// childAspectRatio controls card width/height ratio
            childAspectRatio: isTablet ? 1.3 : 1.2,
            children: [
              _buildStatCard(
                'Events Attended',
                '12',
                Icons.event,
                Colors.blue,
                isTablet,
              ),
              _buildStatCard(
                'Reviews',
                '8',
                Icons.rate_review,
                Colors.orange,
                isTablet,
              ),
              _buildStatCard(
                'Bookmarks',
                '15',
                Icons.bookmark,
                Colors.green,
                isTablet,
              ),
              _buildStatCard(
                'Following',
                '24',
                Icons.people,
                Colors.purple,
                isTablet,
              ),
            ],
          ),
        ],
      ),
    );
  }

  /// Individual statistic card widget
  /// Reusable component showing icon, number, and label
  Widget _buildStatCard(
    String label,
    String value,
    IconData icon,
    Color color,
    bool isTablet,
  ) {
    return Container(
      padding: EdgeInsets.all(isTablet ? 20 : 15),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(15),

        /// BoxShadow adds depth to cards
        /// Makes UI feel more modern and professional
        boxShadow: [
          BoxShadow(
            color: Colors.grey.shade200,
            blurRadius: 10,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(icon, size: isTablet ? 40 : 32, color: color),
          SizedBox(height: isTablet ? 12 : 10),
          Text(
            value,
            style: TextStyle(
              fontSize: isTablet ? 28 : 24,
              fontWeight: FontWeight.bold,
              color: Colors.grey.shade800,
            ),
          ),
          SizedBox(height: isTablet ? 8 : 5),
          Text(
            label,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: isTablet ? 16 : 14,
              color: Colors.grey.shade600,
            ),
          ),
        ],
      ),
    );
  }

  /// Action buttons section with common profile actions
  Widget _buildActionButtons(BuildContext context, bool isTablet) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: isTablet ? 24 : 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Quick Actions',
            style: TextStyle(
              fontSize: isTablet ? 24 : 20,
              fontWeight: FontWeight.bold,
              color: Colors.grey.shade800,
            ),
          ),
          SizedBox(height: isTablet ? 20 : 15),

          /// List of action buttons
          _buildActionButton(
            context,
            'My Events',
            Icons.calendar_today,
            Colors.blue,
            isTablet,
            () {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('My Events - Coming Soon!')),
              );
            },
          ),
          SizedBox(height: isTablet ? 15 : 10),
          _buildActionButton(
            context,
            'Payment History',
            Icons.payment,
            Colors.green,
            isTablet,
            () {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Payment History - Coming Soon!')),
              );
            },
          ),
          SizedBox(height: isTablet ? 15 : 10),
          _buildActionButton(
            context,
            'Certificates',
            Icons.card_membership,
            Colors.orange,
            isTablet,
            () {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Certificates - Coming Soon!')),
              );
            },
          ),
        ],
      ),
    );
  }

  /// Individual action button widget
  /// InkWell provides tap animation and feedback
  Widget _buildActionButton(
    BuildContext context,
    String label,
    IconData icon,
    Color color,
    bool isTablet,
    VoidCallback onTap,
  ) {
    return InkWell(
      onTap: onTap,

      /// BorderRadius on InkWell ensures tap ripple respects container shape
      borderRadius: BorderRadius.circular(12),
      child: Container(
        padding: EdgeInsets.all(isTablet ? 20 : 16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.shade200,
              blurRadius: 8,
              offset: const Offset(0, 3),
            ),
          ],
        ),
        child: Row(
          children: [
            Container(
              padding: EdgeInsets.all(isTablet ? 12 : 10),
              decoration: BoxDecoration(
                color: color.withOpacity(0.1),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Icon(icon, color: color, size: isTablet ? 28 : 24),
            ),
            SizedBox(width: isTablet ? 20 : 15),
            Expanded(
              child: Text(
                label,
                style: TextStyle(
                  fontSize: isTablet ? 18 : 16,
                  fontWeight: FontWeight.w600,
                  color: Colors.grey.shade800,
                ),
              ),
            ),
            Icon(
              Icons.arrow_forward_ios,
              color: Colors.grey.shade400,
              size: isTablet ? 20 : 18,
            ),
          ],
        ),
      ),
    );
  }

  /// Recent activity section showing user's recent actions
  Widget _buildRecentActivity(bool isTablet) {
    return Padding(
      padding: EdgeInsets.all(isTablet ? 24 : 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Recent Activity',
            style: TextStyle(
              fontSize: isTablet ? 24 : 20,
              fontWeight: FontWeight.bold,
              color: Colors.grey.shade800,
            ),
          ),
          SizedBox(height: isTablet ? 20 : 15),

          /// List of recent activities
          _buildActivityItem(
            'Registered for Workshop: Mobile App Development',
            '2 days ago',
            Icons.event_available,
            Colors.green,
            isTablet,
          ),
          SizedBox(height: isTablet ? 15 : 10),
          _buildActivityItem(
            'Left a review for Art Exhibition',
            '5 days ago',
            Icons.rate_review,
            Colors.orange,
            isTablet,
          ),
          SizedBox(height: isTablet ? 15 : 10),
          _buildActivityItem(
            'Bookmarked Leadership Training Camp',
            '1 week ago',
            Icons.bookmark_add,
            Colors.blue,
            isTablet,
          ),
        ],
      ),
    );
  }

  /// Individual activity item widget
  Widget _buildActivityItem(
    String title,
    String time,
    IconData icon,
    Color color,
    bool isTablet,
  ) {
    return Container(
      padding: EdgeInsets.all(isTablet ? 18 : 14),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.grey.shade200),
      ),
      child: Row(
        children: [
          Container(
            padding: EdgeInsets.all(isTablet ? 10 : 8),
            decoration: BoxDecoration(
              color: color.withOpacity(0.1),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Icon(icon, color: color, size: isTablet ? 24 : 20),
          ),
          SizedBox(width: isTablet ? 15 : 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: TextStyle(
                    fontSize: isTablet ? 16 : 14,
                    fontWeight: FontWeight.w500,
                    color: Colors.grey.shade800,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  time,
                  style: TextStyle(
                    fontSize: isTablet ? 14 : 12,
                    color: Colors.grey.shade500,
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
