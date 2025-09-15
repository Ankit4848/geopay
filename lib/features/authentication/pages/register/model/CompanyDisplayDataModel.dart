class CompanyDisplayDataModel {
  CompanyDetail? companyDetail;
  int? stepNumber;
  List<BusinessTypes>? businessTypes;
  List<DocumentTypes>? documentTypes;


  CompanyDisplayDataModel(
      {this.companyDetail,
        this.stepNumber,
        this.businessTypes,
        this.documentTypes});

  CompanyDisplayDataModel.fromJson(Map<String, dynamic> json) {
    companyDetail = json['companyDetail'] != null
        ? new CompanyDetail.fromJson(json['companyDetail'])
        : null;
    stepNumber = json['stepNumber'];
    if (json['businessTypes'] != null) {
      businessTypes = <BusinessTypes>[];
      json['businessTypes'].forEach((v) {
        businessTypes!.add(new BusinessTypes.fromJson(v));
      });
    }
    if (json['documentTypes'] != null) {
      documentTypes = <DocumentTypes>[];
      json['documentTypes'].forEach((v) {
        documentTypes!.add(new DocumentTypes.fromJson(v));
      });
    }


  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.companyDetail != null) {
      data['companyDetail'] = this.companyDetail!.toJson();
    }
    data['stepNumber'] = this.stepNumber;
    if (this.businessTypes != null) {
      data['businessTypes'] =
          this.businessTypes!.map((v) => v.toJson()).toList();
    }
    if (this.documentTypes != null) {
      data['documentTypes'] =
          this.documentTypes!.map((v) => v.toJson()).toList();
    }

    return data;
  }
}

class CompanyDetail {
  int? id;
  int? userId;
  String? businessLicence;
  String? tin;
  String? vat;
  String? companyAddress;
  String? postcode;
  String? bankName;
  String? accountNumber;
  String? bankCode;
  int? stepNumber;
  String? createdAt;
  String? updatedAt;
  int? businessTypeId;
  int? noOfDirector;
  int? isUpdateKyc;
  List<CompanyDocuments>? companyDocuments;
  List<CompanyDirectors>? companyDirectors;

  CompanyDetail(
      {this.id,
        this.userId,
        this.businessLicence,
        this.tin,
        this.vat,
        this.companyAddress,
        this.postcode,
        this.bankName,
        this.accountNumber,
        this.bankCode,
        this.stepNumber,
        this.createdAt,
        this.updatedAt,
        this.businessTypeId,
        this.noOfDirector,
        this.isUpdateKyc,
        this.companyDocuments,
        this.companyDirectors});

