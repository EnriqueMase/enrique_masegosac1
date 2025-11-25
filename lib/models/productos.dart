class Productos {
  final String id;
  final String nombre;
  final double precio;
  int stock;
  final String descripcion;
  final String imagenAsset;

  Productos({
    required this.id,
    required this.nombre,
    required this.precio,
    required this.stock,
    required this.descripcion,
    required this.imagenAsset,
  });
}
