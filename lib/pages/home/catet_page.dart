import 'package:catet_kas/theme.dart';
import 'package:catet_kas/widgets/transaction_card.dart';
import 'package:catet_kas/widgets/transaction_summary_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';

class CatetPage extends StatefulWidget {
  const CatetPage({Key? key}) : super(key: key);

  @override
  State<CatetPage> createState() => _CatetPageState();
}

class _CatetPageState extends State<CatetPage> {
  @override
  Widget build(BuildContext context) {
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
        height: 150,
        margin: EdgeInsets.only(
          top: 20,
        ),
        padding: EdgeInsets.symmetric(
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
                    SizedBox(height: 7),
                    Text(
                      'Rp. 1.000.000',
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
                    SizedBox(height: 7),
                    Text(
                      'Rp. 500.000',
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
            SizedBox(height: 8),
            Container(
              padding: EdgeInsets.symmetric(vertical: 10, horizontal: 35),
              width: double.infinity,
              height: 40,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15),
                color: pemasukanColor.withOpacity(0.25),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Untung',
                    style: primaryTextStyle.copyWith(
                      fontSize: 12,
                      fontWeight: bold,
                      color: pemasukanColor,
                    ),
                  ),
                  Text(
                    'Rp. 500.000',
                    style: primaryTextStyle.copyWith(
                      fontSize: 12,
                      fontWeight: bold,
                      color: pemasukanColor,
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
      return Container(
        width: 180,
        height: 50,
        margin: EdgeInsets.only(top: 15),
        decoration: BoxDecoration(
          border: Border.all(color: buttonColor),
          borderRadius: BorderRadius.circular(15),
        ),
        child: TextButton(
          onPressed: () {},
          child: Text(
            'Laporan Keuangan',
            style: primaryTextStyle.copyWith(
              color: buttonColor,
              fontWeight: bold,
            ),
          ),
        ),
      );
    }

    Widget cari() {
      return Container(
        margin: EdgeInsets.only(top: 15),
        width: 320,
        height: 55,
        child: Row(
          children: [
            Container(
              height: 45,
              width: 230,
              padding: EdgeInsets.symmetric(
                horizontal: 10,
                vertical: 12,
              ),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(5),
                border: Border.all(
                  color: primaryTextColor,
                ),
              ),
              child: TextFormField(
                decoration: InputDecoration.collapsed(
                  hintText: 'Cari',
                ),
              ),
            ),
            SizedBox(
              width: 20,
            ),
            Container(
              height: 45,
              width: 70,
              decoration: BoxDecoration(
                color: buttonColor,
                borderRadius: BorderRadius.circular(5),
              ),
              child: TextButton(
                onPressed: () {},
                child: Text(
                  'Cari',
                  style: secondaryTextStyle.copyWith(
                    color: primaryTextColor,
                    fontWeight: bold,
                  ),
                ),
              ),
            ),
          ],
        ),
      );
    }

    Widget headerListTransaksi() {
      return Container(
        margin: EdgeInsets.only(top: 7),
        child: Row(
          children: [
            Container(
              alignment: Alignment.center,
              width: MediaQuery.of(context).size.width / 2,
              child: Text(
                'Catatan',
                style: primaryTextStyle.copyWith(
                  fontSize: 12,
                  color: Colors.black,
                ),
              ),
            ),
            Container(
              alignment: Alignment.center,
              width: MediaQuery.of(context).size.width / 2,
              child: Text(
                'Transaksi',
                style: primaryTextStyle.copyWith(
                  fontSize: 12,
                  color: Colors.black,
                ),
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
          laporanKeuanganButton(),
          cari(),
          TransactionSummary(
            tanggalCatat: '05 April 2023',
            selisihHarga: 125000,
          ),
          headerListTransaksi(),
          Divider(
            thickness: 1,
          ),
          Transaction(
            catatan: 'Penjualan barang a',
            harga: 65000,
            isPemasukan: true,
          ),
          Transaction(
            catatan: 'Pembelian stok',
            harga: 135000,
            isPemasukan: false,
          ),
          Transaction(
            catatan: 'Penjualan',
            harga: 195000,
            isPemasukan: true,
          ),
          TransactionSummary(
            tanggalCatat: '04 April 2023',
            selisihHarga: 56500,
          ),
          headerListTransaksi(),
          Divider(
            thickness: 1,
          ),
          Transaction(
            catatan: 'Jual rokok',
            harga: 65000,
            isPemasukan: true,
          ),
          Transaction(
            catatan: 'Bayar hutang',
            harga: 85000,
            isPemasukan: false,
          ),
          Transaction(
            catatan: '-',
            harga: 6500,
            isPemasukan: false,
          ),
        ],
      );
    }

    return Scaffold(
      backgroundColor: backgroundColor1,
      appBar: AppBar(
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
      ),
      body: ListView(
        children: [
          content(),
        ],
      ),
      floatingActionButton: SpeedDial(
        animatedIcon: AnimatedIcons.menu_close,
        activeLabel: Text('Catat'),
        animatedIconTheme: IconThemeData.fallback(),
        backgroundColor: buttonColor,
        overlayColor: Colors.black,
        overlayOpacity: 0.4,
        spacing: 10,
        children: [
          SpeedDialChild(
            onTap: () {
              Navigator.pushNamed(context, '/catat-pemasukan');
            },
            child: Icon(Icons.arrow_circle_down),
            label: 'Pemasukan',
            backgroundColor: pemasukanColor,
          ),
          SpeedDialChild(
            onTap: () {
              Navigator.pushNamed(context, '/catat-pengeluaran');
            },
            child: Icon(Icons.arrow_circle_up),
            label: 'Pengeluaran',
            backgroundColor: pengeluaranColor,
          ),
        ],
      ),
    );
  }
}
