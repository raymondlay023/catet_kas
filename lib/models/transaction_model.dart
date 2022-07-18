import 'package:intl/intl.dart';

class TransactionModel {
  late int? id;
  late String? note;
  late double? total;
  late String? type;
  late DateTime? createdAt;
  // late DateTime? updatedAt;

  TransactionModel({
    this.id,
    this.note,
    this.total,
    this.type,
    this.createdAt,
    // this.updatedAt,
  });

  TransactionModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    note = json['note'];
    total = double.parse(json['total'].toString());
    type = json['type'];
    createdAt = DateTime.parse(json['created_at']);
    // updatedAt = DateTime.parse(json['updated_at']);
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'note': note,
      'total': total,
      'type': type,
      'created_at': createdAt.toString(),
      // 'updated_at': updatedAt.toString(),
    };
  }
}
