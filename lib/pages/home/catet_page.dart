import 'package:catet_kas/providers/transaction_provider.dart';
import 'package:catet_kas/theme.dart';
import 'package:catet_kas/widgets/transaction_card.dart';
import 'package:flutter/material.dart';
import 'package:grouped_list/grouped_list.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CatetPage extends StatefulWidget {
  const CatetPage({Key? key}) : super(key: key);
  @override
  State<CatetPage> createState() => _CatetPageState();
}

class _CatetPageState extends State<CatetPage> {
  late Future<dynamic> dataFuture;
  final cariController = TextEditingController(text: '');
  @override
  void initState() {
    super.initState();
    dataFuture = getData();
  }

  Future<dynamic> getData() async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('token');
    await Provider.of<TransactionProvider>(context, listen: false)
        .getTransactions(token!);
    return TransactionProvider().transactions;
  }

  @override
  Widget build(BuildContext context) {
    TransactionProvider transactionProvider =
        Provider.of<TransactionProvider>(context);

    double gainLossTotal = transactionProvider.gainLoss();

    _formatCurrency(double value) {
      return NumberFormat.currency(
              locale: 'id', decimalDigits: 0, symbol: 'Rp ')
          .format(value);
    }

    Widget emptyState() {
      return Container(
        margin: EdgeInsets.only(top: defaultMargin * 2),
        child: Center(
          child: Text(
            'Belum ada transaksi \nyang dicatat :(',
            style: primaryTextStyle.copyWith(
              fontSize: 22,
              color: Colors.black.withOpacity(0.2),
            ),
            textAlign: TextAlign.center,
          ),
        ),
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
                      _formatCurrency(transactionProvider.totalTransaksi(
                          type: 'PEMASUKAN')),
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
                      _formatCurrency(transactionProvider.totalTransaksi(
                          type: 'PENGELUARAN')),
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

    Widget laporanKeuanganButton() {
      return Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            width: 180,
            height: 50,
            margin: const EdgeInsets.only(top: 15),
            decoration: BoxDecoration(
              border: Border.all(color: buttonColor),
              borderRadius: BorderRadius.circular(15),
            ),
            child: TextButton(
              style: TextButton.styleFrom(primary: buttonColor),
              onPressed: () =>
                  Navigator.pushNamed(context, '/laporan-keuangan'),
              child: Text(
                'Laporan Keuangan',
                style: primaryTextStyle.copyWith(
                  color: buttonColor,
                  fontWeight: bold,
                ),
              ),
            ),
          ),
        ],
      );
    }

    // void searchTransaction(String query) {
    //   final suggestion = transactionProvider.transactions.where((transaction) {
    //     final transactionNote = transaction.note!.toLowerCase();
    //     final input = query.toLowerCase();

    //     return transactionNote.contains(input);
    //   }).toList();
    //   setState(() {});
    // }

    Widget cari() {
      return Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            margin: const EdgeInsets.only(top: 15),
            height: 55,
            width: MediaQuery.of(context).size.width / 1.4,
            child: TextField(
              controller: cariController,
              decoration: InputDecoration(
                prefixIcon: const Icon(Icons.search),
                hintText: 'Cari transaksi',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(5),
                  borderSide: BorderSide(color: primaryTextColor),
                ),
              ),
              // onChanged: searchTransaction,
            ),
          ),
        ],
      );
    }

    Widget transactions() {
      return Container(
        width: MediaQuery.of(context).size.width,
        margin: const EdgeInsets.only(top: 10),
        padding: const EdgeInsets.all(15),
        decoration: BoxDecoration(borderRadius: BorderRadius.circular(15)),
        child: GroupedListView<dynamic, String>(
          shrinkWrap: true,
          separator: const Divider(height: 5),
          itemComparator: (item1, item2) => item1.note.compareTo(item2.note),
          groupComparator: (value1, value2) => value2.compareTo(value1),
          elements: transactionProvider.transactions,
          groupBy: (element) => element.createdAt.toString(),
          //header list transaksi
          groupHeaderBuilder: (value) => Column(
            children: [
              Container(
                width: 330,
                padding: const EdgeInsets.symmetric(vertical: 15),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: Colors.black.withAlpha(25),
                ),
                child: Row(
                  children: [
                    Expanded(
                      child: Container(
                        alignment: Alignment.center,
                        width: 115,
                        child: Text(
                          DateFormat('dd-MMM-yyyy').format(value.createdAt),
                          style: primaryTextStyle.copyWith(
                            fontWeight: semiBold,
                            fontSize: 14,
                            color: primaryTextColor,
                          ),
                        ),
                      ),
                    ),
                    Expanded(
                      child: Container(
                        alignment: Alignment.center,
                        width: 115,
                        child: Text(
                          _formatCurrency(transactionProvider
                              .gainLoss(date: value.createdAt)
                              .abs()),
                          style: primaryTextStyle.copyWith(
                            fontSize: 14,
                            fontWeight: semiBold,
                            color: transactionProvider
                                    .gainLoss(date: value.createdAt)
                                    .isNegative
                                ? alertColor
                                : pemasukanColor,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              // column transaksi
              Container(
                margin: const EdgeInsets.only(top: 7),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Text(
                      'Catatan',
                      style: primaryTextStyle.copyWith(
                        fontSize: 12,
                        color: Colors.black,
                      ),
                    ),
                    Text(
                      'Transaksi',
                      style: primaryTextStyle.copyWith(
                        fontSize: 12,
                        color: Colors.black,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          itemBuilder: (context, element) => TransactionCard(element),
        ),
      );
    }

    Widget content() {
      return ListView(
        padding: EdgeInsets.symmetric(horizontal: defaultMargin),
        children: [
          summaryCard(),
          laporanKeuanganButton(),
          // cari(),
          transactionProvider.transactions.isNotEmpty
              ? transactions()
              : emptyState(),
        ],
      );
    }

    Widget futureContent() {
      return SizedBox(
        width: double.infinity,
        child: FutureBuilder(
          future: dataFuture,
          builder: (context, snapshot) {
            switch (snapshot.connectionState) {
              case ConnectionState.waiting:
                return Center(
                    child: CircularProgressIndicator(
                  color: primaryColor,
                ));
              case ConnectionState.done:
              default:
                if (snapshot.hasError) {
                  return Center(child: Text('error : ${snapshot.error}'));
                } else if (snapshot.hasData) {
                  return content();
                } else {
                  return emptyState();
                }
            }
          },
        ),
      );
    }

    PreferredSizeWidget customAppBar() {
      return AppBar(
        automaticallyImplyLeading: false,
        toolbarHeight: 75,
        title: Text(
          'Transaksi',
          style: primaryTextStyle.copyWith(
            fontSize: 22,
            color: backgroundColor1,
          ),
        ),
        centerTitle: true,
        backgroundColor: primaryColor,
      );
    }

    Widget customFloatingActionButton() {
      return FloatingActionButton(
        onPressed: () => Navigator.pushNamed(context, '/catat-transaksi'),
        child: Icon(Icons.create_outlined),
        backgroundColor: buttonColor,
      );
    }

    return Scaffold(
      backgroundColor: backgroundColor1,
      appBar: customAppBar(),
      body: futureContent(),
      floatingActionButton: customFloatingActionButton(),
    );
  }
}
