import 'package:catet_kas/providers/product_provider.dart';
import 'package:catet_kas/theme.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AddProductPage extends StatelessWidget {
  // const AddProductPage({Key? key}) : super(key: key);

  TextEditingController namaBarangController = TextEditingController(text: '');
  TextEditingController hargaJualController = TextEditingController(text: '');
  TextEditingController modalController = TextEditingController(text: '');
  TextEditingController stokController = TextEditingController(text: '');

  @override
  Widget build(BuildContext context) {
    ProductProvider productProvider = Provider.of<ProductProvider>(context);

    handleAddProduct() async {
      final prefs = await SharedPreferences.getInstance();
      final token = prefs.getString('token');
      if (await productProvider.createProduct(
        token: token!,
        name: namaBarangController.text,
        price: double.parse(hargaJualController.text),
        capital: double.parse(modalController.text),
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
        Navigator.popAndPushNamed(context, '/product-list');
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
            padding: const EdgeInsets.symmetric(
              horizontal: 20,
            ),
            child: TextFormField(
              controller: namaBarangController,
              cursorColor: primaryColor,
              decoration: InputDecoration(
                floatingLabelStyle: secondaryTextStyle.copyWith(
                  color: primaryColor,
                ),
                label: const Text('Nama Barang'),
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
            padding: const EdgeInsets.symmetric(
              horizontal: 20,
            ),
            child: TextFormField(
              controller: hargaJualController,
              cursorColor: primaryColor,
              decoration: InputDecoration(
                floatingLabelStyle: secondaryTextStyle.copyWith(
                  color: primaryColor,
                ),
                label: const Text('Harga Jual'),
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

    Widget inputModal() {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: double.infinity,
            alignment: Alignment.center,
            padding: const EdgeInsets.symmetric(
              horizontal: 20,
            ),
            child: TextFormField(
              controller: modalController,
              cursorColor: primaryColor,
              decoration: InputDecoration(
                floatingLabelStyle: secondaryTextStyle.copyWith(
                  color: primaryColor,
                ),
                label: const Text('Modal'),
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
            padding: const EdgeInsets.symmetric(
              horizontal: 20,
            ),
            child: TextFormField(
              controller: stokController,
              cursorColor: primaryColor,
              decoration: InputDecoration(
                floatingLabelStyle: secondaryTextStyle.copyWith(
                  color: primaryColor,
                ),
                label: const Text('Stok Barang'),
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
      backgroundColor: Colors.white,
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
            const SizedBox(height: 20),
            inputNamaBarang(),
            const SizedBox(height: 20),
            inputHargaJual(),
            const SizedBox(height: 20),
            inputModal(),
            const SizedBox(height: 20),
            inputStokBarang(),
            const Spacer(),
            buttonSimpan(),
          ],
        ),
      ),
    );
  }
}
