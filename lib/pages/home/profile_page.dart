import 'package:catet_kas/models/user_model.dart';
import 'package:catet_kas/providers/auth_provider.dart';
import 'package:catet_kas/theme.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ProfilePage extends StatefulWidget {
  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  // late Future<dynamic> dataFuture;
  @override
  void initState() {
    super.initState();
    getData();
    // dataFuture = getData();
  }

  getData() async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('token');
    await Provider.of<AuthProvider>(context, listen: false).getUser(token!);
  }

  @override
  Widget build(BuildContext context) {
    AuthProvider authProvider = Provider.of<AuthProvider>(context);
    UserModel user = authProvider.user;

    handleSignOut() async {
      final prefs = await SharedPreferences.getInstance();
      final token = prefs.getString('token');
      if (await authProvider.logout(token!)) {
        Navigator.pushNamedAndRemoveUntil(
            context, '/sign-in', (route) => false);
      } else {
        print('gagal sign out');
      }
    }

    Widget menuItem(String text) {
      return Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            text,
            style: secondaryTextStyle.copyWith(
              fontSize: 14,
              color: thirdTextColor,
            ),
          ),
          Icon(
            Icons.chevron_right,
            color: thirdTextColor,
          ),
        ],
      );
    }

    Widget content() {
      return Container(
        width: double.infinity,
        padding: EdgeInsets.symmetric(
          horizontal: defaultMargin,
        ),
        decoration: BoxDecoration(color: backgroundColor2),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: defaultMargin),
            Text(
              'Akun',
              style: secondaryTextStyle.copyWith(
                fontSize: 16,
                fontWeight: bold,
                color: backgroundColor1,
              ),
            ),
            const SizedBox(height: 20),
            GestureDetector(
              onTap: (() => Navigator.pushNamed(context, '/edit-profile')),
              child: menuItem('Edit Profil'),
            ),
            const SizedBox(height: 15),
            GestureDetector(
              onTap: () => Navigator.pushNamed(context, '/edit-shop-profile'),
              child: menuItem('Edit Profil Usaha'),
            ),
          ],
        ),
      );
    }

    Widget profileData() {
      return Container(
        width: double.infinity,
        padding: EdgeInsets.all(defaultMargin),
        child: Row(
          children: [
            ClipOval(
              child: Image.asset(
                'assets/image_profile.png',
                width: 75,
              ),
            ),
            const SizedBox(width: 20),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Hallo, ${user.name}',
                    style: primaryTextStyle.copyWith(
                      fontSize: 20,
                      color: backgroundColor1,
                    ),
                  ),
                  const SizedBox(height: 5),
                  Text(
                    '@${user.username}',
                    style: primaryTextStyle.copyWith(
                      fontSize: 16,
                      color: thirdTextColor,
                    ),
                  ),
                ],
              ),
            ),
            GestureDetector(
              onTap: handleSignOut,
              child: Image.asset(
                'assets/icon_logout.png',
                width: 25,
              ),
            ),
          ],
        ),
      );
    }

    PreferredSizeWidget customAppbar() {
      return AppBar(
        toolbarHeight: 120,
        backgroundColor: backgroundColor4,
        automaticallyImplyLeading: false,
        elevation: 0,
        flexibleSpace: SafeArea(
          child: profileData(),
        ),
      );
    }

    return Scaffold(
      appBar: customAppbar(),
      body: content(),
    );
  }
}
