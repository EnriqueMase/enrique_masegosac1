import 'package:enrique_masegosac1/controllers/usuario/controlador_pedidos.dart';
import 'package:flutter/material.dart';

import 'package:enrique_masegosac1/models/pedidos.dart';

class PaginaPedidos extends StatefulWidget {
  const PaginaPedidos({super.key});

  @override
  State<PaginaPedidos> createState() => _PaginaPedidosState();
}

class _PaginaPedidosState extends State<PaginaPedidos> {
  final ControladorPedidos _controladorPedidos = ControladorPedidos();

  String _estadoToText(Pedidos estado) {
    switch (estado) {
      case Pedidos.pedido:
        return 'Pedido';
      case Pedidos.produccion:
        return 'En producción';
      case Pedidos.reparto:
        return 'En reparto';
      case Pedidos.entregado:
        return 'Entregado';
    }
  }

  @override
  Widget build(BuildContext context) {
    final List<Order> pedidos = _controladorPedidos.getMyOrders();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Mis pedidos'),
        backgroundColor: const Color.fromARGB(255, 120, 190, 255),
      ),
      body: pedidos.isEmpty
          ? const Center(child: Text('No tienes ningún pedido aún'))
          : ListView.builder(
              itemCount: pedidos.length,
              itemBuilder: (context, index) {
                final order = pedidos[index];

                return Card(
                  margin: const EdgeInsets.symmetric(
                    horizontal: 12,
                    vertical: 8,
                  ),
                  child: ExpansionTile(
                    title: Text(
                      'Pedido ${order.id}',
                      style: const TextStyle(fontWeight: FontWeight.bold),
                    ),
                    subtitle: Text(
                      'Fecha: ${order.fecha}\n'
                      'Total: ${order.total.toStringAsFixed(2)} €\n'
                      'Estado: ${_estadoToText(order.estado)}',
                    ),
                    children: order.items
                        .map(
                          (item) => ListTile(
                            title: Text(item.productos.nombre),
                            subtitle: Text(
                              'Cantidad: ${item.cantidad}\n'
                              'Subtotal: ${item.subtotal.toStringAsFixed(2)} €',
                            ),
                          ),
                        )
                        .toList(),
                  ),
                );
              },
            ),
    );
  }
}
