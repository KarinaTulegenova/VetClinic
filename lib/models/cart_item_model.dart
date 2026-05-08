import 'service_model.dart';

class CartItemModel {
  const CartItemModel({required this.product, required this.quantity});

  final ServiceModel product;
  final int quantity;

  int get lineTotal => product.price * quantity;
}
