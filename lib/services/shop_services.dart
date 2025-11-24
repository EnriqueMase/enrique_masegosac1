import 'package:enrique_masegosac1/models/order.dart';
import 'package:enrique_masegosac1/models/product.dart';

class OrderResult {
  final bool success;
  final String message;

  OrderResult({required this.success, required this.message});
}

class ShopService {
  static final ShopService _instance = ShopService._internal();

  factory ShopService() => _instance;

  final List<Product> _productos = [];
  final Map<String, List<Order>> _ordersByUser = {};

  ShopService._internal() {
    _initProductos();
  }

  void _initProductos() {
    if (_productos.isNotEmpty) return;
    //Cambiar fotos
    _productos.addAll([
      Product(
        id: 'p1',
        nombre: 'Producto 1',
        precio: 19.99,
        stock: 10,
        descripcion: 'Descripción del Producto 1',
        imagenAsset: 'assets/images/producto1.jpg',
      ),
      Product(
        id: 'p2',
        nombre: 'Producto 2',
        precio: 9.99,
        stock: 5,
        descripcion: 'Descripción del Producto 2',
        imagenAsset: 'assets/images/producto2.png',
      ),
      Product(
        id: 'p3',
        nombre: 'Producto 3',
        precio: 29.99,
        stock: 8,
        descripcion: 'Descripción del Producto 3',
        imagenAsset: 'assets/images/speed.jpg',
      ),
    ]);
  }

  List<Product> get productos => List.unmodifiable(_productos);

  List<Order> getOrdersForUser(String userName) {
    return List.unmodifiable(_ordersByUser[userName] ?? []);
  }

  OrderResult realizarCompra({
    required String userName,
    required List<int> cantidades,
  }) {
    int totalUnidades = 0;

    for (int i = 0; i < _productos.length; i++) {
      totalUnidades += cantidades[i];
    }

    if (totalUnidades == 0) {
      return OrderResult(
        success: false,
        message: 'No has seleccionado ningún producto',
      );
    }

    // Comprobar stock suficiente
    for (int i = 0; i < _productos.length; i++) {
      if (cantidades[i] > _productos[i].stock) {
        return OrderResult(
          success: false,
          message: 'No hay stock suficiente de ${_productos[i].nombre}',
        );
      }
    }

    // Crear items de pedido y descontar stock
    final List<OrderItem> items = [];

    for (int i = 0; i < _productos.length; i++) {
      final qty = cantidades[i];
      if (qty > 0) {
        final p = _productos[i];
        p.stock -= qty;
        items.add(OrderItem(product: p, cantidad: qty));
      }
    }

    final order = Order(
      id: DateTime.now().millisecondsSinceEpoch.toString(),
      userName: userName,
      fecha: DateTime.now(),
      items: items,
    );

    _ordersByUser.putIfAbsent(userName, () => []);
    _ordersByUser[userName]!.add(order);

    return OrderResult(
      success: true,
      message:
          'Compra realizada por un total de ${order.total.toStringAsFixed(2)} €',
    );
  }
}
