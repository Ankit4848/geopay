class MTMBeneficiaryModel {
  int? id;
  int? userId;
  String? categoryName;
  String? serviceName;
  MTMBeneficiaryModelData? data;
  String? createdAt;
  String? updatedAt;

  MTMBeneficiaryModel(
      {this.id,
        this.userId,
        this.categoryName,
        this.serviceName,
        this.data,
        this.createdAt,
        this.updatedAt});

  MTMBeneficiaryModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userId = json['user_id'];
    categoryName = json['category_name'];
    serviceName = json['service_name'];
    data = json['data'] != null ? new MTMBeneficiaryModelData.fromJson(json['data']) : null;
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['user_id'] = this.userId;
    data['category_name'] = this.categoryName;
    data['service_name'] = this.serviceName;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}

class MTMBeneficiaryModelData {
  String? recipientCountry;
  String? channelId;
  String? recipientMobile;
  String? recipientName;
  String? recipientSurname;
  String? recipientAddress;
  String? recipientCity;
  String? recipientState;
  String? recipientPostalcode;
  String? recipientDateofbirth;
  String? senderPlaceofbirth;
  String? purposeOfTransfer;
  String? sourceOfFunds;
  String? categoryName;
  String? serviceName;
  String? recipientCountryCode;
  String? recipientCountryName;
  String? channelName;
  String? senderCountry;
  String? senderCountryCode;
  String? senderCountryName;
  String? senderMobile;
  String? senderName;
  String? senderSurname;
  String? payoutCountry;
  String? payoutCurrency;

  MTMBeneficiaryModelData(
      {this.recipientCountry,
        this.channelId,
        this.recipientMobile,
        this.recipientName,
        this.recipientSurname,
        this.recipientAddress,
        this.recipientCity,
        this.recipientState,
        this.recipientPostalcode,
        this.recipientDateofbirth,
        this.senderPlaceofbirth,
        this.purposeOfTransfer,
        this.sourceOfFunds,
        this.categoryName,
        this.serviceName,
        this.recipientCountryCode,
        this.recipientCountryName,
        this.channelName,
        this.senderCountry,
        this.senderCountryCode,
        this.senderCountryName,
        this.senderMobile,
        this.senderName,
        this.senderSurname,
        this.payoutCountry,
        this.payoutCurrency});

  MTMBeneficiaryModelData.fromJson(Map<String, dynamic> json) {
    recipientCountry = json['recipient_country'].toString();
    channelId = json['channel_id'].toString();
    recipientMobile = json['recipient_mobile'];
    recipientName = json['recipient_name'];
    recipientSurname = json['recipient_surname'];
    recipientAddress = json['recipient_address'];
    recipientCity = json['recipient_city'];
    recipientState = json['recipient_state'];
    recipientPostalcode = json['recipient_postalcode'];
    recipientDateofbirth = json['recipient_dateofbirth'];
    senderPlaceofbirth = json['sender_placeofbirth'];
    purposeOfTransfer = json['purposeOfTransfer'];
    sourceOfFunds = json['sourceOfFunds'];
    categoryName = json['category_name'];
    serviceName = json['service_name'];
    recipientCountryCode = json['recipient_country_code'];
    recipientCountryName = json['recipient_country_name'];
    channelName = json['channel_name'];
    senderCountry = json['sender_country'].toString();
    senderCountryCode = json['sender_country_code'];
    senderCountryName = json['sender_country_name'];
    senderMobile = json['sender_mobile'];
    senderName = json['sender_name'];
    senderSurname = json['sender_surname'];
    payoutCountry = json['payoutCountry'];
    payoutCurrency = json['payoutCurrency'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['recipient_country'] = this.recipientCountry;
    data['channel_id'] = this.channelId;
    data['recipient_mobile'] = this.recipientMobile;
    data['recipient_name'] = this.recipientName;
    data['recipient_surname'] = this.recipientSurname;
    data['recipient_address'] = this.recipientAddress;
    data['recipient_city'] = this.recipientCity;
    data['recipient_state'] = this.recipientState;
    data['recipient_postalcode'] = this.recipientPostalcode;
    data['recipient_dateofbirth'] = this.recipientDateofbirth;
    data['sender_placeofbirth'] = this.senderPlaceofbirth;
    data['purposeOfTransfer'] = this.purposeOfTransfer;
    data['sourceOfFunds'] = this.sourceOfFunds;
    data['category_name'] = this.categoryName;
    data['service_name'] = this.serviceName;
    data['recipient_country_code'] = this.recipientCountryCode;
    data['recipient_country_name'] = this.recipientCountryName;
    data['channel_name'] = this.channelName;
    data['sender_country'] = this.senderCountry;
    data['sender_country_code'] = this.senderCountryCode;
    data['sender_country_name'] = this.senderCountryName;
    data['sender_mobile'] = this.senderMobile;
    data['sender_name'] = this.senderName;
    data['sender_surname'] = this.senderSurname;
    data['payoutCountry'] = this.payoutCountry;
    data['payoutCurrency'] = this.payoutCurrency;
    return data;
  }
}
