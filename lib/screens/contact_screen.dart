import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import '../widget/newcustom_scaffold.dart';

// ContactScreen is a StatelessWidget that displays contact information and social media links
class ContactScreen extends StatelessWidget {
  const ContactScreen({super.key});

  // Function to launch a URL in an external application
  void _launchURL(String url) async {
    final uri = Uri.parse(url);
    if (!await launchUrl(uri, mode: LaunchMode.externalApplication)) {
      throw 'Could not launch $url';
    }
  }

  @override
  Widget build(BuildContext context) {
    return NewCustomScaffold(
      body: Stack(
        children: [
          // Background image at the top
          Align(
            alignment: Alignment.topCenter,
            child: Image.asset('assets/images/top1.png', width: double.infinity, fit: BoxFit.cover),
          ),
          // Background image at the bottom
          Align(
            alignment: Alignment.bottomCenter,
            child: Image.asset('assets/images/bottom.png', width: double.infinity, fit: BoxFit.cover),
          ),

          // Main content centered on the screen
          Center(
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // Title text
                  const Text(
                    "Contact Us",
                    style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: Colors.indigo),
                  ),
                  const SizedBox(height: 20),

                  // Contact information card
                  Card(
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
                    elevation: 5,
                    child: Padding(
                      padding: const EdgeInsets.all(20),
                      child: Column(
                        children: const [
                          Text("CINEC Campus (Pvt) Ltd.", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                          SizedBox(height: 10),
                          Text(
                            "Millennium Drive,\nIT Park,\nMalabe,\nSri Lanka\n\nPhone: +94 11 2 413 500\nFax: +94 11 2 413 505\nEmail: info@cinec.edu",
                            textAlign: TextAlign.center,
                          ),
                        ],
                      ),
                    ),
                  ),

                  const SizedBox(height: 30),

                  // Social media icons row
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      // Facebook icon button
                      IconButton(
                        iconSize: 50,
                        icon: Container(
                          width: 50,
                          height: 50,
                          child: Image.asset(
                            'assets/icons/facebook.png',
                            fit: BoxFit.contain,
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
