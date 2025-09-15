class ApiErrorModel {
  final Map<String, List<String>> errors;

  ApiErrorModel({required this.errors});

  factory ApiErrorModel.fromJson(Map<String, dynamic> json) {
    return ApiErrorModel(
      errors: Map<String, List<String>>.from(
        json['errors']?.map((key, value) => MapEntry(key, List<String>.from(value))) ?? {},
      ),
    );
  }
}
