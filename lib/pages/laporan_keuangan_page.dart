import 'package:catet_kas/models/transaction_model.dart';
import 'package:catet_kas/providers/transaction_provider.dart';
import 'package:catet_kas/theme.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class LaporanKeuanganPage extends StatefulWidget {
  @override
  State<LaporanKeuanganPage> createState() => _LaporanKeuanganPageState();
}

class _LaporanKeuanganPageState extends State<LaporanKeuanganPage> {
  // const LaporanKeuanganPage({Key? key}) : super(key: key);
  DateTimeRange dateRange = DateTimeRange(
    start: DateTime.now(),
    end: DateTime.now().add(Duration(days: 3)),
  );

  @override
  Widget build(BuildContext context) {
    final startDate = dateRange.start;
    final endDate = dateRange.end;
    TransactionProvider transactionProvider =
        Provider.of<TransactionProvider>(context);

    // var filteredTransactions = transactionProvider.transactions.

    Future pickDateRange() async {
      DateTimeRange? newDateRange = await showDateRangePicker(
        context: context,
        initialDateRange: dateRange,
        firstDate: DateTime(1900),
        lastDate: DateTime(2100),
      );

      if (newDateRange == null) return;

      setState(() => dateRange = newDateRange);
    }

    Widget dateRangePicker() {
      return Container(
        margin: EdgeInsets.only(top: defaultMargin),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              style: ElevatedButton.styleFrom(primary: buttonColor),
              onPressed: pickDateRange,
              child: Text(
                DateFormat('dd/MM/yyy').format(startDate),
                style: TextStyle(color: Colors.black87),
              ),
            ),
            Container(
              margin: EdgeInsets.symmetric(horizontal: 10),
              height: 2,
              width: 10,
              decoration: BoxDecoration(color: Colors.black),
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(primary: buttonColor),
              onPressed: pickDateRange,
              child: Text(
                DateFormat('dd/MM/yyy').format(endDate),
                style: TextStyle(color: Colors.black87),
              ),
            )
          ],
        ),
      );
    }

    final transactionFiltered = transactionProvider.transactionsBetweenDates(
        start: startDate, end: endDate);

    Widget transactionsList() {
      return Container(
        margin: EdgeInsets.only(top: defaultMargin),
        child: ListView(shrinkWrap: true, children: [
          Row(
            children: [
              Expanded(
                flex: 2,
                child: Container(
                  padding: EdgeInsets.symmetric(vertical: 20),
                  decoration: BoxDecoration(
                    color: Colors.black26,
                    border: Border.all(width: 1, color: Colors.black54),
                  ),
                  child: Column(
                    children: transactionFiltered
                        .map((transaction) => Text('${transaction.note}'))
                        .toList(),
                  ),
                ),
              ),
              Expanded(
                flex: 1,
                child: Container(
                  padding: EdgeInsets.symmetric(vertical: 20),
                  decoration: BoxDecoration(
                    color: pemasukanColor.withOpacity(0.7),
                    border: Border.all(
                      color: pemasukanColor,
                      width: 1,
                    ),
                  ),
                  child: Column(
                    children: transactionFiltered.map((transaction) {
                      if (transaction.type == 'PEMASUKAN') {
                        return Text('${transaction.total}');
                      } else {
                        return Text('');
                      }
                    }).toList(),
                  ),
                ),
              ),
              Expanded(
                flex: 1,
                child: Container(
                  padding: EdgeInsets.symmetric(vertical: 20),
                  decoration: BoxDecoration(
                    color: pengeluaranColor.withOpacity(0.7),
                    border: Border.all(
                      color: pengeluaranColor,
                      width: 1,
                    ),
                  ),
                  child: Column(
                    children: transactionFiltered.map((transaction) {
                      if (transaction.type == 'PENGELUARAN') {
                        return Text('${transaction.total}');
                      } else {
                        return Text('');
                      }
                    }).toList(),
                  ),
                ),
              ),
            ],
          ),
        ]),
      );
    }

    Widget content() {
      return Column(
        children: [
          dateRangePicker(),
          transactionsList(),
        ],
      );
    }

    PreferredSizeWidget customAppBar() {
      return AppBar(
        toolbarHeight: 75,
        title: Text(
          'Laporan Keuangan',
          style: primaryTextStyle.copyWith(
            fontSize: 20,
            color: cardColor,
          ),
        ),
        backgroundColor: primaryColor,
      );
    }

    return Scaffold(
      appBar: customAppBar(),
      body: content(),
    );
  }
}
