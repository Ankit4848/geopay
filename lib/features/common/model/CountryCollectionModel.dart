class CountryCollectionModel {
  int? id;
  String? iso;
  String? name;
  String? nicename;
  String? iso3;
  String? numcode;
  String? isdcode;
  String? currencyCode;
  String? countryFlag;
  String? createdAt;
  String? updatedAt;
  List<String>? availableChannels;

  CountryCollectionModel(
      {this.id,
        this.iso,
        this.name,
        this.nicename,
        this.iso3,
        this.numcode,
        this.isdcode,
        this.currencyCode,
        this.countryFlag,
        this.createdAt,
        this.updatedAt,
        this.availableChannels});

  CountryCollectionModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    iso = json['iso'];
    name = json['name'];
    nicename = json['nicename'];
    iso3 = json['iso3'];
    numcode = json['numcode'];
    isdcode = json['isdcode'];
    currencyCode = json['currency_code'];
    countryFlag = json['country_flag'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    availableChannels = json['available_channels'].cast<String>();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['iso'] = this.iso;
    data['name'] = this.name;
    data['nicename'] = this.nicename;
    data['iso3'] = this.iso3;
    data['numcode'] = this.numcode;
    data['isdcode'] = this.isdcode;
    data['currency_code'] = this.currencyCode;
    data['country_flag'] = this.countryFlag;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    data['available_channels'] = this.availableChannels;
    return data;
  }
}
