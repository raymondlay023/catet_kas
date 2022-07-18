import 'package:catet_kas/providers/auth_provider.dart';
import 'package:catet_kas/providers/product_provider.dart';
import 'package:catet_kas/theme.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AddProduct extends StatelessWidget {
  // const AddProduct({Key? key}) : super(key: key);

  TextEditingController namaBarangController = TextEditingController(text: '');
  TextEditingController hargaJualController = TextEditingController(text: '');
  TextEditingController kategoriController = TextEditingController(text: '');
  TextEditingController stokController = TextEditingController(text: '');

  @override
  Widget build(BuildContext context) {
    AuthProvider authProvider = Provider.of<AuthProvider>(context);
    ProductProvider productProvider = Provider.of<ProductProvider>(context);

    handleAddProduct() async {
      if (await productProvider.createProduct(
        token: authProvider.user.token!,
        name: namaBarangController.text,
        price: double.parse(hargaJualController.text),
        stock: double.parse(stokController.text),
      )) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            backgroundColor: Colors.blue,
            content: Text(
              'Produk berhasil ditambahkan!',
              textAlign: TextAlign.center,
              style: secondaryTextStyle.copyWith(
                color: backgroundColor1,
              ),
            ),
          ),
        );
        // Navigator.popAndPushNamed(context, '/catet-pemasukan');
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            backgroundColor: alertColor,
            content: Text(
              'Produk gagal ditambahkan!',
              textAlign: TextAlign.center,
              style: secondaryTextStyle.copyWith(
                color: backgroundColor1,
              ),
            ),
          ),
        );
      }
    }

    Widget inputNamaBarang() {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: double.infinity,
            alignment: Alignment.center,
            padding: EdgeInsets.symmetric(
              horizontal: 20,
            ),
            child: TextFormField(
              controller: namaBarangController,
              cursorColor: primaryColor,
              decoration: InputDecoration(
                floatingLabelStyle: secondaryTextStyle.copyWith(
                  color: primaryColor,
                ),
                label: Text('Nama Barang'),
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                    color: thirdTextColor,
                  ),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                    color: primaryColor,
                  ),
                ),
              ),
            ),
          ),
        ],
      );
    }

    Widget inputHargaJual() {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: double.infinity,
            alignment: Alignment.center,
            padding: EdgeInsets.symmetric(
              horizontal: 20,
            ),
            child: TextFormField(
              controller: hargaJualController,
              cursorColor: primaryColor,
              decoration: InputDecoration(
                floatingLabelStyle: secondaryTextStyle.copyWith(
                  color: primaryColor,
                ),
                label: Text('Harga Jual'),
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                    color: thirdTextColor,
                  ),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                    color: primaryColor,
                  ),
                ),
              ),
            ),
          ),
        ],
      );
    }

    Widget inputKategori() {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: double.infinity,
            alignment: Alignment.center,
            padding: EdgeInsets.symmetric(
              horizontal: 20,
            ),
            child: TextFormField(
              controller: kategoriController,
              cursorColor: primaryColor,
              decoration: InputDecoration(
                floatingLabelStyle: secondaryTextStyle.copyWith(
                  color: primaryColor,
                ),
                label: Text('Kategori'),
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                    color: thirdTextColor,
                  ),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                    color: primaryColor,
                  ),
                ),
              ),
            ),
          ),
        ],
      );
    }

    Widget inputStokBarang() {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: double.infinity,
            alignment: Alignment.center,
            padding: EdgeInsets.symmetric(
              horizontal: 20,
            ),
            child: TextFormField(
              controller: stokController,
              cursorColor: primaryColor,
              decoration: InputDecoration(
                floatingLabelStyle: secondaryTextStyle.copyWith(
                  color: primaryColor,
                ),
                label: Text('Stok Barang'),
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                    color: thirdTextColor,
                  ),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                    color: primaryColor,
                  ),
                ),
              ),
            ),
          ),
        ],
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
          onPressed: handleAddProduct,
        ),
      );
    }

    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: backgroundColor1,
      appBar: AppBar(
        toolbarHeight: 65,
        backgroundColor: primaryColor,
        title: Text(
          'Tambah Barang',
          style: primaryTextStyle.copyWith(
            color: backgroundColor1,
          ),
        ),
      ),
      body: Container(
        padding: EdgeInsets.only(
          top: 20,
          left: defaultMargin,
          right: defaultMargin,
        ),
        child: Column(
          children: [
            SizedBox(height: 20),
            inputNamaBarang(),
            SizedBox(height: 20),
            inputHargaJual(),
            SizedBox(height: 20),
            inputKategori(),
            SizedBox(height: 20),
            inputStokBarang(),
            Spacer(),
            buttonSimpan(),
          ],
        ),
      ),
    );
  }
}
