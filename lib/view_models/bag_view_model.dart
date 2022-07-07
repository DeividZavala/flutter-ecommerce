import 'package:ecommerce/models/product_model.dart';
import 'package:flutter/material.dart';

class BagViewModel extends ChangeNotifier {
  final List<Product> productsBag;

  BagViewModel() : productsBag = [];

  int get totalProducts => productsBag.length;
  double get total =>
      productsBag.fold(0, (sum, product) => sum + product.price);
  bool get isEmpty => productsBag.isEmpty;

  void addProduct(Product product) {
    productsBag.add(product);
    notifyListeners();
  }

  void removeProduct(Product product) {
    productsBag.remove(product);
    notifyListeners();
  }

  void clearBag() {
    productsBag.clear();
    notifyListeners();
  }
}
