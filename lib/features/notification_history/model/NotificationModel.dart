class NotificationModel {
  String? id;
  String? notifiableType;
  int? notifiableId;
  String? type;
  Data? data;
  String? readAt;
  String? createdAt;
  String? updatedAt;

  NotificationModel(
      {this.id,
        this.notifiableType,
        this.notifiableId,
        this.type,
        this.data,
        this.readAt,
        this.createdAt,
        this.updatedAt});

  NotificationModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    notifiableType = json['notifiable_type'];
    notifiableId = json['notifiable_id'];
    type = json['type'];
    data = json['data'] != null ? new Data.fromJson(json['data']) : null;
    readAt = json['read_at'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['notifiable_type'] = this.notifiableType;
    data['notifiable_id'] = this.notifiableId;
    data['type'] = this.type;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    data['read_at'] = this.readAt;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}

class Data {
  String? senderName;
  String? receiverName;
  String? receiverProfile;
  String? amount;
  String? comment;
  String? notes;
  String? transactionStatus;

  Data(
      {this.senderName,
        this.receiverName,
        this.receiverProfile,
        this.amount,
        this.comment,
        this.notes,
        this.transactionStatus});

  Data.fromJson(Map<String, dynamic> json) {
    senderName = json['sender_name'];
    receiverName = json['receiver_name'];
    receiverProfile = json['receiver_profile'];
    amount = json['amount'].toString();
    comment = json['comment'];
    notes = json['notes'];
    transactionStatus = json['transaction_status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['sender_name'] = this.senderName;
    data['receiver_name'] = this.receiverName;
    data['receiver_profile'] = this.receiverProfile;
    data['amount'] = this.amount;
    data['comment'] = this.comment;
    data['notes'] = this.notes;
    data['transaction_status'] = this.transactionStatus;
    return data;
  }
}
