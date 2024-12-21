import 'package:dio/dio.dart';
import 'package:get/get.dart';
import 'package:millsellers/app/controllers/auth_controller.dart';
import 'package:millsellers/app/data/models/sale_model.dart';
import 'package:millsellers/utils/contants.dart';

class SellerResource {
  int? customers;
  int? invitees;
  bool? isPremium;
  int? stock;
  int? balance;
  bool? isAccountEnable;
  Seller? seller;
  Referral? referral;
  Shop? shop;
  int? ventes;
  List<Sale>? sales;

  SellerResource(
      {this.customers,
      this.invitees,
      this.isPremium,
      this.stock,
      this.balance,
      this.isAccountEnable,
      this.seller,
      this.referral,
      this.shop, this.sales, this.ventes});

  SellerResource.fromJson(Map<String, dynamic> json) {
    customers = json['customers'];
    invitees = json['invitees'];
    isPremium = json['is_premium'];
    stock = json['stock'];
    balance = json['balance'];
    isAccountEnable = json['is_account_enable'];
    seller = json['seller'] != null ? Seller?.fromJson(json['seller']) : null;
    referral =
        json['referral'] != null ? Referral?.fromJson(json['referral']) : null;
    shop = json['shop'] != null ? Shop?.fromJson(json['shop']) : null;
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['customers'] = customers;
    data['invitees'] = invitees;
    data['is_premium'] = isPremium;
    data['stock'] = stock;
    data['balance'] = balance;
    data['is_account_enable'] = isAccountEnable;
    if (seller != null) {
      data['seller'] = seller?.toJson();
    }
    if (referral != null) {
      data['referral'] = referral?.toJson();
    }
    if (shop != null) {
      data['shop'] = shop?.toJson();
    }
    return data;
  }

  Future<void> setSolde() async {
    final authManager = Get.find<AuthController>();


      var headers = {
        "Content-Type":"application/json",
        'Accept': 'application/json',
        'Authorization': 'Bearer ${authManager.getToken()}',
      };
      var dio = Dio();
      var response = await dio.request(
        BASE_URL + '/seller/wallet',
        options: Options(
          method: 'GET',
          headers: headers,
          validateStatus: (value)=> true
        ),
      );
      print("headers: ${response.requestOptions.headers}");
      if (response.statusCode == 200) {
        balance = response.data['balance'];
      }else {
        print(response.statusMessage);
      }
  }

  Future<void> setStock() async {
    final authManager = Get.find<AuthController>();


    var headers = {
      "Content-Type":"application/json",
      'Accept': 'application/json',
      'Authorization': 'Bearer ${authManager.getToken()}',
    };
    var dio = Dio();
    var response = await dio.request(
      BASE_URL + '/seller/stock',
      options: Options(
          method: 'GET',
          headers: headers,
          validateStatus: (value)=> true
      ),
    );
    print("headers: ${response.requestOptions.headers}");
    if (response.statusCode == 200) {
      stock = response.data['stock'];
      print("stock $stock");
    }else {
      print(response.statusMessage);
    }
  }

  Future<void> setVentes() async {
    final authManager = Get.find<AuthController>();

    var headers = {
      "Content-Type":"application/json",
      'Accept': 'application/json',
      'Authorization': 'Bearer ${authManager.getToken()}',
    };
    var dio = Dio();
    var response = await dio.request(
      BASE_URL + '/seller/sales',
      options: Options(
          method: 'GET',
          headers: headers,
          validateStatus: (value)=> true
      ),
    );
    print("headers: ${response.requestOptions.headers}");
    if (response.statusCode == 200) {
      sales = (response.data['data'] as List).map((data) => Sale.fromJson(data)).toList();
      ventes = response.data['meta']['total'];
    }else {
      print(response.statusMessage);
    }
  }
}

class Seller {
  String? id;
  String? code;
  String? name;
  String? profession;
  String? gender;
  String? phone;
  String? email;
  Place? place;

  Seller(
      {this.id,
      this.code,
      this.name,
      this.profession,
      this.gender,
      this.phone,
      this.email,
      this.place});

  Seller.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    code = json['code'];
    name = json['name'];
    profession = json['profession'];
    gender = json['gender'];
    phone = json['phone'];
    email = json['email'];
    place = json['place'] != null ? Place?.fromJson(json['place']) : null;
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['id'] = id;
    data['code'] = code;
    data['name'] = name;
    data['profession'] = profession;
    data['gender'] = gender;
    data['phone'] = phone;
    data['email'] = email;
    if (place != null) {
      data['place'] = place?.toJson();
    }
    return data;
  }
}

class Place {
  String? country;
  String? city;
  String? address;

  Place({this.country, this.city, this.address});

  Place.fromJson(Map<String, dynamic> json) {
    country = json['country'];
    city = json['city'];
    address = json['address'];
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['country'] = country;
    data['city'] = city;
    data['address'] = address;
    return data;
  }
}

class Referral {
  String? id;
  String? name;

  Referral({this.id, this.name});

  Referral.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    return data;
  }
}

class Shop {
  String? phone;
  Place? place;

  Shop({this.phone, this.place});

  Shop.fromJson(Map<String, dynamic> json) {
    phone = json['phone'];
    place = json['place'] != null ? Place?.fromJson(json['place']) : null;
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['phone'] = phone;
    if (place != null) {
      data['place'] = place?.toJson();
    }
    return data;
  }
}
