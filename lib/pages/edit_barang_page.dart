import 'package:catet_kas/theme.dart';
import 'package:flutter/material.dart';

class EditBarang extends StatelessWidget {
  // const EditBarang({ Key? key }) : super(key: key);
//
  @override
  Widget build(BuildContext context) {
    Widget content() {
      return Column(
        children: [
          Container(
            margin: EdgeInsets.all(10),
          ),
        ],
      );
    }

    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: primaryColor,
        title: Text('Edit barang'),
      ),
      body: Container(
        margin: EdgeInsets.all(defaultMargin),
        padding: EdgeInsets.all(5),
      ),
    );
  }
}
