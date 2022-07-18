import 'package:catet_kas/providers/auth_provider.dart';
import 'package:catet_kas/providers/shop_provider.dart';
import 'package:catet_kas/providers/transaction_provider.dart';
import 'package:catet_kas/theme.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:catet_kas/providers/product_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoadingPage extends StatefulWidget {
  const LoadingPage({Key? key}) : super(key: key);

  @override
  State<LoadingPage> createState() => _LoadingPageState();
}

class _LoadingPageState extends State<LoadingPage> {
  void initState() {
    super.initState();
    getInit();
  }

  getInit() async {
    AuthProvider authProvider =
        Provider.of<AuthProvider>(context, listen: false);
    await Provider.of<ProductProvider>(context, listen: false)
        .getProducts(authProvider.user.token!);
    await Provider.of<TransactionProvider>(context, listen: false)
        .getTransactions(authProvider.user.token!);
    await Provider.of<ShopProvider>(context, listen: false)
        .getShop(authProvider.user.token!);
    final prefs = await SharedPreferences.getInstance();
    prefs.setString('token', authProvider.user.token!);
    print(prefs.getString('token'));
    Navigator.pushNamed(context, '/home');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: primaryColor,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Catet Kas',
              style: logoTextStyle.copyWith(
                fontSize: 80,
                color: backgroundColor1,
              ),
            ),
            CircularProgressIndicator(
              strokeWidth: 2,
              valueColor: AlwaysStoppedAnimation(
                backgroundColor1,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
