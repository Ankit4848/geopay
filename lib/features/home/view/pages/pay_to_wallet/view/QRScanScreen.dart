import 'dart:convert';
import 'dart:io';
import 'package:geopay/core/widgets/dialogs/dialog_utilities.dart';
import 'package:geopay/features/home/view/pages/pay_to_wallet/view/pay_without_qr_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:qr_code_scanner_plus/qr_code_scanner_plus.dart';
import 'package:qr_code_tools/qr_code_tools.dart';

class QRScanScreen extends StatefulWidget {
  const QRScanScreen({Key? key}) : super(key: key);

  @override
  State<QRScanScreen> createState() => _QRScanScreenState();
}

class _QRScanScreenState extends State<QRScanScreen> {
  final GlobalKey qrKey = GlobalKey(debugLabel: 'QR');
  QRViewController? controller;
  String? result;
  bool hasScanned = false;

  @override
  void reassemble() {
    super.reassemble();
    if (Platform.isAndroid) {
      controller?.pauseCamera();
    }
    controller?.resumeCamera();
  }

  Future<void> pickImageAndScan() async {
    final pickedFile = await ImagePicker().pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      final path = pickedFile.path;
      try {
        final qrCode = await QrCodeToolsPlugin.decodeFrom(path);
        if (qrCode != null) {
          _processQRCode(qrCode);
        } else {
          _showError("No QR code found in image.");
        }
      } catch (e) {
        _showError("Failed to read QR code.");
      }
    }
  }

  void _onQRViewCreated(QRViewController qrController) {
    controller = qrController;
    controller?.scannedDataStream.listen((scanData) {
      if (hasScanned) return;
      hasScanned = true;
      controller?.pauseCamera();
      _processQRCode(scanData.code);
    });
  }

  void _processQRCode(String? code) {
    if (code == null || code.isEmpty) {
      _showError("QR code is empty");
      return;
    }

    try {
      final data = jsonDecode(code);

      if (data is Map<String, dynamic>) {
        // Extract country_id and mobile_number if available
        final countryId = data.containsKey('country_id') ? data['country_id'].toString() : null;
        final mobileNumber = data.containsKey('mobile_number') ? data['mobile_number'].toString() : null;

        // Navigate to PayWithoutQrScreen with optional parameters
        Get.off(() => PayWithoutQrScreen(
          countryId: countryId,
          mobileNumber: mobileNumber,
        ));
      } else {
        throw Exception("Invalid QR code data");
      }
    } catch (e) {
      _showError("Invalid QR code format");
    }
  }

  void _showError(String message) {
    hasScanned = false;
    controller?.resumeCamera();

    DialogUtilities.showDialog(
      title: "Error",
      message:    message!,
    );

  }

  @override
  void dispose() {
    controller?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Scan QR Code")),
      body: Column(
        children: [
          Expanded(
            flex: 6,
            child: QRView(
              key: qrKey,
              onQRViewCreated: _onQRViewCreated,
              overlay: QrScannerOverlayShape(
                borderColor: Colors.blue,
                borderRadius: 10,
                borderLength: 30,
                borderWidth: 10,
                cutOutSize: 250,
              ),
            ),
          ),
          if (result != null)
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text("Result: $result"),
            ),
          Expanded(
            flex: 1,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton.icon(
                  onPressed: () {
                    // Camera permission is handled automatically by qr_code_scanner_plus
                    controller?.resumeCamera();
                  },
                  icon: const Icon(Icons.camera_alt),
                  label: const Text("Scan Camera"),
                ),
                ElevatedButton.icon(
                  onPressed: pickImageAndScan,
                  icon: const Icon(Icons.image),
                  label: const Text("Scan Gallery"),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
