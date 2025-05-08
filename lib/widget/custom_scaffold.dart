import 'package:flutter/material.dart';

// CustomScaffold is a reusable widget that wraps its content with a background design
class CustomScaffold extends StatelessWidget {
  final Widget body; // The main content passed from the screen
  final String? title; // Optional title (currently unused)

  const CustomScaffold({super.key, required this.body, this.title});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // App bar with transparent background and no elevation
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),

      // Allow body to extend behind the transparent app bar
      extendBodyBehindAppBar: true,

      // Stack allows background images and body content to be layered
      body: Stack(
        children: [
          // Bottom decorative image
          Align(
            alignment: Alignment.bottomCenter,
            child: Image.asset(
              'assets/images/bottom.png',
              width: double.infinity,
              fit: BoxFit.cover, // Stretch to cover width
            ),
          ),

          // Top decorative image
          Align(
            alignment: Alignment.topCenter,
            child: Image.asset(
              'assets/images/top1.png',
              width: double.infinity,
              fit: BoxFit.cover,
            ),
          ),

          // The main body content of the screen, wrapped in SafeArea to avoid overlaps
          SafeArea(
            child: body,
          ),
        ],
      ),
    );
  }
}
