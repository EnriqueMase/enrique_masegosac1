import 'package:enrique_masegosac1/models/order.dart';
import 'package:enrique_masegosac1/services/Logica_Usuarios.dart';
import 'package:enrique_masegosac1/services/shop_services.dart';

class OrdersController {
  final LogicaUsuarios _usuarios = LogicaUsuarios();
  final ShopService _shopService = ShopService();

  String? get currentUserName {
    final user = _usuarios.getUsuarioActual();
    return user?.nombre;
  }

  List<Order> getOrdersForCurrentUser() {
    final name = currentUserName;
    if (name == null) return [];
    return _shopService.getOrdersForUser(name);
  }
}
