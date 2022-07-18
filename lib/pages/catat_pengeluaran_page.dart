import 'package:catet_kas/theme.dart';
import 'package:flutter/material.dart';

class CatatPengeluaran extends StatelessWidget {
  const CatatPengeluaran({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Widget switchButton() {
      return Container(
        width: double.infinity,
        margin: EdgeInsets.only(top: defaultMargin),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: 170,
              height: 40,
              decoration: BoxDecoration(
                border: Border.all(
                  color: pemasukanColor,
                ),
                borderRadius: BorderRadius.circular(5),
              ),
              child: TextButton(
                onPressed: () {
                  Navigator.pushNamed(context, '/catat-pemasukan');
                },
                child: Text(
                  'Pemasukan',
                  style: secondaryTextStyle.copyWith(
                    color: pemasukanColor,
                  ),
                ),
              ),
            ),
            SizedBox(
              width: 25,
            ),
            Container(
              width: 170,
              height: 40,
              decoration: BoxDecoration(
                color: pengeluaranColor,
                borderRadius: BorderRadius.circular(5),
              ),
              child: TextButton(
                onPressed: () {
                  Navigator.pushNamed(context, '/catat-pengeluaran');
                },
                child: Text(
                  'Pengeluaran',
                  style: secondaryTextStyle.copyWith(
                    color: backgroundColor1,
                  ),
                ),
              ),
            ),
          ],
        ),
      );
    }

    Widget buttonTambahBarangDibeli() {
      return Container(
        width: 365,
        height: 40,
        margin: EdgeInsets.only(top: defaultMargin),
        decoration: BoxDecoration(
          border: Border.all(color: primaryTextColor),
          borderRadius: BorderRadius.circular(5),
        ),
        child: TextButton(
          onPressed: () {
            Navigator.pushNamed(context, '/product-list');
          },
          child: Text(
            '+ Tambah Barang Dibeli',
            style: secondaryTextStyle.copyWith(
              color: primaryTextColor,
            ),
          ),
        ),
      );
    }

    Widget inputTotalPengeluaran() {
      return Container(
        width: double.infinity,
        height: 50,
        margin: EdgeInsets.only(top: defaultMargin),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Total Pengeluaran',
              style: secondaryTextStyle.copyWith(
                color: primaryTextColor,
              ),
            ),
            SizedBox(width: 60),
            Container(
              width: 160,
              height: 40,
              padding: EdgeInsets.symmetric(
                horizontal: 15,
                vertical: 10,
              ),
              child: TextFormField(
                decoration: InputDecoration(
                  focusedBorder: UnderlineInputBorder(
                    borderSide: BorderSide(
                      color: primaryColor,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      );
    }

    Widget inputCatatanTransaksi() {
      return Container(
        width: 350,
        margin: EdgeInsets.only(top: defaultMargin),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Catatan Transaksi',
              style: secondaryTextStyle.copyWith(
                fontSize: 14,
                color: primaryTextColor,
              ),
            ),
            SizedBox(height: 10),
            Container(
              height: 40,
              decoration: BoxDecoration(
                border: Border.all(
                  color: primaryTextColor.withOpacity(0.5),
                ),
              ),
              padding: EdgeInsets.all(10),
              child: TextFormField(
                decoration: InputDecoration.collapsed(
                  hintText: '',
                  hintStyle: secondaryTextStyle.copyWith(
                    fontSize: 12,
                    color: primaryTextColor.withOpacity(0.5),
                  ),
                ),
              ),
            ),
          ],
        ),
      );
    }

    Widget buttonSimpan() {
      return Container(
        width: 300,
        height: 47,
        decoration: BoxDecoration(
          color: buttonColor,
          borderRadius: BorderRadius.circular(15),
        ),
        child: TextButton(
          child: Text(
            'Simpan',
            style: secondaryTextStyle.copyWith(
              fontSize: 18,
              fontWeight: bold,
              color: primaryTextColor,
            ),
          ),
          onPressed: () {},
        ),
      );
    }

    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 65,
        backgroundColor: primaryColor,
        title: Text(
          'Pengeluaran',
          style: primaryTextStyle.copyWith(
            color: backgroundColor1,
          ),
        ),
      ),
      body: Container(
        margin: EdgeInsets.symmetric(
          horizontal: 15,
        ),
        child: SingleChildScrollView(
          child: Column(
            children: [
              buttonTambahBarangDibeli(),
              inputTotalPengeluaran(),
              inputCatatanTransaksi(),
              SizedBox(
                height: 250,
              ),
              buttonSimpan(),
            ],
          ),
        ),
      ),
    );
  }
}
