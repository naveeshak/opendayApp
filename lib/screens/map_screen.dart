import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import '../widget/newcustom_scaffold.dart';

class MapScreen extends StatelessWidget {
  const MapScreen({super.key});

  // Campus Map URL
  final String CampusMapUrl = 'https://goo.gl/maps/vLtE41RByQtVtyuC8'; // Replace with your real map link

  @override
  Widget build(BuildContext context) {
    return NewCustomScaffold(
      body: Stack(
        children: [
          // Top and Bottom decorative images
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

          // Main Content
          SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 60),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const Text(
                  'Campus Map',
                  style: TextStyle(
                    fontSize: 26,
                    fontWeight: FontWeight.bold,
                    color: Colors.indigo,
                  ),
                ),
                const SizedBox(height: 10),
                const Text(
                  'Let us help you get to where you need to go. Use our map to navigate around our expansive campus grounds.',
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 16),
                ),
                const SizedBox(height: 20),

                // Campus Map Image
                ClipRRect(
                  borderRadius: BorderRadius.circular(15),
                  child: Image.asset(
                    'assets/images/campusmap.jpg',
                    fit: BoxFit.contain,
                  ),
                ),
                const SizedBox(height: 30),

                // Button to open Campus Map
                ElevatedButton(
                  onPressed: () async {
                    final Uri uri = Uri.parse(CampusMapUrl);
                    if (await canLaunchUrl(uri)) {
                      await launchUrl(uri);
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text("Could not open Campus Maps"),
                        ),
                      );
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.indigo,
                    padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 15),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
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
