class UserModel {
  UserModel({
    required this.id,
    required this.userRoleId,
    required this.firstName,
    required this.lastName,
    required this.email,
    required this.countryId,
    required this.mobileNumber,
    required this.formattedNumber,
    required this.referalcode,
    required this.fcmToken,
    required this.isCompany,
    required this.verificationToken,
    required this.isEmailVerify,
    required this.isMobileVerify,
    required this.isKycVerify,
    required this.status,
    required this.role,
    required this.balance,
    required this.profileImage,
    required this.deletedAt,
    required this.createdAt,
    required this.updatedAt,
    required this.terms,
    required this.companyName,
    required this.userLimitId,
    required this.isUploadDocument,
    required this.passwordChangedAt,
    required this.address,
    required this.idType,
    required this.idNumber,
    required this.expiryIdDate,
    required this.issueIdDate,
    required this.city,
    required this.state,
    required this.zipCode,
    required this.dateOfBirth,
    required this.gender,
    required this.businessActivityOccupation,
    required this.sourceOfFund,
    required this.developerOption,
    required this.isMerchant,
    required this.token,
    required this.metamap,
    required this.metamapStatus,
    required this.defaultCurrency,
    required this.companyDetail,
    required this.userKyc,
  });

  final int? id;
  final int? userRoleId;
  final String? firstName;
  final String? lastName;
  final String? email;
  final int? countryId;
  final String? mobileNumber;
  final String? formattedNumber;
  final dynamic referalcode;
  final dynamic fcmToken;
  final bool? isCompany;
  final dynamic verificationToken;
  final int? isEmailVerify;
  final int? isMobileVerify;
  final int? isKycVerify;
  final int? status;
  final String? role;
  final String? balance;
  final String? profileImage;
  final dynamic deletedAt;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final int? terms;
  final String? companyName;
  final int? userLimitId;
  final int? isUploadDocument;
  final dynamic passwordChangedAt;
  final String? address;
  final String? idType;
  final String? idNumber;
  final String? expiryIdDate;
  final String? issueIdDate;
  final String? city;
  final String? state;
  final String? zipCode;
  final String? dateOfBirth;
  final String? gender;
  final String? businessActivityOccupation;
  final String? sourceOfFund;
  final int? developerOption;
  final int? isMerchant;
  final String? token;
  final bool? metamap;
  final String? metamapStatus;
  final String? defaultCurrency;
  final CompanyDetail? companyDetail;
  final dynamic userKyc;

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: json["id"],
      userRoleId: json["user_role_id"],
      firstName: json["first_name"],
      lastName: json["last_name"],
      email: json["email"],
      countryId: json["country_id"],
      mobileNumber: json["mobile_number"],
      formattedNumber: json["formatted_number"],
      referalcode: json["referalcode"],
      fcmToken: json["fcm_token"],
      isCompany: json["is_company"],
      verificationToken: json["verification_token"],
      isEmailVerify: json["is_email_verify"],
      isMobileVerify: json["is_mobile_verify"],
      isKycVerify: json["is_kyc_verify"],
      status: json["status"],
      role: json["role"],
      balance: json["balance"],
      profileImage: json["profile_image"],
      deletedAt: json["deleted_at"],
      createdAt: DateTime.tryParse(json["created_at"] ?? ""),
      updatedAt: DateTime.tryParse(json["updated_at"] ?? ""),
      terms: json["terms"],
      companyName: json["company_name"],
      userLimitId: json["user_limit_id"],
      isUploadDocument: json["is_upload_document"],
      passwordChangedAt: json["password_changed_at"],
      address: json["address"],
      idType: json["id_type"],
      idNumber: json["id_number"],
      expiryIdDate:json["expiry_id_date"] ?? "",
      issueIdDate: json["issue_id_date"] ?? "",
      city: json["city"],
      state: json["state"],
      zipCode: json["zip_code"],
      dateOfBirth: json["date_of_birth"] ?? "",
      gender: json["gender"],
      businessActivityOccupation: json["business_activity_occupation"],
      sourceOfFund: json["source_of_fund"],
      developerOption: json["developer_option"],
      isMerchant: json["is_merchant"],
      token: json["token"],
      metamap: json["metamap"],
      metamapStatus: json["metamap_status"],
      defaultCurrency: json["default_currency"],
      companyDetail: json["company_detail"] == null
          ? null
          : CompanyDetail.fromJson(json["company_detail"]),
      userKyc: json["user_kyc"],
    );
  }

  Map<String, dynamic> toJson() => {
        "id": id,
        "user_role_id": userRoleId,
        "first_name": firstName,
        "last_name": lastName,
        "email": email,
        "country_id": countryId,
        "mobile_number": mobileNumber,
        "formatted_number": formattedNumber,
        "referalcode": referalcode,
        "fcm_token": fcmToken,
        "is_company": isCompany,
        "verification_token": verificationToken,
        "is_email_verify": isEmailVerify,
        "is_mobile_verify": isMobileVerify,
        "is_kyc_verify": isKycVerify,
        "status": status,
        "role": role,
        "balance": balance,
        "profile_image": profileImage,
        "deleted_at": deletedAt,
        "created_at": createdAt?.toIso8601String(),
        "updated_at": updatedAt?.toIso8601String(),
        "terms": terms,
        "company_name": companyName,
        "user_limit_id": userLimitId,
        "is_upload_document": isUploadDocument,
        "password_changed_at": passwordChangedAt,
        "address": address,
        "id_type": idType,
        "id_number": idNumber,
        'expiry_id_date': expiryIdDate,
        'issue_id_date': issueIdDate,
        "city": city,
        "state": state,
        "zip_code": zipCode,
        "date_of_birth": dateOfBirth,
        "gender": gender,
        "business_activity_occupation": businessActivityOccupation,
        "source_of_fund": sourceOfFund,
        "developer_option": developerOption,
        "is_merchant": isMerchant,
        "token": token,
        "metamap": metamap,
        "metamap_status": metamapStatus,
        "default_currency": defaultCurrency,
        "company_detail": companyDetail?.toJson(),
        "user_kyc": userKyc,
      };
}

class CompanyDetail {
  int? id;
  int? userId;
  String? companyName;
  String? businessLicence;
  String? tin;
  String? vat;
  String? companyAddress;
  String? postcode;
  String? bankName;
  String? accountNumber;
  String? bankCode;
  String? createdAt;
  String? updatedAt;

  CompanyDetail(
      {this.id,
      this.userId,
      this.companyName,
      this.businessLicence,
      this.tin,
      this.vat,
      this.companyAddress,
      this.postcode,
      this.bankName,
      this.accountNumber,
      this.bankCode,
      this.createdAt,
      this.updatedAt});

  CompanyDetail.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userId = json['user_id'];
    companyName = json['company_name'];
    businessLicence = json['business_licence'];
    tin = json['tin'];
    vat = json['vat'];
    companyAddress = json['company_address'];
    postcode = json['postcode'];
    bankName = json['bank_name'];
    accountNumber = json['account_number'];
    bankCode = json['bank_code'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['user_id'] = userId;
    data['company_name'] = companyName;
    data['business_licence'] = businessLicence;
    data['tin'] = tin;
    data['vat'] = vat;
    data['company_address'] = companyAddress;
    data['postcode'] = postcode;
    data['bank_name'] = bankName;
    data['account_number'] = accountNumber;
    data['bank_code'] = bankCode;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    return data;
  }
}
