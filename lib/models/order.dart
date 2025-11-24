import 'product.dart';

class OrderItem {
  final Product product;
  final int cantidad;

  OrderItem({required this.product, required this.cantidad});

  double get subtotal => cantidad * product.precio;
}

class Order {
  final String id;
  final String userName;
  final DateTime fecha;
  final List<OrderItem> items;

  Order({
    required this.id,
    required this.userName,
    required this.fecha,
    required this.items,
  });

  double get total => items.fold(0.0, (sum, item) => sum + item.subtotal);
}
