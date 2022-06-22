import 'package:catet_kas/providers/auth_provider.dart';
import 'package:catet_kas/theme.dart';
import 'package:catet_kas/widgets/loading_button.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SignUpPage extends StatefulWidget {
  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  // const SignUpPage({Key? key}) : super(key: key);
  TextEditingController nameController = TextEditingController(text: '');
  TextEditingController usernameController = TextEditingController(text: '');
  TextEditingController emailController = TextEditingController(text: '');
  TextEditingController passwordController = TextEditingController(text: '');

  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    AuthProvider authProvider = Provider.of<AuthProvider>(context);

    handleSignUp() async {
      setState(() {
        isLoading = true;
      });

      if (await authProvider.register(
        name: nameController.text,
        username: usernameController.text,
        email: emailController.text,
        password: passwordController.text,
      )) {
        Navigator.pushNamed(context, '/loading');
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            backgroundColor: alertColor,
            content: Text(
              'Gagal Register!',
              textAlign: TextAlign.center,
            ),
          ),
        );
      }

      setState(() {
        isLoading = false;
      });
    }

    Widget nameInput() {
      return Container(
        margin: EdgeInsets.only(top: 40),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Name',
              style: primaryTextStyle.copyWith(
                fontSize: 16,
                fontWeight: regular,
              ),
            ),
            SizedBox(height: 10),
            Container(
              height: 40,
              decoration: BoxDecoration(
                color: backgroundColor1,
              ),
              child: TextFormField(
                controller: nameController,
                cursorColor: primaryColor,
                style: primaryTextStyle.copyWith(fontSize: 15),
                decoration: InputDecoration(
                  focusedBorder: UnderlineInputBorder(
                    borderSide: BorderSide(
                      color: primaryColor,
                    ),
                  ),
                  hintText: 'Your Full Name',
                  hintStyle:
                      primaryTextStyle.copyWith(color: secondaryTextColor),
                ),
              ),
            ),
          ],
        ),
      );
    }

    Widget usernameInput() {
      return Container(
        margin: EdgeInsets.only(top: 40),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Username',
              style: primaryTextStyle.copyWith(
                fontSize: 16,
                fontWeight: regular,
              ),
            ),
            SizedBox(height: 10),
            Container(
              height: 40,
              decoration: BoxDecoration(
                color: backgroundColor1,
              ),
              child: TextFormField(
                controller: usernameController,
                cursorColor: primaryColor,
                style: primaryTextStyle.copyWith(fontSize: 15),
                decoration: InputDecoration(
                  focusedBorder: UnderlineInputBorder(
                    borderSide: BorderSide(
                      color: primaryColor,
                    ),
                  ),
                  hintText: 'Your Username',
                  hintStyle:
                      primaryTextStyle.copyWith(color: secondaryTextColor),
                ),
              ),
            ),
          ],
        ),
      );
    }

    Widget passwordInput() {
      return Container(
        margin: EdgeInsets.only(top: defaultMargin),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Password',
              style: primaryTextStyle.copyWith(
                fontSize: 16,
                fontWeight: regular,
              ),
            ),
            SizedBox(height: 10),
            Container(
              height: 40,
              decoration: BoxDecoration(
                color: backgroundColor1,
              ),
              child: TextFormField(
                obscureText: true,
                controller: passwordController,
                cursorColor: primaryColor,
                style: primaryTextStyle.copyWith(fontSize: 15),
                decoration: InputDecoration(
                  focusedBorder: UnderlineInputBorder(
                    borderSide: BorderSide(
                      color: primaryColor,
                    ),
                  ),
                  hintText: 'Your Password',
                  hintStyle:
                      primaryTextStyle.copyWith(color: secondaryTextColor),
                ),
              ),
            ),
          ],
        ),
      );
    }

    Widget emailInput() {
      return Container(
        margin: EdgeInsets.only(top: 40),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Email',
              style: primaryTextStyle.copyWith(
                fontSize: 16,
                fontWeight: regular,
              ),
            ),
            SizedBox(height: 10),
            Container(
              height: 40,
              decoration: BoxDecoration(
                color: backgroundColor1,
              ),
              child: TextFormField(
                controller: emailController,
                cursorColor: primaryColor,
                style: primaryTextStyle.copyWith(fontSize: 15),
                decoration: InputDecoration(
                  focusedBorder: UnderlineInputBorder(
                    borderSide: BorderSide(
                      color: primaryColor,
                    ),
                  ),
                  hintText: 'Your Email Address',
                  hintStyle:
                      primaryTextStyle.copyWith(color: secondaryTextColor),
                ),
              ),
            ),
          ],
        ),
      );
    }

    Widget header() {
      return Container(
        margin: EdgeInsets.only(
          top: defaultMargin,
        ),
        width: double.infinity,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Daftar',
              style: secondaryTextStyle.copyWith(
                color: primaryTextColor,
                fontSize: 24,
                fontWeight: bold,
              ),
            ),
            SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Sudah punya akun',
                  style: secondaryTextStyle.copyWith(
                    color: primaryTextColor.withAlpha(179),
                    fontSize: 16,
                    fontWeight: medium,
                  ),
                ),
                GestureDetector(
                  onTap: () => Navigator.pushNamed(context, '/sign-in'),
                  child: Text(
                    'Masuk disini',
                    style: secondaryTextStyle.copyWith(
                      color: primaryColor,
                      fontSize: 16,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      );
    }

    Widget logo() {
      return Container(
        margin: EdgeInsets.only(
          top: defaultMargin,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              'CatetKas',
              style: logoTextStyle.copyWith(
                fontSize: 48,
              ),
            ),
          ],
        ),
      );
    }

    Widget signUpButton() {
      return Container(
        height: 40,
        width: double.infinity,
        margin: EdgeInsets.only(
          top: 30,
          bottom: 50,
        ),
        child: TextButton(
          onPressed: handleSignUp,
          style: TextButton.styleFrom(
            backgroundColor: primaryColor,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
            ),
          ),
          child: Text(
            'Sign Up',
            style: secondaryTextStyle.copyWith(
              fontSize: 14,
            ),
          ),
        ),
      );
    }

    return Scaffold(
      backgroundColor: backgroundColor1,
      body: SafeArea(
        child: Container(
          margin: EdgeInsets.symmetric(
            horizontal: 40,
          ),
          child: SingleChildScrollView(
            child: Column(
              children: [
                logo(),
                header(),
                nameInput(),
                usernameInput(),
                emailInput(),
                passwordInput(),
                isLoading ? LoadingButton() : signUpButton(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
