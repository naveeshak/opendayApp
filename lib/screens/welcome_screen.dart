import 'package:flutter/material.dart';
import 'signin_screen.dart';

// Welcome screen that shows a splash screen before redirecting to SigninScreen
class WelcomeScreen extends StatefulWidget {
  const WelcomeScreen({super.key});

  @override
  State<WelcomeScreen> createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {
  @override
  void initState() {
    super.initState();

    // After a 3-second delay, navigate to the SigninScreen
    Future.delayed(const Duration(seconds: 3), () {
      Navigator.pushReplacement(
        // Replace current screen to prevent going back
        context,
        MaterialPageRoute(
          builder: (context) => const SigninScreen(),
        ),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // Transparent app bar with no elevation (shadow)
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      // Extend body behind the app bar
      extendBodyBehindAppBar: true,

      // Stack allows layering of multiple widgets
      body: Stack(
        children: [
          // Bottom decorative image
          Align(
            alignment: Alignment.bottomCenter,
            child: Image.asset(
              'assets/images/bottom.png',
              width: double.infinity,
              fit: BoxFit.cover,
            ),
          ),

          // Center logo/image
          Align(
            alignment: Alignment.center,
            child: Image.asset(
              'assets/images/cinec.png',
              width: 200,
              height: 200,
              fit: BoxFit.cover,
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
        ],
      ),
    );
  }
}
