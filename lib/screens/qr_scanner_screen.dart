import 'package:flutter/material.dart';
import 'package:mobile_scanner/mobile_scanner.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:flutter/services.dart';

// Screen for scanning QR codes using device camera
class QRScannerScreen extends StatefulWidget {
  const QRScannerScreen({super.key});

  @override
  _QRScannerScreenState createState() => _QRScannerScreenState();
}

class _QRScannerScreenState extends State<QRScannerScreen> {
  // Controller for managing the mobile scanner
  MobileScannerController cameraController = MobileScannerController();

  // Variable to store the scanned QR code data
  String scannedData = "Scan a QR Code";
  bool _isScanning = true;

  @override
  void dispose() {
    // Clean up the controller when widget is disposed
    cameraController.dispose();
    super.dispose();
  }


  Future<void> _handleScannedData(String data) async {
    setState(() {
      scannedData = data;
      _isScanning = false;
    });

    // Check if it's a URL
    if (_isValidUrl(data)) {
      await _showUrlDialog(data);
    }
    // Check if it's a file path (simple check)
    else if (_looksLikeFilePath(data)) {
      await _showFileContentDialog(data);
    }
    // Treat as plain text
    else {
      await _showTextDialog(data);
    }

    // Resume scanning after handling
    if (mounted) {
      setState(() => _isScanning = true);
    }
  }

  bool _isValidUrl(String data) {
    final uri = Uri.tryParse(data);
    return uri != null && (uri.scheme == 'http' || uri.scheme == 'https');
  }

  bool _looksLikeFilePath(String data) {
    return data.contains('/') || data.contains('\\') || data.contains('.');
  }

  Future<void> _showUrlDialog(String url) async {
    return showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('URL Detected'),
        content: Text(url),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () async {
              Navigator.pop(context);
              final uri = Uri.parse(url);
              if (!await launchUrl(uri, mode: LaunchMode.externalApplication)) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text('Could not launch $url')),
                );
              } else {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text('Could not launch $url')),
                );
              }
            },
            child: const Text('Open'),
          ),
        ],
      ),
    );
  }

  Future<void> _showFileContentDialog(String filePath) async {
    return showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('File Reference'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text('The QR code contains a file reference:'),
            const SizedBox(height: 10),
            Text(
              filePath,
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 20),
            const Text('Note: This app cannot access actual files from paths.'),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('OK'),
          ),
        ],
      ),
    );
  }

  Future<void> _showTextDialog(String text) async {
    return showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Scanned Text'),
        content: SingleChildScrollView(
          child: Text(text),
        ),
        actions: [
          TextButton(
            onPressed: () {
              Clipboard.setData(ClipboardData(text: text));
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Copied to clipboard')),
              );
              Navigator.pop(context);
            },
            child: const Text('Copy'),
          ),
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('OK'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("QR Code Scanner")),
      body: Stack(
        children: [
          // MobileScanner widget that handles camera and QR detection
          MobileScanner(
            controller: cameraController, // Pass the controller
            // Callback when QR code is detected
            onDetect: (capture) {
              final barcodes = capture.barcodes;
              if (barcodes.isNotEmpty) {
                final data = barcodes.first.rawValue ?? "No data";
                _handleScannedData(data);
              }
            },
          ),

          // Overlay to display scanned data at bottom of screen
          Align(
            alignment: Alignment.bottomCenter,
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: Colors.black.withOpacity(0.6), // Semi-transparent black
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Text(
                  scannedData,
                  style: const TextStyle(color: Colors.white, fontSize: 16),
                  maxLines: 3,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
