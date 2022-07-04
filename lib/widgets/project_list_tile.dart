import 'package:ecommerce/models/product_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

class ProductListTile extends StatelessWidget {
  final Product product;
  final Function()? onPressed;
  final Function() onDelete;
  const ProductListTile(
      {required this.product, required this.onDelete, this.onPressed, Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    return Slidable(
        key: const ValueKey(0),
        endActionPane: ActionPane(motion: const ScrollMotion(), children: [
          SlidableAction(
            // An action can be bigger than the others.
            onPressed: (e) {
              onDelete();
            },
            backgroundColor: const Color(0xFFFE4A49),
            foregroundColor: Colors.white,
            icon: Icons.delete,
            label: 'Delete',
          ),
        ]),
        child: GestureDetector(
          onTap: () {
            if (onPressed != null) {
              onPressed!();
            }
          },
          child: Container(
            width: screenSize.width,
            height: 75,
            padding: const EdgeInsets.all(15),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(12.5),
              boxShadow: [
                BoxShadow(
                    offset: const Offset(10, 20),
                    blurRadius: 10,
                    spreadRadius: 0,
                    color: Colors.grey.withOpacity(.05)),
              ],
            ),
            child: Row(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(8),
                  child: Image.network(
                    product.imageUrl,
                    height: 59,
                    fit: BoxFit.cover,
                  ),
                ),
                const SizedBox(
                  width: 15,
                ),
                SizedBox(
                  width: screenSize.width / 2.35,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(product.name,
                          style: const TextStyle(
                              color: Colors.black,
                              fontSize: 16,
                              fontWeight: FontWeight.bold)),
                      Text(product.description,
                          maxLines: 1,
                          textAlign: TextAlign.center,
                          style: const TextStyle(
                              overflow: TextOverflow.ellipsis,
                              color: Colors.grey,
                              fontSize: 12))
                    ],
                  ),
                ),
                const Spacer(),
                Text("\$${product.price.toString()}",
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                        fontSize: 12,
                        color: Colors.grey,
                        fontWeight: FontWeight.normal)),
              ],
            ),
          ),
        ));
  }
}
