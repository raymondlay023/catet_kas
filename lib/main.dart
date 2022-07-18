import 'package:catet_kas/pages/catat_pemasukan_page.dart';
import 'package:catet_kas/pages/product_list_page.dart';
import 'package:catet_kas/pages/edit_profile_page.dart';
import 'package:catet_kas/pages/edit_shop_profile_page.dart';
import 'package:catet_kas/pages/catat_pengeluaran_page.dart';
import 'package:catet_kas/pages/home/main_page.dart';
import 'package:catet_kas/pages/loading_page.dart';
import 'package:catet_kas/pages/sign_in_page.dart';
import 'package:catet_kas/pages/sign_up_page.dart';
import 'package:catet_kas/pages/splash_page.dart';
import 'package:catet_kas/pages/add_product_page.dart';
import 'package:catet_kas/providers/auth_provider.dart';
import 'package:catet_kas/providers/cart_provider.dart';
import 'package:catet_kas/providers/product_provider.dart';
import 'package:catet_kas/providers/shop_provider.dart';
import 'package:catet_kas/providers/transaction_provider.dart';
import 'package:flutter/material.dart';
import 'package:month_year_picker/month_year_picker.dart';
import 'package:provider/provider.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

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
        ChangeNotifierProvider(
          create: (context) => CartProvider(),
        )
      ],
      child: MaterialApp(
        localizationsDelegates: [
          GlobalWidgetsLocalizations.delegate,
          GlobalMaterialLocalizations.delegate,
          MonthYearPickerLocalizations.delegate,
        ],
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
          '/product-list': (context) => ProductList(),
          '/add-product': (context) => AddProduct(),
          '/loading': (context) => LoadingPage(),
        },
      ),
    );
  }
}
