import 'package:flutter/material.dart';
import '../models/product.dart';
import '../services/product_service.dart';

class ProductProvider with ChangeNotifier {
  List<Product> _products = [];
  String _token = '';

  List<Product> get products => _products;

  set token(String token) {
    _token = token;
  }

  Future<void> fetchProducts() async {
    _products = await ProductService.getProducts(_token);
    notifyListeners();
  }

  Future<void> addProduct(Product product) async {
    final newProduct = await ProductService.createProduct(product, _token);
    _products.add(newProduct);
    notifyListeners();
  }

  Future<void> updateProduct(Product product) async {
    await ProductService.updateProduct(product, _token);
    final index = _products.indexWhere((p) => p.id == product.id);
    if (index != -1) {
      _products[index] = product;
      notifyListeners();
    }
  }

  Future<void> deleteProduct(int id) async {
    await ProductService.deleteProduct(id, _token);
    _products.removeWhere((p) => p.id == id);
    notifyListeners();
  }
}
