import 'package:enrique_masegosac1/models/pedidos.dart';
import 'package:enrique_masegosac1/models/productos.dart';
import 'package:enrique_masegosac1/services/Logica_productos.dart';
import 'package:enrique_masegosac1/services/Logica_pedidos.dart';

class compraResultado {
  final bool success;
  final String message;

  compraResultado({required this.success, required this.message});
}

class ControladorProductos {
  final LogicaProductos _productService = LogicaProductos();
  final LogicaPedidos _logicaPedidos = LogicaPedidos();

  late List<int> _cantidades;

  ProductController() {
    final products = _productService.getProducts();
    _cantidades = List<int>.filled(products.length, 0);
  }

  List<Productos> get productos => _productService.getProducts();
  List<int> get cantidades => List<int>.unmodifiable(_cantidades);

  // Devuelve null si OK, o texto de error si no hay stock
  String? incrementarCantidad(int index) {
    final products = productos;
    if (index < 0 || index >= products.length) return 'Índice inválido';

    final product = products[index];

    if (_cantidades[index] < product.stock) {
      _cantidades[index]++;
      return null;
    } else {
      return 'No hay más stock de ${product.nombre}';
    }
  }

  void decrementarCantidad(int index) {
    if (index < 0 || index >= _cantidades.length) return;
    if (_cantidades[index] > 0) {
      _cantidades[index]--;
    }
  }

  // Realiza la compra para un usuario concreto.
  // - Comprueba cantidades.
  // - Comprueba stock.
  // - Resta stock.
  // - Crea Order + OrderItems.
  // - Guarda el pedido en OrdersService.
  // - Resetea cantidades.
  compraResultado realizarCompraParaUsuario(String userName) {
    final products = productos;
    if (products.isEmpty) {
      return compraResultado(
        success: false,
        message: 'No hay productos disponibles',
      );
    }

    int totalUnidades = 0;
    for (final qty in _cantidades) {
      totalUnidades += qty;
    }

    if (totalUnidades == 0) {
      return compraResultado(
        success: false,
        message: 'No has seleccionado ningún producto',
      );
    }

    // Comprobar stock suficiente
    for (int i = 0; i < products.length; i++) {
      if (_cantidades[i] > products[i].stock) {
        return compraResultado(
          success: false,
          message: 'No hay stock suficiente de ${products[i].nombre}',
        );
      }
    }

    // Crear items + descontar stock
    final List<ObjectoPedido> items = [];
    for (int i = 0; i < products.length; i++) {
      final qty = _cantidades[i];
      if (qty > 0) {
        final p = products[i];
        p.stock -= qty;
        items.add(ObjectoPedido(productos: p, cantidad: qty));
      }
    }

    final order = Order(
      id: DateTime.now().millisecondsSinceEpoch.toString(),
      userName: userName,
      fecha: DateTime.now(),
      items: items,
      estado: Pedidos.pedido,
    );

    _logicaPedidos.addOrderForUser(userName, order);

    // Resetear cantidades
    _cantidades = List<int>.filled(products.length, 0);

    return compraResultado(
      success: true,
      message:
          'Compra realizada por un total de ${order.total.toStringAsFixed(2)} €',
    );
  }
}
