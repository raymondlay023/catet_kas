import 'dart:convert';

import 'package:catet_kas/models/product_model.dart';
import 'package:catet_kas/services/product_service.dart';
import 'package:flutter/cupertino.dart';

class ProductProvider with ChangeNotifier {
  //initialize product & products
  List<ProductModel> _products = [];
  late ProductModel _product;

  //getter setter products
  List<ProductModel> get products => _products;
  set products(List<ProductModel> products) {
    _products = products;
    notifyListeners();
  }

  // getter setter product
  ProductModel get product => _product;
  set product(ProductModel product) {
    _product = product;
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
    String? name,
    double? stock,
    double? price,
  }) async {
    try {
      ProductModel product = await ProductService().update();
      _product = product;
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
      ProductModel product = await ProductService().create(
        token: token,
        name: name,
        price: price,
        capital: capital,
        stock: stock,
      );
      _product = product;
      return true;
    } catch (e) {
      print(e);
      return false;
    }
  }
}
