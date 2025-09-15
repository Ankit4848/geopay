class MobileBeneficiaryModel {
  String? fieldName;
  String? fieldLabel;
  bool? required;
  String? inputType;

  MobileBeneficiaryModel(
      {this.fieldName, this.fieldLabel, this.required, this.inputType});

  MobileBeneficiaryModel.fromJson(Map<String, dynamic> json) {
    fieldName = json['fieldName'];
    fieldLabel = json['fieldLabel'];
    required = json['required'];
    inputType = json['inputType'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['fieldName'] = this.fieldName;
    data['fieldLabel'] = this.fieldLabel;
    data['required'] = this.required;
    data['inputType'] = this.inputType;
    return data;
  }
}
