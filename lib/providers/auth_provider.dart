import 'package:catet_kas/models/user_model.dart';
import 'package:catet_kas/services/auth_service.dart';
import 'package:flutter/cupertino.dart';

class AuthProvider with ChangeNotifier {
  late UserModel _user;

  UserModel get user => _user;

  set user(UserModel user) {
    _user = user;
    notifyListeners();
  }

  Future<bool> register({
    required String name,
    required String username,
    required String email,
    required String password,
  }) async {
    try {
      UserModel user = await AuthService().register(
        name: name,
        username: username,
        email: email,
        password: password,
      );
      _user = user;
      return true;
    } catch (e) {
      print(e);
      return false;
    }
  }

  Future<bool> login({
    required String email,
    required String password,
  }) async {
    try {
      UserModel user = await AuthService().login(
        email: email,
        password: password,
      );
      _user = user;
      return true;
    } catch (e) {
      print(e);
      return false;
    }
  }

  Future<bool> update({
    required String token,
    required String name,
    required String username,
    required String email,
  }) async {
    try {
      UserModel user = await AuthService().update(
        token: token,
        name: name,
        username: username,
        email: email,
      );
      _user = user;
      return true;
    } catch (e) {
      print(e);
      return false;
    }
  }

  Future<bool> logout(String token) async {
    try {
      await AuthService().logout(token);
      return true;
    } catch (e) {
      print(e);
      return false;
    }
  }

  Future<bool> getUser(String token) async {
    try {
      UserModel user = await AuthService().getUser(token: token);
      _user = user;
      return true;
    } catch (e) {
      print(e);
      return false;
    }
  }
}
