class Packs {
  List<Pack>? data;

  Packs({this.data});

  Packs.fromJson(Map<String, dynamic> json) {
    if (json['data'] != null) {
      data = <Pack>[];
      json['data'].forEach((v) {
        data?.add(Pack.fromJson(v));
      });
    }
  }
}

class Pack {
  String? id;
  String? name;
  String? overview;
  String? description;
  List<String>? contents;
  int? quantity;
  int? price;
  bool? isPremium;

  Pack(
      {this.id,
      this.name,
      this.overview,
      this.description,
      this.contents,
      this.quantity,
      this.price,
      this.isPremium});

  Pack.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    overview = json['overview'];
    description = json['description'];
    contents = json['contents']?.cast<String>();
    quantity = json['quantity'];
    price = json['price'];
    isPremium = json['is_premium'];
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['overview'] = overview;
    data['description'] = description;
    data['contents'] = contents;
    data['quantity'] = quantity;
    data['price'] = price;
    data['is_premium'] = isPremium;
    return data;
  }
}
