


class Product {
  String? id;
  int? price, quantity, stock;
  String? reference, name, description, use_case, incredients, key_promises, precautions, storage, created_at, updated_at;
  List<Map<String, dynamic>>? images;
  

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
    this.precautions,
    this.storage,
    this.created_at,
    this.updated_at,
    this.images,
    this.stock,
  });

  // Conversion depuis JSON
  factory Product.fromJson(Map<String, dynamic> json) {
    final product = Product(
      id: json['id'] as String,
      reference: json['reference'] as String,
      name: json['name'] as String,
      description: json['description'] as String,
      price: json['price'],
      quantity: json['quantity'],
      use_case: json['use_case'] as String?,
      incredients: json['ingredients'] as String?,
      key_promises: json['key_promises'] as String?,
      precautions: json['precautions'] as String?,
      storage: json['storage'] as String?,
      created_at: json['created_at'] as String?,
      updated_at: json['updated_at'] as String?,
      images: List<Map<String, dynamic>>.from(json['images'] ?? []),
      stock: json['stock'] as int?,
    );
    
    return product;
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
      'precautions': precautions,
      'storage': storage,
      'created_at': created_at,
      'updated_at': updated_at,
      'images': images,
      'stock': stock
    };
  }

  
}
