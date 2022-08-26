import 'package:catet_kas/models/shop_model.dart';
import 'package:catet_kas/models/transaction_item_model.dart';
import 'package:catet_kas/models/transaction_model.dart';
import 'package:catet_kas/models/user_model.dart';
import 'package:catet_kas/providers/auth_provider.dart';
import 'package:catet_kas/providers/shop_provider.dart';
import 'package:catet_kas/providers/transaction_provider.dart';
import 'package:catet_kas/theme.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:month_year_picker/month_year_picker.dart';
import 'package:provider/provider.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class HomePage extends StatefulWidget {
  @override
  State<HomePage> createState() => _HomePageState();
}

DateTime selectedMonthYear = DateTime.now();

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    AuthProvider authProvider = Provider.of<AuthProvider>(context);
    ShopProvider shopProvider = Provider.of<ShopProvider>(context);
    TransactionProvider transactionProvider =
        Provider.of<TransactionProvider>(context);

    List<TransactionItemModel> allItems = [];
    List<TransactionModel> filteredTransactions = transactionProvider
        .transactions
        .where((transaction) =>
            transaction.createdAt!.month == selectedMonthYear.month)
        .toList();
    for (var transaction in filteredTransactions) {
      var items = transaction.items!.map(
        (item) => item,
      );
      allItems.addAll(items.map((item) => TransactionItemModel.fromJson(item)));
    }

    List<_ChartData> data = [];
    allItems.forEach((element) {
      data.add(_ChartData(
          name: element.product!.name!, quantity: element.quantity!));
    });

    _chartDataExist(_ChartData chartData) {
      return data.indexOf(chartData);
    }

    _formatCurrency(double value) {
      return NumberFormat.currency(
              locale: 'id', decimalDigits: 0, symbol: 'Rp ')
          .format(value);
    }

    UserModel user = authProvider.user;
    ShopModel shop = shopProvider.shop;

    Future<void> handleMonthPicker() async {
      DateTime? selected = await showMonthYearPicker(
        context: context,
        initialDate: selectedMonthYear,
        firstDate: DateTime(1900),
        lastDate: DateTime(2100),
      );

      if (selected != null) {
        setState(() {
          selectedMonthYear = selected;
        });
      }
    }

    Widget profileCard() {
      return Container(
        margin: EdgeInsets.only(top: defaultMargin),
        padding: const EdgeInsets.all(20),
        height: 160,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
          color: primaryColor,
        ),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Halo, ${user.name} !',
                      style: primaryTextStyle.copyWith(
                        fontSize: 20,
                        fontWeight: bold,
                        color: backgroundColor1,
                      ),
                    ),
                    SizedBox(height: 5),
                    Text(
                      '@${user.username}',
                      style: primaryTextStyle.copyWith(
                        fontSize: 16,
                        color: backgroundColor1.withOpacity(0.75),
                      ),
                    ),
                  ],
                ),
                CircleAvatar(
                  backgroundImage: AssetImage('assets/image_profile.png'),
                  // backgroundImage: NetworkImage(user.profilePhotoUrl!),
                  radius: 30,
                ),
              ],
            ),
            const SizedBox(height: 20),
            Container(
              width: 240,
              height: 40,
              padding: const EdgeInsets.all(10),
              alignment: Alignment.center,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(25),
                color: backgroundColor1,
              ),
              child: Text(
                shop.name!,
                style: primaryTextStyle.copyWith(
                  fontSize: 16,
                  color: primaryColor,
                ),
              ),
            ),
          ],
        ),
      );
    }

    Widget ringkasanBulananHeader() {
      return Container(
        alignment: Alignment.center,
        margin: const EdgeInsets.only(
          top: 20,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Ringkasan Bulanan',
              style: primaryTextStyle.copyWith(fontSize: 20),
            ),
            Container(
              width: 100,
              height: 35,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15),
                border: Border.all(color: backgroundColor4),
              ),
              child: TextButton(
                style: TextButton.styleFrom(primary: primaryColor),
                onPressed: handleMonthPicker,
                child: Text(
                  DateFormat('MMMM').format(selectedMonthYear),
                  style: primaryTextStyle.copyWith(
                    color: backgroundColor4,
                  ),
                ),
              ),
            ),
          ],
        ),
      );
    }

    Widget ringkasanBulananCard() {
      return Container(
        width: 360,
        height: 80,
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
        child: Row(
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
                      type: 'PEMASUKAN', date: selectedMonthYear)),
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
                      type: 'PENGELUARAN', date: selectedMonthYear)),
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
      );
    }

    Widget barChart() {
      return Container(
        margin: EdgeInsets.only(
          top: 20,
          bottom: defaultMargin,
        ),
        padding: const EdgeInsets.only(
          top: 20,
          left: 5,
          right: 5,
        ),
        child: Column(
          children: [
            Text(
              'Barang yang paling \nsering dibeli',
              style: primaryTextStyle.copyWith(fontSize: 18),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 20),
            SfCartesianChart(
              primaryXAxis: CategoryAxis(),
              // Enable legend
              legend: Legend(isVisible: true, position: LegendPosition.bottom),
              // Enable tooltip
              tooltipBehavior: TooltipBehavior(enable: true),
              series: <ChartSeries<dynamic, String>>[
                ColumnSeries<dynamic, String>(
                  color: primaryColor,
                  gradient: LinearGradient(
                    colors: <Color>[secondaryColor, primaryColor],
                    begin: Alignment.bottomLeft,
                    end: Alignment.topRight,
                  ),
                  dataSource: data,
                  xValueMapper: (dynamic item, _) => item.name,
                  yValueMapper: (dynamic item, _) => item.quantity,
                  name: 'Jumlah barang dari setiap produk',
                  // Enable data label`
                  // dataLabelSettings: const DataLabelSettings(isVisible: true),
                )
              ],
            ),
          ],
        ),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
          color: cardColor,
        ),
      );
    }

    return Scaffold(
      backgroundColor: backgroundColor1,
      body: SingleChildScrollView(
        child: SafeArea(
          child: Container(
            alignment: Alignment.center,
            margin: EdgeInsets.symmetric(
              horizontal: defaultMargin,
            ),
            child: Column(
              children: [
                profileCard(),
                ringkasanBulananHeader(),
                ringkasanBulananCard(),
                barChart(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _ChartData {
  String name;
  int quantity;

  _ChartData({required this.name, required this.quantity});
}
