import 'package:flutter/material.dart';
import 'package:openday/screens/welcome_screen.dart';

// Main function - Entry point of the Flutter application
void main() {
  // Run the application with MyApp widget as root
  runApp(const MyApp());
}

// Root widget of the application
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    // MaterialApp widget provides fundamental app functionality
    return MaterialApp(
      debugShowCheckedModeBanner: false, // Disable debug banner in top-right corner
      title: 'Flutter Demo', // Title of the application
      // Define the app's theme with a color scheme based on blueAccent
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blueAccent),
      ),
      // Set WelcomeScreen as the initial route/home screen
      home: const WelcomeScreen(),
    );
  }
}

