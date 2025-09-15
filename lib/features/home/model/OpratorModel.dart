class OpratorModel {
  Country? country;
  int? id;
  String? name;
  String? regions;

  OpratorModel({this.country, this.id, this.name, this.regions});

  OpratorModel.fromJson(Map<String, dynamic> json) {
    country =
    json['country'] != null ? new Country.fromJson(json['country']) : null;
    id = json['id'];
    name = json['name'];
    regions = json['regions'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.country != null) {
      data['country'] = this.country!.toJson();
    }
    data['id'] = this.id;
    data['name'] = this.name;
    data['regions'] = this.regions;
    return data;
  }
}

class Country {
  String? isoCode;
  String? name;
  String? regions;

  Country({this.isoCode, this.name, this.regions});

  Country.fromJson(Map<String, dynamic> json) {
    isoCode = json['iso_code'];
    name = json['name'];
    regions = json['regions'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['iso_code'] = this.isoCode;
    data['name'] = this.name;
    data['regions'] = this.regions;
    return data;
  }
}
