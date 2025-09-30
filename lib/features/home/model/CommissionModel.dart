class CommissionModel {
  String? payoutCurrency;
  String? payoutCountry;
  String? txnAmount;
  String? aggregatorRate;
  double? aggregatorCurrencyAmount;
  String? exchangeRate;
  double? payoutCurrencyAmount;
  String? remitCurrency;
  String? platformCharge;
  double? serviceCharge;
  String? sendFee;
  double? totalCharges;
  double? netAmount;

  CommissionModel(
      {this.payoutCurrency,
        this.payoutCountry,
        this.txnAmount,
        this.aggregatorRate,
        this.aggregatorCurrencyAmount,
        this.exchangeRate,
        this.payoutCurrencyAmount,
        this.remitCurrency,
        this.platformCharge,
        this.serviceCharge,
        this.sendFee,
        this.totalCharges,
        this.netAmount});

  CommissionModel.fromJson(Map<String, dynamic> json) {
    payoutCurrency = json['payoutCurrency'];
    payoutCountry = json['payoutCountry'];
    txnAmount = json['txnAmount'];
    aggregatorRate = json['aggregatorRate'];
    aggregatorCurrencyAmount = json['aggregatorCurrencyAmount'].toDouble();
    exchangeRate = json['exchangeRate'];
    payoutCurrencyAmount = json['payoutCurrencyAmount'].toDouble();
    remitCurrency = json['remitCurrency'];
    platformCharge = json['platformCharge'].toString();
    serviceCharge = json['serviceCharge'].toDouble();
    sendFee = json['sendFee'].toString();
    totalCharges = json['totalCharges'].toDouble();
    netAmount = json['netAmount'].toDouble();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['payoutCurrency'] = this.payoutCurrency;
    data['payoutCountry'] = this.payoutCountry;
    data['txnAmount'] = this.txnAmount;
    data['aggregatorRate'] = this.aggregatorRate;
    data['aggregatorCurrencyAmount'] = this.aggregatorCurrencyAmount;
    data['exchangeRate'] = this.exchangeRate;
    data['payoutCurrencyAmount'] = this.payoutCurrencyAmount;
    data['remitCurrency'] = this.remitCurrency;
    data['platformCharge'] = this.platformCharge;
    data['serviceCharge'] = this.serviceCharge;
    data['sendFee'] = this.sendFee;
    data['totalCharges'] = this.totalCharges;
    data['netAmount'] = this.netAmount;
    return data;
  }
}
