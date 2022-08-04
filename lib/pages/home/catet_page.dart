import 'package:catet_kas/providers/transaction_provider.dart';
import 'package:catet_kas/theme.dart';
import 'package:catet_kas/widgets/transaction_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
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

    Widget emptyState() {
      return Container(
        margin: EdgeInsets.symmetric(
          horizontal: defaultMargin,
        ),
        child: Center(
          child: Text(
            'Belum ada transaksi yang dicatat :(',
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
                      'Rp. ${transactionProvider.totalTransaksi('PEMASUKAN')}',
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
                      'Rp. ${transactionProvider.totalTransaksi('PENGELUARAN')}',
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
                    'Rp. ${gainLossTotal.abs()}',
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
                padding: const EdgeInsets.all(15),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: Colors.black.withAlpha(25),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      alignment: Alignment.center,
                      width: 115,
                      child: Text(
                        DateFormat('dd-MMM-yyyy').format(value.createdAt),
                        style: primaryTextStyle.copyWith(
                          fontSize: 14,
                          color: primaryTextColor,
                        ),
                      ),
                    ),
                    Container(
                      alignment: Alignment.center,
                      width: 115,
                      child: Text(
                        'Rp. ${transactionProvider.gainLoss(value.createdAt).abs()}',
                        style: primaryTextStyle.copyWith(
                          fontSize: 14,
                          color: transactionProvider
                                  .gainLoss(value.createdAt)
                                  .isNegative
                              ? alertColor
                              : pemasukanColor,
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

    Widget transactionList() {
      return SizedBox(
        width: double.infinity,
        height: MediaQuery.of(context).size.width / 1.3,
        child: FutureBuilder(
          future: dataFuture,
          builder: (context, snapshot) {
            switch (snapshot.connectionState) {
              case ConnectionState.waiting:
                return const Center(child: CircularProgressIndicator());
              case ConnectionState.done:
              default:
                if (snapshot.hasError) {
                  return const Center(child: Text('error :'));
                } else if (snapshot.hasData) {
                  return transactions();
                } else {
                  return const Text('something went wrong!');
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
            color: cardColor,
          ),
        ),
        centerTitle: true,
        backgroundColor: primaryColor,
      );
    }

    Widget customFloatingButton() {
      return SpeedDial(
        animatedIcon: AnimatedIcons.menu_close,
        activeLabel: const Text('Catat'),
        animatedIconTheme: const IconThemeData.fallback(),
        backgroundColor: buttonColor,
        overlayColor: Colors.black,
        overlayOpacity: 0.4,
        spacing: 10,
        children: [
          SpeedDialChild(
            onTap: () {
              Navigator.pushNamed(context, '/catat-transaksi');
            },
            child: const Icon(Icons.create_outlined),
            label: 'Catat Transaksi',
            backgroundColor: pemasukanColor,
          ),
        ],
      );
    }

    return Scaffold(
      backgroundColor: backgroundColor1,
      appBar: customAppBar(),
      body: ListView(
        padding: EdgeInsets.symmetric(horizontal: defaultMargin),
        children: [
          summaryCard(),
          laporanKeuanganButton(),
          // cari(),
          transactionList(),
        ],
      ),
      floatingActionButton: customFloatingButton(),
    );
  }
}
