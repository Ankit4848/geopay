class DynamicFormField {
  final String fieldName;
  final String fieldLabel;
  final bool required;
  final bool dynamicField;
  final int minLength;
  final int maxLength;
  final Map<String, String> options;
  final String inputType;

  DynamicFormField({
    required this.fieldName,
    required this.fieldLabel,
    required this.required,
    required this.dynamicField,
    required this.minLength,
    required this.maxLength,
    required this.options,
    required this.inputType,
  });

  factory DynamicFormField.fromJson(Map<String, dynamic> json) {
    final rawOptions = json['options'];
    return DynamicFormField(
      fieldName: json['fieldName'],
      fieldLabel: json['fieldLabel'],
      required: json['required'],
      dynamicField: json['dynamicField'],
      minLength: json['minLength'],
      maxLength: json['maxLength'],
      options:  rawOptions is Map<String, dynamic> ? Map<String, String>.from(rawOptions) : {},
      inputType: json['inputType'],
    );
  }
}
