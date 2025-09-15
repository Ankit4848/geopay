class TTBBankModel {
  String? locationId;
  String? locationName;
  String? optionalField;

  TTBBankModel({this.locationId, this.locationName, this.optionalField});

  TTBBankModel.fromJson(Map<String, dynamic> json) {
    locationId = json['locationId'];
    locationName = json['locationName'];
    optionalField = json['optionalField'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['locationId'] = this.locationId;
    data['locationName'] = this.locationName;
    data['optionalField'] = this.optionalField;
    return data;
  }
}
