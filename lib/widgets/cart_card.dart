import 'package:catet_kas/models/cart_model.dart';
import 'package:catet_kas/providers/cart_provider.dart';
import 'package:catet_kas/theme.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CartCard extends StatelessWidget {
  // const CartCard({Key? key}) : super(key: key);

  final CartModel cart;
  CartCard({
    required this.cart,
  });
  @override
  Widget build(BuildContext context) {
    CartProvider cartProvider = Provider.of<CartProvider>(context);
    return Container(
      margin: EdgeInsets.only(top: defaultMargin),
      padding: EdgeInsets.symmetric(
        horizontal: 16,
        vertical: 10,
      ),
      decoration: BoxDecoration(
        color: backgroundColor1,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        children: [
          Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      cart.product.name!,
                      style: primaryTextStyle.copyWith(
                        fontWeight: semiBold,
                      ),
                    ),
                    Text('\$${cart.product.price}',
                        style: TextStyle(color: Colors.black)),
                  ],
                ),
              ),
              Column(
                children: [
                  GestureDetector(
                    onTap: cartProvider.addQuantity(cart.id),
                    child: Icon(Icons.add_circle_outline),
                  ),
                  SizedBox(height: 2),
                  Text(
                    cart.quantity.toString(),
                    style: primaryTextStyle.copyWith(
                      fontWeight: medium,
                    ),
                  ),
                  SizedBox(height: 2),
                  GestureDetector(
                    onTap: cartProvider.reduceQuantity(cart.id),
                    child: Icon(Icons.remove_circle_outline),
                  ),
                ],
              ),
            ],
          ),
          SizedBox(
            height: 12,
          ),
          GestureDetector(
            onTap: cartProvider.removeCart(cart.id),
            child: Row(
              children: [
                Image.asset(
                  'assets/icon_remove.png',
                  width: 10,
                ),
                SizedBox(width: 4),
                Text(
                  'Remove',
                  style: primaryTextStyle.copyWith(
                    fontSize: 12,
                    fontWeight: light,
                    color: alertColor,
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
