class TTBBeneModel {
  final int id;
  final int userId;
  final String categoryName;
  final String serviceName;
  final Map<String, dynamic> data;
  final DateTime createdAt;
  final DateTime updatedAt;

  TTBBeneModel({
    required this.id,
    required this.userId,
    required this.categoryName,
    required this.serviceName,
    required this.data,
    required this.createdAt,
    required this.updatedAt,
  });

  factory TTBBeneModel.fromJson(Map<String, dynamic> json) {
    return TTBBeneModel(
      id: json['id'],
      userId: json['user_id'],
      categoryName: json['category_name'],
      serviceName: json['service_name'],
      data: Map<String, dynamic>.from(json['data'] ?? {}),
      createdAt: DateTime.parse(json['created_at']),
      updatedAt: DateTime.parse(json['updated_at']),
    );
  }

  Map<String, dynamic> toJson() => {
    'id': id,
    'user_id': userId,
    'category_name': categoryName,
    'service_name': serviceName,
    'data': data,
    'created_at': createdAt.toIso8601String(),
    'updated_at': updatedAt.toIso8601String(),
  };
  /// Only returns the data field
  Map<String, dynamic> toDataJson() {
    return data;
  }
}