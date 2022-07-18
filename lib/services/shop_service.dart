import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:catet_kas/models/shop_model.dart';

class ShopService {
  String baseUrl = 'http://192.168.1.4:8000/api/shops';

  Future<ShopModel> getShop(String token) async {
    var url = Uri.parse('$baseUrl/read');
    var headers = {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      'Authorization': token,
    };

    var response = await http.get(
      url,
      headers: headers,
    );

    print(response.body);

    if (response.statusCode == 200) {
      var data = jsonDecode(response.body)['data'];
      ShopModel shop = ShopModel.fromJson(data);
      return shop;
    } else {
      throw Exception('Gagal mengambil data shop!');
    }
  }

  Future<ShopModel> create({
    required String name,
    required String category,
    required String phoneNumber,
  }) async {
    var url = Uri.parse('$baseUrl/create');
    var headers = {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
    };
    var body = jsonEncode({
      'name': name,
      'category': category,
      'phoneNumber': phoneNumber,
    });

    var response = await http.post(
      url,
      headers: headers,
      body: body,
    );

    print(response.body);

    if (response.statusCode == 200) {
      var data = jsonDecode(response.body)['data'];
      ShopModel shop = ShopModel.fromJson(data);
      return shop;
    } else {
      throw Exception('Gagal ');
    }
  }

  Future<ShopModel> update({
    required String token,
    String? name,
    String? category,
    String? phoneNumber,
  }) async {
    var url = Uri.parse('$baseUrl/update');
    var headers = {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      'Authorization': token,
    };
    var body = jsonEncode({
      'name': name,
      'category': category,
      'phone_number': phoneNumber,
    });

    var response = await http.post(
      url,
      headers: headers,
      body: body,
    );

    print(response.body);

    if (response.statusCode == 200) {
      var data = jsonDecode(response.body)['data'];
      ShopModel shop = ShopModel.fromJson(data);
      return shop;
    } else {
      throw Exception('Gagal update shop profile!');
    }
  }
}
