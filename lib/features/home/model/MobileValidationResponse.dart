class MobileValidationResponse {
  bool? success;
  String? message;
  Response? response;

  MobileValidationResponse({this.success, this.message, this.response});

  MobileValidationResponse.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    message = json['message'];
    response = json['response'] != null
        ? new Response.fromJson(json['response'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['success'] = this.success;
    data['message'] = this.message;
    if (this.response != null) {
      data['response'] = this.response!.toJson();
    }
    return data;
  }
}

class Response {
  Country? country;
  int? id;
  bool? identified;
  String? name;
  String? regions;

  Response({this.country, this.id, this.identified, this.name, this.regions});

  Response.fromJson(Map<String, dynamic> json) {
    country =
    json['country'] != null ? new Country.fromJson(json['country']) : null;
    id = json['id'];
    identified = json['identified'];
    name = json['name'];
    regions = json['regions'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.country != null) {
      data['country'] = this.country!.toJson();
    }
    data['id'] = this.id;
    data['identified'] = this.identified;
    data['name'] = this.name;
    data['regions'] = this.regions;
    return data;
  }
}

class Country {
  String? isoCode;
  String? name;
  Null? regions;

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
