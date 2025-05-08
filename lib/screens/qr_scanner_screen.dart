import 'package:flutter/material.dart';
import 'package:mobile_scanner/mobile_scanner.dart';

class QRScannerScreen extends StatefulWidget {
  const QRScannerScreen({super.key});

  @override
  _QRScannerScreenState createState() => _QRScannerScreenState();
}

class _QRScannerScreenState extends State<QRScannerScreen> {
  // Controller to manage the mobile scanner (camera)
  MobileScannerController cameraController = MobileScannerController();

  // Variable to store scanned QR code result
  String scannedData = "Scan a QR Code";

  // Dispose the camera controller when the screen is removed from memory
  @override
  void dispose() {
    cameraController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("QR Code Scanner")),
      body: Stack(
        children: [
          // Scanner camera view using MobileScanner
          MobileScanner(
            controller: cameraController,
            onDetect: (capture) {
              final List<Barcode> barcodes = capture.barcodes;

              // If any barcode is detected, update UI and return the result
              if (barcodes.isNotEmpty) {
                setState(() {
                  scannedData = barcodes.first.rawValue ?? "No data";
                });

                // Close the scanner screen and send back scanned result
                Navigator.pop(context, scannedData);
              }
            },
          ),

          // Overlay widget to display the scanned result at the bottom
          Align(
            alignment: Alignment.bottomCenter,
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: Colors.black.withOpacity(0.6),
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
