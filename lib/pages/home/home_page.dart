import 'package:catet_kas/models/shop_model.dart';
import 'package:catet_kas/models/user_model.dart';
import 'package:catet_kas/providers/auth_provider.dart';
import 'package:catet_kas/providers/product_provider.dart';
import 'package:catet_kas/providers/shop_provider.dart';
import 'package:catet_kas/providers/transaction_provider.dart';
import 'package:catet_kas/theme.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    AuthProvider authProvider = Provider.of<AuthProvider>(context);
    ShopProvider shopProvider = Provider.of<ShopProvider>(context);

    UserModel user = authProvider.user;
    ShopModel shop = shopProvider.shop;

    Widget profileCard() {
      return Container(
        margin: EdgeInsets.only(
          top: defaultMargin,
        ),
        padding: EdgeInsets.all(20),
        height: 160,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
          color: primaryColor,
        ),
        child: Expanded(
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Halo, ${user.name} !',
                        style: primaryTextStyle.copyWith(
                          fontSize: 20,
                          fontWeight: bold,
                          color: cardColor,
                        ),
                      ),
                      Text(
                        '@${user.username}',
                        style: primaryTextStyle.copyWith(
                          fontSize: 14,
                          color: cardColor.withOpacity(0.5),
                        ),
                      ),
                    ],
                  ),
                  CircleAvatar(
                    backgroundImage: AssetImage('assets/image_profile.png'),
                    // backgroundImage: NetworkImage(user.profilePhotoUrl!),
                    radius: 30,
                  ),
                ],
              ),
              SizedBox(height: 20),
              Container(
                width: 240,
                height: 40,
                padding: EdgeInsets.all(10),
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(25),
                  color: cardColor,
                ),
                child: Text(
                  shop.name!,
                  style: primaryTextStyle.copyWith(
                    fontSize: 16,
                    color: primaryColor,
                  ),
                ),
              ),
            ],
          ),
        ),
      );
    }

    Widget laporanBulananHeader() {
      return Container(
        alignment: Alignment.center,
        margin: EdgeInsets.only(
          top: 20,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Laporan Bulanan',
              style: primaryTextStyle.copyWith(fontSize: 20),
            ),
            Container(
              width: 100,
              height: 35,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15),
                border: Border.all(color: backgroundColor4),
              ),
              child: TextButton(
                onPressed: () {},
                child: Text(
                  'April 2022',
                  style: primaryTextStyle.copyWith(
                    color: backgroundColor4,
                  ),
                ),
              ),
            ),
          ],
        ),
      );
    }

    Widget laporanBulananCard() {
      return Container(
        width: 340,
        height: 80,
        margin: EdgeInsets.only(
          top: 20,
        ),
        padding: EdgeInsets.symmetric(
          horizontal: 20,
          vertical: 15,
        ),
        decoration: BoxDecoration(
          color: cardColor,
          borderRadius: BorderRadius.circular(15),
        ),
        child: Expanded(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Column(
                children: [
                  Text(
                    'Total Penjualan',
                    style: primaryTextStyle.copyWith(
                      fontSize: 12,
                    ),
                  ),
                  SizedBox(height: 7),
                  Text(
                    'Rp. 1.000.000',
                    style: primaryTextStyle.copyWith(
                      color: pemasukanColor,
                      fontSize: 14,
                      fontWeight: bold,
                    ),
                  ),
                ],
              ),
              Container(
                height: 65,
                width: 1,
                decoration: BoxDecoration(
                  color: primaryTextColor.withOpacity(0.5),
                ),
              ),
              Column(
                children: [
                  Text(
                    'Total Pengeluaran',
                    style: primaryTextStyle.copyWith(
                      fontSize: 12,
                    ),
                  ),
                  SizedBox(height: 7),
                  Text(
                    'Rp. 500.000',
                    style: primaryTextStyle.copyWith(
                      color: pengeluaranColor,
                      fontSize: 14,
                      fontWeight: bold,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      );
    }

    Widget barChart() {
      return Container(
        margin: EdgeInsets.only(
          top: 20,
        ),
        padding: EdgeInsets.only(
          top: 20,
          left: 20,
          right: 20,
        ),
        width: 340,
        height: 340,
        child: Column(
          children: [
            Text(
              'Barang yang paling sering dibeli',
              style: primaryTextStyle.copyWith(fontSize: 16),
            ),
            SizedBox(height: 20),
            Container(
              width: 250,
              height: 250,
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage('assets/image_chart.png'),
                ),
              ),
            ),
          ],
        ),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
          color: cardColor,
        ),
      );
    }

    return Scaffold(
      backgroundColor: backgroundColor1,
      body: SafeArea(
        child: Container(
          alignment: Alignment.center,
          margin: EdgeInsets.symmetric(
            horizontal: defaultMargin,
          ),
          child: ListView(
            children: [
              Column(
                children: [
                  profileCard(),
                  laporanBulananHeader(),
                  laporanBulananCard(),
                  barChart(),
                  SizedBox(
                    height: defaultMargin,
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
