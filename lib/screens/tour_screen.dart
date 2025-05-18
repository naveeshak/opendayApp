import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import '../widget/newcustom_scaffold.dart';

// This widget represents the Virtual Campus Tour screen
class TourScreen extends StatelessWidget {
  const TourScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return NewCustomScaffold(
      // Using a Stack to layer background images and content
      body: Stack(
        children: [
          // Top decorative image
          Align(
            alignment: Alignment.topCenter,
            child: Image.asset(
              'assets/images/top1.png',
              width: double.infinity,
              fit: BoxFit.cover,
            ),
          ),
          // Bottom decorative image
          Align(
            alignment: Alignment.bottomCenter,
            child: Image.asset(
              'assets/images/bottom.png',
              width: double.infinity,
              fit: BoxFit.cover,
            ),
          ),

          // Main content centered on screen
          Center(
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // Title text
                  const Text(
                    "Virtual Campus Tour",
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Colors.indigo,
                    ),
                  ),
                  const SizedBox(height: 20),

                  // Description text
                  const Text(
                    "Explore our campus from anywhere in the world with our interactive 360° virtual tour.",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.black87,
                    ),
                  ),
                  const SizedBox(height: 30),

                  // Virtual tour preview image with shadow and rounded corners
                  Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.3),
                          blurRadius: 10,
                          spreadRadius: 2,
                          offset: const Offset(0, 5),
                        ),
                      ],
                    ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(20),
                      child: Image.asset(
                        'assets/images/virtualtour.png',
                        width: 300,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  const SizedBox(height: 30),

                  // Button to launch the virtual tour
                  ElevatedButton(
                    onPressed: () async {
                      const virtualTourUrl = 'http://cinec360.cinecict.net/';
                      final uri = Uri.parse(virtualTourUrl);
                      // Check if URL can be launched
                      if (await canLaunchUrl(uri)) {
                        await launchUrl(uri);
                      } else {
                        // Show error message if URL can't be launched
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text("Could not launch the virtual tour"),
                          ),
                        );
                      }
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.indigo,
                      padding: const EdgeInsets.symmetric(
                          horizontal: 40, vertical: 15),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    child: const Text(
                      "Start Virtual Tour",
                      style: TextStyle(
                        fontSize: 18,
                        color: Colors.white,
                      ),
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
}