import 'package:enrique_masegosac1/models/pedidos.dart';

class LogicaPedidos {
  static final LogicaPedidos _instance = LogicaPedidos._internal();

  factory LogicaPedidos() => _instance;

  LogicaPedidos._internal();

  // userName -> lista de pedidos
  final Map<String, List<Order>> _ordersByUser = {};

  List<Order> getOrdersForUser(String userName) {
    return List.unmodifiable(_ordersByUser[userName] ?? []);
  }

  // Todos los pedidos de todos los usuarios (para admin)
  List<Order> getAllOrders() {
    final List<Order> lista = [];
    for (final entry in _ordersByUser.entries) {
      lista.addAll(entry.value);
    }
    return lista;
  }

  void addOrderForUser(String userName, Order order) {
    _ordersByUser.putIfAbsent(userName, () => []);
    _ordersByUser[userName]!.add(order);
  }

  void updateOrderStatus(String orderId, Pedidos newStatus) {
    for (final entry in _ordersByUser.entries) {
      for (final order in entry.value) {
        if (order.id == orderId) {
          order.estado = newStatus;
          return;
        }
      }
    }
  }
}
