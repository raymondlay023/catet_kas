import 'package:catet_kas/models/user_model.dart';
import 'package:catet_kas/providers/auth_provider.dart';
import 'package:catet_kas/theme.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class EditProfilePage extends StatelessWidget {
  const EditProfilePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    AuthProvider authProvider = Provider.of<AuthProvider>(context);
    UserModel user = authProvider.user;

    Widget header() {
      return Container(
        width: double.infinity,
        decoration: BoxDecoration(
          color: backgroundColor4,
        ),
      );
    }

    Widget input(String text, String hintText) {
      return Container(
        margin: EdgeInsets.only(
          top: defaultMargin,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              text,
              style: primaryTextStyle.copyWith(
                fontSize: 14,
                fontWeight: bold,
                color: cardColor,
              ),
            ),
            TextFormField(
              style: secondaryTextStyle.copyWith(
                color: backgroundColor1,
              ),
              decoration: InputDecoration(
                hintText: hintText,
                hintStyle: secondaryTextStyle.copyWith(
                  color: secondaryTextColor.withOpacity(0.5),
                ),
                enabledBorder: UnderlineInputBorder(
                  borderSide: BorderSide(
                    color: backgroundColor1,
                  ),
                ),
              ),
            )
          ],
        ),
      );
    }

    Widget content() {
      return Container(
        width: double.infinity,
        padding: EdgeInsets.all(defaultMargin),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              width: 100,
              height: 100,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                image: DecorationImage(
                  fit: BoxFit.fill,
                  image: AssetImage('assets/image_profile.png'),
                  // image: NetworkImage(user.profilePhotoUrl!),
                ),
              ),
            ),
            SizedBox(height: 10),
            input('Nama', user.name!),
            input('Username', '@${user.username!}'),
            input('Email', user.email!),
          ],
        ),
      );
    }

    return Scaffold(
      backgroundColor: backgroundColor2,
      appBar: AppBar(
        toolbarHeight: 80,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(Icons.close),
        ),
        backgroundColor: backgroundColor4,
        elevation: 0,
        centerTitle: true,
        title: Text(
          'Edit Profil',
          style: primaryTextStyle.copyWith(
            color: cardColor,
            fontSize: 22,
          ),
        ),
        actions: [
          IconButton(
            onPressed: () {},
            icon: Icon(Icons.check),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            content(),
          ],
        ),
      ),
    );
  }
}
