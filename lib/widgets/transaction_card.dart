import 'package:catet_kas/models/transaction_model.dart';
import 'package:catet_kas/theme.dart';
import 'package:flutter/material.dart';

class TransactionCard extends StatelessWidget {
  final TransactionModel transaction;
  const TransactionCard(this.transaction);
  @override
  Widget build(BuildContext context) {
    // return Card(
    //   elevation: 0,
    //   child: ListTile(
    //     contentPadding: EdgeInsets.all(12),
    //     title: Text(transaction.note!),
    //   ),
    // );
    return Container(
      decoration: const BoxDecoration(),
      padding: const EdgeInsets.symmetric(vertical: 12),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Container(
            alignment: Alignment.center,
            width: MediaQuery.of(context).size.width / 3,
            child: Text(
              transaction.note!,
              style: primaryTextStyle.copyWith(
                fontSize: 12,
                color: primaryTextColor.withOpacity(0.5),
              ),
            ),
          ),
          Container(
            alignment: Alignment.center,
            width: MediaQuery.of(context).size.width / 3,
            child: Text(
              'Rp. ${transaction.total}',
              style: primaryTextStyle.copyWith(
                fontSize: 12,
                color: transaction.type == 'PEMASUKAN'
                    ? pemasukanColor
                    : pengeluaranColor,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
