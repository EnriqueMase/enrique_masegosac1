import 'package:enrique_masegosac1/controllers/order_controler.dart';
import 'package:enrique_masegosac1/widgets/drawer.dart';
import 'package:flutter/material.dart';

import 'package:enrique_masegosac1/models/order.dart';

class PaginaPedidos extends StatefulWidget {
  const PaginaPedidos({super.key});

  @override
  State<PaginaPedidos> createState() => _PaginaPedidosState();
}

class _PaginaPedidosState extends State<PaginaPedidos> {
  final OrdersController _ordersController = OrdersController();

  @override
  Widget build(BuildContext context) {
    final List<Order> pedidos = _ordersController.getOrdersForCurrentUser();

    return Scaffold(
      drawer: Cdrawer(),
      appBar: AppBar(
        title: const Text('Pedidos'),
        backgroundColor: const Color.fromARGB(255, 120, 190, 255),
      ),
      body: pedidos.isEmpty
          ? const Center(child: Text('No tienes ningún pedido aún'))
          : ListView.builder(
              itemCount: pedidos.length,
              itemBuilder: (context, index) {
                final order = pedidos[index];
                return ExpansionTile(
                  title: Text(
                    'Pedido ${order.id}',
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                  subtitle: Text(
                    'Fecha: ${order.fecha}'
                    '\nTotal: ${order.total.toStringAsFixed(2)} €',
                  ),
                  children: order.items
                      .map(
                        (item) => ListTile(
                          title: Text(item.product.nombre),
                          subtitle: Text(
                            'Cantidad: ${item.cantidad} '
                            '- Subtotal: ${item.subtotal.toStringAsFixed(2)} €',
                          ),
                        ),
                      )
                      .toList(),
                );
              },
            ),
    );
  }
}
