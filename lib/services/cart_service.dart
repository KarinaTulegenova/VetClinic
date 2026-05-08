import '../models/cart_item_model.dart';
import '../models/service_model.dart';

class CartService {
  CartService._();

  static final Map<String, CartItemModel> _items = {};

  static List<CartItemModel> get items => List.unmodifiable(_items.values);

  static int get total {
    return _items.values.fold(0, (sum, item) => sum + item.lineTotal);
  }

  static int get itemCount {
    return _items.values.fold(0, (sum, item) => sum + item.quantity);
  }

  static void add(ServiceModel product) {
    final existing = _items[product.title];
    _items[product.title] = CartItemModel(
      product: product,
      quantity: (existing?.quantity ?? 0) + 1,
    );
  }

  static void removeOne(String title) {
    final existing = _items[title];
    if (existing == null) {
      return;
    }

    if (existing.quantity <= 1) {
      _items.remove(title);
      return;
    }

    _items[title] = CartItemModel(
      product: existing.product,
      quantity: existing.quantity - 1,
    );
  }

  static void remove(String title) {
    _items.remove(title);
  }

  static void clear() {
    _items.clear();
  }
}
