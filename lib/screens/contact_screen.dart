import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import '../widget/newcustom_scaffold.dart';

// ContactScreen is a StatelessWidget that displays contact information and social media links
class ContactScreen extends StatelessWidget {
  const ContactScreen({super.key});

  // Function to launch a URL in an external application
  // Takes a URL string as input and attempts to open it in an external browser/app
  void _launchURL(String url) async {
    // Parse the string URL into a Uri object
    final uri = Uri.parse(url);
    // Try to launch the URL using the url_launcher package
    // LaunchMode.externalApplication ensures it opens in an external app/browser
    if (!await launchUrl(uri, mode: LaunchMode.externalApplication)) {
      // Throw an exception if the URL couldn't be launched
      throw 'Could not launch $url';
    }
  }

  @override
  Widget build(BuildContext context) {
    // Using NewCustomScaffold as the base widget for consistent app styling
    return NewCustomScaffold(
      body: Stack(
        children: [
          // Background image at the top of the screen
          // Align widget positions the image at the top center
          Align(
            alignment: Alignment.topCenter,
            child: Image.asset('assets/images/top1.png', width: double.infinity, fit: BoxFit.cover),
          ),
          // Background image at the bottom of the screen
          // Align widget positions the image at the bottom center
          Align(
            alignment: Alignment.bottomCenter,
            child: Image.asset('assets/images/bottom.png', width: double.infinity, fit: BoxFit.cover),
          ),

          // Main content centered on the screen
          Center(
            child: Padding(
              padding: const EdgeInsets.all(20), // Padding around all content
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center, // Centers content vertically
                children: [
                  // Title text widget
                  const Text(
                    "Contact Us",
                    style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: Colors.indigo),
                  ),
                  const SizedBox(height: 20), // Spacer between title and card

                  // Card widget for contact information
                  Card(
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)), // Rounded corners
                    elevation: 5, // Shadow depth
                    child: Padding(
                      padding: const EdgeInsets.all(20), // Inner padding
                      child: Column(
                        children: const [
                          // Company name
                          Text("CINEC Campus (Pvt) Ltd.", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                          SizedBox(height: 10), // Spacer
                          // Company address and contact details
                          Text(
                            "Millennium Drive,\nIT Park,\nMalabe,\nSri Lanka\n\nPhone: +94 11 2 413 500\nFax: +94 11 2 413 505\nEmail: info@cinec.edu",
                            textAlign: TextAlign.center, // Center-aligned text
                          ),
                        ],
                      ),
                    ),
                  ),

                  const SizedBox(height: 30), // Spacer between card and social icons

                  // Row of social media icon buttons
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center, // Centers icons horizontally
                    children: [
                      // Facebook icon button
                      IconButton(
                        iconSize: 50,
                        icon: Container(
                          width: 50,
                          height: 50,
                          child: Image.asset(
                            'assets/icons/facebook.png',
                            fit: BoxFit.contain, // Fits image within container
                            // Error builder shows an error icon if image fails to load
                            errorBuilder: (context, error, stackTrace) => Icon(Icons.error),
                          ),
                        ),
                        onPressed: () => _launchURL('https://www.facebook.com/share/1C4TixWTEx/'),
                      ),
                      // Instagram icon button
                      IconButton(
                        iconSize: 50,
                        icon: Container(
                          width: 40,
                          height: 40,
                          child: Image.asset(
                            'assets/icons/instagram.png',
                            fit: BoxFit.contain,
                            errorBuilder: (context, error, stackTrace) => Icon(Icons.error),
                          ),
                        ),
                        onPressed: () => _launchURL('https://www.instagram.com/cinec_campus?igsh=dW04d2NhOWczMHY='),
                      ),
                      // LinkedIn icon button
                      IconButton(
                        iconSize: 50,
                        icon: Container(
                          width: 43,
                          height: 43,
                          child: Image.asset(
                            'assets/icons/linkedin.png',
                            fit: BoxFit.contain,
                            errorBuilder: (context, error, stackTrace) => Icon(Icons.error),
                          ),
                        ),
                        onPressed: () => _launchURL('https://www.linkedin.com/school/cinec-campus/'),
                      ),
                      // TikTok icon button
                      IconButton(
                        iconSize: 50,
                        icon: Container(
                          width: 40,
                          height: 40,
                          child: Image.asset(
                            'assets/icons/tiktok.png',
                            fit: BoxFit.contain,
                            errorBuilder: (context, error, stackTrace) => Icon(Icons.error),
                          ),
                        ),
                        onPressed: () => _launchURL('https://www.tiktok.com/@cineccampus?_t=ZS-8wJlMlAbGwj&_r=1'),
                      ),
                      // YouTube icon button
                      IconButton(
                        iconSize: 50,
                        icon: Container(
                          width: 40,
                          height: 40,
                          child: Image.asset(
                            'assets/icons/youtube.png',
                            fit: BoxFit.contain,
                            errorBuilder: (context, error, stackTrace) => Icon(Icons.error),
                          ),
                        ),
                        onPressed: () => _launchURL('https://youtube.com/@cineccampus2575?si=jYj1Q_ombTNH7l5V'),
                      ),
                    ],
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
