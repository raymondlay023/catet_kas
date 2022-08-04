import 'package:catet_kas/models/transaction_model.dart';
import 'package:catet_kas/providers/shop_provider.dart';
import 'package:catet_kas/providers/transaction_provider.dart';
import 'package:catet_kas/theme.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:dotted_line/dotted_line.dart';
import 'package:shared_preferences/shared_preferences.dart';

class DetailTransaksiPage extends StatelessWidget {
  // const DetailTransaksiPage({Key? key}) : super(key: key);
  final TransactionModel transaction;
  const DetailTransaksiPage({required this.transaction});
  @override
  Widget build(BuildContext context) {
    ShopProvider shopProvider = Provider.of<ShopProvider>(context);
    TransactionProvider transactionProvider =
        Provider.of<TransactionProvider>(context);

    Widget verticalDivider(double height) {
      return Container(
        height: height,
        width: 1,
        decoration: BoxDecoration(
          color: primaryTextColor.withOpacity(0.5),
        ),
      );
    }

    Widget content() {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: defaultMargin),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Column(
                children: [
                  Text(
                    '${shopProvider.shop.name}',
                    style: primaryTextStyle.copyWith(
                      fontWeight: bold,
                      fontSize: 18,
                    ),
                  ),
                  Text(
                    '${shopProvider.shop.phoneNumber}',
                    style: primaryTextStyle.copyWith(
                      fontSize: 15,
                      color: Colors.black.withOpacity(0.5),
                    ),
                  ),
                ],
              )
            ],
          ),
          SizedBox(height: defaultMargin),
          Text(DateFormat('EEEE, MMM d, yyyy').format(transaction.createdAt!)),
          SizedBox(height: 10),
          const DottedLine(),
          SizedBox(height: defaultMargin / 2),
          Row(
            children: [
              Expanded(
                flex: 3,
                child: Text(
                  'Nama Barang',
                  textAlign: TextAlign.center,
                  style: primaryTextStyle.copyWith(
                    color: Colors.black45,
                    fontSize: 16,
                  ),
                ),
              ),
              Expanded(
                flex: 1,
                child: Text(
                  'Jumlah',
                  textAlign: TextAlign.center,
                  style: primaryTextStyle.copyWith(
                    color: Colors.black45,
                    fontSize: 16,
                  ),
                ),
              ),
              Expanded(
                flex: 2,
                child: Text(
                  'Total',
                  textAlign: TextAlign.center,
                  style: primaryTextStyle.copyWith(
                    color: Colors.black45,
                    fontSize: 16,
                  ),
                ),
              ),
            ],
          ),
          Divider(
            thickness: 0.5,
            color: primaryTextColor.withOpacity(0.5),
          ),
          SizedBox(height: 10),
          Row(
            children: [
              Expanded(
                flex: 3,
                child: Column(
                  children: transaction.items!
                      .map((item) => Column(
                            children: [
                              Text('${item['product']['name']}'),
                              Text('Rp. ${item['product']['price']} / item',
                                  style: TextStyle(color: Colors.black38)),
                              SizedBox(height: 10),
                            ],
                          ))
                      .toList(),
                ),
              ),
              Expanded(
                flex: 1,
                child: Column(
                  children: transaction.items!
                      .map((item) => Column(
                            children: [
                              Text('${item['quantity']}'),
                              SizedBox(height: 25),
                            ],
                          ))
                      .toList(),
                ),
              ),
              Expanded(
                flex: 2,
                child: Column(
                  children: transaction.items!
                      .map((item) => Column(
                            children: [
                              Text(
                                  'Rp. ${item['product']['price'] * item['quantity']}'),
                              SizedBox(height: 25),
                            ],
                          ))
                      .toList(),
                ),
              ),
            ],
          ),
          SizedBox(height: defaultMargin / 2),
          const DottedLine(),
          SizedBox(
            height: 20,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                width: 15,
              ),
              Expanded(
                flex: 2,
                child: Text(
                  'Total Transaksi',
                  style: TextStyle(fontWeight: bold, fontSize: 16),
                  // textAlign: TextAlign.center,
                ),
              ),
              Expanded(
                flex: 1,
                child: Text(
                  'Rp. ${transaction.total}',
                  style: TextStyle(fontSize: 15),
                  textAlign: TextAlign.center,
                ),
              ),
            ],
          ),
          SizedBox(height: defaultMargin),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              SizedBox(
                width: 15,
              ),
              Text(
                'Catatan :',
                style: TextStyle(fontSize: 15, fontWeight: bold),
                // textAlign: TextAlign.center,
              ),
            ],
          ),
          SizedBox(height: 10),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              SizedBox(
                width: 15,
              ),
              Text(
                '${transaction.note}',
                style: primaryTextStyle.copyWith(
                    fontSize: 15, color: Colors.black45),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ],
      );
    }

    handleDeleteTransaction() async {
      final prefs = await SharedPreferences.getInstance();
      final token = prefs.getString('token');

      if (await transactionProvider.delete(
        token: token!,
        id: transaction.id!,
      )) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          backgroundColor: pemasukanColor,
          content: const Text(
            'Transaksi berhasil dihapus!',
            textAlign: TextAlign.center,
          ),
        ));
        Navigator.pop(context);
      } else {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          backgroundColor: alertColor,
          content: const Text(
            'Transaksi gagal dihapus!',
            textAlign: TextAlign.center,
          ),
        ));
      }
    }

    PreferredSizeWidget customAppBar() {
      return AppBar(
        toolbarHeight: 75,
        title: Text(
          'Detail Transaksi',
          style: primaryTextStyle.copyWith(
            fontSize: 20,
            color: cardColor,
          ),
        ),
        backgroundColor: primaryColor,
        actions: [
          IconButton(
            splashRadius: 25,
            icon: Icon(
              Icons.mode_edit,
              color: cardColor,
            ),
            onPressed: () {},
          ),
          IconButton(
            splashRadius: 25,
            icon: Icon(
              Icons.delete,
              color: cardColor,
            ),
            onPressed: handleDeleteTransaction,
          ),
        ],
      );
    }

    return Scaffold(
      appBar: customAppBar(),
      body: SingleChildScrollView(
        child: content(),
        padding: EdgeInsets.all(15),
      ),
    );
  }
}
