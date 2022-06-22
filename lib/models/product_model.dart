class ProductModel {
  late int? id;
  late String? name;
  late double? price;
  late int? stock;
  late int? capital;
  late DateTime? createdAt;
  late DateTime? updatedAt;

  ProductModel({
    this.id,
    this.name,
    this.price,
    this.stock,
    this.capital,
  });

  ProductModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    price = double.parse(json['price'].toString());
    stock = json['stock'];
    createdAt = DateTime.parse(json['created_at']);
    updatedAt = DateTime.parse(json['updated_at']);
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'price': price,
      'stock': stock,
      'createdAt': createdAt.toString(),
      'updatedAt': updatedAt.toString(),
    };
  }
}
