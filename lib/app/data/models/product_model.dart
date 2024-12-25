class Product {
  String? id;
  int? price, quantity;
  String? reference, name, description, use_case, incredients,
      key_promises;
  String? storage, created_at, updated_at;
  List<Map<String, dynamic>>? images;
  Map<String, dynamic>? rewards;

  Product({
    this.id,
    this.reference,
    this.name,
    this.description,
    this.price,
    this.quantity,
    this.use_case,
    this.incredients,
    this.key_promises,
    this.storage,
    this.created_at,
    this.updated_at,
    this.images,
    this.rewards,
  });

  // Conversion depuis JSON
  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
      id: json['id'] as String,
      reference: json['reference'] as String,
      name: json['name'] as String,
      description: json['description'] as String,
      price: json['price'],
      quantity: json['quantity'],
      use_case: json['use_case'] as String?,
      incredients: json['ingredients'] as String?,
      key_promises: json['key_promises'] as String?,
      storage: json['storage'] as String?,
      created_at: json['created_at'] as String?,
      updated_at: json['updated_at'] as String?,
      images: List<Map<String, dynamic>>.from(json['images'] ?? []),
      rewards: json['rewards'],
    );
  }

  // Conversion vers JSON
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'reference': reference,
      'name': name,
      'description': description,
      'price': price,
      'quantity': quantity,
      'use_case': use_case,
      'ingredients': incredients,
      'key_promises': key_promises,
      'storage': storage,
      'created_at': created_at,
      'updated_at': updated_at,
      'images': images,
      'rewards': rewards,
    };
  }


}
