import 'package:flutter/material.dart';
import 'package:qr_code_scanner_plus/qr_code_scanner_plus.dart';


class QRScanView extends StatefulWidget {
  const QRScanView({super.key});

  @override
  _QRScanViewState createState() => _QRScanViewState();
}

class _QRScanViewState extends State<QRScanView> {
  final GlobalKey qrKey = GlobalKey(debugLabel: 'QR');
  QRViewController? controller;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Stack(
        children: [
          // QR Scanner View
          Positioned.fill(
            child: QRView(key: qrKey, onQRViewCreated: _onQRViewCreated),
          ),
          // Top Navigation
          Positioned(
            top: 40,
            left: 20,
            child: GestureDetector(
              onTap: () => Navigator.of(context).pop(),
              child: Container(
                padding: EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: Colors.black.withOpacity(0.5),
                  shape: BoxShape.circle,
                ),
                child: Icon(Icons.close, color: Colors.white, size: 24),
              ),
            ),
          ),
          // Flash and Instructions
          Positioned(
            bottom: 40,
            left: 20,
            right: 20,
            child: Column(
              children: [
                // Flash Button
                ElevatedButton.icon(
                  onPressed: () => controller?.toggleFlash(),
                  icon: Icon(Icons.flash_on, color: Colors.white),
                  label: Text(
                    "Toggle Flash",
                    style: TextStyle(color: Colors.white),
                  ),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.black.withOpacity(0.6),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                  ),
                ),
                SizedBox(height: 20),
                // Instruction Text
                Text(
                  "Align the QR code within the frame to scan",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                  ),
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          ),
          // QR Scanner Frame
          Center(
            child: Container(
              height: 250,
              width: 250,
              decoration: BoxDecoration(
                border: Border.all(color: Colors.white, width: 2),
                borderRadius: BorderRadius.circular(12),
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _onQRViewCreated(QRViewController controller) {
    this.controller = controller;
    controller.scannedDataStream.first.then((scanData) {
      print("SCAN RESULT :: $scanData");
      Navigator.of(context).pop(scanData);
    });
  }

  @override
  void dispose() {
    controller?.dispose();
    super.dispose();
  }
}
