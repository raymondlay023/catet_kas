import 'package:catet_kas/providers/auth_provider.dart';
import 'package:catet_kas/theme.dart';
import 'package:catet_kas/widgets/loading_button.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SignInPage extends StatefulWidget {
  @override
  State<SignInPage> createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPage> {
  // const SignInPage({Key? key}) : super(key: key);

  TextEditingController emailController = TextEditingController(text: '');
  TextEditingController passwordController = TextEditingController(text: '');

  bool isLoading = false;
  @override
  Widget build(BuildContext context) {
    AuthProvider authProvider = Provider.of<AuthProvider>(context);
    handleSignIn() async {
      setState(() {
        isLoading = true;
      });

      if (await authProvider.login(
        email: emailController.text,
        password: passwordController.text,
      )) {
        Navigator.pushNamed(context, '/loading');
      } else {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          backgroundColor: alertColor,
          content: Text(
            'Gagal Login!',
            textAlign: TextAlign.center,
          ),
        ));
      }

      setState(() {
        isLoading = false;
      });
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
                validator: (value) {
                  if (value == null) {
                    return 'Tolong isi passwordnya!';
                  } else {
                    return null;
                  }
                },
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
                validator: (value) {
                  if (value == null) {
                    return 'Tolong isi emailnya!';
                  } else {
                    return null;
                  }
                },
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
              'Masuk',
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
                  'Belum punya akun',
                  style: secondaryTextStyle.copyWith(
                    color: primaryTextColor.withAlpha(179),
                    fontSize: 16,
                    fontWeight: medium,
                  ),
                ),
                GestureDetector(
                  onTap: () => Navigator.pushNamed(context, '/sign-up'),
                  child: Text(
                    'Daftar disini',
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

    Widget signInButton() {
      return Container(
        height: 40,
        width: double.infinity,
        margin: EdgeInsets.only(
          top: 30,
        ),
        child: TextButton(
          onPressed: handleSignIn,
          style: TextButton.styleFrom(
            backgroundColor: primaryColor,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
            ),
          ),
          child: Text(
            'Sign In',
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
        child: SingleChildScrollView(
          child: Container(
            margin: EdgeInsets.symmetric(
              horizontal: 40,
            ),
            child: Column(
              children: [
                logo(),
                header(),
                emailInput(),
                passwordInput(),
                isLoading ? LoadingButton() : signInButton(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
