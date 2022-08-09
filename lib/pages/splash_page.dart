import 'dart:async';
import 'package:catet_kas/theme.dart';
import 'package:flutter/material.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({Key? key}) : super(key: key);

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  @override
  void initState() {
    Timer(
      const Duration(seconds: 3),
      () => Navigator.pushReplacementNamed(context, '/sign-in'),
    );
  }

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
