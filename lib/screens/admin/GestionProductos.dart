import 'package:flutter/material.dart';

import 'package:enrique_masegosac1/controllers/administrador/controlados_productos_admin.dart';
import 'package:enrique_masegosac1/models/productos.dart';

class GestionProductosPage extends StatefulWidget {
  const GestionProductosPage({super.key});
  @override
  State<GestionProductosPage> createState() => _GestionProductosPageState();
}

class _GestionProductosPageState extends State<GestionProductosPage> {
  final ControladosProductosAdmin _controladosProductosAdmin =
      ControladosProductosAdmin();

  void _mostrarDialogoCrearProducto() {
    final formKey = GlobalKey<FormState>();
    final idController = TextEditingController();
    final nombreController = TextEditingController();
    final descripcionController = TextEditingController();
    final precioController = TextEditingController();
    final stockController = TextEditingController();
    final imagenController = TextEditingController(
      text: 'assets/images/producto_nuevo.png',
    );

    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: const Text('Crear producto'),
        content: Form(
          key: formKey,
          child: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextFormField(
                  controller: idController,
                  decoration: const InputDecoration(labelText: 'ID producto'),
                  validator: (v) =>
                      v == null || v.isEmpty ? 'Obligatorio' : null,
                ),
                TextFormField(
                  controller: nombreController,
                  decoration: const InputDecoration(labelText: 'Nombre'),
                  validator: (v) =>
                      v == null || v.isEmpty ? 'Obligatorio' : null,
                ),
                TextFormField(
                  controller: descripcionController,
                  decoration: const InputDecoration(labelText: 'Descripción'),
                ),
                TextFormField(
                  controller: precioController,
                  decoration: const InputDecoration(labelText: 'Precio'),
                  keyboardType: const TextInputType.numberWithOptions(
                    decimal: true,
                  ),
                  validator: (v) =>
                      v == null || v.isEmpty ? 'Obligatorio' : null,
                ),
                TextFormField(
                  controller: stockController,
                  decoration: const InputDecoration(labelText: 'Stock'),
                  keyboardType: TextInputType.number,
                  validator: (v) =>
                      v == null || v.isEmpty ? 'Obligatorio' : null,
                ),
                TextFormField(
                  controller: imagenController,
                  decoration: const InputDecoration(
                    labelText: 'Ruta imagen (asset)',
                  ),
                ),
              ],
            ),
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancelar'),
          ),
          ElevatedButton(
            onPressed: () {
              if (!formKey.currentState!.validate()) return;

              final precio = double.tryParse(precioController.text.trim()) ?? 0;
              final stock = int.tryParse(stockController.text.trim()) ?? 0;

              _controladosProductosAdmin.crearProducto(
                id: idController.text.trim(),
                nombre: nombreController.text.trim(),
                descripcion: descripcionController.text.trim(),
                precio: precio,
                stock: stock,
                imagenAsset: imagenController.text.trim(),
              );

              Navigator.pop(context);
              setState(() {});
            },
            child: const Text('Crear'),
          ),
        ],
      ),
    );
  }

  void _mostrarDialogoEditarProducto(Productos p) {
    final formKey = GlobalKey<FormState>();
    final idController = TextEditingController(text: p.id);
    final nombreController = TextEditingController(text: p.nombre);
    final descripcionController = TextEditingController(text: p.descripcion);
    final precioController = TextEditingController(text: p.precio.toString());
    final stockController = TextEditingController(text: p.stock.toString());
    final imagenController = TextEditingController(text: p.imagenAsset);

    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: Text('Editar producto: ${p.nombre}'),
        content: Form(
          key: formKey,
          child: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextFormField(
                  controller: idController,
                  decoration: const InputDecoration(labelText: 'ID producto'),
                  validator: (v) =>
                      v == null || v.isEmpty ? 'Obligatorio' : null,
                ),
                TextFormField(
                  controller: nombreController,
                  decoration: const InputDecoration(labelText: 'Nombre'),
                  validator: (v) =>
                      v == null || v.isEmpty ? 'Obligatorio' : null,
                ),
                TextFormField(
                  controller: descripcionController,
                  decoration: const InputDecoration(labelText: 'Descripción'),
                ),
                TextFormField(
                  controller: precioController,
                  decoration: const InputDecoration(labelText: 'Precio'),
                  keyboardType: const TextInputType.numberWithOptions(
                    decimal: true,
                  ),
                ),
                TextFormField(
                  controller: stockController,
                  decoration: const InputDecoration(labelText: 'Stock'),
                  keyboardType: TextInputType.number,
                ),
                TextFormField(
                  controller: imagenController,
                  decoration: const InputDecoration(
                    labelText: 'Ruta imagen (asset)',
                  ),
                ),
              ],
            ),
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancelar'),
          ),
          ElevatedButton(
            onPressed: () {
              if (!formKey.currentState!.validate()) return;

              final precio =
                  double.tryParse(precioController.text.trim()) ?? p.precio;
              final stock =
                  int.tryParse(stockController.text.trim()) ?? p.stock;

              final nuevo = Productos(
                id: idController.text.trim(),
                nombre: nombreController.text.trim(),
                precio: precio,
                stock: stock,
                descripcion: descripcionController.text.trim(),
                imagenAsset: imagenController.text.trim(),
              );

              _controladosProductosAdmin.editarProducto(
                idOriginal: p.id,
                datosNuevos: nuevo,
              );

              Navigator.pop(context);
              setState(() {});
            },
            child: const Text('Guardar'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final productos = _controladosProductosAdmin.getProductos();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Gestión de productos'),
        backgroundColor: const Color.fromARGB(255, 120, 190, 255),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _mostrarDialogoCrearProducto,
        child: const Icon(Icons.add),
      ),
      body: productos.isEmpty
          ? const Center(child: Text('No hay productos'))
          : ListView.builder(
              itemCount: productos.length,
              itemBuilder: (context, index) {
                final p = productos[index];
                return Card(
                  margin: const EdgeInsets.symmetric(
                    horizontal: 12,
                    vertical: 6,
                  ),
                  child: ListTile(
                    leading: ClipRRect(
                      borderRadius: BorderRadius.circular(8),
                      child: Image.asset(
                        p.imagenAsset,
                        width: 40,
                        height: 40,
                        fit: BoxFit.cover,
                        errorBuilder: (_, __, ___) =>
                            const Icon(Icons.image_not_supported),
                      ),
                    ),
                    title: Text(p.nombre),
                    subtitle: Text(
                      'Precio: ${p.precio.toStringAsFixed(2)} €\n'
                      'Stock: ${p.stock}',
                    ),
                    trailing: PopupMenuButton<String>(
                      onSelected: (value) {
                        if (value == 'editar') {
                          _mostrarDialogoEditarProducto(p);
                        } else if (value == 'eliminar') {
                          _controladosProductosAdmin.eliminarProducto(p.id);
                          setState(() {});
                        }
                      },
                      itemBuilder: (context) => [
                        const PopupMenuItem(
                          value: 'editar',
                          child: Text('Editar'),
                        ),
                        const PopupMenuItem(
                          value: 'eliminar',
                          child: Text(
                            'Eliminar',
                            style: TextStyle(color: Colors.red),
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
    );
  }
}
