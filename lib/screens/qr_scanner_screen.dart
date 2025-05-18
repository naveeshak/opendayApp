import 'package:flutter/material.dart';
import 'package:mobile_scanner/mobile_scanner.dart';

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

  @override
  void dispose() {
    // Clean up the controller when widget is disposed
    cameraController.dispose();
    super.dispose();
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
              final List<Barcode> barcodes = capture.barcodes;

              if (barcodes.isNotEmpty) {
                setState(() {
                  // Update scanned data with first detected barcode
                  scannedData = barcodes.first.rawValue ?? "No data";
                });

                // Return scanned data to previous screen and close scanner
                Navigator.pop(context, scannedData);
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
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
