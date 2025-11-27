import 'package:enrique_masegosac1/l10n/app_localizations.dart';
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
    final l10n = AppLocalizations.of(context)!;
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
        title: Text(l10n.createProduct),
        content: Form(
          key: formKey,
          child: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextFormField(
                  controller: idController,
                  decoration: InputDecoration(labelText: l10n.productId),
                  validator: (v) =>
                      v == null || v.isEmpty ? l10n.requiredField : null,
                ),
                TextFormField(
                  controller: nombreController,
                  decoration: InputDecoration(labelText: l10n.name),
                  validator: (v) =>
                      v == null || v.isEmpty ? l10n.requiredField : null,
                ),
                TextFormField(
                  controller: descripcionController,
                  decoration: InputDecoration(labelText: l10n.description),
                ),
                TextFormField(
                  controller: precioController,
                  decoration: InputDecoration(labelText: l10n.price),
                  keyboardType: const TextInputType.numberWithOptions(
                    decimal: true,
                  ),
                  validator: (v) =>
                      v == null || v.isEmpty ? l10n.requiredField : null,
                ),
                TextFormField(
                  controller: stockController,
                  decoration: InputDecoration(labelText: l10n.stock),
                  keyboardType: TextInputType.number,
                  validator: (v) =>
                      v == null || v.isEmpty ? l10n.requiredField : null,
                ),
                TextFormField(
                  controller: imagenController,
                  decoration: InputDecoration(labelText: l10n.imagePath),
                ),
              ],
            ),
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text(l10n.cancel),
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
            child: Text(l10n.create),
          ),
        ],
      ),
    );
  }

  void _mostrarDialogoEditarProducto(Productos p) {
    final l10n = AppLocalizations.of(context)!;
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
        title: Text(l10n.editProduct(p.nombre)),
        content: Form(
          key: formKey,
          child: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextFormField(
                  controller: idController,
                  decoration: InputDecoration(labelText: l10n.productId),
                  validator: (v) =>
                      v == null || v.isEmpty ? l10n.requiredField : null,
                ),
                TextFormField(
                  controller: nombreController,
                  decoration: InputDecoration(labelText: l10n.name),
                  validator: (v) =>
                      v == null || v.isEmpty ? l10n.requiredField : null,
                ),
                TextFormField(
                  controller: descripcionController,
                  decoration: InputDecoration(labelText: l10n.description),
                ),
                TextFormField(
                  controller: precioController,
                  decoration: InputDecoration(labelText: l10n.price),
                  keyboardType: const TextInputType.numberWithOptions(
                    decimal: true,
                  ),
                ),
                TextFormField(
                  controller: stockController,
                  decoration: InputDecoration(labelText: l10n.stock),
                  keyboardType: TextInputType.number,
                ),
                TextFormField(
                  controller: imagenController,
                  decoration: InputDecoration(labelText: l10n.imagePath),
                ),
              ],
            ),
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text(l10n.cancel),
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
            child: Text(l10n.save),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final productos = _controladosProductosAdmin.getProductos();

    return Scaffold(
      appBar: AppBar(
        title: Text(l10n.productManagement),
        backgroundColor: const Color.fromARGB(255, 120, 190, 255),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _mostrarDialogoCrearProducto,
        child: const Icon(Icons.add),
      ),
      body: productos.isEmpty
          ? Center(child: Text(l10n.noProducts))
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
                      '${l10n.price}: ${p.precio.toStringAsFixed(2)} €\n'
                      '${l10n.stock}: ${p.stock}',
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
                        PopupMenuItem(value: 'editar', child: Text(l10n.edit)),
                        PopupMenuItem(
                          value: 'eliminar',
                          child: Text(
                            l10n.delete,
                            style: const TextStyle(color: Colors.red),
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
