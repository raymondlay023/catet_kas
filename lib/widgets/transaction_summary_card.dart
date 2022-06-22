import 'package:catet_kas/theme.dart';
import 'package:flutter/material.dart';

class TransactionSummary extends StatelessWidget {
  String tanggalCatat = '';
  int selisihHarga = 0;

  TransactionSummary({required this.tanggalCatat, required this.selisihHarga});
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 15),
      width: double.infinity,
      height: 50,
      decoration: BoxDecoration(
        color: thirdTextColor,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Container(
            alignment: Alignment.center,
            width: MediaQuery.of(context).size.width / 2,
            child: Text(
              tanggalCatat,
              style: primaryTextStyle.copyWith(
                fontSize: 16,
                fontWeight: bold,
              ),
            ),
          ),
          Container(
            alignment: Alignment.center,
            width: MediaQuery.of(context).size.width / 2,
            child: Text(
              'Untung Rp. $selisihHarga',
              style: primaryTextStyle.copyWith(
                fontSize: 12,
                fontWeight: bold,
                color: pemasukanColor,
              ),
            ),
          ),
          Divider(
            thickness: 1,
            height: 5,
          ),
        ],
      ),
    );
  }
}
