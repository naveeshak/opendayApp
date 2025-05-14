import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import '../widget/newcustom_scaffold.dart';

class ContactScreen extends StatelessWidget {
  const ContactScreen({super.key});

  // Open URLs in browser
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
          // Decorative background
          Align(
            alignment: Alignment.topCenter,
            child: Image.asset('assets/images/top1.png', width: double.infinity, fit: BoxFit.cover),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Image.asset('assets/images/bottom.png', width: double.infinity, fit: BoxFit.cover),
          ),

          // Main content
          Center(
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    "Contact Us",
                    style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: Colors.indigo),
                  ),
                  const SizedBox(height: 20),

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

                  // Social Media Icons
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      IconButton(
                        iconSize: 50, // This sets the clickable area size
                        icon: Container(
                          width: 50, // Slightly smaller than iconSize for padding
                          height: 50,
                          child: Image.asset(
                            'assets/icons/facebook.png',
                            fit: BoxFit.contain, // Ensures image fits properly
                            errorBuilder: (context, error, stackTrace) => Icon(Icons.error), // Fallback widget
                          ),
                        ),
                        onPressed: () => _launchURL('https://www.facebook.com/share/1C4TixWTEx/'),
                      ),
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
