import 'package:enrique_masegosac1/models/productos.dart';

class LogicaProductos {
  static final LogicaProductos _instance = LogicaProductos._internal();

  factory LogicaProductos() => _instance;

  LogicaProductos._internal() {
    _initProductos();
  }

  final List<Productos> _productos = [];

  void _initProductos() {
    if (_productos.isNotEmpty) return;

    _productos.addAll([
      Productos(
        id: 'p1',
        nombre: 'Teclado',
        precio: 39.99,
        stock: 50,
        descripcion: 'Descripción del Producto 1',
        imagenAsset: 'assets/images/teclado.jpg',
      ),
      Productos(
        id: 'p2',
        nombre: 'Raton',
        precio: 119.99,
        stock: 70,
        descripcion: 'Descripción del Producto 2',
        imagenAsset: 'assets/images/raton.jpg',
      ),
      Productos(
        id: 'p3',
        nombre: 'Cascos Speed',
        precio: 49.99,
        stock: 10,
        descripcion: 'Descripción del Producto 3',
        imagenAsset: 'assets/images/speed.jpg',
      ),
    ]);
  }

  List<Productos> getProducts() => List.unmodifiable(_productos);

  Productos? getById(String id) {
    try {
      return _productos.firstWhere((p) => p.id == id);
    } catch (_) {
      return null;
    }
  }

  void updateStock(String id, int newStock) {
    final p = getById(id);
    if (p != null) {
      p.stock = newStock;
    }
  }

  void addProduct(Productos product) {
    _productos.add(product);
  }

  void editProduct(String id, Productos newData) {
    for (int i = 0; i < _productos.length; i++) {
      if (_productos[i].id == id) {
        _productos[i] = newData;
        return;
      }
    }
  }

  void deleteProduct(String id) {
    _productos.removeWhere((p) => p.id == id);
  }
}
