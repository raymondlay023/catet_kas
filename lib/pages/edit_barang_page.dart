import 'package:catet_kas/theme.dart';
import 'package:flutter/material.dart';

class EditBarangPage extends StatelessWidget {
  // const EditBarangPage({ Key? key }) : super(key: key);
//
  @override
  Widget build(BuildContext context) {
    Widget content() {
      return Column(
        children: [
          Container(
            margin: const EdgeInsets.all(10),
          ),
        ],
      );
    }

    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: primaryColor,
        title: const Text('Edit barang'),
      ),
      body: Container(
        margin: EdgeInsets.all(defaultMargin),
        padding: const EdgeInsets.all(5),
      ),
    );
  }
}
