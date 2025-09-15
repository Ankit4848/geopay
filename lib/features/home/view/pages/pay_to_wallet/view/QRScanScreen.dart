import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:qr_code_scanner_plus/qr_code_scanner_plus.dart';
import 'package:qr_code_tools/qr_code_tools.dart';
import 'package:permission_handler/permission_handler.dart';

// Dummy screen to navigate
class PayWithQrScreen extends StatelessWidget {
  final String countryId;
  final String mobileNumber;

  const PayWithQrScreen({
    super.key,
    required this.countryId,
    required this.mobileNumber,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Pay With QR")),
      body: Center(
        child: Text('Country ID: $countryId\nMobile: $mobileNumber'),
      ),
    );
  }
}

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

      if (data is Map<String, dynamic> &&
          data.containsKey('mobile_number') &&
          data.containsKey('country_id')) {
        Get.off(() => PayWithQrScreen(
          countryId: data['country_id'].toString(),
          mobileNumber: data['mobile_number'].toString(),
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

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(message)),
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
                  onPressed: () async {
                    await Permission.camera.request();
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
