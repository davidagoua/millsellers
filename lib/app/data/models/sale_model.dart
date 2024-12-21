import 'package:millsellers/app/data/models/seller_resource_model.dart';

class Sale {
  String? id;
  int? quantity;
  int? amount;
  Customer? customer;

  Sale({this.id, this.quantity, this.amount, this.customer});

  Sale.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    quantity = json['quantity'];
    amount = json['amount'];
    customer =
        json['customer'] != null ? Customer?.fromJson(json['customer']) : null;
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['id'] = id;
    data['quantity'] = quantity;
    data['amount'] = amount;
    if (customer != null) {
      data['customer'] = customer?.toJson();
    }
    return data;
  }
}

class Customer {
  String? id;
  String? name;
  String? phone;
  Place? place;

  Customer({this.id, this.name, this.phone, this.place});

  Customer.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    phone = json['phone'];
    place = json['place'] != null ? Place?.fromJson(json['place']) : null;
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['phone'] = phone;
    if (place != null) {
      data['place'] = place?.toJson();
    }
    return data;
  }
}


