import 'package:catet_kas/pages/home/catet_page.dart';
import 'package:catet_kas/pages/home/home_page.dart';
import 'package:catet_kas/pages/home/profile_page.dart';
import 'package:catet_kas/theme.dart';
import 'package:flutter/material.dart';

class MainPage extends StatefulWidget {
  const MainPage({Key? key}) : super(key: key);

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  int _selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    Widget customBottomNav() {
      return BottomNavigationBar(
        selectedLabelStyle: primaryTextStyle.copyWith(color: primaryColor),
        backgroundColor: Colors.white,
        elevation: 0,
        type: BottomNavigationBarType.fixed,
        currentIndex: _selectedIndex,
        onTap: (index) {
          setState(() {
            _selectedIndex = index;
          });
        },
        items: [
          BottomNavigationBarItem(
            icon: Container(
              margin: EdgeInsets.symmetric(
                vertical: 5,
              ),
              child: Image.asset(
                'assets/icon_home.png',
                width: 20,
                color: _selectedIndex == 0 ? primaryColor : primaryTextColor,
              ),
            ),
            label: 'Beranda',
          ),
          BottomNavigationBarItem(
            icon: Container(
              margin: EdgeInsets.symmetric(
                vertical: 5,
              ),
              child: Image.asset(
                'assets/icon_catet.png',
                width: 20,
                color: _selectedIndex == 1 ? primaryColor : primaryTextColor,
              ),
            ),
            label: 'Catet',
          ),
          BottomNavigationBarItem(
            icon: Container(
              margin: EdgeInsets.symmetric(
                vertical: 5,
              ),
              child: Image.asset(
                'assets/icon_profile.png',
                width: 20,
                color: _selectedIndex == 2 ? primaryColor : primaryTextColor,
              ),
            ),
            label: 'Profil',
          ),
        ],
      );
    }

    Widget body() {
      switch (_selectedIndex) {
        case 0:
          return HomePage();
        case 1:
          return CatetPage();
        case 2:
          return ProfilePage();
        default:
          return HomePage();
      }
    }

    return Scaffold(
      bottomNavigationBar: customBottomNav(),
      body: body(),
    );
  }
}
