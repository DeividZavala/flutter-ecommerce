import 'package:ecommerce/models/product_model.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test("Product description match the defined text", () {
    const String description = "This is a product description";
    const String name = "Product name";
    final Product product = Product(
      name: name,
      price: 200,
      imageUrl: "imageUrl",
      description: description,
    );

    expect(product.description, description);
    expect(product.name, name);
  });
  group("Price", () {
    test("should assign the price correctly", () {
      const double price = 100;
      final Product product = Product(
          name: "product",
          description: "description",
          price: price,
          imageUrl: "imageUrl");
      expect(product.price, price);
      expect(product.priceWithTax, price * 1.2);
    });

    test("should assign the price with taxes correctly", () {
      const double price = 100;
      final Product product = Product(
          name: "product",
          description: "description",
          price: price,
          imageUrl: "imageUrl");
      expect(product.priceWithTax, price * 1.2);
    });
  });
}
