import 'package:catet_kas/models/product_model.dart';
import 'package:catet_kas/services/product_service.dart';
import 'package:flutter/cupertino.dart';

class ProductProvider with ChangeNotifier {
  //initialize product & products
  List<ProductModel> _products = [];

  //getter setter products
  List<ProductModel> get products => _products;
  set products(List<ProductModel> products) {
    _products = products;
    notifyListeners();
  }

  Future<void> getProducts(String token) async {
    try {
      List<ProductModel> products = await ProductService().getProducts(token);
      _products = products;
    } catch (e) {
      print(e);
    }
  }

  Future<bool> updateProduct({
    required int id,
    required String token,
    String? name,
    double? stock,
    double? price,
    double? capital,
  }) async {
    try {
      await ProductService().update(
        token: token,
        id: id,
        name: name,
        stock: stock,
        price: price,
        capital: capital,
      );
      return true;
    } catch (e) {
      print(e);
      return false;
    }
  }

  Future<bool> createProduct({
    required String token,
    required String name,
    required double price,
    double capital = 0,
    double stock = 0,
  }) async {
    try {
      await ProductService().create(
        token: token,
        name: name,
        price: price,
        capital: capital,
        stock: stock,
      );
      return true;
    } catch (e) {
      print(e);
      return false;
    }
  }

  Future<bool> deleteProduct({
    required String token,
    required int id,
  }) async {
    try {
      await ProductService().delete(
        token: token,
        id: id,
      );
      return true;
    } catch (e) {
      print(e);
      return false;
    }
  }
}
