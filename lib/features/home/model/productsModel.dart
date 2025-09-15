class ProductsModel {
  int? id;
  String? name;
  String? retailUnitCurrency;
  double? retailUnitAmount;
  String? wholesaleUnitCurrency;
  double? wholesaleUnitAmount;
  double? retailRates;
  double? wholesaleRates;
  double? destinationRates;
  String? destinationCurrency;
  String? platformFees;
  int? validity;
  String? validityUnit;
  String? remitCurrency;

  ProductsModel(
      {this.id,
        this.name,
        this.retailUnitCurrency,
        this.retailUnitAmount,
        this.wholesaleUnitCurrency,
        this.wholesaleUnitAmount,
        this.retailRates,
        this.wholesaleRates,
        this.destinationRates,
        this.destinationCurrency,
        this.platformFees,
        this.validity,
        this.validityUnit,
        this.remitCurrency});

  ProductsModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    retailUnitCurrency = json['retail_unit_currency'];
    retailUnitAmount = double.parse(json['retail_unit_amount'].toString());
    wholesaleUnitCurrency = json['wholesale_unit_currency'];
    wholesaleUnitAmount = double.parse(json['wholesale_unit_amount'].toString());
    retailRates = double.parse(json['retail_rates'].toString());
    wholesaleRates = double.parse(json['wholesale_rates'].toString());
    destinationRates = double.parse(json['destination_rates'].toString());
    destinationCurrency = json['destination_currency'];
    platformFees = json['platform_fees'];
    validity = json['validity'];
    validityUnit = json['validity_unit'];
    remitCurrency = json['remit_currency'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['retail_unit_currency'] = this.retailUnitCurrency;
    data['retail_unit_amount'] = this.retailUnitAmount;
    data['wholesale_unit_currency'] = this.wholesaleUnitCurrency;
    data['wholesale_unit_amount'] = this.wholesaleUnitAmount;
    data['retail_rates'] = this.retailRates;
    data['wholesale_rates'] = this.wholesaleRates;
    data['destination_rates'] = this.destinationRates;
    data['destination_currency'] = this.destinationCurrency;
    data['platform_fees'] = this.platformFees;
    data['validity'] = this.validity;
    data['validity_unit'] = this.validityUnit;
    data['remit_currency'] = this.remitCurrency;
    return data;
  }
}
