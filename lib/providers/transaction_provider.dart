import 'package:catet_kas/models/transaction_model.dart';
import 'package:catet_kas/services/transaction_service.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class TransactionProvider with ChangeNotifier {
  List<TransactionModel> _transactions = [];
  late TransactionModel _transaction;

  TransactionModel get transaction => _transaction;
  set transaction(TransactionModel transaction) {
    _transaction = transaction;
    notifyListeners();
  }

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

  Future<bool> create({
    required String token,
    required String note,
    required double total,
    required String type,
    required List items,
  }) async {
    try {
      TransactionModel transaction = await TransactionService().create(
        token: token,
        note: note,
        total: total,
        type: type,
        items: items,
      );
      _transaction = transaction;
      return true;
    } catch (e) {
      print(e);
      return false;
    }
  }

  Future<bool> delete({
    required String token,
    required int id,
  }) async {
    try {
      await TransactionService().delete(token: token, id: id);
      return true;
    } catch (e) {
      print(e);
      return false;
    }
  }

  Future<bool> update({
    required String token,
    required int id,
    required String note,
    required double total,
    required String type,
    required List items,
  }) async {
    try {
      await TransactionService().update(
        token: token,
        id: id,
        note: note,
        total: total,
        type: type,
        items: items,
      );
      return true;
    } catch (e) {
      print(e);
      return false;
    }
  }

  double totalTransaksi(
      {String? type, DateTime? date, List<TransactionModel>? transactions}) {
    double total = 0;
    final __transactions = transactions ?? _transactions;
    if (date != null && type != null) {
      for (var item in __transactions.where((element) =>
          element.type == type && element.createdAt!.month == date.month)) {
        total += (item.total!);
      }
    } else if (date != null) {
      for (var item
          in __transactions.where((element) => element.createdAt! == date)) {
        total += (item.total!);
      }
    } else if (type != null) {
      for (var item
          in __transactions.where((element) => element.type == type)) {
        total += (item.total!);
      }
    } else {
      for (var item in __transactions) {
        total += (item.total!);
      }
    }
    return total;
  }

  double gainLoss({DateTime? date, List<TransactionModel>? transactions}) {
    double total = 0;
    final __transactions = transactions ?? _transactions;
    if (date != null) {
      for (var item in __transactions
          .where((transaction) => transaction.createdAt! == date)) {
        if (item.type == 'PEMASUKAN') {
          total += (item.total!);
        } else {
          total -= (item.total!);
        }
      }
    } else {
      for (var item in __transactions) {
        if (item.type == 'PEMASUKAN') {
          total += (item.total!);
        } else {
          total -= (item.total!);
        }
      }
    }

    return total;
  }

  List<TransactionModel> transactionsBetweenDates({
    required DateTime start,
    required DateTime end,
  }) {
    List<DateTime> dates = _transactions.map((e) => e.createdAt!).toList();
    List<TransactionModel> items = _transactions.map((e) => e).toList();
    assert(dates.length == items.length);

    var dateFormat = DateFormat('y-MM-dd');

    var output = <TransactionModel>[];

    for (var i = 0; i < dates.length; i++) {
      var date = dateFormat.parse(dates[i].toString(), true);
      if (date.compareTo(start) >= 0 && date.compareTo(end) <= 0) {
        output.add(items[i]);
      }
    }
    return output;
  }
}
