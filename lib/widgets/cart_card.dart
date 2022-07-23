import 'package:catet_kas/models/cart_model.dart';
import 'package:catet_kas/providers/cart_provider.dart';
import 'package:catet_kas/theme.dart';
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
      margin: const EdgeInsets.all(5),
      padding: const EdgeInsets.all(15),
      decoration: BoxDecoration(
        color: backgroundColor1,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              // Text(
              //   '${cart.quantity}x',
              //   style: primaryTextStyle.copyWith(
              //       color: primaryTextColor.withOpacity(0.5)),
              // ),
              SizedBox(width: 20),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      cart.product.name!,
                      style: primaryTextStyle.copyWith(
                        fontWeight: semiBold,
                        color: primaryTextColor,
                      ),
                    ),
                    Text(
                      'Rp.${cart.product.price}',
                      style: primaryTextStyle.copyWith(
                          color: primaryTextColor.withOpacity(0.5)),
                    ),
                  ],
                ),
              ),
              Row(
                children: [
                  IconButton(
                    padding: EdgeInsets.zero,
                    iconSize: 25,
                    splashRadius: 15,
                    onPressed: () => cartProvider.reduceQuantity(cart.id),
                    icon: const Icon(Icons.remove_circle_outline),
                  ),
                  Text('${cart.quantity}'),
                  IconButton(
                    padding: EdgeInsets.zero,
                    iconSize: 25,
                    splashRadius: 15,
                    onPressed: () => cartProvider.addQuantity(cart.id),
                    icon: const Icon(Icons.add_circle_outline),
                  ),
                ],
              ),
            ],
          ),
          TextButton.icon(
            onPressed: () => cartProvider.removeCart(cart.id),
            icon: Icon(Icons.delete, color: pengeluaranColor),
            label: Text('Remove', style: TextStyle(color: pengeluaranColor)),
          ),
        ],
      ),
    );
  }
}
