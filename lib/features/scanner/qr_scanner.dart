import 'dart:ui';
import 'package:flutter/material.dart';

class QrScannerScreen extends StatefulWidget {
  const QrScannerScreen({super.key});

  @override
  State<QrScannerScreen> createState() => _QrScannerScreenState();
}

class _QrScannerScreenState extends State<QrScannerScreen> {
  final GlobalKey qrKey = GlobalKey(debugLabel: 'QR');
  String selectedSearchType = 'Student Search';

  // @override
  // void reassemble() {
  //   super.reassemble();
  //   if (controller != null) {
  //     controller!.pauseCamera();
  //     controller!.resumeCamera();
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Search Profile'),
      ),
      body: Column(
        
        children: [
          
          // Search Type Selector
          Padding(

            padding: const EdgeInsets.all(1),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                _buildRadioOption('Student Search'),
                _buildRadioOption('Staff S.'),
                _buildRadioOption('Student Atd.'),
              ],
            ),
          ),
          // Scanner View with overlay
          const Expanded(
            child: Stack(
              children: [
                // QR Scanner
                // QRView(
                //   key: qrKey,
                //   onQRViewCreated: _onQRViewCreated,
                //   overlay: QrScannerOverlayShape(
                //     borderColor: Colors.green,
                //     borderRadius: 10,
                //     borderLength: 30,
                //     borderWidth: 10,
                //     cutOutSize: MediaQuery.of(context).size.width * 0.6,
                //   ),
                // ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildRadioOption(String title) {
    return Row(
      children: [
        Radio<String>(
          value: title,
          groupValue: selectedSearchType,
          onChanged: (value) {
            setState(() {
              selectedSearchType = value!;
              // TODO: Add functionality
            });
          },
        ),
        Text(title),
      ],
    );
  }

  // void _onQRViewCreated(QRViewController controller) {
  //   this.controller = controller;
  //   controller.scannedDataStream.listen((scanData) {
  //     // Handle the scanned QR code data
  //     debugPrint('Scanned QR Code: ${scanData.code}');
  //     // You can add logic here to handle different search types
  //   });
  // }

  @override
  void dispose() {
    // controller?.dispose();
    super.dispose();
  }
}
