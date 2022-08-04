import 'package:catet_kas/models/product_model.dart';

class TransactionItemModel {
  late int? id;
  late int? usersId;
  late int? productsId;
  late int? transactionsId;
  late int? quantity;
  late dynamic product;

  TransactionItemModel({
    this.id,
    this.usersId,
    this.productsId,
    this.quantity,
    this.transactionsId,
    this.product,
  });

  TransactionItemModel.fromJson(Map<dynamic, dynamic> json) {
    id = json['id'];
    usersId = json['users_id'];
    productsId = json['products_id'];
    transactionsId = json['transactions_id'];
    quantity = json['quantity'];
    product = ProductModel.fromJson(json['product']);
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'users_id': usersId,
      'products_id': productsId,
      'transactions_id': transactionsId,
      'quantity': quantity,
      'product': product,
    };
  }
}
