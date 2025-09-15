import 'package:flutter/material.dart';

class ServiceModel {
  final String gifPath;
  final String title;
  final VoidCallback onTap;

  ServiceModel({
    required this.gifPath,
    required this.title,
    required this.onTap,
  });
}
