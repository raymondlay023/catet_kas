import 'package:catet_kas/models/cart_model.dart';
import 'package:catet_kas/providers/cart_provider.dart';
import 'package:catet_kas/theme.dart';
import 'package:catet_kas/widgets/cart_card.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CatatTransaksi extends StatefulWidget {
  @override
  State<CatatTransaksi> createState() => _CatatTransaksiState();
}

class _CatatTransaksiState extends State<CatatTransaksi> {
  double totalPrice = 0;
  @override
  Widget build(BuildContext context) {
    CartProvider cartProvider = Provider.of<CartProvider>(context);
    List<CartModel> carts = cartProvider.carts;

    getTotalPrice() {
      totalPrice = cartProvider.totalPrice();
      return totalPrice;
    }

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
            const SizedBox(
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
            const SizedBox(width: 60),
            Container(
              width: 160,
              height: 40,
              padding: const EdgeInsets.symmetric(
                horizontal: 15,
                vertical: 10,
              ),
              child: TextFormField(
                initialValue: getTotalPrice().toString(),
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
              padding: const EdgeInsets.all(10),
              child: TextFormField(
                cursorColor: primaryColor,
                decoration: InputDecoration(
                  label: const Text('Catatan Transaksi'),
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
        width: MediaQuery.of(context).size.width / 1.1,
        margin: EdgeInsets.symmetric(vertical: 20, horizontal: defaultMargin),
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

    Widget cartItems() {
      return Container(
        height: 250,
        margin: EdgeInsets.only(top: defaultMargin),
        child: ListView(
          shrinkWrap: true,
          children: carts.map((cart) => CartCard(cart: cart)).toList(),
        ),
      );
    }

    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 65,
        backgroundColor: primaryColor,
        title: Text(
          'Catat Transaksi',
          style: primaryTextStyle.copyWith(
            color: backgroundColor1,
          ),
        ),
      ),
      body: ListView(
        padding: EdgeInsets.symmetric(horizontal: defaultMargin),
        children: [
          carts.isNotEmpty ? cartItems() : Container(),
          buttonTambahBarangTerjual(),
          inputTotalPemasukan(),
          inputCatatanTransaksi(),
        ],
      ),
      bottomNavigationBar: buttonSimpan(),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.refresh),
        onPressed: () => getTotalPrice(),
      ),
    );
  }
}
