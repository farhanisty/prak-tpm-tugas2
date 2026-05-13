import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../controllers/cart_controller.dart';

class CartPage extends GetView<CartController> {
  const CartPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Cart"),
        centerTitle: true,
      ),

      body: Obx(
        () {
          if (controller.products.isEmpty) {
            return const Center(
              child: Text(
                "Cart is empty",
                style: TextStyle(fontSize: 18),
              ),
            );
          }

          return ListView.builder(
            padding: const EdgeInsets.all(12),
            itemCount: controller.products.length,
            itemBuilder: (context, index) {
              final product = controller.products[index];

              return Card(
                margin: const EdgeInsets.only(bottom: 12),
                elevation: 3,

                child: Padding(
                  padding: const EdgeInsets.all(12),

                  child: Row(
                    children: [
                      Container(
                        width: 90,
                        height: 90,
                        decoration: BoxDecoration(
                          color: Colors.blueGrey,
                          borderRadius:
                              BorderRadius.circular(10),
                        ),

                        child: ClipRRect(
                          borderRadius:
                              BorderRadius.circular(10),

                          child: Image.network(
                            product.images[0],
                            fit: BoxFit.contain,
                          ),
                        ),
                      ),

                      const SizedBox(width: 12),

                      Expanded(
                        child: Column(
                          crossAxisAlignment:
                              CrossAxisAlignment.start,

                          children: [
                            Text(
                              product.title,
                              maxLines: 2,
                              overflow:
                                  TextOverflow.ellipsis,

                              style: const TextStyle(
                                fontWeight:
                                    FontWeight.bold,
                                fontSize: 16,
                              ),
                            ),

                            const SizedBox(height: 8),

                            Text(
                              '\$${product.price}',
                              style: const TextStyle(
                                fontSize: 16,
                              ),
                            ),
                          ],
                        ),
                      ),

                      IconButton(
                        onPressed: () {
                          controller.deleteCartById(
                            product.id,
                          );

                          Get.snackbar(
                            "Cart",
                            "${product.title} removed",
                            snackPosition:
                                SnackPosition.BOTTOM,
                          );
                        },

                        icon: const Icon(
                          Icons.delete,
                          color: Colors.red,
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          );
        },
      ),

      bottomNavigationBar: Obx(
        () => Container(
          padding: const EdgeInsets.all(16),

          decoration: const BoxDecoration(
            color: Colors.white,

            boxShadow: [
              BoxShadow(
                blurRadius: 5,
                color: Colors.black12,
              ),
            ],
          ),

          child: Row(
            mainAxisAlignment:
                MainAxisAlignment.spaceBetween,

            children: [
              Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment:
                    CrossAxisAlignment.start,

                children: [
                  const Text(
                    "Total Price",
                    style: TextStyle(
                      color: Colors.grey,
                    ),
                  ),

                  Text(
                    '\$${controller.getTotalPrice().toStringAsFixed(2)}',

                    style: const TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),

              ElevatedButton(
                onPressed: () {},

                child: const Text("Checkout"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
