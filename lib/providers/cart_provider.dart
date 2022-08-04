import 'package:catet_kas/models/cart_model.dart';
import 'package:catet_kas/models/product_model.dart';
import 'package:flutter/cupertino.dart';

class CartProvider with ChangeNotifier {
  List<CartModel> _carts = [];

  List<CartModel> get carts => _carts;
  set carts(List<CartModel> carts) {
    _carts = carts;
    notifyListeners();
  }

  addCart(ProductModel product) {
    if (productExist(product)) {
      int index =
          _carts.indexWhere((element) => element.product.id == product.id);
      _carts[index].quantity++;
    } else {
      _carts.add(
        CartModel(
          id: _carts.length,
          product: product,
          quantity: 1,
        ),
      );
    }
    notifyListeners();
  }

  removeCart(int id) {
    int index = _carts.indexWhere((element) => element.id == id);
    _carts.removeAt(index);
    notifyListeners();
  }

  removeCartByProduct(ProductModel product) {
    int index =
        _carts.indexWhere((element) => element.product.id == product.id);
    _carts.removeAt(index);
    notifyListeners();
  }

  addQuantity(int id) {
    int index = _carts.indexWhere((element) => element.id == id);
    _carts[index].quantity++;
    notifyListeners();
  }

  reduceQuantity(int id) {
    int index = _carts.indexWhere((element) => element.id == id);
    _carts[index].quantity--;
    if (_carts[index].quantity == 0) {
      _carts.removeAt(index);
    }
    notifyListeners();
  }

  totaItems() {
    int total = 0;
    for (var item in _carts) {
      total += item.quantity;
    }
    return total;
  }

  totalPrice() {
    double total = 0;
    for (var item in _carts) {
      total += (item.quantity * item.product.price!);
    }
    return total;
  }

  productExist(ProductModel product) {
    if (_carts.indexWhere((element) => element.product.id == product.id) ==
        -1) {
      return false;
    } else {
      return true;
    }
  }
}
