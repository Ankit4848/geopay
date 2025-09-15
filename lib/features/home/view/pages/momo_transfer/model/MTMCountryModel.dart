class MTMCountryModel {
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
  List<Channels>? channels;

  MTMCountryModel(
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
        this.channels});

  MTMCountryModel.fromJson(Map<String, dynamic> json) {
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
    if (json['channels'] != null) {
      channels = <Channels>[];
      json['channels'].forEach((v) {
        channels!.add(new Channels.fromJson(v));
      });
    }
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
    if (this.channels != null) {
      data['channels'] = this.channels!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Channels {
  int? id;
  int? countryId;
  String? channel;
  String? fees;
  String? commissionType;
  String? commissionCharge;
  int? status;
  String? createdAt;
  String? updatedAt;

  Channels(
      {this.id,
        this.countryId,
        this.channel,
        this.fees,
        this.commissionType,
        this.commissionCharge,
        this.status,
        this.createdAt,
        this.updatedAt});

  Channels.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    countryId = json['country_id'];
    channel = json['channel'];
    fees = json['fees'];
    commissionType = json['commission_type'];
    commissionCharge = json['commission_charge'];
    status = json['status'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['country_id'] = this.countryId;
    data['channel'] = this.channel;
    data['fees'] = this.fees;
    data['commission_type'] = this.commissionType;
    data['commission_charge'] = this.commissionCharge;
    data['status'] = this.status;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}
