class MainTranscationModel {
  List<TranscationModel>? data;
  List<String>? txnStatuses;
  List<String>? transactionTypes;

  MainTranscationModel({this.data, this.txnStatuses, this.transactionTypes});

  MainTranscationModel.fromJson(Map<String, dynamic> json) {
    if (json['data'] != null) {
      data = <TranscationModel>[];
      json['data'].forEach((v) {
        data!.add(new TranscationModel.fromJson(v));
      });
    }
    txnStatuses = json['txnStatuses'].cast<String>();
    transactionTypes = json['transactionTypes'].cast<String>();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    data['txnStatuses'] = this.txnStatuses;
    data['transactionTypes'] = this.transactionTypes;
    return data;
  }
}

class TranscationModel {
  int? id;
  int? userId;
  int? receiverId;
  String? platformName;
  String? platformProvider;
  String? transactionType;
  int? countryId;
  String? txnAmount;
  String? txnStatus;
  String? comments;
  String? notes;
  String? createdAt;
  String? updatedAt;
  String? uniqueIdentifier;
  String? countryCode;
  String? productName;
  String? operatorId;
  String? productId;
  String? mobileNumber;
  String? unitCurrency;
  String? unitAmount;
  String? unitRates;
  String? rates;
  String? unitConvertCurrency;
  String? unitConvertAmount;
  String? unitConvertExchange;
  String? orderId;
  String? fees;
  String? serviceCharge;
  String? totalCharge;
  int? isRefunded;
  String? refundReason;
  String? additionalMessage;
  String? receiptUrl;

  TranscationModel(
      {this.id,
        this.userId,
        this.receiverId,
        this.platformName,
        this.platformProvider,
        this.transactionType,
        this.countryId,
        this.txnAmount,
        this.txnStatus,
        this.comments,
        this.notes,
        this.createdAt,
        this.updatedAt,
        this.uniqueIdentifier,
        this.countryCode,
        this.productName,
        this.operatorId,
        this.productId,
        this.mobileNumber,
        this.unitCurrency,
        this.unitAmount,
        this.unitRates,
        this.rates,
        this.unitConvertCurrency,
        this.unitConvertAmount,
        this.unitConvertExchange,
        this.orderId,
        this.fees,
        this.serviceCharge,
        this.totalCharge,
        this.isRefunded,
        this.refundReason,
        this.receiptUrl,
        this.additionalMessage});

  TranscationModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userId = json['user_id'];
    receiverId = json['receiver_id'];
    platformName = json['platform_name'];
    platformProvider = json['platform_provider'];
    transactionType = json['transaction_type'];
    countryId = json['country_id'];
    txnAmount = json['txn_amount'];
    txnStatus = json['txn_status'];
    comments = json['comments'];
    notes = json['notes'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    uniqueIdentifier = json['unique_identifier'];
    countryCode = json['country_code'].toString();
    productName = json['product_name'].toString();
    operatorId = json['operator_id'].toString();
    productId = json['product_id'].toString();
    mobileNumber = json['mobile_number'];
    unitCurrency = json['unit_currency'];
    unitAmount = json['unit_amount'];
    unitRates = json['unit_rates'];
    rates = json['rates'];
    unitConvertCurrency = json['unit_convert_currency'];
    unitConvertAmount = json['unit_convert_amount'];
    unitConvertExchange = json['unit_convert_exchange'];
    orderId = json['order_id'];
    fees = json['fees'];
    serviceCharge = json['service_charge'];
    totalCharge = json['total_charge'];
    isRefunded = json['is_refunded'];
    receiptUrl = json['receipt_url'];
    refundReason = json['refund_reason'].toString();
    additionalMessage = json['additional_message'].toString();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['user_id'] = this.userId;
    data['receiver_id'] = this.receiverId;
    data['platform_name'] = this.platformName;
    data['platform_provider'] = this.platformProvider;
    data['transaction_type'] = this.transactionType;
    data['country_id'] = this.countryId;
    data['txn_amount'] = this.txnAmount;
    data['txn_status'] = this.txnStatus;
    data['comments'] = this.comments;
    data['notes'] = this.notes;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    data['unique_identifier'] = this.uniqueIdentifier;
    data['country_code'] = this.countryCode;
    data['product_name'] = this.productName;
    data['operator_id'] = this.operatorId;
    data['product_id'] = this.productId;
    data['mobile_number'] = this.mobileNumber;
    data['unit_currency'] = this.unitCurrency;
    data['unit_amount'] = this.unitAmount;
    data['unit_rates'] = this.unitRates;
    data['rates'] = this.rates;
    data['unit_convert_currency'] = this.unitConvertCurrency;
    data['unit_convert_amount'] = this.unitConvertAmount;
    data['unit_convert_exchange'] = this.unitConvertExchange;
    data['order_id'] = this.orderId;
    data['fees'] = this.fees;
    data['service_charge'] = this.serviceCharge;
    data['total_charge'] = this.totalCharge;
    data['is_refunded'] = this.isRefunded;
    data['refund_reason'] = this.refundReason;
    data['additional_message'] = this.additionalMessage;
    data['receipt_url'] = this.receiptUrl;
    return data;
  }
}


