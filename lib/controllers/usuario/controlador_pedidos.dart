import 'package:enrique_masegosac1/models/pedidos.dart';
import 'package:enrique_masegosac1/services/Logica_Usuarios.dart';
import 'package:enrique_masegosac1/services/Logica_pedidos.dart';

class ControladorPedidos {
  final LogicaUsuarios _usuarios = LogicaUsuarios();
  final LogicaPedidos _logicaPedidos = LogicaPedidos();

  String? get currentUserName {
    final user = _usuarios.getUsuarioActual();
    return user?.nombre;
  }

  List<Order> getMyOrders() {
    final name = currentUserName;
    if (name == null) return [];
    return _logicaPedidos.getOrdersForUser(name);
  }
}
