import 'package:flutter/material.dart';
import 'package:openday/screens/welcome_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:openday/screens/home_screen.dart';

// Main function - Entry point of the Flutter application
void main() {
  // Run the application with MyApp widget as root
  runApp(const MyApp());
}

// Root widget of the application
class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  bool? isLoggedIn;

  @override
  void initState() {
    super.initState();
    checkLoginStatus();
  }

  Future<void> checkLoginStatus() async {
    final prefs = await SharedPreferences.getInstance();
    final loggedIn = prefs.getBool('isLoggedIn') ?? false;
    setState(() {
      isLoggedIn = loggedIn;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (isLoggedIn == null) {
      // Still checking login status, show loading
      return const MaterialApp(
        home: Scaffold(
          body: Center(child: CircularProgressIndicator()),
        ),
      );
    }

    // MaterialApp widget provides fundamental app functionality
    return MaterialApp(
      debugShowCheckedModeBanner: false, // Disable debug banner in top-right corner
      title: 'Flutter Demo', // Title of the application
      // Define the app's theme with a color scheme based on blueAccent
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blueAccent),
      ),
      // Set WelcomeScreen as the initial route/home screen
      home: isLoggedIn! ? const HomeScreen() : const WelcomeScreen(),
      routes: {
        '/login': (context) => const WelcomeScreen(),
        '/home': (context) => const HomeScreen(),
        // other routes here
      },
    );
  }
}

