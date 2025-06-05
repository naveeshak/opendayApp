import 'package:flutter/material.dart';
import '../widget/newcustom_scaffold.dart';
import 'qr_scanner_screen.dart';
import 'package:openday/screens/contact_screen.dart';
import 'package:openday/screens/tour_screen.dart';

// Main home screen that displays a banner and grid of options
class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return NewCustomScaffold(
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
          LayoutBuilder(
            builder: (context, constraints) {
              return SingleChildScrollView(
                child: ConstrainedBox(
                  constraints: BoxConstraints(
                    minHeight: constraints.maxHeight, // Ensure minimum height fills screen
                  ),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const SizedBox(height: 20), // Top spacing

                      // Banner image with shadow effect
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        child: Container(
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
                              'assets/images/banner.jpeg',
                              width: double.infinity,
                              height: 300,
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                      ),

                      const SizedBox(height: 25), // Spacing between banner and grid

                      // Grid of options (3 columns)
                      Padding(
                        padding: const EdgeInsets.only(
                          left: 20,
                          right: 20,
                          bottom: 20,
                        ),
                        child: GridView.count(
                          crossAxisCount: 3, // 3 items per row
                          shrinkWrap: true, // Take only needed space
                          physics: const NeverScrollableScrollPhysics(), // Disable scrolling
                          crossAxisSpacing: 12, // Horizontal spacing between items
                          mainAxisSpacing: 12, // Vertical spacing between items
                          childAspectRatio: 0.85, // Width to height ratio
                          children: [
                            _buildGridButton(context, 'assets/images/event.jpg', 'Event', EventScreen()),
                            _buildGridButton(context, 'assets/images/map.jpg', 'Map', MapScreen()),
                            _buildGridButton(context, 'assets/images/qr.jpg', 'QR', QRScreen()),
                            _buildGridButton(context, 'assets/images/tour.jpg', 'Virtual Tour', TourScreen()),
                            _buildGridButton(context, 'assets/images/offer.jpg', 'Offers', OffersScreen()),
                            _buildGridButton(context, 'assets/images/contact.jpg', 'Contact Us', ContactScreen()),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        ],
      ),
    );
  }

  // Helper method to create consistent grid buttons
  Widget _buildGridButton(BuildContext context, String imagePath, String label, Widget screen) {
    return Card(
      elevation: 4, // Shadow depth
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: InkWell(
        borderRadius: BorderRadius.circular(12),
        onTap: () {

          // Navigate to the corresponding screen when tapped
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => screen),
          );
        },
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Top image part of the button
            ClipRRect(
              borderRadius: const BorderRadius.vertical(
                  top: Radius.circular(12)),
              child: Image.asset(
                imagePath,
                width: double.infinity,
                height: 70,
                fit: BoxFit.cover,
              ),
            ),
            // Bottom label part of the button
            Padding(
              padding: const EdgeInsets.symmetric(
                vertical: 8,
                horizontal: 4,
              ),
              child: Text(
                label,
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.bold,
                ),
                maxLines: 2, // Ensure text doesn't overflow
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// Events screen showing schedule of open day events
class EventScreen extends StatefulWidget {
  @override
  _EventScreenState createState() => _EventScreenState();
}

class _EventScreenState extends State<EventScreen> {
  // List of events with title, time and favorite status
  final List<Map<String, dynamic>> events = [
    {'title': 'Welcome & Registration', 'time': '8:30 AM - 9:00 AM', 'isFavorite': false},
    {'title': 'Keynote Speech by University President', 'time': '9:00 AM - 9:30 AM', 'isFavorite': false},
    {'title': 'Campus Tour', 'time': '10:00 AM - 11:00 AM', 'isFavorite': false},
    {'title': 'Faculty & Department Presentations', 'time': '11:30 AM - 12:30 PM', 'isFavorite': false},
    {'title': 'Student Panel & Q&A', 'time': '1:00 PM - 1:30 PM', 'isFavorite': false},
    {'title': 'Scholarship & Admission Guidance Session', 'time': '2:00 PM - 2:30 PM', 'isFavorite': false},
    {'title': 'Clubs & Societies Fair', 'time': '3:00 PM - 4:00 PM', 'isFavorite': false},
  ];

  // Toggle favorite status for an event
  void _toggleFavorite(int index) {
    setState(() {
      events[index]['isFavorite'] = !events[index]['isFavorite'];
    });
  }

  @override
  Widget build(BuildContext context) {
    return NewCustomScaffold(
      body: Stack(
        children: [
          // Background images
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
          Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 16,
              vertical: 32,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Screen title
                const Center(
                  child: Text(
                    "Open Day Events",
                    style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                // List of events
                Expanded(
                  child: ListView.builder(
                    itemCount: events.length,
                    itemBuilder: (context, index) {
                      final event = events[index];
                      return Card(
                        elevation: 4,
                        color: Colors.indigo[100], // Light indigo background
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        margin: const EdgeInsets.symmetric(vertical: 6),
                        child: ListTile(
                          title: Text(
                            event['title']!,
                            style: const TextStyle(
                              color: Colors.indigo,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          subtitle: Padding(
                            padding: const EdgeInsets.only(top: 4),
                            child: Text(
                              event['time']!,
                              style: const TextStyle(color: Colors.indigo),
                            ),
                          ),
                          // Favorite star icon
                          trailing: GestureDetector(
                            onTap: () => _toggleFavorite(index),
                            child: Icon(
                              Icons.star,
                              color: event['isFavorite'] ? Colors.yellow : Colors.indigo,
                            ),
                          ),
                        ),
                      );
                    },
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

// Placeholder map screen
class MapScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) => Scaffold(
    appBar: AppBar(title: const Text("Map Screen")),
  );
}

// QR code scanning screen
class QRScreen extends StatelessWidget {
  const QRScreen({super.key});

  @override
  Widget build(BuildContext context) => NewCustomScaffold(
    body: Stack(
      children: [
        // Background images
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
        Center(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                // Instructions text
                const Text(
                  "Click the button and scan the QR code to unlock exclusive content such as videos, documents, and speaker biographies",
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 16, color: Colors.black),
                ),
                const SizedBox(height: 20),
                // QR code display
                ClipOval(
                  child: Container(
                    width: 200,
                    height: 200,
                    decoration: const BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.black,
                    ),
                    child: Image.asset(
                      'assets/images/qrcode.jpg',
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                const SizedBox(height: 30),
                // Scan button
                ElevatedButton(
                  onPressed: () async {
                    // Launch QR scanner and get result
                    final scannedResult = await Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => const QRScannerScreen()),
                    );
                    if (scannedResult != null) {
                      // Show scanned result
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text("Scanned: $scannedResult")),
                      );
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blue,
                    padding: const EdgeInsets.symmetric(
                      horizontal: 32,
                      vertical: 12,
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  child: const Text(
                    "Scan Me",
                    style: TextStyle(fontSize: 18, color: Colors.white),
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

// Placeholder offers screen
class OffersScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) => Scaffold(
    appBar: AppBar(title: const Text("Offers Screen")),
  );
}