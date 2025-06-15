import 'package:flutter/material.dart';
import '../widget/newcustom_scaffold.dart';

class OffersScreen extends StatelessWidget {
  const OffersScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return NewCustomScaffold(
      body: Stack(
        children: [
          // Decorative background images
          Align(
            alignment: Alignment.topCenter,
            child: Image.asset(
              'assets/images/top1.png',
              width: double.infinity,
              fit: BoxFit.cover,
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Image.asset(
              'assets/images/bottom.png',
              width: double.infinity,
              fit: BoxFit.cover,
            ),
          ),

          // Main content
          SingleChildScrollView(
            padding: const EdgeInsets.only(top: 60, bottom: 20),
            child: Column(
              children: [
                _buildBanner('assets/images/offer1.png'),
                const SizedBox(height: 16),
                _buildBanner('assets/images/offer2.png'),
                const SizedBox(height: 16),
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
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(12),
        child: Image.asset(
          imagePath,
          width: double.infinity,
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}
