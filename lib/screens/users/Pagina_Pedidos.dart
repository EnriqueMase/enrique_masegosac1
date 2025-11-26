import 'package:enrique_masegosac1/controllers/usuario/controlador_pedidos.dart';
import 'package:enrique_masegosac1/l10n/app_localizations.dart';
import 'package:enrique_masegosac1/widgets/drawer.dart';
import 'package:flutter/material.dart';

import 'package:enrique_masegosac1/models/pedidos.dart';

class PaginaPedidos extends StatefulWidget {
  const PaginaPedidos({super.key});

  @override
  State<PaginaPedidos> createState() => _PaginaPedidosState();
}

class _PaginaPedidosState extends State<PaginaPedidos> {
  final ControladorPedidos _controladorPedidos = ControladorPedidos();

  String _estadoToText(Pedidos estado, AppLocalizations l10n) {
    switch (estado) {
      case Pedidos.pedido:
        return l10n.ordered;
      case Pedidos.produccion:
        return l10n.inProduction;
      case Pedidos.reparto:
        return l10n.inDelivery;
      case Pedidos.entregado:
        return l10n.delivered;
    }
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final List<Order> pedidos = _controladorPedidos.getMyOrders();

    return Scaffold(
      drawer: Cdrawer(),

      appBar: AppBar(
        title: Text(l10n.myOrders),
        backgroundColor: const Color.fromARGB(255, 120, 190, 255),
      ),
      body: pedidos.isEmpty
          ? Center(child: Text(l10n.noOrdersYet))
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
                      l10n.orderId(order.id),
                      style: const TextStyle(fontWeight: FontWeight.bold),
                    ),
                    subtitle: Text(
                      '${l10n.date}: ${order.fecha}\n'
                      '${l10n.total}: ${order.total.toStringAsFixed(2)} €\n'
                      '${l10n.status}: ${_estadoToText(order.estado, l10n)}',
                    ),
                    children: order.items
                        .map(
                          (item) => ListTile(
                            title: Text(item.productos.nombre),
                            subtitle: Text(
                              '${l10n.quantity}: ${item.cantidad}\n'
                              '${l10n.subtotal}: ${item.subtotal.toStringAsFixed(2)} €',
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
