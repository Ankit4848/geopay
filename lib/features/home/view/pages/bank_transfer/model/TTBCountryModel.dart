class TTBCountryModel {
  int? id;
  String? data;
  String? value;
  String? label;
  String? countryFlag;
  String? serviceName;
  int? status;
  String? createdAt;
  String? updatedAt;
  String? markdownType;
  String? markdownCharge;
  String? iso;
  String? isdcode;

  TTBCountryModel(
      {this.id,
        this.data,
        this.value,
        this.label,
        this.serviceName,
        this.countryFlag,
        this.status,
        this.createdAt,
        this.updatedAt,
        this.markdownType,
        this.markdownCharge,
        this.isdcode,
        this.iso});

  TTBCountryModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    data = json['data'];
    value = json['value'];
    label = json['label'];
    serviceName = json['service_name'];
    countryFlag = json['country_flag'];
    status = json['status'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    markdownType = json['markdown_type'];
    markdownCharge = json['markdown_charge'].toString();
    iso = json['iso'];
    isdcode = json['isdcode'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['data'] = this.data;
    data['value'] = this.value;
    data['label'] = this.label;
    data['country_flag'] = this.countryFlag;
    data['service_name'] = this.serviceName;
    data['status'] = this.status;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    data['markdown_type'] = this.markdownType;
    data['markdown_charge'] = this.markdownCharge;
    data['iso'] = this.iso;
    data['isdcode'] = this.isdcode;
    return data;
  }
}
