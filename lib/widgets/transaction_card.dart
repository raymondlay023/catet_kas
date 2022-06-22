import 'package:catet_kas/theme.dart';
import 'package:flutter/material.dart';

class Transaction extends StatelessWidget {
  String catatan = '';
  int harga = 0;
  bool isPemasukan = true;
  Transaction(
      {required this.catatan, required this.harga, required this.isPemasukan});
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Container(
            alignment: Alignment.center,
            width: MediaQuery.of(context).size.width / 2,
            child: Text(
              catatan,
              style: primaryTextStyle.copyWith(
                fontSize: 12,
                color: primaryTextColor.withOpacity(0.5),
              ),
            ),
          ),
          Container(
            alignment: Alignment.center,
            width: MediaQuery.of(context).size.width / 2,
            child: Text(
              'Rp. $harga',
              style: primaryTextStyle.copyWith(
                fontSize: 12,
                color: isPemasukan ? pemasukanColor : pengeluaranColor,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
