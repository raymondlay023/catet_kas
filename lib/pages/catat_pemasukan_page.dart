import 'package:catet_kas/providers/cart_provider.dart';
import 'package:catet_kas/theme.dart';
import 'package:catet_kas/widgets/cart_card.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CatatPemasukan extends StatelessWidget {
  const CatatPemasukan({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    CartProvider cartProvider = Provider.of<CartProvider>(context);
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
                color: pemasukanColor,
                borderRadius: BorderRadius.circular(5),
              ),
              child: TextButton(
                onPressed: () {},
                child: Text(
                  'Pemasukan',
                  style: secondaryTextStyle.copyWith(
                    color: backgroundColor1,
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
                border: Border.all(
                  color: pengeluaranColor,
                ),
                borderRadius: BorderRadius.circular(5),
              ),
              child: TextButton(
                onPressed: () {
                  Navigator.pushNamed(context, '/catat-pengeluaran');
                },
                child: Text(
                  'Pengeluaran',
                  style: secondaryTextStyle.copyWith(
                    color: pengeluaranColor,
                  ),
                ),
              ),
            ),
          ],
        ),
      );
    }

    Widget buttonTambahBarangTerjual() {
      return Container(
        width: 340,
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
            '+ Tambah Barang Terjual',
            style: secondaryTextStyle.copyWith(
              color: primaryTextColor,
            ),
          ),
        ),
      );
    }

    Widget inputTotalPemasukan() {
      return Container(
        width: double.infinity,
        height: 50,
        margin: EdgeInsets.only(top: defaultMargin),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Total Pemasukan',
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
                cursorColor: primaryColor,
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
        margin: EdgeInsets.only(top: defaultMargin),
        width: 350,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: EdgeInsets.all(10),
              child: TextFormField(
                cursorColor: primaryColor,
                decoration: InputDecoration(
                  label: Text('Catatan Transaksi'),
                  floatingLabelStyle:
                      primaryTextStyle.copyWith(color: primaryTextColor),
                  enabledBorder: UnderlineInputBorder(
                    borderSide: BorderSide(
                      color: primaryTextColor,
                    ),
                  ),
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

    Widget buttonSimpan() {
      return Container(
        width: 300,
        height: 47,
        margin: EdgeInsets.only(bottom: defaultMargin),
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

    Widget content() {
      return ListView(
        padding: EdgeInsets.symmetric(
          horizontal: defaultMargin,
        ),
        children:
            cartProvider.carts.map((cart) => CartCard(cart: cart)).toList(),
      );
    }

    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        toolbarHeight: 65,
        backgroundColor: primaryColor,
        title: Text(
          'Pemasukan',
          style: primaryTextStyle.copyWith(
            color: backgroundColor1,
          ),
        ),
      ),
      body: Container(
        margin: EdgeInsets.symmetric(
          horizontal: 15,
        ),
        child: Column(
          children: [
            buttonTambahBarangTerjual(),
            inputTotalPemasukan(),
            inputCatatanTransaksi(),
            Spacer(),
            buttonSimpan(),
          ],
        ),
      ),
    );
  }
}
