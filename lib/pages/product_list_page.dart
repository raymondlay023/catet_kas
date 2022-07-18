import 'package:catet_kas/providers/auth_provider.dart';
import 'package:catet_kas/providers/product_provider.dart';
import 'package:catet_kas/theme.dart';
import 'package:catet_kas/widgets/product_card.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ProductList extends StatefulWidget {
  const ProductList({Key? key}) : super(key: key);

  @override
  State<ProductList> createState() => _ProductListState();
}

class _ProductListState extends State<ProductList> {
  void initState() {
    super.initState();
    getInit();
  }

  getInit() async {
    AuthProvider authProvider =
        Provider.of<AuthProvider>(context, listen: false);
    await Provider.of<ProductProvider>(context, listen: false)
        .getProducts(authProvider.user.token!);
  }

  bool isChecked = false;

  @override
  Widget build(BuildContext context) {
    ProductProvider productProvider = Provider.of<ProductProvider>(context);
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
      return Expanded(
        child: ListView(
          shrinkWrap: true,
          children: productProvider.products
              .map((product) => ProductCard(product))
              .toList(),
        ),
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
            'Cari',
            style: secondaryTextStyle.copyWith(
              color: backgroundColor1,
            ),
          ),
          onPressed: () {},
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
        actions: [
          IconButton(
            icon: Icon(Icons.add),
            onPressed: () {
              Navigator.pushNamed(context, '/add-product');
            },
          ),
        ],
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
            Divider(thickness: 7, color: thirdTextColor.withOpacity(0.3)),
            content(),
          ],
        ),
      ),
    );
  }
}
