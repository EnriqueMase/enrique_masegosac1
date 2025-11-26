import 'package:enrique_masegosac1/l10n/app_localizations.dart';
import 'package:enrique_masegosac1/screens/auth/Pantalla_login.dart';
import 'package:enrique_masegosac1/services/Logica_Usuarios.dart';
import 'package:enrique_masegosac1/widgets/drawer.dart';
import 'package:flutter/material.dart';

import 'package:enrique_masegosac1/controllers/usuario/controlador_productos.dart';
import 'package:enrique_masegosac1/models/productos.dart';

class PaginaCompras extends StatefulWidget {
  const PaginaCompras({super.key});

  @override
  State<PaginaCompras> createState() => _PaginaComprasState();
}

class _PaginaComprasState extends State<PaginaCompras> {
  final ControladorProductos _controladorProductos = ControladorProductos();
  final LogicaUsuarios _usuarios = LogicaUsuarios();

  void _incrementar(int index) {
    final error = _controladorProductos.incrementarCantidad(index);
    if (error != null) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(error), backgroundColor: Colors.red),
      );
    } else {
      setState(() {});
    }
  }

  void _decrementar(int index) {
    _controladorProductos.decrementarCantidad(index);
    setState(() {});
  }

  void _realizarCompra() {
    final l10n = AppLocalizations.of(context)!;
    final user = _usuarios.getUsuarioActual();
    if (user == null) {
      // Si por algún motivo no hay usuario logueado, volvemos al login
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (_) => const PantallaLogin()),
      );
      return;
    }

    final result = _controladorProductos.realizarCompraParaUsuario(user.nombre);

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          result.success ? l10n.purchaseSuccess : l10n.purchaseError,
        ),
        backgroundColor: result.success ? Colors.green : Colors.red,
      ),
    );

    if (result.success) {
      setState(() {});
    }
  }

  Widget _productoCard({
    required Productos producto,
    required int cantidad,
    required VoidCallback onAdd,
    required VoidCallback onRemove,
  }) {
    final l10n = AppLocalizations.of(context)!;
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      elevation: 3,
      margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Row(
          children: [
            // cambiar imagenes
            ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: Image.asset(
                producto.imagenAsset,
                width: 60,
                height: 60,
                fit: BoxFit.cover,
                errorBuilder: (_, __, ___) =>
                    const Icon(Icons.image_not_supported, size: 48),
              ),
            ),
            const SizedBox(width: 12),

            // Info del producto que vendemos
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    producto.nombre,
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    '${l10n.price}: ${producto.precio.toStringAsFixed(2)} €',
                  ),
                  Text('${l10n.stock}: ${producto.stock}'),
                  Text(
                    producto.descripcion,
                    style: const TextStyle(fontSize: 12, color: Colors.black54),
                  ),
                ],
              ),
            ),

            // controlar cantidad
            Row(
              children: [
                IconButton(
                  onPressed: onRemove,
                  icon: const Icon(Icons.remove, color: Colors.red),
                ),
                Text(
                  cantidad.toString(),
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                IconButton(
                  onPressed: onAdd,
                  icon: const Icon(Icons.add, color: Colors.green),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final productos = _controladorProductos.productos;
    final cantidades = _controladorProductos.cantidades;

    final user = _usuarios.getUsuarioActual();
    final titulo = user != null ? l10n.welcomeUser(user.nombre) : l10n.welcome;

    return Scaffold(
      drawer: Cdrawer(),
      appBar: AppBar(
        title: Text(titulo),
        backgroundColor: const Color.fromARGB(255, 120, 190, 255),
      ),
      body: Column(
        children: [
          const SizedBox(height: 8),
          Expanded(
            child: ListView.builder(
              itemCount: productos.length,
              itemBuilder: (context, index) {
                final producto = productos[index];
                final cantidad = cantidades[index];

                return _productoCard(
                  producto: producto,
                  cantidad: cantidad,
                  onAdd: () => _incrementar(index),
                  onRemove: () => _decrementar(index),
                );
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16),
            child: SizedBox(
              width: double.infinity,
              child: ElevatedButton.icon(
                icon: const Icon(Icons.shopping_cart_outlined),
                label: Text(l10n.makePurchase),
                onPressed: () async {
                  final confirmar = await showDialog<bool>(
                    context: context,
                    builder: (context) => AlertDialog(
                      title: Text(l10n.confirmPurchase),
                      content: Text(l10n.confirmPurchaseQuestion),
                      actions: [
                        TextButton(
                          onPressed: () => Navigator.of(context).pop(false),
                          child: Text(l10n.cancel),
                        ),
                        ElevatedButton(
                          onPressed: () => Navigator.of(context).pop(true),
                          child: Text(l10n.confirm),
                        ),
                      ],
                    ),
                  );

                  if (confirmar == true) {
                    _realizarCompra();
                  }
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
