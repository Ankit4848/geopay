import 'package:get/get.dart';

class CommonModel {
  List<Banners>? banners;
  List<Faqs>? faqs;
  String? aboutus;
  String? siteName;
  String? contactAddress;
  String? contactWebsite;
  String? contactEmail;
  String? socialWhatsapp;
  String? socialInstagram;
  String? socialFacebook;
  String? socialLinkedin;
   List<BusinessOccupation>? idType;
   List<BusinessOccupation>? sourceOfFunds;
   List<BusinessOccupation>? businessOccupation;

  CommonModel(
      {this.banners,
        this.faqs,
        this.aboutus,
        this.siteName,
        this.contactAddress,
        this.contactWebsite,
        this.contactEmail,
        this.socialWhatsapp,
        this.socialInstagram,
        this.socialFacebook,
        this.idType,
        this.sourceOfFunds,
        this.businessOccupation,
        this.socialLinkedin});

  CommonModel.fromJson(Map<String, dynamic> json) {
    if (json['banners'] != null) {
      banners = <Banners>[];
      json['banners'].forEach((v) {
        banners!.add(new Banners.fromJson(v));
      });
    }
    if (json['faqs'] != null) {
      faqs = <Faqs>[];
      json['faqs'].forEach((v) {
        faqs!.add(new Faqs.fromJson(v));
      });
    }
    idType= json["id_type"] == null ? [] : List<BusinessOccupation>.from(json["id_type"]!.map((x) => BusinessOccupation.fromJson(x)));
    sourceOfFunds= json["source_of_funds"] == null ? [] : List<BusinessOccupation>.from(json["source_of_funds"]!.map((x) => BusinessOccupation.fromJson(x)));
    businessOccupation= json["business_occupation"] == null ? [] : List<BusinessOccupation>.from(json["business_occupation"]!.map((x) => BusinessOccupation.fromJson(x)));

    aboutus = json['aboutus'];
    siteName = json['site_name'];
    contactAddress = json['contact_address'];
    contactWebsite = json['contact_website'];
    contactEmail = json['contact_email'];
    socialWhatsapp = json['social_whatsapp'];
    socialInstagram = json['social_instagram'];
    socialFacebook = json['social_facebook'];
    socialLinkedin = json['social_linkedin'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.banners != null) {
      data['banners'] = this.banners!.map((v) => v.toJson()).toList();
    }
    if (this.faqs != null) {
      data['faqs'] = this.faqs!.map((v) => v.toJson()).toList();
    }

    if (this.idType != null) {
      data['id_type'] = this.idType!.map((v) => v.toJson()).toList();
    }
    if (this.sourceOfFunds != null) {
      data['source_of_funds'] = this.sourceOfFunds!.map((v) => v.toJson()).toList();
    }
    if (this.businessOccupation != null) {
      data['business_occupation'] = this.businessOccupation!.map((v) => v.toJson()).toList();
    }



    data['aboutus'] = this.aboutus;
    data['site_name'] = this.siteName;
    data['contact_address'] = this.contactAddress;
    data['contact_website'] = this.contactWebsite;
    data['contact_email'] = this.contactEmail;
    data['social_whatsapp'] = this.socialWhatsapp;
    data['social_instagram'] = this.socialInstagram;
    data['social_facebook'] = this.socialFacebook;
    data['social_linkedin'] = this.socialLinkedin;
    return data;
  }
}
class BusinessOccupation {
  BusinessOccupation({
    required this.value,
    required this.label,
  });

  final String? value;
  final String? label;

  factory BusinessOccupation.fromJson(Map<String, dynamic> json){
    return BusinessOccupation(
      value: json["value"],
      label: json["label"],
    );
  }

  Map<String, dynamic> toJson() => {
    "value": value,
    "label": label,
  };

}
class Banners {
  int? id;
  String? title;
  String? image;

  Banners({this.id, this.title, this.image});

  Banners.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    image = json['image'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['title'] = this.title;
    data['image'] = this.image;
    return data;
  }
}

class Faqs {
  String? title;
  String? description;
  RxBool isExpanded=false.obs;

  Faqs({this.title, this.description,isExpanded});

  Faqs.fromJson(Map<String, dynamic> json) {
    title = json['title'];
    description = json['description'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['title'] = this.title;
    data['description'] = this.description;
    return data;
  }
}
