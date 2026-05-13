import 'package:belajar_getx/controllers/cart_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../controllers/product_controller.dart';
import '../../views/widgets/product_card.dart';

class ProductPage extends GetView<ProductController> {
  ProductPage({super.key});

  // // tidak boleh harusnya
  // final ProductController controller = Get.put(ProductController());
  final CartController cartController = Get.find<CartController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Product Home Page'),
        actions: [
          Obx(
            () => Stack(
              children: [
                IconButton(
                  onPressed: () {
                    Get.toNamed("/cart");
                  },
                  icon: const Icon(Icons.shopping_cart),
                ),
                  Positioned(
                    right: 5,
                    top: 5,
                    child: Container(
                      padding: const EdgeInsets.all(5),
                      decoration: const BoxDecoration(
                        color: Colors.red,
                        shape: BoxShape.circle,
                      ),
                      child: Text(
                        '${cartController.getAllCarts().length}',
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 12,
                        ),
                      ),
                    ),
                  ),
              ],
            ),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(12),
        child: Obx(() {
          if (controller.isLoading) {
            return const Center(
              child: CircularProgressIndicator(color: Colors.blueGrey),
            );
          }
          return GridView.builder(
            itemCount: controller.products.length,
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              crossAxisSpacing: 8,
              mainAxisSpacing: 8,
            ),
            itemBuilder: (context, index) {
              return ProductCard(
                product: controller.products[index],
                onTap: () {
                  Get.toNamed("/detail", arguments: controller.products[index]);
                },
              );
            },
          );
        }),
      ),
    );
  }
}
