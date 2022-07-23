class TransactionItemModel {
  late int? id;
  late int? usersId;
  late int? productsId;
  late int? transactionsId;
  late int? quantity;

  TransactionItemModel({
    this.id,
    this.usersId,
    this.productsId,
    this.quantity,
    this.transactionsId,
  });

  TransactionItemModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    usersId = json['users_id'];
    productsId = json['products_id'];
    transactionsId = json['transactions_id'];
    quantity = json['quantity'];
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'users_id': usersId,
      'products_id': productsId,
      'transactions_id': transactionsId,
      'quantity': quantity,
    };
  }
}