  CompanyDetail.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userId = json['user_id'];
    businessLicence = json['business_licence'];
    tin = json['tin'];
    vat = json['vat'];
    companyAddress = json['company_address'];
    postcode = json['postcode'];
    bankName = json['bank_name'];
    accountNumber = json['account_number'];
    bankCode = json['bank_code'];
    stepNumber = json['step_number'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    businessTypeId = json['business_type_id'];
    noOfDirector = json['no_of_director'];
    isUpdateKyc = json['is_update_kyc'];
    if (json['company_documents'] != null) {
      companyDocuments = <CompanyDocuments>[];
      json['company_documents'].forEach((v) {
        companyDocuments!.add(new CompanyDocuments.fromJson(v));
      });
    }
    if (json['company_directors'] != null) {
      companyDirectors = <CompanyDirectors>[];
      json['company_directors'].forEach((v) {
        companyDirectors!.add(new CompanyDirectors.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['user_id'] = this.userId;
    data['business_licence'] = this.businessLicence;
    data['tin'] = this.tin;
    data['vat'] = this.vat;
    data['company_address'] = this.companyAddress;
    data['postcode'] = this.postcode;
    data['bank_name'] = this.bankName;
    data['account_number'] = this.accountNumber;
    data['bank_code'] = this.bankCode;
    data['step_number'] = this.stepNumber;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    data['business_type_id'] = this.businessTypeId;
    data['no_of_director'] = this.noOfDirector;
    data['is_update_kyc'] = this.isUpdateKyc;
    if (this.companyDocuments != null) {
      data['company_documents'] =
          this.companyDocuments!.map((v) => v.toJson()).toList();
    }
    if (this.companyDirectors != null) {
      data['company_directors'] =
          this.companyDirectors!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class CompanyDocuments {
  int? id;
  int? companyDetailsId;
  String? documentType;
  String? document;
  int? status;
  String? reason;
  String? createdAt;
  String? updatedAt;
  int? documentTypeId;
  int? companyDirectorId;

  CompanyDocuments(
      {this.id,
        this.companyDetailsId,
        this.documentType,
        this.document,
        this.status,
        this.reason,
        this.createdAt,
        this.updatedAt,
        this.documentTypeId,
        this.companyDirectorId});

  CompanyDocuments.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    companyDetailsId = json['company_details_id'];
    documentType = json['document_type'];
    document = json['document'];
    status = json['status'];
    reason = json['reason'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    documentTypeId = json['document_type_id'];
    companyDirectorId = json['company_director_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['company_details_id'] = this.companyDetailsId;
    data['document_type'] = this.documentType;
    data['document'] = this.document;
    data['status'] = this.status;
    data['reason'] = this.reason;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    data['document_type_id'] = this.documentTypeId;
    data['company_director_id'] = this.companyDirectorId;
    return data;
  }
}

class CompanyDirectors {
  int? id;
  int? companyDetailsId;
  String? name;
  String? createdAt;
  String? updatedAt;

  CompanyDirectors(
      {this.id,
        this.companyDetailsId,
        this.name,
        this.createdAt,
        this.updatedAt});

  CompanyDirectors.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    companyDetailsId = json['company_details_id'];
    name = json['name'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['company_details_id'] = this.companyDetailsId;
    data['name'] = this.name;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}

class BusinessTypes {
  int? id;
  String? businessType;
  int? isDirector;
  int? status;
  String? createdAt;
  String? updatedAt;

  BusinessTypes(
      {this.id,
        this.businessType,
        this.isDirector,
        this.status,
        this.createdAt,
        this.updatedAt});

  BusinessTypes.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    businessType = json['business_type'];
    isDirector = json['is_director'];
    status = json['status'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['business_type'] = this.businessType;
    data['is_director'] = this.isDirector;
    data['status'] = this.status;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}

class DocumentTypes {
  int? id;
  String? label;
  String? name;
  String? reason;
  int? status;
  int? isEdit;
  String? fileStatus;
  String? createdAt;
  String? updatedAt;

  DocumentTypes(
      {this.id,
        this.label,
        this.name,
        this.reason,
        this.isEdit,
        this.fileStatus="Pending",
        this.status,
        this.createdAt,
        this.updatedAt});

  DocumentTypes.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    label = json['label'];
    name = json['name'];
    status = json['status'];
    reason = json['reason'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['label'] = this.label;
    data['name'] = this.name;
    data['reason'] = this.reason;
    data['status'] = this.status;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}

class CompanyDocument {
  CompanyDocuments? memorandumArticlesOfAssociation;
  CompanyDocuments? registrationOfShareholders;
  CompanyDocuments? registrationOfDirectors;
  CompanyDocuments? proofOfAddressShareholders;
  CompanyDocuments? proofOfAddressDirectors;
  CompanyDocuments? govtIdShareholders;
  CompanyDocuments? govtIdDirectors;

  CompanyDocument(
      {this.memorandumArticlesOfAssociation,
        this.registrationOfShareholders,
        this.registrationOfDirectors,
        this.proofOfAddressShareholders,
        this.proofOfAddressDirectors,
        this.govtIdShareholders,
        this.govtIdDirectors});

  CompanyDocument.fromJson(Map<String, dynamic> json) {
    memorandumArticlesOfAssociation =
    json['memorandum_articles_of_association'] != null
        ? new CompanyDocuments.fromJson(
        json['memorandum_articles_of_association'])
        : null;
    registrationOfShareholders = json['registration_of_shareholders'] != null
        ? new CompanyDocuments.fromJson(json['registration_of_shareholders'])
        : null;
    registrationOfDirectors = json['registration_of_directors'] != null
        ? new CompanyDocuments.fromJson(json['registration_of_directors'])
        : null;
    proofOfAddressShareholders = json['proof_of_address_shareholders'] != null
        ? new CompanyDocuments.fromJson(json['proof_of_address_shareholders'])
        : null;
    proofOfAddressDirectors = json['proof_of_address_directors'] != null
        ? new CompanyDocuments.fromJson(json['proof_of_address_directors'])
        : null;
    govtIdShareholders = json['govt_id_shareholders'] != null
        ? new CompanyDocuments.fromJson(json['govt_id_shareholders'])
        : null;
    govtIdDirectors = json['govt_id_directors'] != null
        ? new CompanyDocuments.fromJson(json['govt_id_directors'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.memorandumArticlesOfAssociation != null) {
      data['memorandum_articles_of_association'] =
          this.memorandumArticlesOfAssociation!.toJson();
    }
    if (this.registrationOfShareholders != null) {
      data['registration_of_shareholders'] =
          this.registrationOfShareholders!.toJson();
    }
    if (this.registrationOfDirectors != null) {
      data['registration_of_directors'] =
          this.registrationOfDirectors!.toJson();
    }
    if (this.proofOfAddressShareholders != null) {
      data['proof_of_address_shareholders'] =
          this.proofOfAddressShareholders!.toJson();
    }
    if (this.proofOfAddressDirectors != null) {
      data['proof_of_address_directors'] =
          this.proofOfAddressDirectors!.toJson();
    }
    if (this.govtIdShareholders != null) {
      data['govt_id_shareholders'] = this.govtIdShareholders!.toJson();
    }
    if (this.govtIdDirectors != null) {
      data['govt_id_directors'] = this.govtIdDirectors!.toJson();
    }
    return data;
  }
}
