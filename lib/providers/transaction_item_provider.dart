import 'package:catet_kas/models/transaction_item_model.dart';
import 'package:flutter/cupertino.dart';

class TransactionItem with ChangeNotifier {
  List<TransactionItemModel> _transaction_items = [];

  List<TransactionItemModel> get transaction_items => _transaction_items;
  set transaction_items(List<TransactionItemModel> transactionItems) {
    _transaction_items = transactionItems;
    notifyListeners();
  }
}
