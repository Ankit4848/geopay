import 'package:get/get.dart';

class FAQModel {
  final String title;
  final String description;
  RxBool isExpanded;

  FAQModel(
      {required this.title,
      required this.description,
      required this.isExpanded});
}
