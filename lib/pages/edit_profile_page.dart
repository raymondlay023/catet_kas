import 'package:catet_kas/models/user_model.dart';
import 'package:catet_kas/providers/auth_provider.dart';
import 'package:catet_kas/theme.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class EditProfilePage extends StatefulWidget {
  const EditProfilePage({Key? key}) : super(key: key);

  @override
  State<EditProfilePage> createState() => _EditProfilePageState();
}

class _EditProfilePageState extends State<EditProfilePage> {
  @override
  void initState() {
    super.initState();
    getInit();
  }

  getInit() async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('token');
    AuthProvider().getUser(token!);
  }

  @override
  Widget build(BuildContext context) {
    @override
    AuthProvider authProvider = Provider.of<AuthProvider>(context);
    UserModel user = authProvider.user;

    TextEditingController nameController =
        TextEditingController(text: user.name);
    TextEditingController usernameController =
        TextEditingController(text: user.username);
    TextEditingController emailController =
        TextEditingController(text: user.email);

    handleUpdateProfile() async {
      final prefs = await SharedPreferences.getInstance();
      final token = prefs.getString('token');
      if (await authProvider.update(
        token: token!,
        name: nameController.text,
        username: usernameController.text,
        email: emailController.text,
      )) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            backgroundColor: Colors.blue,
            content: Text(
              'Profile berhasil diupdate!',
              textAlign: TextAlign.center,
              style: secondaryTextStyle.copyWith(
                color: backgroundColor1,
              ),
            ),
          ),
        );
        Navigator.pushNamedAndRemoveUntil(
            context, '/edit-profile', ModalRoute.withName('/home'));
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            backgroundColor: alertColor,
            content: Text(
              'Profile gagal diupdate!',
              textAlign: TextAlign.center,
              style: secondaryTextStyle.copyWith(
                color: backgroundColor1,
              ),
            ),
          ),
        );
      }
    }

    Widget header() {
      return Container(
        width: double.infinity,
        decoration: BoxDecoration(
          color: backgroundColor4,
        ),
      );
    }

    Widget inputNama() {
      return Container(
        margin: EdgeInsets.only(
          top: defaultMargin,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Nama',
              style: primaryTextStyle.copyWith(
                fontSize: 14,
                fontWeight: bold,
                color: cardColor,
              ),
            ),
            TextFormField(
              controller: nameController,
              style: secondaryTextStyle.copyWith(
                color: backgroundColor1,
              ),
              decoration: InputDecoration(
                hintText: 'Masukkan nama anda',
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

    Widget inputUsername() {
      return Container(
        margin: EdgeInsets.only(
          top: defaultMargin,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Username',
              style: primaryTextStyle.copyWith(
                fontSize: 14,
                fontWeight: bold,
                color: cardColor,
              ),
            ),
            TextFormField(
              controller: usernameController,
              style: secondaryTextStyle.copyWith(
                color: backgroundColor1,
              ),
              decoration: InputDecoration(
                hintText: 'Masukkan username anda',
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

    Widget inputEmail() {
      return Container(
        margin: EdgeInsets.only(
          top: defaultMargin,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Email',
              style: primaryTextStyle.copyWith(
                fontSize: 14,
                fontWeight: bold,
                color: cardColor,
              ),
            ),
            TextFormField(
              controller: emailController,
              style: secondaryTextStyle.copyWith(
                color: backgroundColor1,
              ),
              decoration: InputDecoration(
                hintText: 'Masukkan email anda',
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
              decoration: const BoxDecoration(
                shape: BoxShape.circle,
                image: DecorationImage(
                  fit: BoxFit.fill,
                  image: AssetImage('assets/image_profile.png'),
                  // image: NetworkImage(user.profilePhotoUrl!),
                ),
              ),
            ),
            const SizedBox(height: 10),
            inputNama(),
            inputUsername(),
            inputEmail(),
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
          icon: const Icon(Icons.close),
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
            onPressed: handleUpdateProfile,
            icon: const Icon(Icons.check),
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
