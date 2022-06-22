import 'package:catet_kas/models/shop_model.dart';
import 'package:catet_kas/providers/shop_provider.dart';
import 'package:catet_kas/theme.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class EditShopProfilePage extends StatelessWidget {
  const EditShopProfilePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    ShopProvider shopProvider = Provider.of<ShopProvider>(context);
    ShopModel shop = shopProvider.shop;

    Widget input(String text, String hintText) {
      return Container(
        margin: EdgeInsets.only(
          top: defaultMargin,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              text,
              style: primaryTextStyle.copyWith(
                fontSize: 14,
                fontWeight: bold,
                color: cardColor,
              ),
            ),
            TextFormField(
              style: secondaryTextStyle.copyWith(
                color: backgroundColor1,
              ),
              decoration: InputDecoration(
                hintText: hintText,
                hintStyle: secondaryTextStyle.copyWith(
                  color: secondaryTextColor.withOpacity(0.5),
                ),
                enabledBorder: UnderlineInputBorder(
                  borderSide: BorderSide(
                    color: backgroundColor1,
                  ),
                ),
              ),
            )
          ],
        ),
      );
    }

    Widget content() {
      return Container(
        width: double.infinity,
        padding: EdgeInsets.all(defaultMargin),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              width: 100,
              height: 100,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                image: DecorationImage(
                  image: AssetImage(
                    'assets/image_shop.png',
                  ),
                ),
              ),
            ),
            SizedBox(height: 10),
            input('Nama Usaha', shop.name!),
            input('Kategori Usaha', shop.category!),
            input('Nomor Telepon', shop.phoneNumber!),
          ],
        ),
      );
    }

    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 80,
        backgroundColor: backgroundColor4,
        elevation: 0,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(Icons.close),
        ),
        title: Text(
          'Edit Profil Usaha',
          style: primaryTextStyle.copyWith(
            fontSize: 22,
            color: cardColor,
          ),
        ),
        centerTitle: true,
        actions: [
          IconButton(
            onPressed: () {},
            icon: Icon(Icons.check),
          ),
        ],
      ),
      backgroundColor: backgroundColor2,
      body: SingleChildScrollView(
        child: Column(
          children: [
            content(),
          ],
        ),
      ),
    );
  }
}
