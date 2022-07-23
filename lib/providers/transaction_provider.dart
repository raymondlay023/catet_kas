import 'package:catet_kas/models/transaction_model.dart';
import 'package:catet_kas/services/transaction_service.dart';
import 'package:flutter/cupertino.dart';

class TransactionProvider with ChangeNotifier {
  List<TransactionModel> _transactions = [];

  List<TransactionModel> get transactions => _transactions;
  set transactions(List<TransactionModel> transactions) {
    _transactions = transactions;
    notifyListeners();
  }

  Future<void> getTransactions(String token) async {
    try {
      List<TransactionModel> transactions =
          await TransactionService().getTransactions(token);
      _transactions = transactions;
    } catch (e) {
      print(e);
    }
  }

  double totalTransaksi([String? tipe, DateTime? tanggal]) {
    double total = 0;
    if (tanggal != null && tipe != null) {
      for (var item in _transactions.where((element) =>
          element.type == tipe && element.createdAt!.month == tanggal.month)) {
        total += (item.total!);
      }
    } else if (tanggal != null) {
      for (var item
          in _transactions.where((element) => element.createdAt! == tanggal)) {
        total += (item.total!);
      }
    } else if (tipe != null) {
      for (var item in _transactions.where((element) => element.type == tipe)) {
        total += (item.total!);
      }
    } else {
      for (var item in _transactions) {
        total += (item.total!);
      }
    }
    return total;
  }

  double gainLoss([DateTime? tanggal]) {
    double total = 0;
    if (tanggal != null) {
      for (var item
          in _transactions.where((element) => element.createdAt! == tanggal)) {
        if (item.type == 'PEMASUKAN') {
          total += (item.total!);
        } else {
          total -= (item.total!);
        }
      }
    } else {
      for (var item in _transactions) {
        if (item.type == 'PEMASUKAN') {
          total += (item.total!);
        } else {
          total -= (item.total!);
        }
      }
    }

    return total;
  }
}
