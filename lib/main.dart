import 'package:catet_kas/pages/catat_pemasukan_page.dart';
import 'package:catet_kas/pages/daftar_barang_page.dart';
import 'package:catet_kas/pages/edit_profile_page.dart';
import 'package:catet_kas/pages/edit_shop_profile_page.dart';
import 'package:catet_kas/pages/catat_pengeluaran_page.dart';
import 'package:catet_kas/pages/home/main_page.dart';
import 'package:catet_kas/pages/loading_page.dart';
import 'package:catet_kas/pages/sign_in_page.dart';
import 'package:catet_kas/pages/sign_up_page.dart';
import 'package:catet_kas/pages/splash_page.dart';
import 'package:catet_kas/pages/tambah_barang_page.dart';
import 'package:catet_kas/providers/auth_provider.dart';
import 'package:catet_kas/providers/product_provider.dart';
import 'package:catet_kas/providers/shop_provider.dart';
import 'package:catet_kas/providers/transaction_provider.dart';
import 'package:catet_kas/widgets/loading_button.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => AuthProvider(),
        ),
        ChangeNotifierProvider(
          create: (context) => ProductProvider(),
        ),
        ChangeNotifierProvider(
          create: (context) => ShopProvider(),
        ),
        ChangeNotifierProvider(
          create: (context) => TransactionProvider(),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        routes: {
          '/': (context) => SplashPage(),
          '/sign-in': (context) => SignInPage(),
          '/sign-up': (context) => SignUpPage(),
          '/home': (context) => MainPage(),
          '/edit-profile': (context) => EditProfilePage(),
          '/edit-shop-profile': (context) => EditShopProfilePage(),
          '/catat-pemasukan': (context) => CatatPemasukan(),
          '/catat-pengeluaran': (context) => CatatPengeluaran(),
          '/daftar-barang': (context) => DaftarBarang(),
          '/tambah-barang': (context) => TambahBarang(),
          '/loading': (context) => LoadingPage(),
        },
      ),
    );
  }
}
