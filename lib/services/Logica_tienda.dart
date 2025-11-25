import 'package:enrique_masegosac1/models/pedidos.dart';
import 'package:enrique_masegosac1/models/productos.dart';

class LogicaTienda {
  final bool success;
  final String message;

  LogicaTienda({required this.success, required this.message});
}

class LogicaTiendas {
  static final LogicaTiendas _instance = LogicaTiendas._internal();

  factory LogicaTiendas() => _instance;

  final List<Productos> _productos = [];
  final Map<String, List<Order>> _ordersByUser = {};

  LogicaTiendas._internal() {
    _initProductos();
  }

  void _initProductos() {
    if (_productos.isNotEmpty) return;
    //Cambiar fotos
    _productos.addAll([
      Productos(
        id: 'p1',
        nombre: 'Super Light 2 LG',
        precio: 19.99,
        stock: 10,
        descripcion: 'Descripción del Producto 1',
        imagenAsset: 'assets/images/raton.jpg',
      ),
      Productos(
        id: 'p2',
        nombre: 'Forgeon Meteor Teclado Gaming Wireless',
        precio: 9.99,
        stock: 5,
        descripcion: 'Descripción del Producto 2',
        imagenAsset: 'assets/images/teclado.jpg',
      ),
      Productos(
        id: 'p3',
        nombre: 'Kind of homeless',
        precio: 29.99,
        stock: 8,
        descripcion: 'Descripción del Producto 3',
        imagenAsset: 'assets/images/speed.jpg',
      ),
    ]);
  }

  List<Productos> get productos => List.unmodifiable(_productos);

  List<Order> getOrdersForUser(String userName) {
    return List.unmodifiable(_ordersByUser[userName] ?? []);
  }

  LogicaTienda realizarCompra({
    required String userName,
    required List<int> cantidades,
  }) {
    int totalUnidades = 0;

    for (int i = 0; i < _productos.length; i++) {
      totalUnidades += cantidades[i];
    }

    if (totalUnidades == 0) {
      return LogicaTienda(
        success: false,
        message: 'No has seleccionado ningún producto',
      );
    }

    // Comprobar stock suficiente
    for (int i = 0; i < _productos.length; i++) {
      if (cantidades[i] > _productos[i].stock) {
        return LogicaTienda(
          success: false,
          message: 'No hay stock suficiente de ${_productos[i].nombre}',
        );
      }
    }

    // Crear items de pedido y descontar stock
    final List<ObjectoPedido> items = [];

    for (int i = 0; i < _productos.length; i++) {
      final qty = cantidades[i];
      if (qty > 0) {
        final p = _productos[i];
        p.stock -= qty;
        items.add(ObjectoPedido(productos: p, cantidad: qty));
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

    return LogicaTienda(
      success: true,
      message:
          'Compra realizada por un total de ${order.total.toStringAsFixed(2)} €',
    );
  }
}
