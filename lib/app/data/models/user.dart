import 'package:millsellers/app/data/models/seller_resource_model.dart';

/*
{
	"data": {
		"customers": 5,
		"invitees": 0,
		"is_premium": false,
		"is_pro": true,
		"wallets": {
			"default": 999625670,
			"bonus": null
		},
		"is_account_enable": true,
		"seller": {
			"id": "380bab39-910e-3292-93f6-f8441ca3c6a3",
			"code": "2e368ea9-037c-396f-8c82-0e176fbabb93",
			"name": "David-Stéphane Boutin",
			"profession": "Géologue prospecteur",
			"gender": "male",
			"phone": "03 20 92 80 00",
			"email": "sikirou@1000vendeurs.academy",
			"place": {
				"country": "Égypte",
				"city": "Chevallier",
				"address": "83, rue de Bernier\n03579 DumontVille"
			}
		},
		"referral": null,
		"shop": {
			"phone": "0699291892",
			"place": {
				"country": "Chypre",
				"city": "Brun",
				"address": "rue Carlier\n82235 Jeandan"
			}
		},
		"created_at": "2024-12-24T08:17:14.000000Z",
		"updated_at": "2024-12-24T08:17:14.000000Z"
	}
}
*/

class User {
  int? customers;
  int? invitees;
  bool? isPremium;
  bool? isPro;
  Map<String, dynamic>? wallets;
  bool? isAccountEnable;
  Seller? seller;
  Referral? referral;
  Shop? shop;
  String? createdAt;
  String? updatedAt;

  User({
    this.customers,
    this.invitees,
    this.isPremium,
    this.isPro,
    this.wallets,
    this.isAccountEnable,
    this.seller,
    this.referral,
    this.shop,
    this.createdAt,
    this.updatedAt,
  });

  User.fromJson(Map<String, dynamic> json) {
    customers = json['customers'];
    invitees = json['invitees'];
    isPremium = json['is_premium'];
    isPro = json['is_pro'];
    wallets = json['wallets'];
    isAccountEnable = json['is_account_enable'];
    seller = json['seller'] != null ? Seller.fromJson(json['seller']) : null;
    referral = json['referral'] != null ? Referral.fromJson(json['referral']) : null;
    shop = json['shop'] != null ? Shop.fromJson(json['shop']) : null;
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['customers'] = customers;
    data['invitees'] = invitees;
    data['is_premium'] = isPremium;
    data['is_pro'] = isPro;
    data['wallets'] = wallets;
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
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    return data;
  }
}
