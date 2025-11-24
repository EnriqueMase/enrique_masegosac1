import 'package:enrique_masegosac1/models/product.dart';
import 'package:enrique_masegosac1/services/shop_services.dart';

class ShopController {
  final ShopService _service = ShopService();
  late List<int> _cantidades;

  ShopController() {
    _cantidades = List<int>.filled(_service.productos.length, 0);
  }

  List<Product> get productos => _service.productos;

  List<int> get cantidades => List<int>.unmodifiable(_cantidades);

  String? incrementarCantidad(int index) {
    final producto = _service.productos[index];

    if (_cantidades[index] < producto.stock) {
      _cantidades[index]++;
      return null;
    } else {
      return 'No hay más stock de ${producto.nombre}';
    }
  }

  void decrementarCantidad(int index) {
    if (_cantidades[index] > 0) {
      _cantidades[index]--;
    }
  }

  OrderResult realizarCompraParaUsuario(String userName) {
    final result = _service.realizarCompra(
      userName: userName,
      cantidades: _cantidades,
    );

    if (result.success) {
      _cantidades = List<int>.filled(_service.productos.length, 0);
    }

    return result;
  }
}
