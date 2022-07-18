import 'package:catet_kas/models/shop_model.dart';
import 'package:catet_kas/models/user_model.dart';
import 'package:catet_kas/providers/auth_provider.dart';
import 'package:catet_kas/providers/shop_provider.dart';
import 'package:catet_kas/theme.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class EditShopProfilePage extends StatefulWidget {
  const EditShopProfilePage({Key? key}) : super(key: key);

  @override
  State<EditShopProfilePage> createState() => _EditShopProfilePageState();
}

late String _token;

class _EditShopProfilePageState extends State<EditShopProfilePage> {
  void initState() {
    super.initState();
    getInit();
  }

  getInit() async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('token');
    setState(() {
      _token = token!;
    });
    print(_token);
  }

  @override
  Widget build(BuildContext context) {
    ShopProvider shopProvider = Provider.of<ShopProvider>(context);
    ShopModel shop = shopProvider.shop;

    TextEditingController nameController =
        TextEditingController(text: shop.name);
    TextEditingController categoryController =
        TextEditingController(text: shop.category);
    TextEditingController phoneNumberController =
        TextEditingController(text: shop.phoneNumber);

    handleUpdateShop() async {
      if (await shopProvider.update(
        token: _token,
        name: nameController.text,
        category: categoryController.text,
        phoneNumber: phoneNumberController.text,
      )) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            backgroundColor: Colors.blue,
            content: Text(
              'Toko Usaha berhasil diupdate!',
              textAlign: TextAlign.center,
              style: secondaryTextStyle.copyWith(
                color: backgroundColor1,
              ),
            ),
          ),
        );
        Navigator.restorablePopAndPushNamed(context, '/home');
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            backgroundColor: alertColor,
            content: Text(
              'Toko Usaha gagal diupdate!',
              textAlign: TextAlign.center,
              style: secondaryTextStyle.copyWith(
                color: backgroundColor1,
              ),
            ),
          ),
        );
      }
    }

    Widget inputNamaUsaha() {
      return Container(
        margin: EdgeInsets.only(
          top: defaultMargin,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Nama Usaha',
              style: primaryTextStyle.copyWith(
                fontSize: 14,
                fontWeight: bold,
                color: cardColor,
              ),
            ),
            TextFormField(
              controller: nameController,
              style: secondaryTextStyle.copyWith(
                color: backgroundColor1,
              ),
              decoration: InputDecoration(
                hintText: 'Masukkan usaha',
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

    Widget inputKategoriUsaha() {
      return Container(
        margin: EdgeInsets.only(
          top: defaultMargin,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Kategori Usaha',
              style: primaryTextStyle.copyWith(
                fontSize: 14,
                fontWeight: bold,
                color: cardColor,
              ),
            ),
            TextFormField(
              controller: categoryController,
              style: secondaryTextStyle.copyWith(
                color: backgroundColor1,
              ),
              decoration: InputDecoration(
                hintText: 'Masukkan kategori usaha',
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

    Widget inputNomorTelepon() {
      return Container(
        margin: EdgeInsets.only(
          top: defaultMargin,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Nomor Telepon',
              style: primaryTextStyle.copyWith(
                fontSize: 14,
                fontWeight: bold,
                color: cardColor,
              ),
            ),
            TextFormField(
              controller: phoneNumberController,
              style: secondaryTextStyle.copyWith(
                color: backgroundColor1,
              ),
              decoration: InputDecoration(
                hintText: 'Masukkan nomor telepon',
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
            inputNamaUsaha(),
            inputKategoriUsaha(),
            inputNomorTelepon(),
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
            onPressed: handleUpdateShop,
            icon: Icon(Icons.check),
          ),
        ],
      ),
      backgroundColor: backgroundColor2,
      body: SingleChildScrollView(
        child: content(),
      ),
    );
  }
}
