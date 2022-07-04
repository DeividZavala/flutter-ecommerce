class Product {
  final String? id;
  final String name;
  final String description;
  final String imageUrl;
  final double price;

  Map<String, dynamic> toMap(String docId) {
    return {
      "id": docId,
      "name": name,
      "description": description,
      "imageUrl": imageUrl,
      "price": price
    };
  }

  Product.fromMap(Map<String, dynamic> map)
      : id = map["id"] ?? "",
        name = map["name"] ?? "",
        description = map["description"] ?? "",
        imageUrl = map["imageUrl"] ?? "",
        price = map["price"] ?? 0.0;

  Product(
      {required this.name,
      required this.description,
      required this.imageUrl,
      required this.price,
      this.id});
}
