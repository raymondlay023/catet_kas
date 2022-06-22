import 'dart:async';

class ShopModel {
  late int? id;
  late String? name;
  late String? phoneNumber;
  late String? category;
  late DateTime? createdAt;
  late DateTime? updatedAt;

  ShopModel({
    this.id,
    this.name,
    this.phoneNumber,
    this.category,
    this.createdAt,
    this.updatedAt,
  });

  ShopModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    phoneNumber = json['phone_number'];
    category = json['category'];
    createdAt = DateTime.parse(json['created_at']);
    updatedAt = DateTime.parse(json['updated_at']);
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'phone_number': phoneNumber,
      'category': category,
      'created_at': createdAt.toString(),
      'updated_at': updatedAt.toString(),
    };
  }
}
