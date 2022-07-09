import 'package:ecommerce/app/providers.dart';
import 'package:ecommerce/widgets/empty_widge.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class UserBag extends ConsumerWidget {
  const UserBag({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context, ref) {
    final bagViewModel = ref.watch(bagProvider);
    return Scaffold(
      body: SafeArea(
          child: Padding(
        padding: const EdgeInsets.all(10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                IconButton(
                  icon: const Icon(Icons.arrow_back),
                  onPressed: () {
                    Navigator.pop(context); //. Go back a screen
                  },
                ),
                const Flexible(
                  child: Text(
                    "My Bag",
                    style: TextStyle(color: Colors.black, fontSize: 18),
                  ),
                ),
              ],
            ),
            Flexible(
                child: bagViewModel.isEmpty
                    ? const EmptyWidget()
                    : ListView.builder(
                        itemCount: bagViewModel.totalProducts,
                        itemBuilder: ((context, index) {
                          final product = bagViewModel.productsBag[index];
                          return ListTile(
                            title: Text(product.name),
                            subtitle: Text("\$${product.price}"),
                            trailing: IconButton(
                              icon: const Icon(Icons.delete),
                              onPressed: () {
                                bagViewModel.removeProduct(product);
                              },
                            ),
                          );
                        }))),
            Align(
              alignment: Alignment.bottomCenter,
              child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Total: \$${bagViewModel.total.toStringAsFixed(2)}",
                      style: const TextStyle(
                          fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                    ElevatedButton(
                        onPressed: () async {
                          final payment = ref.read(paymentProvider);
                          final user = ref.read(authStateChangesProvider);
                          final userBag = ref.watch(bagProvider);

                          final result = await payment.initPaymentSheet(
                              user.value!, userBag.total);

                          if (!result.isError) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                  content: Text('Payment completed!')),
                            );
                            ref.watch(databaseProvider)!.saveOrder(
                                result.payIntentId!, userBag.productsBag);
                            userBag.clearBag();
                            Navigator.pop(context);
                          } else {
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text(result.message),
                              ),
                            );
                          }
                        },
                        child: const Text("Checkout")),
                  ]),
            )
          ],
        ),
      )),
    );
  }
}