import 'package:catet_kas/providers/auth_provider.dart';
import 'package:catet_kas/providers/shop_provider.dart';
import 'package:catet_kas/theme.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AddShopPage extends StatefulWidget {
  const AddShopPage({Key? key}) : super(key: key);

  @override
  State<AddShopPage> createState() => _AddShopPageState();
}

class _AddShopPageState extends State<AddShopPage> {
  @override
  void initState() {
    super.initState();
    getInit();
  }

  getInit() async {
    AuthProvider authProvider =
        Provider.of<AuthProvider>(context, listen: false);
    final prefs = await SharedPreferences.getInstance();
    prefs.setString('token', authProvider.user.token!);
  }

  TextEditingController nameController = TextEditingController(text: '');
  TextEditingController categoryController = TextEditingController(text: '');
  TextEditingController phoneNumberController = TextEditingController(text: '');

  @override
  Widget build(BuildContext context) {
    ShopProvider shopProvider = Provider.of<ShopProvider>(context);

    handleAddShop() async {
      final prefs = await SharedPreferences.getInstance();
      final token = prefs.getString('token');
      if (await shopProvider.create(
        token: token!,
        name: nameController.text,
        category: categoryController.text,
        phoneNumber: phoneNumberController.text,
      )) {
        Navigator.pushReplacementNamed(context, '/loading');
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            backgroundColor: alertColor,
            content: Text(
              'Toko gagal ditambahkan!',
              textAlign: TextAlign.center,
              style: secondaryTextStyle.copyWith(
                color: backgroundColor1,
              ),
            ),
          ),
        );
      }
    }

    Widget header() {
      return Container(
        margin: EdgeInsets.all(20),
        child: Text(
          'Informasi Usaha',
          style: primaryTextStyle.copyWith(fontSize: 22),
        ),
      );
    }

    Widget nameInput() {
      return Container(
        margin: EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Nama Usaha',
                style: primaryTextStyle.copyWith(
                  fontSize: 16,
                )),
            TextFormField(
              controller: nameController,
              validator: (value) {
                if (value == '') {
                  return 'Tolong isi namanya!';
                } else {
                  return null;
                }
              },
              cursorColor: primaryColor,
              style: primaryTextStyle.copyWith(fontSize: 15),
              decoration: InputDecoration(
                focusedBorder: UnderlineInputBorder(
                  borderSide: BorderSide(
                    color: primaryColor,
                  ),
                ),
                hintText: 'Masukkan nama usaha Anda',
                hintStyle: primaryTextStyle.copyWith(color: secondaryTextColor),
              ),
            ),
          ],
        ),
      );
    }

    Widget categoryInput() {
      return Container(
        margin: EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Kategori Usaha',
              style: primaryTextStyle.copyWith(
                fontSize: 16,
              ),
            ),
            TextFormField(
              controller: categoryController,
              validator: (value) {
                if (value == '') {
                  return 'Tolong isi kategorinya!';
                } else {
                  return null;
                }
              },
              style: primaryTextStyle.copyWith(fontSize: 15),
              decoration: InputDecoration(
                focusedBorder: UnderlineInputBorder(
                  borderSide: BorderSide(
                    color: primaryColor,
                  ),
                ),
                hintText: 'Masukkan kategori usaha Anda',
                hintStyle: primaryTextStyle.copyWith(color: secondaryTextColor),
              ),
            ),
          ],
        ),
      );
    }

    Widget phoneNumberInput() {
      return Container(
        margin: EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Nomor Handphone',
                style: primaryTextStyle.copyWith(
                  fontSize: 16,
                )),
            TextFormField(
              controller: phoneNumberController,
              validator: (value) {
                if (value == '') {
                  return 'Tolong isi nomor teleponnya!';
                } else {
                  return null;
                }
              },
              style: primaryTextStyle.copyWith(fontSize: 15),
              decoration: InputDecoration(
                focusedBorder: UnderlineInputBorder(
                  borderSide: BorderSide(
                    color: primaryColor,
                  ),
                ),
                hintText: 'Masukkan nomor handphone Anda',
                hintStyle: primaryTextStyle.copyWith(color: secondaryTextColor),
              ),
            ),
          ],
        ),
      );
    }

    Widget buttonSimpan() {
      return Container(
        width: MediaQuery.of(context).size.width,
        alignment: Alignment.bottomCenter,
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            primary: buttonColor,
            fixedSize: Size(MediaQuery.of(context).size.width / 1.5,
                40), // maximumSize: Size(MediaQuery.of(context).size.width / , 35),
          ),
          onPressed: handleAddShop,
          child: Text(
            'Simpan',
            style: primaryTextStyle.copyWith(
              color: primaryTextColor,
              fontWeight: semiBold,
              fontSize: 18,
            ),
          ),
        ),
      );
    }

    Widget content() {
      return SingleChildScrollView(
        child: Container(
          padding:
              EdgeInsets.symmetric(vertical: 15, horizontal: defaultMargin),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              header(),
              nameInput(),
              categoryInput(),
              phoneNumberInput(),
              SizedBox(height: MediaQuery.of(context).size.height / 4),
              buttonSimpan(),
            ],
          ),
        ),
      );
    }

    PreferredSizeWidget customAppBar() {
      return AppBar(
        automaticallyImplyLeading: false,
        toolbarHeight: 75,
        centerTitle: true,
        title: Text(
          'Daftar Usaha Baru',
          style: primaryTextStyle.copyWith(
            fontSize: 22,
            color: backgroundColor1,
          ),
        ),
        backgroundColor: primaryColor,
      );
    }

    return Scaffold(
      appBar: customAppBar(),
      body: content(),
      backgroundColor: backgroundColor1,
    );
  }
}
