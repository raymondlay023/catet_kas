import 'package:catet_kas/models/product_model.dart';
import 'package:catet_kas/pages/edit_product_page.dart';
import 'package:catet_kas/providers/product_provider.dart';
import 'package:catet_kas/theme.dart';
import 'package:catet_kas/widgets/product_card.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ProductList extends StatefulWidget {
  const ProductList({Key? key}) : super(key: key);

  @override
  State<ProductList> createState() => _ProductListState();
}

class _ProductListState extends State<ProductList> {
  late Future<dynamic> dataFuture;
  @override
  void initState() {
    super.initState();
    dataFuture = getData();
  }

  Future<dynamic> getData() async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('token');
    await Provider.of<ProductProvider>(context, listen: false)
        .getProducts(token!);
    var products = ProductProvider().products;
    return products;
  }

  // bool isChecked = false;

  @override
  Widget build(BuildContext context) {
    ProductProvider productProvider = Provider.of<ProductProvider>(context);

    handleDeleteProduct(ProductModel product) async {
      final prefs = await SharedPreferences.getInstance();
      final token = prefs.getString('token');

      if (await productProvider.deleteProduct(
        token: token!,
        id: product.id!,
      )) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            backgroundColor: Colors.blue,
            content: Text(
              'Produk berhasil diupdate!',
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
              'Produk gagal diupdate!',
              textAlign: TextAlign.center,
              style: secondaryTextStyle.copyWith(
                color: backgroundColor1,
              ),
            ),
          ),
        );
      }
    }

    Widget fieldCariBarang() {
      return Container(
        width: 175,
        height: 35,
        padding: const EdgeInsets.only(
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

    Widget products() {
      return ListView(
        shrinkWrap: true,
        children: productProvider.products
            .map((product) => ProductCard(product))
            .toList(),
      );
    }

    Widget products2() {
      return SingleChildScrollView(
          child: ExpansionPanelList.radio(
        children: productProvider.products
            .map((product) => ExpansionPanelRadio(
                  value: product.id!,
                  headerBuilder: (context, isExpanded) => ProductCard(product),
                  body: Container(
                      padding: EdgeInsets.only(bottom: 20),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          GestureDetector(
                            onTap: () => Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: ((context) => EditProduct(
                                      product: product,
                                    )),
                              ),
                            ),
                            child: Row(
                              children: [
                                Icon(Icons.mode_edit, color: Colors.green),
                                SizedBox(width: 10),
                                Text('Edit'),
                              ],
                            ),
                          ),
                          GestureDetector(
                            onTap: () => handleDeleteProduct(product),
                            child: Row(
                              children: [
                                Icon(Icons.delete, color: Colors.red),
                                SizedBox(width: 10),
                                Text('Delete'),
                              ],
                            ),
                          ),
                        ],
                      )),
                ))
            .toList(),
      ));
    }

    Widget listProduct() {
      return Expanded(
          child: FutureBuilder(
        future: dataFuture,
        builder: (context, snapshot) {
          switch (snapshot.connectionState) {
            case ConnectionState.waiting:
              return const Center(child: CircularProgressIndicator());
            case ConnectionState.done:
            default:
              if (snapshot.hasError) {
                return const Center(child: Text('error :'));
              } else if (snapshot.hasData) {
                return Expanded(
                  child: products2(),
                );
              } else {
                return const Center(child: CircularProgressIndicator());
              }
          }
        },
      ));
    }

    Widget buttonCariBarang() {
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
      backgroundColor: Colors.white,
      appBar: AppBar(
        toolbarHeight: 65,
        backgroundColor: primaryColor,
        title: Text(
          'Daftar Barang',
          style: primaryTextStyle.copyWith(
            color: Colors.white,
          ),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: () {
              Navigator.pushNamed(context, '/add-product');
            },
          ),
        ],
      ),
      body: Container(
        padding: const EdgeInsets.only(top: 20),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                fieldCariBarang(),
                const SizedBox(width: 30),
                buttonCariBarang(),
              ],
            ),
            const SizedBox(height: 20),
            Divider(thickness: 7, color: thirdTextColor.withOpacity(0.3)),
            listProduct(),
          ],
        ),
      ),
    );
  }
}
