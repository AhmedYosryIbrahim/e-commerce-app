import 'package:hive/hive.dart';

abstract class CartLocalDataSource {
  Future<void> addProductToCart(List<dynamic> product);
  Future<void> deleteProductFromCart(int id);
  Future<List<dynamic>> getCartProducts();
}

class CartLocalDataSourceImpl implements CartLocalDataSource {
  final cartBox = Hive.box('userData');

  @override
  Future<void> addProductToCart(List<dynamic> product) async {
    await cartBox.put('cart', product);
  }

  @override
  Future<void> deleteProductFromCart(int id) async {
    cartBox.delete(id);
  }

  @override
  Future<List<dynamic>> getCartProducts() async {
    return cartBox.get('cart') ?? [];
  }
}
