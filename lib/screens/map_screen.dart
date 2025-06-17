import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import '../widget/newcustom_scaffold.dart';

// Screen displaying the campus map with interactive features
class MapScreen extends StatelessWidget {
  const MapScreen({super.key});

  // Campus Map URL
  final String CampusMapUrl = 'https://www.google.com/maps/d/viewer?mid=1rzZybqbU6EKHx9eXlvCEG4vSJk2Ac8I&ll=6.915259086288546%2C79.96070804053609&z=18';

  @override
  Widget build(BuildContext context) {
    return NewCustomScaffold(
      body: Stack(
        children: [
          // Top and Bottom decorative images
          // This provides visual consistency with other screens
          Align(
            alignment: Alignment.topCenter,
            child: Image.asset(
              'assets/images/top1.png',
              width: double.infinity,
              fit: BoxFit.cover, // Ensures the image covers the available space
            ),
          ),
          // Bottom decorative background image
          // Matches the top image for balanced design
          Align(
            alignment: Alignment.bottomCenter,
            child: Image.asset(
              'assets/images/bottom.png',
              width: double.infinity,
              fit: BoxFit.cover,
            ),
          ),

          // Main Content
          SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 60),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                // Screen title
                const Text(
                  'Campus Map',
                  style: TextStyle(
                    fontSize: 26,
                    fontWeight: FontWeight.bold,
                    color: Colors.indigo, // Brand color
                  ),
                ),
                const SizedBox(height: 10), // Spacing between title and subtitle
                // Descriptive text about the map functionality
                const Text(
                  'Let us help you get to where you need to go. Use our map to navigate around our expansive campus grounds.',
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 16),
                ),
                const SizedBox(height: 20), // Spacing before the map image

                // Campus Map Image
                ClipRRect(
                  borderRadius: BorderRadius.circular(15), // Rounded corners
                  child: Image.asset(
                    'assets/images/campusmap.jpg',
                    fit: BoxFit.contain, // Ensures full image is visible
                  ),
                ),
                const SizedBox(height: 30), // Spacing before the button


                // Button to open Campus Map
                ElevatedButton(
                  onPressed: () async {
                    // Attempt to launch the Google Maps URL
                    final Uri uri = Uri.parse(CampusMapUrl);
                    if (await canLaunchUrl(uri)) {
                      await launchUrl(uri);
                    } else {
                      // Show error if URL can't be launched
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text("Could not open Campus Maps"),
                        ),
                      );
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.indigo, // Brand color
                    padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 15),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10), // Rounded corners
                    ),
                  ),
                  child: const Text(
                    "Open campus map",
                    style: TextStyle(
                      fontSize: 18,
                      color: Colors.white,
                    ),
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
