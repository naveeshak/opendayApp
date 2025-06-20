import 'package:flutter/material.dart';
import '../screens/home_screen.dart';
import '../screens/contact_screen.dart';
import 'package:openday/screens/tour_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:openday/screens/map_screen.dart';
import 'package:openday/screens/offers_screen.dart';
import '../widget/search_delegate.dart';

// A reusable scaffold widget with a custom AppBar and a bottom menu
class NewCustomScaffold extends StatelessWidget {
  final Widget body; // The main content of the screen
  final String? title; // Optional title (not used currently)

  const NewCustomScaffold({super.key, required this.body, this.title});

  // Function to show the bottom menu sheet
  void _showMenu(BuildContext context) {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.white,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (BuildContext context) {
        return SafeArea(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Divider(height: 1, thickness: 1),

              // List of navigation menu items
              _buildMenuItem(context, Icons.home_filled, 'Home', HomeScreen()),
              _buildMenuItem(context, Icons.qr_code_scanner, 'QR Scanner', QRScreen()),
              _buildMenuItem(context, Icons.event_available, 'Event Schedule', EventScreen()),
              _buildMenuItem(context, Icons.map_outlined, 'Campus Map', MapScreen()),
              _buildMenuItem(context, Icons.local_offer_outlined, 'Special Offers', OffersScreen()),
              _buildMenuItem(context, Icons.help_outline, 'Contact Us', ContactScreen()),
              _buildMenuItem(context, Icons.video_camera_back_outlined, 'Virtual Tour', TourScreen()),

              const Divider(height: 16, thickness: 1),
              _buildLogoutItem(context),

              const SizedBox(height: 20),
            ],
          ),
        );
      },
    );
  }

  // Helper method to build a stylized ListTile for each menu item
  Widget _buildMenuItem(BuildContext context, IconData icon, String label, Widget screen) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
      decoration: BoxDecoration(
        color: Colors.grey[50],
        borderRadius: BorderRadius.circular(10),
      ),
      child: ListTile(
        leading: Icon(icon, color: Colors.indigo[700]),
        title: Text(
          label,
          style: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w500,
          ),
        ),
        trailing: const Icon(Icons.chevron_right, color: Colors.grey),
        contentPadding: const EdgeInsets.symmetric(horizontal: 16),
        minLeadingWidth: 24,
        onTap: () {
          Navigator.pop(context); // Close the bottom sheet
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => screen), // Navigate to the selected screen
          );
        },
      ),
    );
  }

  Widget _buildLogoutItem(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
      decoration: BoxDecoration(
        color: Colors.grey[50],
        borderRadius: BorderRadius.circular(10),
      ),
      child: ListTile(
        leading: const Icon(Icons.logout, color: Colors.red),
        title: const Text(
          'Logout',
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w500,
            color: Colors.red,
          ),
        ),
        trailing: const Icon(Icons.chevron_right, color: Colors.grey),
        contentPadding: const EdgeInsets.symmetric(horizontal: 16),
        minLeadingWidth: 24,
        onTap: () async {
          Navigator.pop(context); // Close bottom sheet

          final prefs = await SharedPreferences.getInstance();
          await prefs.clear();

          Navigator.pushNamedAndRemoveUntil(context, '/login', (route) => false);
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // App bar with a custom design
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 1,

        // Menu icon to open bottom sheet menu
        leading: IconButton(
          icon: const Icon(Icons.menu, color: Colors.black, size: 28),
          onPressed: () => _showMenu(context),
        ),

        // Centered logo title
        title: Image.asset(
          'assets/images/cinec_logo.png',
          height: 40,
        ),
        centerTitle: true,

        // Optional action icons (search, notifications)
        actions: [
          IconButton(
            icon: const Icon(Icons.search, color: Colors.black, size: 26),
            onPressed: () {
              showSearch(
                context: context,
                delegate: SimpleSearchDelegate([
                  'QR',
                  'Campus Map',
                  'Special Offers',
                  'Virtual Tour',
                  'Contact Us',
                  'QR Scanner',
                  'Home',
                  'Offers',
                  'Event',
                  'Email',
                  'Phone',
                  'Fax',
                  '360',
                  'Virtual',
                ]),
              );
            },

          ),
          IconButton(
            icon: const Icon(Icons.notifications_outlined, color: Colors.black, size: 26),
            onPressed: () {
              // Notification functionality (not implemented yet)
            },
          ),
        ],
      ),

      // Main screen body content
      body: SafeArea(child: body),
    );
  }
}
