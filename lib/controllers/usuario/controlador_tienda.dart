import 'package:enrique_masegosac1/models/productos.dart';
import 'package:enrique_masegosac1/services/Logica_tienda.dart';

class ControladorTienda {
  final LogicaTiendas _logicaTiendas = LogicaTiendas();
  late List<int> _cantidades;

  ControladorTienda() {
    _cantidades = List<int>.filled(_logicaTiendas.productos.length, 0);
  }

  List<Productos> get productos => _logicaTiendas.productos;

  List<int> get cantidades => List<int>.unmodifiable(_cantidades);

  String? incrementarCantidad(int index) {
    final producto = _logicaTiendas.productos[index];

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

  LogicaTienda realizarCompraParaUsuario(String userName) {
    final result = _logicaTiendas.realizarCompra(
      userName: userName,
      cantidades: _cantidades,
    );

    if (result.success) {
      _cantidades = List<int>.filled(_logicaTiendas.productos.length, 0);
    }

    return result;
  }
}
