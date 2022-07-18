import 'package:catet_kas/models/product_model.dart';
import 'package:catet_kas/theme.dart';
import 'package:flutter/material.dart';

class ProductCard extends StatelessWidget {
  final ProductModel product;
  ProductCard(this.product);
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 300,
      alignment: Alignment.center,
      margin: EdgeInsets.symmetric(horizontal: defaultMargin),
      padding: EdgeInsets.symmetric(
        vertical: 20,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          // Checkbox(value: , onChanged: ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                product.name!,
                style: secondaryTextStyle.copyWith(
                  fontSize: 16,
                  fontWeight: bold,
                  color: primaryTextColor,
                ),
              ),
              SizedBox(height: 10),
              Text(
                'Rp. ${product.price}',
                style: secondaryTextStyle.copyWith(
                  fontSize: 12,
                  color: Colors.black.withOpacity(0.5),
                ),
              ),
            ],
          ),
          Row(
            children: [
              IconButton(
                splashRadius: 20,
                onPressed: () {},
                icon: Icon(Icons.indeterminate_check_box_outlined),
              ),
              Text(
                product.stock.toString(),
                style: secondaryTextStyle.copyWith(
                  fontSize: 12,
                  color: primaryTextColor,
                ),
              ),
              IconButton(
                splashRadius: 20,
                onPressed: () {},
                icon: Icon(Icons.add_box_outlined),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
