import 'package:millsellers/app/data/models/seller_resource_model.dart';

class Order {
  String? id;
  String? name, created_at, updated_at, phone, status;
  Seller? seller;
  Place? place;
  int? quantity, amount;

  Order(
      {this.id,
      this.name,
      this.quantity,
      this.amount,
      this.created_at,
      this.updated_at,
      this.phone,
      this.status,
      this.seller,
      this.place});

  Order.fromJson(Map<String, dynamic> json) {
    id = json['id'] as String;
    name = json['name'] as String;
    quantity = json['quantity'] as int;
    amount = json['amount'] as int;
    created_at = json['created_at'] as String;
    updated_at = json['updated_at'] as String;
    phone = json['phone'] as String;
    status = json['status'] as String;
    if (json['seller'] != null) {
      seller = Seller.fromJson(json['seller']);
    }
    if (json['place'] != null) {
      place = Place.fromJson(json['place']);
    }
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['quantity'] = quantity as int;
    data['amount'] = amount as int;
    data['created_at'] = created_at;
    data['updated_at'] = updated_at;
    data['phone'] = phone;
    data['status'] = status;
    if (seller != null) {
      data['seller'] = seller?.toJson();
    }
    if (place != null) {
      data['place'] = place?.toJson();
    }
    return data;
  }
}
