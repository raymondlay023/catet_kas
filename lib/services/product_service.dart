import 'dart:convert';

import 'package:catet_kas/models/product_model.dart';
import 'package:http/http.dart' as http;

class ProductService {
  String baseUrl = 'http://192.168.1.4:8000/api/products';

  Future<List<ProductModel>> getProducts(String token) async {
    var url = Uri.parse('$baseUrl/read');
    var headers = {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      'Authorization': token
    };

    var response = await http.get(
      url,
      headers: headers,
    );

    print(response.body);

    if (response.statusCode == 200) {
      List data = jsonDecode(response.body)['data'];
      List<ProductModel> products = [];

      for (var item in data) {
        products.add(ProductModel.fromJson(item));
      }
      return products;
    } else {
      throw Exception('Gagal mengambil data produk!');
    }
  }

  Future<ProductModel> update({
    required String token,
    required int id,
    String? name,
    double? price,
    double? capital,
    double? stock,
  }) async {
    var url = Uri.parse('$baseUrl/update?id=$id');
    var headers = {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      'Authorization': token,
    };
    var body = jsonEncode({
      'name': name,
      'price': price,
      'capital': capital,
      'stock': stock,
    });

    var response = await http.post(
      url,
      headers: headers,
      body: body,
    );

    print(response.body);

    if (response.statusCode == 200) {
      var data = jsonDecode(response.body)['data'];
      ProductModel product = ProductModel.fromJson(data);
      return product;
    } else {
      throw Exception('Gagal update produk!');
    }
  }

  Future<ProductModel> create({
    required String token,
    required String name,
    required double price,
    double capital = 0,
    double stock = 0,
  }) async {
    var url = Uri.parse('$baseUrl/create');
    var headers = {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      'Authorization': token,
    };
    var body = jsonEncode({
      'name': name,
      'price': price,
      'capital': capital,
      'stock': stock,
    });

    var response = await http.post(
      url,
      headers: headers,
      body: body,
    );

    print(response.body);

    if (response.statusCode == 200) {
      var data = jsonDecode(response.body)['data'];
      ProductModel product = ProductModel.fromJson(data);
      return product;
    } else {
      throw Exception('Produk gagal ditambahkan!');
    }
  }

  Future<void> delete({
    required String token,
    required int id,
  }) async {
    var url = Uri.parse('$baseUrl/delete?id=$id');
    var headers = {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      'Authorization': token,
    };

    var response = await http.post(
      url,
      headers: headers,
    );

    print(response.body);

    if (response.statusCode == 200) {
      var data = jsonDecode(response.body)['data'];
      print(data['message']);
    } else {
      throw Exception('Produk gagal dihapus!');
    }
  }
}
