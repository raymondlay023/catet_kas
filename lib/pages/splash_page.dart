import 'dart:async';
import 'package:catet_kas/providers/product_provider.dart';
import 'package:catet_kas/theme.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({Key? key}) : super(key: key);

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  void initState() {
    // getInit();

    // super.initState();

    Timer(
      Duration(seconds: 3),
      () => Navigator.pushNamed(context, '/sign-in'),
    );
  }

  // getInit() async {
  //   await Provider.of<ProductProvider>(context, listen: false).getProducts();
  //   Navigator.pushNamed(context, '/sign-in');
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text(
          'Catet Kas',
          style: logoTextStyle.copyWith(fontSize: 80),
        ),
      ),
    );
  }
}
