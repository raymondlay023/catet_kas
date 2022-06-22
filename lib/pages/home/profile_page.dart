import 'package:catet_kas/models/user_model.dart';
import 'package:catet_kas/providers/auth_provider.dart';
import 'package:catet_kas/theme.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    AuthProvider authProvider = Provider.of<AuthProvider>(context);
    UserModel user = authProvider.user;

    Widget header() {
      return AppBar(
        backgroundColor: backgroundColor4,
        automaticallyImplyLeading: false,
        elevation: 0,
        flexibleSpace: SafeArea(
          child: Container(
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
                SizedBox(width: 20),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Hallo, ${user.name}',
                        style: primaryTextStyle.copyWith(
                          fontSize: 20,
                          color: cardColor,
                        ),
                      ),
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
                  onTap: (() => Navigator.pushNamedAndRemoveUntil(
                      context, '/sign-in', (route) => false)),
                  child: Image.asset(
                    'assets/icon_logout.png',
                    width: 25,
                  ),
                ),
              ],
            ),
          ),
        ),
      );
    }

    Widget menuItem(String text) {
      return Container(
        child: Row(
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
        ),
      );
    }

    Widget content() {
      return Expanded(
        child: Container(
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
                  color: cardColor,
                ),
              ),
              SizedBox(height: 25),
              GestureDetector(
                onTap: (() => Navigator.pushNamed(context, '/edit-profile')),
                child: menuItem('Edit Profil'),
              ),
              SizedBox(height: 15),
              GestureDetector(
                onTap: () => Navigator.pushNamed(context, '/edit-shop-profile'),
                child: menuItem('Edit Profil Usaha'),
              ),
            ],
          ),
        ),
      );
    }

    return Column(
      children: [
        header(),
        content(),
      ],
    );
  }
}
