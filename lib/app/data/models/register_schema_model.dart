class RegisterSchema {
  dynamic packId;
  dynamic sellerName;
  dynamic sellerPhone;
  dynamic sellerEmail;
  dynamic sellerGender;
  dynamic sellerProfession;
  dynamic sellerTshirtDeleveryPlace;
  dynamic sellerTshirtSize;
  dynamic sellerPlaceCountry;
  dynamic sllerPlaceCity;
  dynamic sllerPlaceAddress;
  dynamic sellerPassword;
  dynamic sellerReferalId;
  dynamic paymentReference;
  dynamic paymentFile;
  dynamic shopPhone;
  dynamic shopPlaceCountry;
  dynamic shopPlaceCity;
  dynamic shopPlaceAddress;

  RegisterSchema(
      {this.packId,
      this.sellerName,
      this.sellerPhone,
      this.sellerEmail,
      this.sellerGender,
      this.sellerProfession,
      this.sellerTshirtDeleveryPlace,
      this.sellerTshirtSize,
      this.sellerPlaceCountry,
      this.sllerPlaceCity,
      this.sllerPlaceAddress,
      this.sellerPassword,
      this.sellerReferalId,
      this.paymentReference,
      this.paymentFile,
      this.shopPhone,
      this.shopPlaceCountry,
      this.shopPlaceCity,
      this.shopPlaceAddress});

  RegisterSchema.fromJson(Map<String, dynamic> json) {
    packId = json['pack_id'];
    sellerName = json['seller_name'];
    sellerPhone = json['seller_phone'];
    sellerEmail = json['seller_email'];
    sellerGender = json['seller_gender'];
    sellerProfession = json['seller_profession'];
    sellerTshirtDeleveryPlace = json['seller_tshirt_delevery_place'];
    sellerTshirtSize = json['seller_tshirt_size'];
    sellerPlaceCountry = json['seller_place_country'];
    sllerPlaceCity = json['sller_place_city'];
    sllerPlaceAddress = json['sller_place_address'];
    sellerPassword = json['seller_password'];
    sellerReferalId = json['seller_referal_id'];
    paymentReference = json['payment_reference'];
    paymentFile = json['payment_file'];
    shopPhone = json['shop_phone'];
    shopPlaceCountry = json['shop_place_country'];
    shopPlaceCity = json['shop_place_city'];
    shopPlaceAddress = json['shop_place_address'];
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['pack_id'] = packId;
    data['seller.name'] = sellerName;
    data['seller.phone'] = sellerPhone;
    data['seller.email'] = sellerEmail;
    data['seller.gender'] = sellerGender;
    data['seller.profession'] = sellerProfession;
    data['seller.tshirt.delevery_place'] = sellerTshirtDeleveryPlace;
    data['seller.tshirt.size'] = sellerTshirtSize;
    data['seller.place.country'] = sellerPlaceCountry;
    data['seller.place.city'] = sllerPlaceCity;
    data['seller.place.address'] = sllerPlaceAddress;
    data['seller.password'] = sellerPassword;
    data['seller.referal_id'] = sellerReferalId;
    data['payment.reference'] = paymentReference;
    data['payment.file'] = paymentFile;
    data['shop.phone'] = shopPhone;
    data['shop.place.country'] = shopPlaceCountry;
    data['shop.place.city'] = shopPlaceCity;
    data['shop.place.address'] = shopPlaceAddress;
    return data;
  }
}
