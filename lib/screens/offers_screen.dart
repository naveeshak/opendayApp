import 'package:flutter/material.dart';
import '../widget/newcustom_scaffold.dart';

// Screen that displays promotional offers and discounts available during Open Day
/// Shows a scrollable list of offer banners in a vertical layout
class OffersScreen extends StatelessWidget {
  const OffersScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return NewCustomScaffold(
      body: Stack(
        children: [
          // Decorative background images
          // Matches the visual style of other screens in the app
          Align(
            alignment: Alignment.topCenter,
            child: Image.asset(
              'assets/images/top1.png',
              width: double.infinity,
              fit: BoxFit.cover, // Ensures the image covers the full width
            ),
          ),
          // Bottom decorative background image
          // Provides visual balance to the top image
          Align(
            alignment: Alignment.bottomCenter,
            child: Image.asset(
              'assets/images/bottom.png',
              width: double.infinity,
              fit: BoxFit.cover,
            ),
          ),

          // Main content
          // Contains all offer banners in a vertical list
          SingleChildScrollView(
            padding: const EdgeInsets.only(top: 60, bottom: 20),
            child: Column(
              children: [
                // First promotional offer banner
                _buildBanner('assets/images/offer1.png'),
                const SizedBox(height: 16), // Spacing between banners
                // Second promotional offer banner
                _buildBanner('assets/images/offer2.png'),
                const SizedBox(height: 16), // Spacing between banners
                // Third promotional offer banner
                _buildBanner('assets/images/offer3.png'),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // Reusable banner widget
  Widget _buildBanner(String imagePath) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16), // Side margins
      child: ClipRRect(
        borderRadius: BorderRadius.circular(12), // Rounded corners
        child: Image.asset(
          imagePath,
          width: double.infinity, // Full width of parent
          fit: BoxFit.cover, // Ensures image fills container
        ),
      ),
    );
  }
}
