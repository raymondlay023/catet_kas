import 'dart:convert';

import 'package:catet_kas/models/transaction_model.dart';
import 'package:http/http.dart' as http;

class TransactionService {
  String baseUrl = 'http://catetkas.masuk.id/api/transactions';
  // String baseUrl = 'http://192.168.1.7:8000/api/transactions';

  Future<List<TransactionModel>> getTransactions(String token) async {
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
      List<TransactionModel> transactions = [];

      for (var item in data) {
        transactions.add(TransactionModel.fromJson(item));
      }
      return transactions;
    } else {
      throw Exception('Gagal mengambil data transaksi!');
    }
  }

  Future<TransactionModel> create({
    required String token,
    required String note,
    required double total,
    required String type,
    required List items,
  }) async {
    var url = Uri.parse('$baseUrl/create');
    var headers = {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      'Authorization': token,
    };
    var body = jsonEncode({
      'note': note,
      'total': total,
      'type': type,
      'items': items
          .map(
            (item) => {
              'id': item.product.id,
              'quantity': item.quantity,
            },
          )
          .toList(),
    });

    var response = await http.post(
      url,
      headers: headers,
      body: body,
    );

    print(response.body);

    if (response.statusCode == 200) {
      var data = jsonDecode(response.body)['data'];
      TransactionModel transaction = TransactionModel.fromJson(data);
      return transaction;
    } else {
      throw Exception('Transaksi gagal ditambahkan!');
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
      throw Exception('Transaksi gagal dihapus!');
    }
  }

  Future<TransactionModel> update({
    required String token,
    required int id,
    required String note,
    required double total,
    required String type,
    required List items,
  }) async {
    var url = Uri.parse('$baseUrl/update?id=$id');
    var headers = {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      'Authorization': token,
    };

    var body = jsonEncode({
      'note': note,
      'total': total,
      'type': type,
      'items': items
          .map(
            (item) => {
              'id': item.product.id,
              'quantity': item.quantity,
            },
          )
          .toList(),
    });

    var response = await http.post(
      url,
      headers: headers,
      body: body,
    );

    print(response.body);

    if (response.statusCode == 200) {
      var data = jsonDecode(response.body)['data'];
      TransactionModel transaction = TransactionModel.fromJson(data);
      return transaction;
    } else {
      throw Exception('Transaksi gagal dihapus!');
    }
  }
}
