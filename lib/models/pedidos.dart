import 'productos.dart';

enum Pedidos { pedido, produccion, reparto, entregado }

class ObjectoPedido {
  final Productos productos;
  final int cantidad;

  ObjectoPedido({required this.productos, required this.cantidad});

  double get subtotal => cantidad * productos.precio;
}

class Order {
  final String id;
  final String userName;
  final DateTime fecha;
  final List<ObjectoPedido> items;
  Pedidos estado;

  Order({
    required this.id,
    required this.userName,
    required this.fecha,
    required this.items,
    this.estado = Pedidos.pedido,
  });

  double get total => items.fold(0.0, (sum, item) => sum + item.subtotal);
}
