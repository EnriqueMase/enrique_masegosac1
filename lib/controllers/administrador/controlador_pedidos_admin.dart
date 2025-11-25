import 'package:enrique_masegosac1/models/pedidos.dart';
import 'package:enrique_masegosac1/services/Logica_pedidos.dart';

class ControladorPedidosAdmin {
  final LogicaPedidos _logicaPedidos = LogicaPedidos();

  List<Order> getTodosPedidos() {
    return _logicaPedidos.getAllOrders();
  }

  void cambiarEstadoPedido(String orderId, Pedidos nuevoEstado) {
    _logicaPedidos.updateOrderStatus(orderId, nuevoEstado);
  }
}
