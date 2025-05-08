import 'package:flutter/material.dart';
import 'signin_screen.dart'; // Importing the screen to navigate to after the welcome screen

// WelcomeScreen is a StatefulWidget because it involves a timed navigation
class WelcomeScreen extends StatefulWidget {
  const WelcomeScreen({super.key});

  @override
  State<WelcomeScreen> createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {
  @override
  void initState() {
    super.initState();

    // Automatically navigate to SigninScreen after 3 seconds
    Future.delayed(const Duration(seconds: 3), () {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => const SigninScreen(), // Go to SigninScreen
        ),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // Transparent AppBar to allow top image to be visible behind it
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0, // No shadow
      ),
      extendBodyBehindAppBar: true, // Allow body content behind the app bar

      body: Stack(
        children: [
          // Bottom image aligned to bottom of screen
          Align(
            alignment: Alignment.bottomCenter,
            child: Image.asset(
              'assets/images/bottom.png',
              width: double.infinity,
              fit: BoxFit.cover, // Cover full width
            ),
          ),

          // Center image, usually logo or app icon
          Align(
            alignment: Alignment.center,
            child: Image.asset(
              'assets/images/cinec.png', // App logo/image in the center
              width: 200,
              height: 200,
              fit: BoxFit.cover,
            ),
          ),

          // Top image aligned to top of the screen
          Align(
            alignment: Alignment.topCenter,
            child: Image.asset(
              'assets/images/top1.png', // Decorative top image
              width: double.infinity,
              fit: BoxFit.cover,
            ),
          ),
        ],
      ),
    );
  }
}
