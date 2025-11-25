import 'package:enrique_masegosac1/models/productos.dart';
import 'package:enrique_masegosac1/services/Logica_productos.dart';

class ControladosProductosAdmin {
  final LogicaProductos _logicaProductos = LogicaProductos();

  List<Productos> getProductos() {
    return _logicaProductos.getProducts();
  }

  void crearProducto({
    required String id,
    required String nombre,
    required String descripcion,
    required double precio,
    required int stock,
    required String imagenAsset,
  }) {
    final p = Productos(
      id: id,
      nombre: nombre,
      precio: precio,
      stock: stock,
      descripcion: descripcion,
      imagenAsset: imagenAsset,
    );
    _logicaProductos.addProduct(p);
  }

  void editarProducto({
    required String idOriginal,
    required Productos datosNuevos,
  }) {
    _logicaProductos.editProduct(idOriginal, datosNuevos);
  }

  void eliminarProducto(String id) {
    _logicaProductos.deleteProduct(id);
  }
}
