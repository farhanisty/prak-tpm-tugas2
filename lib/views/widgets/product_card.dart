import 'package:belajar_getx/controllers/cart_controller.dart';
import 'package:flutter/material.dart';
import '../../models/product.dart';
import 'package:get/get.dart';

class ProductCard extends StatelessWidget {
  ProductCard({super.key, required this.product, required this.onTap});

  final Product product;
  final VoidCallback onTap;

  final CartController cartController = Get.find<CartController>();

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Card(
        color: Colors.blueGrey,
        elevation: 3,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        child: Column(
          children: [
            Flexible(
              flex: 2,
              child: Stack(
                children: [
                  Positioned.fill(
                    child: Image.network(
                      product.images[0],
                      fit: BoxFit.contain,
                      loadingBuilder: (
                        context,
                        child,
                        loadingProgress,
                      ) {
                        if (loadingProgress == null) return child;

                        return const Center(
                          child: CircularProgressIndicator(
                            color: Colors.white,
                          ),
                        );
                      },
                    ),
                  ),
                  Positioned(
                    top: 8,
                    right: 8,
                    child: CircleAvatar(
                      backgroundColor: Colors.white,
                      child: Obx(() => IconButton(
                        onPressed: () {
                          if(!cartController.isProductInCart(product.id)) {
                            cartController.addCart(product);

                            Get.snackbar(
                              'Cart',
                              '${product.title} added to cart',
                              snackPosition: SnackPosition.BOTTOM,
                              duration: const Duration(seconds: 2),
                            );
                          } else {
                            cartController.deleteCartById(product.id);

                            Get.snackbar(
                              'Cart',
                              '${product.title} removed from cart',
                              snackPosition: SnackPosition.BOTTOM,
                              duration: const Duration(seconds: 2),
                            );
                          }
                        },
                        icon: Icon(
                          (cartController.isProductInCart(product.id)) ? Icons.shopping_cart : Icons.shopping_cart_outlined,
                          color: Colors.black,
                        ),
                      )
                      ),
                    ),
                  ),
                ],
              ),
            ),

            Flexible(
              child: Container(
                width: double.infinity,
                decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(10),
                    bottomRight: Radius.circular(10),
                  ),
                ),
                padding: const EdgeInsets.all(8),
                child: Column(
                  mainAxisAlignment:
                      MainAxisAlignment.spaceBetween,
                  crossAxisAlignment:
                      CrossAxisAlignment.stretch,
                  children: [
                    Text(
                      product.title,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 14,
                      ),
                    ),

                    Text('\$${product.price}'),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}