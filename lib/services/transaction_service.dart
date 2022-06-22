import 'dart:convert';

import 'package:catet_kas/models/transaction_model.dart';
import 'package:http/http.dart' as http;

class TransactionService {
  String baseUrl = 'http://192.168.1.6:8000/api/transactions';

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
      List data = jsonDecode(response.body)['data'];
      List<TransactionModel> transactions = [];

      for (var item in data) {
        transactions.add(TransactionModel.fromJson(item));
      }
      return transactions;
    } else {
      throw Exception('Gagal mengambil data transaksi!');
    }
  }
}
