import 'package:catet_kas/models/shop_model.dart';
import 'package:catet_kas/services/shop_service.dart';
import 'package:flutter/cupertino.dart';

class ShopProvider with ChangeNotifier {
  late ShopModel _shop;

  ShopModel get shop => _shop;

  set shop(ShopModel shop) {
    _shop = shop;
    notifyListeners();
  }

  Future<void> getShop(String token) async {
    try {
      ShopModel shop = await ShopService().getShop(token);
      _shop = shop;
    } catch (e) {
      print(e);
    }
  }

  Future<bool> update({
    required String token,
    required String name,
    required String category,
    required String phoneNumber,
  }) async {
    try {
      ShopModel shop = await ShopService().update(
        token: token,
        name: name,
        category: category,
        phoneNumber: phoneNumber,
      );
      _shop = shop;
      return true;
    } catch (e) {
      print(e);
      return false;
    }
  }

  Future<bool> create({
    required String name,
    required String category,
    required String phoneNumber,
  }) async {
    try {
      ShopModel shop = await ShopService().create(
        name: name,
        category: category,
        phoneNumber: phoneNumber,
      );
      _shop = shop;
      return true;
    } catch (e) {
      return false;
    }
  }
}
