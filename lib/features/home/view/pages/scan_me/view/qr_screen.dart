import 'dart:ui';

import 'package:geopay/core/core.dart';
import 'package:geopay/features/common/controller/common_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:qr_flutter/qr_flutter.dart';

import 'dart:io';
import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:path_provider/path_provider.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:share_plus/share_plus.dart';

class QrScreen extends StatelessWidget {
  QrScreen({super.key});

  final GlobalKey _qrKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    CommonController commonController = Get.find();

    return Scaffold(
      backgroundColor: VariableUtilities.theme.whiteColor,
      body: Column(
        children: [
          CustomAppBar(
            title: 'Show Code',
            action: [
              IconButton(
                icon: SvgPicture.asset(AssetUtilities.share),
                onPressed: () async {
                  await _shareQrScreenshot();
                },
              ),
            ],
          ),
          Expanded(
            child: RepaintBoundary(
              key: _qrKey,

              child: Container(decoration: BoxDecoration(
                color: Colors.white
              ),
                child: Column(
                  children: [
                    SizedBox(height: MediaQuery.of(context).size.height * 0.15),
                    Text(
                      "${commonController.userModel.value!.firstName} ${commonController.userModel.value!.lastName}",
                      style: FontUtilities.style(fontSize: 16, fontWeight: FWT.bold),
                    ),
                    Text(
                      'Scan this QR code',
                      style: FontUtilities.style(
                        fontSize: 12,
                        fontWeight: FWT.bold,
                        fontColor: const Color(0xFF7C7D81),
                      ),
                    ),
                    const SizedBox(height: 46),
                    QrImageView(
                      data: '{"mobile_number":"${commonController.userModel.value!.mobileNumber}","country_id":${commonController.userModel.value!.countryId}}',
                      version: QrVersions.auto,
                      size: 250.0,
                      backgroundColor: Colors.white,
                    ),
                    const SizedBox(height: 46),
                    Text(
                      'Most trusted payment application',
                      style: FontUtilities.style(
                        fontSize: 14,
                        fontWeight: FWT.bold,
                        fontColor: VariableUtilities.theme.blackColor,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      'OR Enter the Mobile No.',
                      style: FontUtilities.style(
                        fontSize: 14,
                        fontWeight: FWT.regular,
                        fontColor: const Color(0xFF7C7D81),
                      ),
                    ),
                    const SizedBox(height: 12),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SvgPicture.asset(AssetUtilities.user),
                        const SizedBox(width: 10),
                        Text(
                          '${commonController.userModel.value!.formattedNumber}',
                          style: FontUtilities.style(
                            fontSize: 14,
                            fontWeight: FWT.bold,
                            fontColor: VariableUtilities.theme.secondaryColor,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Future<void> _shareQrScreenshot() async {
    try {
      RenderRepaintBoundary boundary =
      _qrKey.currentContext!.findRenderObject() as RenderRepaintBoundary;
      var image = await boundary.toImage(pixelRatio: 3.0);
      ByteData? byteData = await image.toByteData(format: ImageByteFormat.png);
      Uint8List pngBytes = byteData!.buffer.asUint8List();

      final directory = await getTemporaryDirectory();
      final imagePath = await File('${directory.path}/qr_code.png').create();
      await imagePath.writeAsBytes(pngBytes);

      await Share.shareXFiles([XFile(imagePath.path)], text: 'Scan this QR Code');
    } catch (e) {
      print("Screenshot sharing failed: $e");
    }
  }
}



