import 'package:ecommerce/app/pages/user/user_bag.dart';
import 'package:ecommerce/app/pages/user/user_orders.dart';
import 'package:flutter/material.dart';

class UserTopBar extends StatelessWidget {
  final IconButton leadingIconButton;
  const UserTopBar({required this.leadingIconButton, Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
      leadingIconButton,
      const Spacer(),
      IconButton(
          onPressed: () {
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => const UserOrders()));
          },
          icon: const Icon(Icons.menu)),
      IconButton(
          onPressed: () {
            Navigator.of(context).push(MaterialPageRoute(
              builder: (context) {
                return const UserBag();
              },
            ));
          },
          icon: const Icon(Icons.shopping_bag)),
    ]);
  }
}
