import 'package:catet_kas/models/transaction_model.dart';
import 'package:catet_kas/pages/detail_transaksi_page.dart';
import 'package:catet_kas/theme.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class TransactionCard extends StatelessWidget {
  final TransactionModel transaction;
  const TransactionCard(this.transaction);
  @override
  Widget build(BuildContext context) {
    _formatCurrency(double value) {
      return NumberFormat.currency(
              locale: 'id', decimalDigits: 0, symbol: 'Rp ')
          .format(value);
    }

    return GestureDetector(
      onTap: () => Navigator.push(
        context,
        MaterialPageRoute(
          builder: ((context) => DetailTransaksiPage(
                transaction: transaction,
              )),
        ),
      ),
      child: Container(
        decoration: const BoxDecoration(),
        padding: const EdgeInsets.symmetric(vertical: 12),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Flexible(
              flex: 1,
              child: Container(
                alignment: Alignment.center,
                child: Text(
                  transaction.note!,
                  textAlign: TextAlign.center,
                  style: primaryTextStyle.copyWith(
                    fontSize: 12,
                    color: primaryTextColor.withOpacity(0.5),
                  ),
                ),
              ),
            ),
            Flexible(
              flex: 1,
              child: Container(
                alignment: Alignment.center,
                child: Text(
                  _formatCurrency(transaction.total!),
                  textAlign: TextAlign.center,
                  style: primaryTextStyle.copyWith(
                    fontSize: 12,
                    color: transaction.type == 'PEMASUKAN'
                        ? pemasukanColor
                        : pengeluaranColor,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
