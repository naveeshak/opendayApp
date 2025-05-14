import 'package:flutter/material.dart';
import '../widget/newcustom_scaffold.dart';
import 'qr_scanner_screen.dart';
import 'package:flutter/gestures.dart';
import 'package:openday/screens/contact_screen.dart';
import 'package:openday/screens/tour_screen.dart';


/// HomeScreen widget displaying the main dashboard with a grid of features.
class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return NewCustomScaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(height: 20),

            // Banner Image with rounded corners and shadow
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black,
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
                  width: 300,
                  fit: BoxFit.cover,
                ),
              ),
            ),

            const SizedBox(height: 30),

            // Grid of navigable buttons
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: GridView.count(
                crossAxisCount: 3,
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                crossAxisSpacing: 20,
                mainAxisSpacing: 20,
                children: [
                  _buildIconButton(context, 'assets/images/event.jpg', 'Event', EventScreen()),
                  _buildIconButton(context, 'assets/images/map.jpg', 'Map', MapScreen()),
                  _buildIconButton(context, 'assets/images/qr.jpg', 'QR', QRScreen()),
                  _buildIconButton(context, 'assets/images/tour.jpg', 'Virtual Tour', TourScreen()),
                  _buildIconButton(context, 'assets/images/offer.jpg', 'Offers', OffersScreen()),
                  _buildIconButton(context, 'assets/images/contact.jpg', 'Contact Us', ContactScreen()),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  /// Helper method to create stylized button widgets with image and label
  Widget _buildIconButton(BuildContext context, String imagePath, String label, Widget screen) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => screen),
        );
      },
      child: Container(
        decoration: BoxDecoration(
          color: Colors.transparent,
          borderRadius: BorderRadius.circular(15),
          boxShadow: [
            BoxShadow(
              color: Colors.grey,
              blurRadius: 8,
              spreadRadius: 2,
              offset: const Offset(3, 3),
            ),
          ],
        ),
        padding: const EdgeInsets.all(3),
        child: Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12),
            boxShadow: [
              BoxShadow(
                color: Colors.grey,
                blurRadius: 1,
                spreadRadius: 0.5,
                offset: const Offset(-2, -2),
              ),
              BoxShadow(
                color: Colors.grey,
                blurRadius: 1,
                spreadRadius: 0.5,
                offset: const Offset(2, 2),
              ),
            ],
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Image inside button
              ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: Image.asset(
                  imagePath,
                  width: 140,
                  height: 79,
                  fit: BoxFit.cover,
                ),
              ),
              const SizedBox(height: 5),
              Text(
                label,
                style: const TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

/// Displays a list of open day events with option to mark as favorite.
class EventScreen extends StatefulWidget {
  @override
  _EventScreenState createState() => _EventScreenState();
}

class _EventScreenState extends State<EventScreen> {
  // Event list with favorite flag
  final List<Map<String, dynamic>> events = [
    {'title': 'Welcome & Registration', 'time': '8:30 AM - 9:00 AM', 'isFavorite': false},
    {'title': 'Keynote Speech by University President', 'time': '9:00 AM - 9:30 AM', 'isFavorite': false},
    {'title': 'Campus Tour', 'time': '10:00 AM - 11:00 AM', 'isFavorite': false},
    {'title': 'Faculty & Department Presentations', 'time': '11:30 AM - 12:30 PM', 'isFavorite': false},
    {'title': 'Student Panel & Q&A', 'time': '1:00 PM - 1:30 PM', 'isFavorite': false},
    {'title': 'Scholarship & Admission Guidance Session', 'time': '2:00 PM - 2:30 PM', 'isFavorite': false},
    {'title': 'Clubs & Societies Fair', 'time': '3:00 PM - 4:00 PM', 'isFavorite': false},
  ];

  /// Toggle favorite status for an event
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
          // Decorative top and bottom wave images
          Align(
            alignment: Alignment.topCenter,
            child: Image.asset('assets/images/top1.png', width: double.infinity, fit: BoxFit.cover),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Image.asset('assets/images/bottom.png', width: double.infinity, fit: BoxFit.cover),
          ),

          // Main event list content
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 32),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Center(
                  child: Text("Open Day Events", style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
                ),
                const SizedBox(height: 20),

                // Scrollable list of events
                Expanded(
                  child: ListView.builder(
                    itemCount: events.length,
                    itemBuilder: (context, index) {
                      final event = events[index];
                      return Card(
                        elevation: 4,
                        color: Colors.indigo[100],
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                        margin: const EdgeInsets.symmetric(vertical: 6),
                        child: ListTile(
                          title: Text(
                            event['title']!,
                            style: const TextStyle(color: Colors.indigo, fontWeight: FontWeight.bold),
                          ),
                          subtitle: Padding(
                            padding: const EdgeInsets.only(top: 4),
                            child: Text(event['time']!, style: const TextStyle(color: Colors.indigo)),
                          ),
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

/// Displays a basic map screen (placeholder)
class MapScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) => Scaffold(appBar: AppBar(title: const Text("Map Screen")));
}

/// QRScreen with instructions, QR code image, and scan button
class QRScreen extends StatelessWidget {
  const QRScreen({super.key});

  @override
  Widget build(BuildContext context) => NewCustomScaffold(
    body: Stack(
      children: [
        // Decorative wave images
        Align(
          alignment: Alignment.topCenter,
          child: Image.asset('assets/images/top1.png', width: double.infinity, fit: BoxFit.cover),
        ),
        Align(
          alignment: Alignment.bottomCenter,
          child: Image.asset('assets/images/bottom.png', width: double.infinity, fit: BoxFit.cover),
        ),

        // Main QR scan UI
        Center(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
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

                // Button to navigate to scanner
                ElevatedButton(
                  onPressed: () async {
                    final scannedResult = await Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => const QRScannerScreen()),
                    );
                    if (scannedResult != null) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text("Scanned: $scannedResult")),
                      );
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blue,
                    padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 12),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                  ),
                  child: const Text("Scan Me", style: TextStyle(fontSize: 18, color: Colors.white)),
                ),
              ],
            ),
          ),
        ),
      ],
    ),
  );
}

/// Placeholder screen for Offers
class OffersScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) => Scaffold(appBar: AppBar(title: const Text("Offers Screen")));
}
