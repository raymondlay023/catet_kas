import 'package:catet_kas/theme.dart';
import 'package:catet_kas/widgets/barang_card.dart';
import 'package:flutter/material.dart';

class DaftarBarang extends StatelessWidget {
  const DaftarBarang({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Widget cariBarang() {
      return Container(
        width: 175,
        height: 35,
        padding: EdgeInsets.only(
          top: 7,
          left: 12,
          right: 5,
        ),
        decoration: BoxDecoration(
          border: Border.all(
            color: thirdTextColor,
          ),
          borderRadius: BorderRadius.circular(5),
        ),
        child: TextFormField(
          decoration: InputDecoration.collapsed(
            hintText: 'Cari Barang',
            hintStyle: secondaryTextStyle.copyWith(
              color: thirdTextColor,
            ),
          ),
        ),
      );
    }

    Widget content() {
      return Column(
        children: [
          BarangCard(
            nama: 'Barang A',
            harga: 20000,
            stok: 0,
          ),
        ],
      );
    }

    Widget buttonTambahBarang() {
      return Container(
        width: 115,
        height: 35,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(5),
          color: primaryColor,
        ),
        child: TextButton(
          child: Text(
            'Tambah',
            style: secondaryTextStyle.copyWith(
              color: backgroundColor1,
            ),
          ),
          onPressed: () {
            Navigator.pushNamed(context, '/tambah-barang');
          },
        ),
      );
    }

    return Scaffold(
      backgroundColor: backgroundColor1,
      appBar: AppBar(
        toolbarHeight: 65,
        backgroundColor: primaryColor,
        title: Text(
          'Daftar Barang',
          style: primaryTextStyle.copyWith(
            color: backgroundColor1,
          ),
        ),
      ),
      body: Container(
        padding: EdgeInsets.only(top: 20),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                cariBarang(),
                SizedBox(width: 30),
                buttonTambahBarang(),
              ],
            ),
            SizedBox(height: 20),
            Divider(
              thickness: 7,
              color: thirdTextColor.withOpacity(0.3),
            ),
            content(),
          ],
        ),
      ),
    );
  }
}
