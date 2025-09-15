import 'package:flutter/material.dart';
import 'package:get/get.dart';

/// calculated device height, width and scalable pixels.
extension DeviceExtension on num {
  /// calculate device height.
  double hPr() => (this * 813) / Get.height;

  /// calculate device width.
  double wPr() => (this * 375) / Get.width;

  /// calculate device scalable pixel.
  double scp(BuildContext context) =>
      this *
      (((hPr() + wPr()) +
              (MediaQuery.of(context).devicePixelRatio *
                  MediaQuery.of(context).size.aspectRatio)) /
          2.08) /
      100;
}

/// this is the class to get some information of the device.
class Device {
  /// device aspect ratio.
  static double ratio(BuildContext context) =>
      MediaQuery.of(context).size.aspectRatio;
}
