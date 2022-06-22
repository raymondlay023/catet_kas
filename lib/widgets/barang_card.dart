import 'package:catet_kas/theme.dart';
import 'package:flutter/material.dart';

class BarangCard extends StatelessWidget {
  BarangCard(
      {Key? key, required this.nama, required this.harga, required this.stok})
      : super(key: key);

  String nama;
  int harga;
  int stok;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 300,
      alignment: Alignment.center,
      margin: EdgeInsets.symmetric(horizontal: defaultMargin),
      padding: EdgeInsets.symmetric(
        vertical: 20,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                nama,
                style: secondaryTextStyle.copyWith(
                  fontSize: 16,
                  fontWeight: bold,
                  color: primaryTextColor,
                ),
              ),
              SizedBox(height: 10),
              Text(
                'Rp. $harga',
                style: secondaryTextStyle.copyWith(
                  fontSize: 12,
                  color: Colors.black.withOpacity(0.5),
                ),
              ),
            ],
          ),
          Row(
            children: [
              IconButton(
                splashRadius: 20,
                onPressed: () {},
                icon: Icon(Icons.indeterminate_check_box_outlined),
              ),
              Text(
                stok.toString(),
                style: secondaryTextStyle.copyWith(
                  fontSize: 12,
                  color: primaryTextColor,
                ),
              ),
              IconButton(
                splashRadius: 20,
                onPressed: () {},
                icon: Icon(Icons.add_box_outlined),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
