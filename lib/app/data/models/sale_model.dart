import 'package:millsellers/app/data/models/product_model.dart';
import 'package:millsellers/app/data/models/seller_resource_model.dart';

class Sale {
  String? id;
  int? quantity;
  int? amount;
  Customer? customer;
  String? created_at;
  String? updated_at;
  Product? product;

  Sale(
      {this.id,
      this.quantity,
      this.amount,
      this.customer,
      this.created_at,
      this.updated_at,
      this.product});

  Sale.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    quantity = json['quantity'];
    amount = json['amount'];
    customer =
        json['customer'] != null ? Customer?.fromJson(json['customer']) : null;
    created_at = json['created_at'];
    updated_at = json['updated_at'];  
    product =
        json['product'] != null ? Product?.fromJson(json['product']) : null;
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['id'] = id;
    data['quantity'] = quantity;
    data['amount'] = amount;
    data['created_at'] = created_at;
    data['updated_at'] = updated_at;
    if (customer != null) {
      data['customer'] = customer?.toJson();
    }
    if (product != null) {
      data['product'] = product?.toJson();
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


