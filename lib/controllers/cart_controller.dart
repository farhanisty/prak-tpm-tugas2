import 'package:get/get.dart';
import 'package:belajar_getx/models/product.dart';

class CartController extends GetxController {
  final RxList<Product> _product = <Product>[].obs;
  List<Product> get products => _product;


  List<Product> getAllCarts() {
    return products;
  }

  void addCart(Product product) {
    _product.add(product);
  }

  void deleteCartById(int id) {
    _product.removeWhere((product) => product.id == id);
  }

  bool isProductInCart(int id) {
      return _product.any(
        (product) => product.id == id,
      );
  }

  double getTotalPrice() {
    double total = 0;

    for (final product in _product) {
      total += product.price;
    }

    return total;
  }
}