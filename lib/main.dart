import 'package:catet_kas/pages/catat_transaksi_page.dart';
import 'package:catet_kas/pages/edit_product_page.dart';
import 'package:catet_kas/pages/product_list_page.dart';
import 'package:catet_kas/pages/edit_profile_page.dart';
import 'package:catet_kas/pages/edit_shop_profile_page.dart';
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

void main() => runApp(const MyApp());

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
        localizationsDelegates: const [
          GlobalWidgetsLocalizations.delegate,
          GlobalMaterialLocalizations.delegate,
          MonthYearPickerLocalizations.delegate,
        ],
        debugShowCheckedModeBanner: false,
        routes: {
          '/': (context) => const SplashPage(),
          '/sign-in': (context) => SignInPage(),
          '/sign-up': (context) => SignUpPage(),
          '/home': (context) => const MainPage(),
          '/edit-profile': (context) => const EditProfilePage(),
          '/edit-shop-profile': (context) => const EditShopProfilePage(),
          '/catat-transaksi': (context) => CatatTransaksi(),
          '/product-list': (context) => const ProductList(),
          '/add-product': (context) => AddProduct(),
          // '/edit-product': (context) => EditProduct(product: ),
          '/loading': (context) => const LoadingPage(),
        },
      ),
    );
  }
}
