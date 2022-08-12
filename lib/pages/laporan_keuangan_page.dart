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
    start: DateTime.now().subtract(Duration(days: 30)),
    end: DateTime.now(),
  );

  @override
  Widget build(BuildContext context) {
    final startDate = dateRange.start;
    final endDate = dateRange.end;
    TransactionProvider transactionProvider =
        Provider.of<TransactionProvider>(context);

    final filteredTransactions = transactionProvider.transactionsBetweenDates(
        start: startDate, end: endDate);
    double gainLossTotal =
        transactionProvider.gainLoss(transactions: filteredTransactions);

    _formatCurrency(double value) {
      return NumberFormat.currency(
              locale: 'id', decimalDigits: 0, symbol: 'Rp ')
          .format(value);
    }

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
            TextButton.icon(
              icon: Icon(
                Icons.calendar_month,
                color: primaryColor,
              ),
              style: TextButton.styleFrom(
                primary: primaryColor.withOpacity(0.25),
                side: BorderSide(color: primaryColor),
              ),
              onPressed: pickDateRange,
              label: Text(
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
            TextButton.icon(
              icon: Icon(
                Icons.calendar_month,
                color: primaryColor,
              ),
              style: TextButton.styleFrom(
                primary: primaryColor.withOpacity(0.25),
                side: BorderSide(color: primaryColor),
              ),
              onPressed: pickDateRange,
              label: Text(
                DateFormat('dd/MM/yyy').format(endDate),
                style: TextStyle(color: Colors.black87),
              ),
            )
          ],
        ),
      );
    }

    Widget box({String text = '', required Color? color}) {
      return Container(
        width: double.infinity,
        padding: EdgeInsets.symmetric(vertical: 20),
        decoration: BoxDecoration(
          color: color!,
        ),
        child: Text(
          text,
          textAlign: TextAlign.center,
        ),
      );
    }

    Widget transactionListHeader() {
      return Container(
        margin: EdgeInsets.only(top: defaultMargin),
        child: Row(
          children: [
            Expanded(flex: 2, child: box(text: 'Transaksi', color: thirdColor)),
            Expanded(flex: 1, child: box(text: 'Pemasukan', color: thirdColor)),
            Expanded(
                flex: 1, child: box(text: 'Pengeluaran', color: thirdColor)),
          ],
        ),
      );
    }

    Widget transactionsList() {
      return ListView(
        shrinkWrap: true,
        children: [
          Row(
            children: [
              Expanded(
                flex: 2,
                child: Column(
                  children: filteredTransactions
                      .map((transaction) => box(
                          color: thirdTextColor.withOpacity(0.25),
                          text: transaction.note!))
                      .toList(),
                ),
              ),
              Expanded(
                flex: 1,
                child: Column(
                  children: filteredTransactions.map((transaction) {
                    if (transaction.type == 'PEMASUKAN') {
                      return box(
                          text: _formatCurrency(transaction.total!),
                          color: pemasukanColor.withOpacity(0.25));
                    } else {
                      return box(color: pemasukanColor.withOpacity(0.25));
                    }
                  }).toList(),
                ),
              ),
              Expanded(
                flex: 1,
                child: Column(
                  children: filteredTransactions.map((transaction) {
                    if (transaction.type == 'PENGELUARAN') {
                      return box(
                          text: _formatCurrency(transaction.total!),
                          color: pengeluaranColor.withOpacity(0.25));
                    } else {
                      return box(color: pengeluaranColor.withOpacity(0.25));
                    }
                  }).toList(),
                ),
              ),
            ],
          ),
        ],
      );
    }

    Widget summaryCard() {
      return Container(
        width: 340,
        height: 160,
        margin: const EdgeInsets.only(
          top: 20,
        ),
        padding: const EdgeInsets.symmetric(
          horizontal: 20,
          vertical: 15,
        ),
        decoration: BoxDecoration(
          color: cardColor,
          borderRadius: BorderRadius.circular(15),
        ),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Column(
                  children: [
                    Text(
                      'Total Penjualan',
                      style: primaryTextStyle.copyWith(
                        fontSize: 12,
                      ),
                    ),
                    const SizedBox(height: 7),
                    Text(
                      _formatCurrency(transactionProvider.total(
                          type: 'PEMASUKAN',
                          transactions: filteredTransactions)),
                      style: primaryTextStyle.copyWith(
                        color: pemasukanColor,
                        fontSize: 14,
                        fontWeight: bold,
                      ),
                    ),
                  ],
                ),
                Container(
                  height: 65,
                  width: 1,
                  decoration: BoxDecoration(
                    color: primaryTextColor.withOpacity(0.5),
                  ),
                ),
                Column(
                  children: [
                    Text(
                      'Total Pengeluaran',
                      style: primaryTextStyle.copyWith(
                        fontSize: 12,
                      ),
                    ),
                    const SizedBox(height: 7),
                    Text(
                      _formatCurrency(transactionProvider.total(
                          type: 'PENGELUARAN',
                          transactions: filteredTransactions)),
                      style: primaryTextStyle.copyWith(
                        color: pengeluaranColor,
                        fontSize: 14,
                        fontWeight: bold,
                      ),
                    ),
                  ],
                ),
              ],
            ),
            const SizedBox(height: 8),
            Container(
              padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 35),
              width: double.infinity,
              height: 50,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15),
                color: gainLossTotal.isNegative
                    ? pengeluaranColor.withOpacity(0.25)
                    : pemasukanColor.withOpacity(0.25),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    gainLossTotal.isNegative ? 'Rugi' : 'Untung',
                    style: primaryTextStyle.copyWith(
                      fontSize: 16,
                      fontWeight: bold,
                      color: gainLossTotal.isNegative
                          ? pengeluaranColor
                          : pemasukanColor,
                    ),
                  ),
                  Text(
                    _formatCurrency(gainLossTotal.abs()),
                    style: primaryTextStyle.copyWith(
                      fontSize: 16,
                      fontWeight: bold,
                      color: gainLossTotal.isNegative
                          ? pengeluaranColor
                          : pemasukanColor,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      );
    }

    Widget content() {
      return Column(
        children: [
          summaryCard(),
          dateRangePicker(),
          filteredTransactions.isNotEmpty
              ? Column(
                  children: [
                    transactionListHeader(),
                    const Divider(height: 2),
                    transactionsList(),
                  ],
                )
              : Container(
                  margin: EdgeInsets.only(top: defaultMargin * 2),
                  child: Text(
                    'There\'s no transactions \nbetween those dates :(',
                    style: primaryTextStyle.copyWith(
                      color: Colors.black38,
                      fontSize: 20,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
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
            color: backgroundColor1,
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
